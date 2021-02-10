Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0AE2316022
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhBJHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:38:30 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42754 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhBJHi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:38:27 -0500
Received: by mail-pg1-f180.google.com with SMTP id o38so674275pgm.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 23:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xrVzKrroi0WiHoE1Eiac+UaIa6UslROTnvy19e6lBxc=;
        b=AAeRZiK0tngD1Zvelgp5DF2yHF+efNukWq7OHbVWzm/W50UAq4EAj07d/l7qD7H/7N
         bGUZBNljMIKYQIkpbZCmfGKPqkbHg/OXT8USTNbYEl8a27SbyeiPK7S4VNtTWJJMdshK
         ADDCM3cs9GIbsEB+oQDPnX7WK2+HQVOZhDAQrMG4tAbIf9R7EmID5cYMq1q4vmk/4dBc
         viW0kKiVxo0Fc1Am5luOr/vn+QIVvV78t0crD3pI9MHG890W6rp36mQgGQn7jW5yFRAb
         UrBXpCb6HfkTCpKtmbiwnagLup6J7dpzV179urlm5AQCJG++zIURwViu3JaBYgYnjd1U
         XS7A==
X-Gm-Message-State: AOAM531e4qjXc0vapMkpqQXo4Xad1TGllcvTBI5+6qqrVYLMTbtULIpT
        +DDaI6dbFuq983q4sTjzd7E=
X-Google-Smtp-Source: ABdhPJznPFpnLqFW26o4g5iuGiEFHDto1iWEJQp+BgovpxC+1gMiK/lG8V83mRgNWMKiYacR/5VoRg==
X-Received: by 2002:a63:564f:: with SMTP id g15mr1942501pgm.334.1612942667048;
        Tue, 09 Feb 2021 23:37:47 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.101])
        by smtp.gmail.com with ESMTPSA id u31sm1318993pgl.9.2021.02.09.23.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 23:37:46 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:07:41 +0530
From:   karthek <mail@karthek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix block comments alignment
Message-ID: <YCONRdMzQu7KAJEP@karthik-strix-linux.karthek.com>
References: <YCLaHXD/sUKM5HZE@karthik-strix-linux.karthek.com>
 <20210210072717.GS2696@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210072717.GS2696@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:27:17AM +0300, Dan Carpenter wrote:
> On Wed, Feb 10, 2021 at 12:23:17AM +0530, karthik alapati wrote:
> > fix checkpatch.pl warning for "block comments should align the * on each line"
> > 
> > Signed-off-by: karthik alapati <mail@karthek.com>
> > ---
> >  .../staging/rtl8723bs/hal/rtl8723b_phycfg.c   | 204 +++++++++---------
> >  1 file changed, 102 insertions(+), 102 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> > index cf23414d7..003f954c2 100644
> > --- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> > +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> > @@ -20,16 +20,16 @@
> >  #define MAX_DOZE_WAITING_TIMES_9x 64
> >  
> >  /**
> > -* Function:	phy_CalculateBitShift
> > -*
> > -* OverView:	Get shifted position of the BitMask
> > -*
> > -* Input:
> > -*		u32 	BitMask,
> > -*
> > -* Output:	none
> > -* Return:		u32 	Return the shift bit bit position of the mask
> > -*/
> > + * Function:	phy_CalculateBitShift
> > + *
> > + * OverView:	Get shifted position of the BitMask
> > + *
> > + * Input:
> > + *		u32 	BitMask,
> 
> Why is this on a different line??
> 
> > + *
> > + * Output:	none
> > + * Return:		u32 	Return the shift bit bit position of the mask
> 
> The "u32" is indented more than the "none".  "bit bit" is probably a
> typo?
> 
> > + */
> >  static	u32 phy_CalculateBitShift(u32 BitMask)
> >  {
> >  	u32 i;
> 
> There is a proper kernel-doc style that function comments are supposed
> to use.  https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html
> 
> ./scripts/kernel-doc -v -none drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
> 
> regards,
> dan carpenter
> 

thats my old patch
the new one is already sent to greg,lkml
