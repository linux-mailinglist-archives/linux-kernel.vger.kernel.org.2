Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439B13DEA71
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbhHCKHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235443AbhHCKGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:06:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7687B60F58;
        Tue,  3 Aug 2021 10:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627985131;
        bh=93hGHvv0jTlTB/pEmtoCJ8yywlMMD3nceQAE0r3RVYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RIJBSN8U6aaoMxxeZTyKttqq1mHfYfV4Abqz+vr8Iv1lafIA1LVwBbszbuxrMJ8hl
         EMrfXzLjxRCF/G4EYrVMaHVz35eDp5jT7XjcO/5Zc5teOZEZNJGwuBd0jBlGlhiFNC
         CX5+biaUbp0n/FFC+hBZr3RDFPMBa3bSgXzZg56jb4+mjNXJzWS+G9/jjDEoQ3htYv
         sCYHkUuObvSY5bxnq8fVkVUlN5vq1o0rrCWaLvEzeK9A/xNmXbt6r+eMPQt4Zgw1Va
         PvxwSWLH7y04yLNIo+fxvBQwhC/HJfMXs1Fzso/4uSDYZoGgK88M6gdSXS+1baQjFO
         EfFieD6fXDqhQ==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Barry Song <song.bao.hua@hisilicon.com>,
        catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux@roeck-us.net, tyhicks@linux.microsoft.com,
        Qi Liu <liuqi115@huawei.com>, linuxarm@huawei.com,
        maz@kernel.org, Ard Biesheuvel <ard.biesheuvel@arm.com>,
        tabba@google.com, Masami Hiramatsu <mhiramat@kernel.org>,
        lecopzer.chen@mediatek.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: fix the doc of RANDOMIZE_MODULE_REGION_FULL
Date:   Tue,  3 Aug 2021 11:05:20 +0100
Message-Id: <162798340286.1497797.18069753288714137637.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210730125131.13724-1-song.bao.hua@hisilicon.com>
References: <20210730125131.13724-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2021 00:51:31 +1200, Barry Song wrote:
> Obviously kaslr is setting the module region to 2GB rather than 4GB since
> commit b2eed9b588112 ("arm64/kernel: kaslr: reduce module randomization
> range to 2 GB"). So fix the size of region in Kconfig.
> On the other hand, even though RANDOMIZE_MODULE_REGION_FULL is not set,
> module_alloc() can fall back to a 2GB window if ARM64_MODULE_PLTS is set.
> In this case, veneers are still needed. !RANDOMIZE_MODULE_REGION_FULL
> doesn't necessarily mean veneers are not needed.
> So fix the doc to be more precise to avoid any confusion to the readers
> of the code.

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: fix the doc of RANDOMIZE_MODULE_REGION_FULL
      https://git.kernel.org/arm64/c/f9c4ff2ab9fe

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
