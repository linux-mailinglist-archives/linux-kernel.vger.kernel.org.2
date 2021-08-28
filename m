Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80E83FA491
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhH1IqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 04:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhH1IqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 04:46:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76005C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 01:45:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c4so5596345plh.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mj2fJEfaUbBANZczs67LmtlLb+z0I2pfGwPFTif1uss=;
        b=a5U8orWsTW9nmja3DLUQLHRrt6u268wBDqykSLZLkcWxzmf0S2objaM9mRyzqL/+XL
         OpQPm6anCzlcOsxblKlapb2pmWERlwqiM/S42+2thugh77Go5FjGj1UlLsTht6o1vXYI
         enAD4Jou6qZN7IWDWSrhxIUziJujyN2FbY6mPMi0RX6BrZ8iMl3bFgDiosPzmGcgJfmS
         711fQo5SiQcDSdZdYfJLMM3ZW9sVqp0KBrhj/EQr425C5v1x9wPLMHOSmbtDcjv9uTny
         45EdZvoCJ4xZX6LesPrksUzYuC7MueSvjlSNTm07e6raNNpOGRNLe/J6uh9M1JGo+m6a
         pAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mj2fJEfaUbBANZczs67LmtlLb+z0I2pfGwPFTif1uss=;
        b=NIgSSTfnefHJ9JV/claf5ZREnvuIix0Ukt+Xwp8LjLFlQM9Cx5KmOhPiM74NG/gdBa
         rxsxuYITq1/93o1/7B9vNTXLAKeuc+xQMdRiHrKeXT/6UgdWhymBXj6j+eW72gaTZy8B
         ZkOAnEP54L9VMJW9JPjaoFhLLs+ZlYx1txHyXeZMu3Gh3D0pY7CPz1eUp7q0HS/H8esA
         y1dOo7m5pSIu1qthPBrtpi+P3ugmUql2lf6jWf8Tdpb+hdnu9Dxg3KJgXjMMVHiAipYX
         L67CQJfbb6LozqpiGVzUKfe4SmhSNJshTTXsZYnkLLf5BE3JtVrGGICyt0CQwtX2Yaj4
         o0cQ==
X-Gm-Message-State: AOAM533AiKRvlfpSC/RKEnQxlilb5gBFF0kWCgkaSuYSSD5tyb0FUKjN
        nNOuB8vZ43gEZ05GgorkQlU=
X-Google-Smtp-Source: ABdhPJyuWKjgRpdDqPoc221JsZzAUhi9aYvdY1P3sSv0Dmbcho5r8FvZ2OQZBnoXHyGrbXWeZAFuig==
X-Received: by 2002:a17:90a:1957:: with SMTP id 23mr14936632pjh.141.1630140330967;
        Sat, 28 Aug 2021 01:45:30 -0700 (PDT)
Received: from localhost ([49.206.124.188])
        by smtp.gmail.com with ESMTPSA id r3sm8280120pff.119.2021.08.28.01.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 01:45:30 -0700 (PDT)
Date:   Sat, 28 Aug 2021 14:15:28 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] staging: r8188eu: incorrect type in
 csum_ipv6_magic
Message-ID: <20210828084528.gbkqcgqaaf3adyb7@xps.yggdrasil>
References: <cover.1629563318.git.aakashhemadri123@gmail.com>
 <392082864befe91bb03d16ff7ca5e57ba2a8e549.1629563318.git.aakashhemadri123@gmail.com>
 <f2ab21eab23c4863b1b5c004a75d834d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ab21eab23c4863b1b5c004a75d834d@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/25 09:23AM, David Laight wrote:
> From: Aakash Hemadri
> > Sent: 23 August 2021 18:00
> > 
> > Fix sparse warning:
> > > rtw_br_ext.c:771:84:    got restricted __be16 [usertype] payload_len
> > > rtw_br_ext.c:773:110: warning: incorrect type in argument 2
> >     (different base types)
> > > rtw_br_ext.c:773:110:    expected int len
> > > rtw_br_ext.c:773:110:    got restricted __be16 [usertype] payload_len
> > 
> > csum_ipv6_magic and csum_partial expect int len not __be16, use
> > be16_to_cpu()
> 
> This is a behaviour change on LE systems.
> Even if you are testing on BE the commit message should say
> that it fixes the length passed to the checksum code and
> was detected by sparse.
> 

Thanks for the note david.

-Aakash
