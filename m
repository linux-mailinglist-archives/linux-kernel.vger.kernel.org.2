Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D518356656
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhDGIU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234102AbhDGIUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:20:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0D2461363;
        Wed,  7 Apr 2021 08:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617783616;
        bh=RIQQZ/8OzyrqcVeWTPhjOoZF88p41cOlDYgQorJvWh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSFcHHCumsdCEBMoybYS1wxglvtYG8f+/SgA1uBtK0d1UmLZxCYMCwrGHq6U0YPuD
         OnQG6+sQ9IDUh46edCwkdF9aDA07VEKNRmz0kjTxWaxBLK5NeCAT0qe59jTBB62vNB
         iAI+Ec2e2X9Uri8tHyeEPlaWTT/ZEJDRjS/R01Hs=
Date:   Wed, 7 Apr 2021 10:20:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove unused variable
Message-ID: <YG1rPiYTjo2zkiJp@kroah.com>
References: <1617765499-65626-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1617765499-65626-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:18:19AM +0800, Jiapeng Chong wrote:
> Fix the following gcc warning:
> 
> drivers/staging/rtl8723bs/core/rtw_ieee80211.c:657:15: warning: variable
> ‘sec_idx’ set but not used [-Wunused-but-set-variable].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

This does not apply to my tree anymore, please update your branch and
rebase and resend.

thanks,

greg k-h
