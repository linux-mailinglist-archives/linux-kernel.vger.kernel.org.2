Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43904348A28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCYH1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhCYH0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:26:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C1666196C;
        Thu, 25 Mar 2021 07:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616657193;
        bh=1IUwXoO5xAFX8usPNq7StrQ+IR6v+7aG+gGOMQNwtRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3W+ed2gPUsgYBVOZqW7LQs32SV9QfEPGyrfDYmLkGS2eioesG1AJ4Lw48T14kf6q
         SiQ8fCeU0p+/Q39/+UiGqv4I1+elNBML+NBSx4rsgDBoCtIPVgB2A/PVD6ZNb+LFt9
         x6jncotDq35Hj40N3Ntyf1N5JUIw0tL0m6RPPvq4=
Date:   Thu, 25 Mar 2021 08:26:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2] uacce: delete not be needed variable initialization
Message-ID: <YFw7JYZDuWUAZNvv@kroah.com>
References: <1616656729-31530-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616656729-31530-1-git-send-email-yekai13@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 03:18:49PM +0800, Kai Ye wrote:
> delete not be needed variable initialization.

I am sorry, but I can not parse this sentence.  Can you try resending
this with a better description?

> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/misc/uacce/uacce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If this is a v2, you have to list below the --- line what changed from
previous versions, right?  Please do so when you send a v3.

thanks,

greg k-h
