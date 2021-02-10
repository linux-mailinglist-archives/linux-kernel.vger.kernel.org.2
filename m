Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C44B31623D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhBJJaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:30:24 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:44810 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhBJJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:28:13 -0500
Received: by mail-pf1-f176.google.com with SMTP id t29so864788pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 01:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zu62HP9m63yZE307VzYXxI9D7LUnBeJ+ipjKTDKOcS0=;
        b=dJUHUoCOAWSQxZVvzA45hW7qFgHOZ+e3wsm8qpUF+ZLL4JUYqYUEGyU0TRnsZO21/z
         JOvXqC8pyK00HTFgwU7NqlXF2dbb2+Wsu+vsuwJk2v+Lslgt80f8NIwaY1d5XjRCMV69
         j1w/QzcqBPWkAVzZQeo5Vm5gnBdBN2L5FZLOhgMLvXtoychMHRc9EcgaOot1Togb7Kyw
         r+SsruUzvaE8UvO87+3MbQV4Y1/zYXxNnTo0VKWmGS/O968u7aEEUsFFWy1A1eNLbHvX
         qjl2hPv0x3rm4gSt+zXiXhBhkUoNlCba5Hias05It2TDjM0JfyChwYAKpNLkKb0wjrA3
         SU9g==
X-Gm-Message-State: AOAM530TBEhlBvxvd/CsePcxbLfs7L82WU7ihjgj/eKRsRPR7ZhRsS4O
        xDP3uaN5VUbln5x1F58lEf8=
X-Google-Smtp-Source: ABdhPJxSnmaDqTA9myTTiCWdo0YZbdY1NjfXetCIwjvCv7m+cN+YPJCUIyJnIY5CrDOhsh+TSx8i3w==
X-Received: by 2002:a63:2d3:: with SMTP id 202mr2236181pgc.438.1612949252571;
        Wed, 10 Feb 2021 01:27:32 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.101])
        by smtp.gmail.com with ESMTPSA id y15sm1635433pju.20.2021.02.10.01.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 01:27:31 -0800 (PST)
Date:   Wed, 10 Feb 2021 14:57:27 +0530
From:   karthek <mail@karthek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix function comments to follow
 kernel-doc
Message-ID: <YCOm/1Tu5Su3BZ9c@karthik-strix-linux.karthek.com>
References: <YCL6vrGPQ0uDZUI8@karthik-strix-linux.karthek.com>
 <20210210080636.GT2696@kadam>
 <CAJ5zXr1hJ6ts7Gqi_vfaJceZ8qKPgFk479h4sA9AxFrAdB8vHw@mail.gmail.com>
 <20210210090120.GU20820@kadam>
 <CAJ5zXr1OW+RfNNuXOZDjUvm=EKz5C9=GPc243z3Wk_qc3N=6sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ5zXr1OW+RfNNuXOZDjUvm=EKz5C9=GPc243z3Wk_qc3N=6sQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 02:38:28PM +0530, karthek wrote:
> On Wed, Feb 10, 2021, 2:31 PM Dan Carpenter <dan.carpenter@oracle.com>
> wrote:
> 
> > On Wed, Feb 10, 2021 at 02:28:31PM +0530, karthek wrote:
> > > On Wed, Feb 10, 2021 at 1:37 PM Dan Carpenter <dan.carpenter@oracle.com>
> > wrote:
> > > > > @@ -789,7 +759,7 @@ static void phy_PostSetBwMode8723B(struct
> > adapter *Adapter)
> > > > >
> > > > >               PHY_SetBBReg(Adapter, rFPGA1_RFMOD, bRFMOD, 0x0);
> > > > >
> > > > > -/*                   PHY_SetBBReg(Adapter, rFPGA0_AnalogParameter2,
> > BIT10, 1); */
> > > > > +     /*PHY_SetBBReg(Adapter, rFPGA0_AnalogParameter2, BIT10, 1); */
> > > >
> > > > This format is wrong.  Anyway, just delete the commented out code.
> > > >
> > > > regards,
> > > > dan carpenter
> > > >
> > >
> > > how can i delete that, i have no idea what this driver does
> > > i'm just fixing coding style issues for eudyptula challenge.
> > > i dont think its a good idea to delete the code without knowing its
> > > purpose even though its commented out
> >
> > Commented code obviously doesn't do anything at all?
> >
> > regards,
> > dan carpenter
> >
>
sorry for that html mail, im onthego,i sent it from phone
anyway here is the original message:

Ofcourse it does nothing

But why does it exist in the first place,
 
Why maintainer decided to comment it out without just deleting it?
Maybe there is some reason which i don't know
So i decided not to touch it
 
Anyway I'm new to this so just say what should i do now?
