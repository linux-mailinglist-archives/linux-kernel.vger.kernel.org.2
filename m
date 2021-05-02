Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE451370DCD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 18:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhEBQKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 12:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEBQKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 12:10:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68405C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 09:09:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p17so1504691plf.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WnKnLYa6L3aqa5GoFfmd9JLUCyztCoRGIMqS2sYZeyY=;
        b=u7c8qEk8tGKTWLrmMEMgQ3Q1hkXZTQJt9XHTHOyE7w31SpVXBevFFhXc7w/CXbaiNq
         QYX58lUpUeuYSl5Q+TWgfRl4S+cjfv1PL52iD1SOXnA1iIcNoFg3Ay846pbwAYg1LgEk
         VLm1hwH/Cz8n3D9qAIw8M0WmMRAgFURkZQhzYPfTOrv1e6OedggM/afSn+ylyN9AOI/4
         MO1jEAXu4aK6o8lSV+CK4AFEZi0vPgcGDfnbM4/q22AL2jrlxk9Quu2wI+rBD3ILP3HD
         os9WD1S9kT7cTGERsAI3uPXA/HI7mvd2RreBTbARRqRvzDk5XOs7mN8LVCaxRR7US8h/
         YOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WnKnLYa6L3aqa5GoFfmd9JLUCyztCoRGIMqS2sYZeyY=;
        b=Cf3aRiP6h2B3AbayqJyiMoS6k5NmUhbty38eU4ONU60YrU4Uk/wTPPXzYsypwl7htM
         An7gamIn2p9/vrCw/ZaRJ6RdsPhN5jIMCQHOgwJP4JNyDFjjzJtJAjfYtuwna3pVgPA+
         0OzGiDGpPRrE/98BoRD3bhQBjYOIhXl0ijK8CvM3tVQG0TaS821aDeGLE3Xvg2bhC2J7
         l31qsDREhsckehsuXmi4gavk7cVgyUmAYKg6MMoY4JsYwjtEdIrN573rwfa2xpwoZR93
         X1s5KwNdjTxPIWfEt8Mwfb5AOmVaoqbqA4N/8VmF/D/hR0+6/8ACSSjL8XFUok1dgY8P
         nnbw==
X-Gm-Message-State: AOAM533nfCLmd3ZMcBAWpELkas+BFPCYXd8CK4MOBUsf6gpRVsMYclK5
        s3gFKfp8feFpclOGK3qww7I=
X-Google-Smtp-Source: ABdhPJzp4FejfUBTZwBwD3Qt/uF7weVbThxKacLkzLher0piU4Z+y3LPMNbQN0iObdO/2fHq+QAavQ==
X-Received: by 2002:a17:90a:8c03:: with SMTP id a3mr16150298pjo.187.1619971764767;
        Sun, 02 May 2021 09:09:24 -0700 (PDT)
Received: from user ([2001:4490:4409:14d1:d6e9:983f:6cb8:c051])
        by smtp.gmail.com with ESMTPSA id y14sm5860880pjr.51.2021.05.02.09.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 09:09:23 -0700 (PDT)
Date:   Sun, 2 May 2021 21:39:15 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     gregkh@linuxfoundation.org, marcocesati@gmail.com,
        fabioaiuto83@gmail.com, dan.carpenter@oracle.com,
        john.oldman@polehill.co.uk, ross.schm.dev@gmail.com,
        insafonov@gmail.com, hdegoede@redhat.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: rtl8723bs: Change the return type
Message-ID: <20210502160915.GA5757@user>
References: <20210428175520.GA8921@user>
 <20210429222721.rudewp22t55fkmgf@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429222721.rudewp22t55fkmgf@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 10:27:33PM +0000, Bryan Brattlof wrote:
> On Wed, Apr 28, 2021 at 11:25:20PM +0530, Saurav Girepunje wrote:
> >Remove the ret variable in rtw_suspend_common() and change
> >the return type from int to void as rtw_suspend_common()
> >always return zero unconditionally.
> >
> >Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> >---
> > drivers/staging/rtl8723bs/include/osdep_intf.h | 2 +-
> > drivers/staging/rtl8723bs/os_dep/os_intfs.c    | 5 ++---
> > drivers/staging/rtl8723bs/os_dep/sdio_intf.c   | 4 +++-
> > 3 files changed, 6 insertions(+), 5 deletions(-)
> >
> >diff --git a/drivers/staging/rtl8723bs/include/osdep_intf.h b/drivers/staging/rtl8723bs/include/osdep_intf.h
> >index 48c90f00cc2e..111e0179712a 100644
> >--- a/drivers/staging/rtl8723bs/include/osdep_intf.h
> >+++ b/drivers/staging/rtl8723bs/include/osdep_intf.h
> >@@ -66,7 +66,7 @@ void rtw_ips_pwr_down(struct adapter *padapter);
> > int rtw_drv_register_netdev(struct adapter *padapter);
> > void rtw_ndev_destructor(struct net_device *ndev);
> >
> >-int rtw_suspend_common(struct adapter *padapter);
> >+void rtw_suspend_common(struct adapter *padapter);
> > int rtw_resume_common(struct adapter *padapter);
> >
> > int netdev_open(struct net_device *pnetdev);
> >diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> >index 1f34cb2e367c..724909078d80 100644
> >--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> >+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> >@@ -1146,14 +1146,13 @@ static void rtw_suspend_normal(struct adapter *padapter)
> > 		padapter->intf_deinit(adapter_to_dvobj(padapter));
> > }
> >
> >-int rtw_suspend_common(struct adapter *padapter)
> >+void rtw_suspend_common(struct adapter *padapter)
> > {
> > 	struct dvobj_priv *psdpriv = padapter->dvobj;
> > 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
> > 	struct pwrctrl_priv *pwrpriv = dvobj_to_pwrctl(psdpriv);
> > 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> >
> >-	int ret = 0;
> > 	unsigned long start_time = jiffies;
> >
> > 	DBG_871X_LEVEL(_drv_always_, " suspend start\n");
> >@@ -1196,7 +1195,7 @@ int rtw_suspend_common(struct adapter *padapter)
> >
> > exit:
> >
> >-	return ret;
> >+	return;
> > }
> >
>
> Hi Saurav
>
> Now that this function doesn't return anything, we can also remove the
> `exit:` jump by replacing the `goto exit` on line 1175 with this
> return.
>
> --
> ~Bryan
> >
> > static int rtw_resume_process_normal(struct adapter *padapter)
> >diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> >index a9a9631dd23c..84c16925c4f5 100644
> >--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> >+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> >@@ -452,7 +452,9 @@ static int rtw_sdio_suspend(struct device *dev)
> > 		return 0;
> > 	}
> >
> >-	return rtw_suspend_common(padapter);
> >+	rtw_suspend_common(padapter);
> >+
> >+	return 0;
> > }
> >
> > static int rtw_resume_process(struct adapter *padapter)
> >--
> >2.25.1
> >
>
I think you are pointing to rtw_suspend_common function's goto statement.
Yes, We can remove now. I will send a separate patch for removing goto statement.

~Saurav
