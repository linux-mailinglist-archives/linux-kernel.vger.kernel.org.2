Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB0A352B70
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhDBO0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235657AbhDBO0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:26:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CBCE610D0;
        Fri,  2 Apr 2021 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617373559;
        bh=Lf93N/tl1xrWpMgnoYJzzsBTFoVZBsYXZfQ4MU67R4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzTwa3X43qv8VqHNgCql84rSJJI/YTlin3+Y/StlgQ8DTKuCduSERDWjA3+vB7kRQ
         kFspaM1LfR3jNSHFitKGOhCDhLPdwCaf/9Mk7pRaZecbL3OrTZCLVaiL/Pt57LhrnH
         WGfP/X3QiG31kYMQ+oLZuzGU+ORd2clOj37vZRtY=
Date:   Fri, 2 Apr 2021 16:25:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     He Ying <heying24@huawei.com>
Cc:     nsaenzjulienne@suse.de, sudeep.holla@arm.com,
        linus.walleij@linaro.org, robh@kernel.org, john.stultz@linaro.org,
        colin.king@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom-scm: Fix QCOM_SCM configuration
Message-ID: <YGcpdDrDJiXQX2ZJ@kroah.com>
References: <20210331064941.134333-1-heying24@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331064941.134333-1-heying24@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 02:49:41AM -0400, He Ying wrote:
> When CONFIG_QCOM_SCM is y while CONFIG_HAVE_ARM_SMCCC
> is not set, compiling errors are encountered as follows:
> 
> drivers/firmware/qcom_scm-smc.o: In function `__scm_smc_do_quirk':
> qcom_scm-smc.c:(.text+0x36): undefined reference to `__arm_smccc_smc'
> drivers/firmware/qcom_scm-legacy.o: In function `scm_legacy_call':
> qcom_scm-legacy.c:(.text+0xe2): undefined reference to `__arm_smccc_smc'
> drivers/firmware/qcom_scm-legacy.o: In function `scm_legacy_call_atomic':
> qcom_scm-legacy.c:(.text+0x1f0): undefined reference to `__arm_smccc_smc'
> 
> So add dependency on HAVE_ARM_SMCCC in QCOM_SCM configuration.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>  drivers/firmware/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

What commit caused this problem to show up?  Please add a "Fixes:" tag
in here and resend.

thanks,

greg k-h
