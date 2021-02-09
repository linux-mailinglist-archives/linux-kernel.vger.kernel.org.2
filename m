Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0810D3158F4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 22:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhBIVuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 16:50:07 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:35879 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhBITTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:19:31 -0500
Received: by mail-pl1-f180.google.com with SMTP id e9so10320188plh.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:18:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2k/d78qpcdGfcE/7XyTjLUmLITauhfpSo/Pyt61K9e0=;
        b=KvwHm2T4G9raqQlPodd3yVgeliWSb4i+rhHaA99s4kkb3Yhaid76VXTPhRtTRmEnZr
         0RRIvhRKt0ApKNtB9c5+2HomDUjvCa4s8aTryDOaxtd1etguN9FblKWOG0sakSf3iEgC
         MIlUM+YXziXCxb06mhF+tKyv7pzYyDsxM2Dc7I7e/LV/O+dFlTE8M1mp3irgyMZyRh9k
         SrlQuahfIOz7nr9V57QdIovY+3PL3velHiiwzF61DfW2+Ewfd5aif8L7rWDcdrQSgwk9
         7c4YYaS/2OhBs/9m/1FBlGYvU7kQ/zr2XONXkmGdPFD4PEoFVoD/hLFzHqffCVIaDnWt
         9joQ==
X-Gm-Message-State: AOAM533BtIVp8M3SM6CgK0Z1GcJMpmGr4b3v4fhv9za26V9/nx+ATx3s
        nOuARvrQgxXilsFgjSbfQIRipnGoo0WQcKMl
X-Google-Smtp-Source: ABdhPJzE7VCmTtyFVANQj8wVEzYvN/M8OJVjJ5KQk63E3gqf927etMQmpb+hXgN3dfwnOWqq2ny5og==
X-Received: by 2002:a17:902:ecc4:b029:e1:5a03:87b5 with SMTP id a4-20020a170902ecc4b02900e15a0387b5mr12240721plh.39.1612898267662;
        Tue, 09 Feb 2021 11:17:47 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.47])
        by smtp.gmail.com with ESMTPSA id a5sm22872652pgl.41.2021.02.09.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:17:47 -0800 (PST)
Date:   Wed, 10 Feb 2021 00:47:43 +0530
From:   karthek <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCLf16C9y6yo37x/@karthik-strix-linux.karthek.com>
References: <YCLaHXD/sUKM5HZE@karthik-strix-linux.karthek.com>
 <YCLbdtaTRk8dtsVA@kroah.com>
 <YCLd2286lLdO0BAE@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCLd2286lLdO0BAE@karthik-strix-linux.karthek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:39:15AM +0530, karthek wrote:
> On Tue, Feb 09, 2021 at 07:59:02PM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Feb 10, 2021 at 12:23:17AM +0530, karthik alapati wrote:
> > > fix checkpatch.pl warning for "block comments should align the * on each line"
> > > 
> > > Signed-off-by: karthik alapati <mail@karthek.com>
> > > ---
> > >  .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 204 +++++++++---------
> > >  1 file changed, 102 insertions(+), 102 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> > > index cf23414d7..003f954c2 100644
> > > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> > > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> > > @@ -20,16 +20,16 @@
> > >  #define MAX_DOZE_WAITING_TIMES_9x 64
> > >  
> > >  /**
> > > -* Function:	phy_CalculateBitShift
> > > -*
> > > -* OverView:	Get shifted position of the BitMask
> > > -*
> > > -* Input:
> > > -*		u32 	BitMask,
> > > -*
> > > -* Output:	none
> > > -* Return:		u32 	Return the shift bit bit position of the mask
> > > -*/
> > > + * Function:	phy_CalculateBitShift
> > > + *
> > > + * OverView:	Get shifted position of the BitMask
> > > + *
> > > + * Input:
> > > + *		u32 	BitMask,
> > > + *
> > > + * Output:	none
> > > + * Return:		u32 	Return the shift bit bit position of the mask
> > > + */
> > 
> > These huge function comments are not normal kernel coding style anyway,
> > why not fix them up to use the correct style, don't paper over it and
can you please say it straight?
what exactly do you want me to do?
> > keep this mess around any longer than it needs to be.
what mess? my mails?
> > 
> > thanks,
> > 
> > greg k-h
