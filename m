Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BD4350EA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhDAF7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 01:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233255AbhDAF7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 01:59:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E032361029;
        Thu,  1 Apr 2021 05:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617256755;
        bh=XD5dFTafi/zh+nbVhSvc/b+NA8PLtkafirLsfoVxupQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dXyjK55TzCMFvWujSIhwio+Y7BjQ0ZGXfPzsFH6khYyTLw9mRYNjdwX+mN4eZMIQ7
         pHq7SPRtDRTAvj34fH2JI3Hk3L/czS6TteSXmP8cEkRl16rF0ZVi7SStZB7doGonSP
         DeIgl6v/pLN0ubNiOO9bcjIrQlVb+Tcy+Zf+YGvk=
Date:   Thu, 1 Apr 2021 07:59:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        johan@kernel.org, elder@kernel.org
Subject: Re: [PATCH -next v2] staging: greybus: camera: Switch to
 memdup_user_nul()
Message-ID: <YGVhLiV1EeqIJQnM@kroah.com>
References: <20210401031752.2861248-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401031752.2861248-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:17:52AM +0800, Yang Yingliang wrote:
> Use memdup_user_nul() helper instead of open-coding to
> simplify the code.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/staging/greybus/camera.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

What changed from v1?

Always put that below the --- line like the documentation asks you to.
Please fix up and send a v3.

thanks,

greg k-h
