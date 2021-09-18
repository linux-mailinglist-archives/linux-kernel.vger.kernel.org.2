Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31494107A2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 18:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbhIRQsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 12:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbhIRQsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 12:48:17 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37A9C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 09:46:53 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u22so10343551oie.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=obSBg7yoA8+wBn+9K/jBy5HRK2evrx5Rl7Npq0wHYHg=;
        b=SZjbm7c3OdFuckYQ903VM07ZGtiPuY1r8bAJ+GiKVRlbJyxq/l1nqB3LXLc95HCqOR
         qFGU2jZx//GGmJ17XWYCBb8pEThdNc+e2mhGvo3FVo4NQ9HGl2MOYho8psPZ0Z7NLyc4
         +3TZN2W0u2Wn6kSutXwRWjiwQVPwNmk9olWvweTCeSOh3vRZx8HayQgDWclctfLkoeHL
         zEsAfv58yu/5kTY8lZtc9La/QhLpJQh1qILarqfuQdCotwfnro/C/8yKiHDtY8dhGlaj
         tnNrWDNo/xXlh6EawZ6DaOIp+fnox0v/Lrb68Zid3MZX0IXbJKknYBt/srLVQrxxNnmD
         oLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=obSBg7yoA8+wBn+9K/jBy5HRK2evrx5Rl7Npq0wHYHg=;
        b=3Y3rsyqaGIXWXii0sb/sEY3WdxcD4iDGuIOP22jMOFYDS4kcxJByuKt7y+pe5klmHS
         1RoBb5BgJ4PZZHX7spDGoJYlBY/29LlXh9IZEjW80+4r80WWUol2gtSPW+OeQadmlR3I
         xHA0jSVfjRfji+82DG058iI4nXhItWRJFXmZn0VX3f3fIOrrkuNIP2fACPxluaXiB8Fq
         Yy5cJMz69Y2Lc84m1vmUzx6/mwEVX7LEBA1sYAKEjoqLqoosyA3e2hO6tIedTpkfkxXB
         gNDVTSD5sqyt2HPNgSQkTPh01ylNipbIlKzqIeIHEtxOzUpkPz1oTsI3g5J7pdDtAxgn
         DGRQ==
X-Gm-Message-State: AOAM532g57DU1+EWjmayB5ugaRPjPrV82LbkALmBIlno9a2Jad/5t6he
        l1yTrz40kg0cb8IRATRXTrE=
X-Google-Smtp-Source: ABdhPJzTgiK5k3wxTcFSH+8ValyCDQhB2y+AWRWhvCRi0+VDHB1aFFghNw2fPZNAL/ckm4vd9aNheg==
X-Received: by 2002:a54:4e84:: with SMTP id c4mr13665751oiy.106.1631983613291;
        Sat, 18 Sep 2021 09:46:53 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1007? (2603-8090-2005-39b3-0000-0000-0000-1007.res6.spectrum.com. [2603:8090:2005:39b3::1007])
        by smtp.gmail.com with ESMTPSA id ay42sm2216153oib.22.2021.09.18.09.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 09:46:52 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <89d9424a-d792-633a-d8e8-cebe7c3a2e20@lwfinger.net>
Date:   Sat, 18 Sep 2021 11:46:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: staging: r8188eu: Can odm_DynamicTxPowerNIC() be removed?
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7f1c135a-d85d-d271-f315-d665a5fe1472@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <7f1c135a-d85d-d271-f315-d665a5fe1472@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/21 08:31, Michael Straube wrote:
> Hi Larry, Phillip and all.
> 
> While removing code that checks for the chip type I stumbled upon this:
> 
> 
> void odm_DynamicTxPowerNIC(struct odm_dm_struct *pDM_Odm)
> {
>      if (!(pDM_Odm->SupportAbility & ODM_BB_DYNAMIC_TXPWR))
>          return;
> 
>      if (pDM_Odm->SupportICType == ODM_RTL8188E) {
>          /*  ??? */
>          /*  This part need to be redefined. */
>      }
> }
> 
> 
> (pDM_Odm->SupportICType == ODM_RTL8188E) is always true in this driver.
> Currently the function does nothing and the driver seems to work fine.
> Because of the comment I'm not sure if the whole function can just be
> removed?

Yes, I agree. No later driver does anything with this routine, thus it is dead 
and can be removed.

Larry

