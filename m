Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F9C3DBE05
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 20:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhG3SAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 14:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhG3SAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 14:00:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03D4360F5C;
        Fri, 30 Jul 2021 18:00:43 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64/kexec: Test page size support with new TGRAN range values
Date:   Fri, 30 Jul 2021 19:00:37 +0100
Message-Id: <162766803320.17946.7819223335881854647.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1626237975-1909-1-git-send-email-anshuman.khandual@arm.com>
References: <1626237975-1909-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 10:16:15 +0530, Anshuman Khandual wrote:
> The commit 26f55386f964 ("arm64/mm: Fix __enable_mmu() for new TGRAN range
> values") had already switched into testing ID_AA64MMFR0_TGRAN range values.
> This just changes system_supports_[4|16|64]kb_granule() helpers to perform
> similar range tests as well. While here, it standardizes page size specific
> supported min and max TGRAN values.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/kexec: Test page size support with new TGRAN range values
      https://git.kernel.org/arm64/c/79d82cbcbb3d

-- 
Catalin

