Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1290E40762B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbhIKKy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 06:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbhIKKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 06:54:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194EAC061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 03:53:13 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n5so6433761wro.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 03:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9g1h57WR+cWFjB9mDMaUTM0AGZhj7ugykY0nD7rqH0=;
        b=Pc2u8Ke3uj6l97Zkw5TCF+tmqFtPQUAjBLYANW4h4I3BlJ/vO+zMrXD4Kh69hmIKOP
         MOrHSgc5czssNqaUjXCi05fMVQ1OYeumBJra/FGEuxP9N6advWcxRwArKI16IOLwJ0vs
         evsrqJl5ouM9DPhAVmcA44xLAcRqXzmBcmPSV5nlIXpt15NKtBCg9VNW2sNPVRbROI39
         3tl8g8s95lqgnyEEUQ7+0scZsnScP939mLqgbbb4MPo42vQjGmEPDrTPV7Ad8Rvvlxx2
         yzPP8ODaf/CUbv2EBKRW2iEJImrF06LSPO3Sbi626mnogotnDu+b92lCelftx0FrhJ5n
         AZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9g1h57WR+cWFjB9mDMaUTM0AGZhj7ugykY0nD7rqH0=;
        b=b/snwCBIX3qxY/NWm+553hue9Bc1yKC9gZ0ubUJw72R4Q7cT443ta6SYlz0ZLrxq3m
         DE7Ku64779UXy5UD+mlYXaCssC98ZLMdk9QYBkD6So69Etl0iNuVDaNBvRYDZAsd3ATM
         7SszQMmOcnvW5GodQCYxyFxlGZPgBb1LDEE9r3AVN8blP2v3HKqAHZvqqUF8sJ27UcoT
         gd1MBme3g0J0Sp+PB+gMMqnthqDDtAtIcYbfOAh/fRrsVNIRvkRULxuJRwOj0HWYK6l2
         5rfCTnp3Vcn2xXNOsZcmdEX7pO2mERlHlHGsPf37oKbLn7yQn0eOr22nA/5zJkWjBbLN
         h0Yw==
X-Gm-Message-State: AOAM5311CtnoZxm+qmsjffD4cp+/dx6s8z3kieUUHDniBoDMbGlWQKlo
        zvXlPO7CBqiv7bsAOfNOfJY=
X-Google-Smtp-Source: ABdhPJyQW/a10cROwyhkoxZfR6fReG9TtRJaD7L1bcs/diDzAqFT9ef0nfBESA9Gq6eRtGoihH4mDg==
X-Received: by 2002:adf:9e4d:: with SMTP id v13mr2606136wre.26.1631357591595;
        Sat, 11 Sep 2021 03:53:11 -0700 (PDT)
Received: from agape.jhs ([5.171.81.52])
        by smtp.gmail.com with ESMTPSA id j17sm1326397wrh.67.2021.09.11.03.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 03:53:11 -0700 (PDT)
Date:   Sat, 11 Sep 2021 12:53:08 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: remove possible deadlock when
 disconnect
Message-ID: <20210911105307.GB1407@agape.jhs>
References: <20210902093559.9779-1-fabioaiuto83@gmail.com>
 <c730848c-3c8d-1e49-fa74-b956400a5d3d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c730848c-3c8d-1e49-fa74-b956400a5d3d@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

On Fri, Sep 10, 2021 at 11:06:58PM +0200, Hans de Goede wrote:
> Hi,

<snip>

> 
> Thank you for your work on this. Overall this looks good.
> 
> I have one remark, since now you are relying on the
> sta->sleep_q.lock to protect the sleep_q data, you also
> need to update the sleep_q accesses in rtw_free_stainfo()
> specifically you need to add a spin_{lock,unlock}_bh(psta->sleep_q.lock)
> around these lines:
> 
> 
>         rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
>         psta->sleepq_len = 0;
> 
> 
> Note there also is a:
> 
>         spin_lock_bh(&pxmitpriv->lock);
> 
> Just above this which needs to be pushed down to below the
> block which takes the psta->sleep_q.lock, so that the entire
> thing ends up looking like this:
> 
> 	spin_lock_bh(&psta->sleep_q.lock);
>         rtw_free_xmitframe_queue(pxmitpriv, &psta->sleep_q);
>         psta->sleepq_len = 0;
> 	spin_unlock_bh(&psta->sleep_q.lock);
> 
>         spin_lock_bh(&pxmitpriv->lock);
> 
> Other then that this patch looks good, thanks.
> 
> Regards,
> 
> Hans
> 

good catch, thanks a lot for review.

Greg, I see that this one is not in staging-next,
would you drop it so I can send a new one?
Or shall I send a Fixes: patch?

thank you all,

fabio
