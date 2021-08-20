Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C63F360D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbhHTVcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbhHTVcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:32:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A802C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:31:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2600:8800:8c06:1000::c8f3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C7CEF1F44A8F;
        Fri, 20 Aug 2021 22:31:33 +0100 (BST)
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] drm/panfrost: Bug fixes for lock_region
Date:   Fri, 20 Aug 2021 17:31:14 -0400
Message-Id: <20210820213117.13050-1-alyssa.rosenzweig@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Morgan reported UBSAN errors in panfrost and tracked them down to
the size computation in lock_region. This calculation is overcomplicated
(seemingly cargo culted from kbase) and can be simplified with kernel
helpers and some mathematical identities. The first patch in the series
rewrites the calculation in a form avoiding undefined behaviour; Chris
confirms it placates UBSAN.

While researching this function, I noticed a pair of other potential
bugs: Bifrost can lock more than 4GiB at a time, but must lock at least
32KiB at a time. The latter patches in the series handle these cases.

The size computation was unit-tested in userspace. Relevant code below,
just missing some copypaste definitions for fls64/clamp/etc:

	#define MIN_LOCK (1ULL << 12)
	#define MAX_LOCK (1ULL << 48)

	struct {
		uint64_t size;
		uint8_t encoded;
	} tests[] = {
		/* Clamping */
		{ 0, 11 },
		{ 1, 11 },
		{ 2, 11 },
		{ 4095, 11 },
		/* Power of two */
		{ 4096, 11 },
		/* Round up */
		{ 4097, 12 },
		{ 8192, 12 },
		{ 16384, 13 },
		{ 16385, 14 },
		/* Maximum */
		{ ~0ULL, 47 },
	};

	static uint8_t region_width(uint64_t size)
	{
		size = clamp(size, MIN_LOCK, MAX_LOCK);
		return fls64(size - 1) - 1;
	}

	int main(int argc, char **argv)
	{
		for (unsigned i = 0; i < ARRAY_SIZE(tests); ++i) {
			uint64_t test = tests[i].size;
			uint8_t expected = tests[i].encoded;
			uint8_t actual = region_width(test);

			assert(expected == actual);
		}
	}

Alyssa Rosenzweig (3):
  drm/panfrost: Simplify lock_region calculation
  drm/panfrost: Use u64 for size in lock_region
  drm/panfrost: Clamp lock region to Bifrost minimum

 drivers/gpu/drm/panfrost/panfrost_mmu.c  | 31 +++++++++---------------
 drivers/gpu/drm/panfrost/panfrost_regs.h |  2 ++
 2 files changed, 13 insertions(+), 20 deletions(-)

-- 
2.30.2

