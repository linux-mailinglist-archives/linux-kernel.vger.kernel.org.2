Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22D3372E76
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhEDRGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbhEDRG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:06:28 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1776C061763
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 10:05:33 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q2so8292147pfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+bVzPOaiGSpT9fPHodrAVpiteIe5e+Ae3qWhGcxKKAU=;
        b=kcQjh8UyCfHGDomwiT3CD9fJ4Uv6ynvJ7yVxBkSenSh8/4pBwX/ns1e1cqz5XvCt/J
         /X4r5KTma3914e56sEW0xfNH34HnbCTLcPEzZ9r7is5j1IwB1+pAPOPz5gZE99F7gCvA
         cmmJJlz3vPjEvTlna0gqbOGhjr6wyeKFP62zoJqbJ8weQppTiyYcolnZchUtGL8d2C3k
         0eSZ8sCHZHpI6ZSH5PnWrhBEPlvPaaQvYHF2rl8AORhX2pHVCzlOY9wpSdRX115Q262l
         vDWP34a0V73sWmZYN06/h8xDekYUalDNee9IxYJvQLy9a3OtYWkM12efk+irjATRNXQZ
         fGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+bVzPOaiGSpT9fPHodrAVpiteIe5e+Ae3qWhGcxKKAU=;
        b=JiBRUHWNa+FQ0IcPoVPIuXizF7wezgOquOpa4i7e5+FQ99dv31a9zDLRkLyhpcQvYN
         ixZRTuvIGya6WMGnIL5iXEJOaq3DsMU6oEKJjvx8hqU4bITrWM5KHJwd40G/bWqrtnQe
         wuBspn12eyGMxNkUcWYbdvuudZT6hfVNbXGq8PB9i6x4OVNxIeSNFSXgqdZ0wzB4U52U
         p4GWfAaNyZD5NI6rb/5naPEzqu17lkc9GbkAY3KrX0CIiO4n/rwnzUELc8LdWvqrIPo9
         19fGZtiJkPEOrf7sAH4jKoGDQXFzWYTLtUQK6H+A7eIAb6gtb2BAv33t0QBWqPi0Cn+s
         BUuA==
X-Gm-Message-State: AOAM5320LnRVi2AsWvySfNnmUoBU23LJ1/jBIi2KlazL6jyBIJDReESP
        HE2JbS9m8LvXepY32A72XXB9WfFa69sfrQ==
X-Google-Smtp-Source: ABdhPJwrzlIkkQtOwdmep59o++iyB2NlituPGYpI1BN/yYBGd2NSCYsW91QD+1JkXKZU8+AcR+A8qQ==
X-Received: by 2002:a63:5c41:: with SMTP id n1mr2160215pgm.333.1620147933177;
        Tue, 04 May 2021 10:05:33 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x9sm13848080pfq.197.2021.05.04.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 10:05:32 -0700 (PDT)
Date:   Tue, 4 May 2021 11:05:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: char: Remove useless includes
Message-ID: <20210504170530.GD1734971@xps15>
References: <20210429080639.6379-1-arnaud.pouliquen@foss.st.com>
 <20210503174238.GD1699665@xps15>
 <b2f6b9ca-9dc2-920b-941d-175779bc1034@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2f6b9ca-9dc2-920b-941d-175779bc1034@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

[...]

> 
> I started by this one and then I got carried away tested the other include...
> You are right, I just don't follow her the first rule of the "submit checklist"
> 
> "If you use a facility then #include the file that defines/declares that
> facility. Don’t depend on other header files pulling in ones that you use."
> 
> That said I just have a doubt for uapi/linux/rpmsg.h that will be include
> by rpmsg.h[2], as these includes are part of the rpmsg framework API, should we
> keep both, considering the rule as strict?

I red the last paragraph several times I can't understand what you are
trying to convey.  Please rephrase, provide more context or detail exactly where
you think we have a problem.

Thanks,
Mathieu


> 
> [1] https://www.kernel.org/doc/html/latest/process/submit-checklist.html
> [2]
> https://patchwork.kernel.org/project/linux-remoteproc/patch/20210311140413.31725-3-arnaud.pouliquen@foss.st.com/
> 
> Thanks,
> Arnaud
> 
> > 
> > Thanks,
> > Mathieu
> > 
> >>  
> >>  #define RPMSG_DEV_MAX	(MINORMASK + 1)
> >>  
> >> -- 
> >> 2.17.1
> >>
