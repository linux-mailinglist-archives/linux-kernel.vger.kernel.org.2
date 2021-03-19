Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254E83423E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhCSSAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhCSSAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:00:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC5CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LSQXGOox+uWbTS3r6xWtG4JVC4Hz7vay5Ab5pG8xqOU=; b=zvxadFyayw6l2oXHmu4p3HXkmV
        2wFsSJ4g9o0TXw1xpXnOAq/4wnCm5hxuKaNpKKAogvCvZCUQogvEK9OWy5Of/BboO4nzbbljs3Jai
        OpJZNZKjvQd4L/YDKeGxvszIBYLGpJCAVE3VD9zUqD6iVO6Vi2LkPPOjKUSzg+dMjssowTQUiWbhM
        D2x6mzx4Cg7W++kDb6K+DhPTPsiKk+HD/SV2W46nTpu6i2gQYkKyuYBnXgLNzHiwSGIIK4qXeyd+a
        YwKg+dXgpgCTQ8trZDBajTwpphJqEzGvQyydgL+AcDJsIIbjRdrpwe2os+FIL43IAHNqr0BO/SaRA
        m4Y11RAA==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNJQ9-001RKl-Dh; Fri, 19 Mar 2021 18:00:26 +0000
Date:   Fri, 19 Mar 2021 11:00:25 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, insafonov@gmail.com,
        dinghao.liu@zju.edu.cn, dan.carpenter@oracle.com,
        yepeilin.cs@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8188eu: Fix a typo
In-Reply-To: <20210319014120.6474-1-unixbhaskar@gmail.com>
Message-ID: <27d89fb-d14-df64-eeb2-f5b788ff294@bombadil.infradead.org>
References: <20210319014120.6474-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_110025_480629_988CFBCC 
X-CRM114-Status: GOOD (  11.63  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote: > > s/pasive/passive/
    Also need to s/varable/variable/ 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/pasive/passive/

Also need to s/varable/variable/


>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> drivers/staging/rtl8188eu/core/rtw_mlme.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> index f87dd71934c3..96d15fca48b0 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
> @@ -37,7 +37,7 @@ int rtw_init_mlme_priv(struct adapter *padapter)
> 	pmlmepriv->pscanned = NULL;
> 	pmlmepriv->fw_state = 0;
> 	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
> -	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
> +	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: passive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
>
> 	spin_lock_init(&pmlmepriv->lock);
> 	_rtw_init_queue(&pmlmepriv->free_bss_pool);
> --
> 2.26.2
>
>
