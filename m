Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0083FEB4B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343586AbhIBJak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbhIBJai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:30:38 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6620C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 02:29:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mf2so2818023ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BCIadNtgJxMuBnbXRvKUyOdGpeELhFfMWSvYcSrngec=;
        b=aWLt2Lg2fnQiH9AQHWg5eETKa/61mTI9WRLFUX/nmylrMtEA+1eW6NAo/7dgaidPEB
         XzWVeCUPHO1tdutR3FXVtqSWgURsn0ft6X0LB/U6DDibpdYwcxsYy8NjcANkLkwYLG2/
         d1mmQ54p68ABhepC6FPrzxU9/DwKmZ9DPekp4g2v4Bxm9DDMpn7JS7a673aozwcQw9oE
         6M64grjhnoCQ3gkA7Iw1TNtIRcdQGqDPMiFdCdvjNDUhES9AjHhsXeciv0knKJhfhB7Z
         VvIqmvbIhTadr2mF6UbnuGTq9Ij4oOkVtXO8/xSOXJD/szPFIr8fKjptcsBTSWiUrkRF
         +0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BCIadNtgJxMuBnbXRvKUyOdGpeELhFfMWSvYcSrngec=;
        b=WNy5zL2HPH76DiKlwI4rKwJkBlFWV7jBLehLFDvYNNc03iANc6TQSmfKdMCRy40BJ2
         urVOeqS1TuFxl1ZEejW1hDZaTNoQ6Oa9JdEUoaGRTx1yABBi2akQHk5ccc22EH0DsUTt
         jG6BKCiEYzsum3FEt/vg5Cal0sUqE1m4+uA/VmcHfFZV5x3xe9okMpym7mlb64dcieHl
         t/8byMjiLEjzcWa5QcZfF2Xz3AwlQFySIBGUof9UjeMnlDYQYaZFZwD4Rwvm4G/UOP0+
         pjDnXJL2Qq/YrG8Hic50SnUXCsCKWfukTVZB38/RUwO66aK5Gsve/vCUjjhPxLe9fq9e
         d5/Q==
X-Gm-Message-State: AOAM533cE1SysS6gnDUJsNaux7dJ5Rol6Mfel0LRzJfqOmsngOxR6lnY
        dXEvAbyizBU2+2MFED+gkNI=
X-Google-Smtp-Source: ABdhPJyULatZFvFoW3qSuW8cTMDFGP1r2V0iYpahlZ7Ujx81qTFPG/N28YCkofjrYYEKeElJsLpa2g==
X-Received: by 2002:a17:906:4892:: with SMTP id v18mr2716465ejq.541.1630574978589;
        Thu, 02 Sep 2021 02:29:38 -0700 (PDT)
Received: from agape.jhs ([5.171.72.108])
        by smtp.gmail.com with ESMTPSA id v10sm759876edt.25.2021.09.02.02.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 02:29:38 -0700 (PDT)
Date:   Thu, 2 Sep 2021 11:29:35 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        Michael Straube <straube.linux@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove possible deadlock when
 disconnect
Message-ID: <20210902092934.GA1422@agape.jhs>
References: <20210830141645.3646-1-fabioaiuto83@gmail.com>
 <YTCWwLSX0I3Ica2e@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YTCWwLSX0I3Ica2e@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On Thu, Sep 02, 2021 at 11:17:52AM +0200, Greg KH wrote:

<snip> 

> 
> With this patch applied, I get the following build warning:
> 
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c: In function ‘chk_bmc_sleepq_hdl’:
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:5922:27: warning: unused variable ‘pxmitpriv’ [-Wunused-variable]
>  5922 |         struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
>       |                           ^~~~~~~~~
> 
> 
> Please fix up and resend it, we can not add build warnings to the tree
> at any time.

oops, sorry will fix soon

> 
> thanks,
> 
> greg k-h

thank you,

fabio
