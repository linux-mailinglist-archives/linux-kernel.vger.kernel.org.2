Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1F371F88
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhECSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:23:01 -0400
Received: from srv6.fidu.org ([159.69.62.71]:56432 "EHLO srv6.fidu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhECSW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:22:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 9A563C800D2;
        Mon,  3 May 2021 20:21:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 2roVKCChHMH2; Mon,  3 May 2021 20:21:53 +0200 (CEST)
Received: from wsembach-tuxedo.fritz.box (p200300E37f3986001A8B79e0b24CB29D.dip0.t-ipconnect.de [IPv6:2003:e3:7f39:8600:1a8b:79e0:b24c:b29d])
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPA id E2A21C800CE;
        Mon,  3 May 2021 20:21:52 +0200 (CEST)
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     wse@tuxedocomputers.com, ville.syrjala@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/i915/display Try YCbCr420 color when RGB fails
Date:   Mon,  3 May 2021 20:21:44 +0200
Message-Id: <20210503182148.851790-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When encoder validation of a display mode fails, retry with less bandwidth
heavy YCbCr420 color mode, if available. This enables some HDMI 1.4 setups
to support 4k60Hz output, which previously failed silently.

AMDGPU had nearly the exact same issue. This problem description is
therefore copied from my commit message of the AMDGPU patch.

On some setups, while the monitor and the gpu support display modes with
pixel clocks of up to 600MHz, the link encoder might not. This prevents
YCbCr444 and RGB encoding for 4k60Hz, but YCbCr420 encoding might still be
possible. However, which color mode is used is decided before the link
encoder capabilities are checked. This patch fixes the problem by retrying
to find a display mode with YCbCr420 enforced and using it, if it is
valid.

This patchset is revision 2, now split up in multiple parts with some
minor restructuring added für a cleaner implementation.


