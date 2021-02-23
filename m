Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED05E322D90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhBWPaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:58158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233320AbhBWP3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:29:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8851864E20;
        Tue, 23 Feb 2021 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614094126;
        bh=/yFNU66U4Xw+JD7FpZgD669dqSm9thssAE43uytWBV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iriA5e9XzHqLm0IOvgqYXsErbMc0pIs3Ve/qrXWEMmls0Ekd/l1MHUZ6090exbi+P
         zhlCCHsD0pD5tOXsGkPhqTYf+WtPXfLGOkiZnunylfotsEIej3zaKoG1LWh2PuTpXp
         4j9TgOenknb5FwbWdoT/snGoRHDl9xmOOoOw5fxNQtzAImQN2EV75X6XSoHzEuPWU7
         Zd9F0lj3TlM0x1ZzP/IpfrP83sbwcEjGGYe+H2k8iTyG0WZ7x0k+0r7gfy0ZXzleDM
         nIM6Xwuw3RHZukCH/HkguBZVm0gct7vw+R1Oh1nrrFrDKfIWnHG/prdAFowqCsqhVd
         FwGIVl/Sb1/Bg==
From:   Will Deacon <will@kernel.org>
To:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        He Zhe <zhe.he@windriver.com>, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, namhyung@kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] arm64: uprobe: Return EOPNOTSUPP for AARCH32 instruction probing
Date:   Tue, 23 Feb 2021 15:28:39 +0000
Message-Id: <161407668452.1401335.3864455032595350603.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223082535.48730-1-zhe.he@windriver.com>
References: <20210223082535.48730-1-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 16:25:34 +0800, He Zhe wrote:
> As stated in linux/errno.h, ENOTSUPP should never be seen by user programs.
> When we set up uprobe with 32-bit perf and arm64 kernel, we would see the
> following vague error without useful hint.
> 
> The sys_perf_event_open() syscall returned with 524 (INTERNAL ERROR:
> strerror_r(524, [buf], 128)=22)
> 
> [...]

Applied first patch only to arm64 (for-next/fixes), thanks!

[1/2] arm64: uprobe: Return EOPNOTSUPP for AARCH32 instruction probing
      https://git.kernel.org/arm64/c/d47422d953e2

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
