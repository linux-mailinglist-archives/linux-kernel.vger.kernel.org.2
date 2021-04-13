Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A98035D51F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 04:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbhDMCDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 22:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbhDMCDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 22:03:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 19:03:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id p67so5461780pfp.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 19:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qUjaIguq8yzqDkohG7sI2rAfSZY7awUZei/nxUOMr3E=;
        b=vJNaJV+SxnOz/uU9pIGZ5okaXuBTkZF8q/Ly7teLJE7oCsuHhkgi3MBc24jkuPxSP/
         UUb0SzxQW3WlzKcfXCPF6vUHlhA7WFK0uD3vVny63Vz6MotwBIFnCLtKfHKpaPMVnAcO
         Rn1/jTBwEJ+pHqh7xmBVKVHTGC0QdzLBQDWsmu6RFxg2L90/u38pESDyfbHQ51o925FJ
         i02sTLO5QTfgTWdB57HMRXPhmlJMf2Z1KIBC/quvGPJ0XFnltyrm7MxpX8cp4/sY7gWc
         1TcTs0OGWbqBbSCvDTZPYZS9MhODFK00TgsexRH9eCLcChjcBcfbzugvm4BFWYlW1Qqc
         4QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qUjaIguq8yzqDkohG7sI2rAfSZY7awUZei/nxUOMr3E=;
        b=ErAX43i60sl/bm3rNSPwBq52bYIOx9XABcbA3B1KgNIAbYnQ4sBsiwLT6py4g1lXZ0
         iAiJ6eas6YP2x0vJn9vd6LlB8svEdhIr/LFe1Rv5mNPlYFvG649rFl+252s6MFXEhsGi
         Or9ZL4sdfRjF4qgncxtB2FdlNcrCZO17qmHjcfJbI1WJl0jQ44ksgzYCvg0Tsxgg78Ps
         /QyhFwtRpQoq7L+n1nA/Vvknml4+EQoKxoGthlUz+vaAaIK6aLw/S5FXxjzNF/bECULc
         Atd176Sw5pMasrbOQPG7aXGKPMi+DvqkknndapdhqB0QoMMkw4cjhEqDkKrSYLJFOi3J
         giPw==
X-Gm-Message-State: AOAM533SQEsLxs1QGZJaIIiDG1771fQ7ujSyUak0KnMYcpb9GYPLj05K
        +VX4eunS8f3ytpOObqGQb90=
X-Google-Smtp-Source: ABdhPJzh+KJxcTy///1/XRItUEDPHgNs0iw+HJPK72UDsZB/HlXRkeuW56DidnZcm9f7dUPEziSs9Q==
X-Received: by 2002:a05:6a00:13a0:b029:248:f411:2778 with SMTP id t32-20020a056a0013a0b0290248f4112778mr13864229pfg.66.1618279390742;
        Mon, 12 Apr 2021 19:03:10 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id d21sm577784pjx.24.2021.04.12.19.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 19:03:09 -0700 (PDT)
Date:   Tue, 13 Apr 2021 07:33:04 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v4 3/3] staging: rtl8192e: remove unnecessary parentheses
Message-ID: <YHT72MuY6mQ+JPGL@kali>
References: <cover.1618224838.git.mitaliborkar810@gmail.com>
 <29464cba775f9529db30b7fb4168198975098b55.1618224838.git.mitaliborkar810@gmail.com>
 <d82c4f4be48b645983a7f922f1791ebf098b22c5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d82c4f4be48b645983a7f922f1791ebf098b22c5.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 01:46:54PM -0700, Joe Perches wrote:
> On Mon, 2021-04-12 at 16:52 +0530, Mitali Borkar wrote:
> > Removed unnecessary parentheses because they must be used only when it
> > is necessary or they improve readability.
> > Reported by checkpatch.
> 
> I gave you feedback about the memset changes.
> Please use it.
> https://lore.kernel.org/lkml/f5fe04d62b22eb5e09c299e769d9b9d8917f119c.camel@perches.com/
>
I am sorry Sir, I missed this. I will make required changes now.

> > Changes from v3:- No changes.
> > Changes from v2:- Rectified spelling mistake in subject description.
> > Changes has been made in v3.
> > Changes from v1:- No changes.
> []
> > diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
> []
> > @@ -646,13 +646,13 @@ void HTInitializeHTInfo(struct rtllib_device *ieee)
> >  	pHTInfo->CurrentMPDUDensity = pHTInfo->MPDU_Density;
> >  	pHTInfo->CurrentAMPDUFactor = pHTInfo->AMPDU_Factor;
> >  
> > 
> > -	memset((void *)(&(pHTInfo->SelfHTCap)), 0,
> > +	memset((void *)(&pHTInfo->SelfHTCap), 0,
> >  	       sizeof(pHTInfo->SelfHTCap));
> 
> 	memset(&pHTInfo->SelfHTCap, 0, sizeof(pHTInfo->SelfHTCap);
> 
> etc...
> 
