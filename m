Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D3A360440
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhDOI2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:28:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74742C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:28:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t23so11678439pjy.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ThzKSBEscgyFL7BlDbMYI+gg7hmKU2tT8pbcfoQyHE=;
        b=EB5WyVh3ix9MZzij/IEz32LodRm5xEeK1ENaqom08i0kh1rewHwF9z0A4vVWYKymsi
         Glu4QXTEQN7vsCAVg01IngTM16ug60XF23mWdwSoX6iJLOti5trgUScCu+4NVS8ojABx
         KA2xohhZB06umkc1nu7I/1VyoibgwsaNaiZAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ThzKSBEscgyFL7BlDbMYI+gg7hmKU2tT8pbcfoQyHE=;
        b=FfPIJfkC9P7EMN86Dmo3MUETkLo9vGl5+paFhC/JQllMXui034DBZjpv4aWEbs14G9
         gE8WSHELF8RjFBjuBsIr3URTqGFQt2naSOJCAIVXIeHm8C0cmof6syNCB4OcmYNyQuuG
         r6B8M5Qu13xkSXIevnz5IijSCS5blGi2BbhnD7Z6cTFYUAfkmhklUif/gO96XSMcHHFb
         Wc4jPKSTvUhhtVsOzeAgwLWq+RrkMsOIXDl9ND8e7dhqBI+5iLu+qUdiD+dqBxulje0K
         2X5FzNtud/DLXI0vVjmddelfRLxh8JrL3pkgqRReYZdluRfWnVnxfz+TsbVn+LI0zklR
         4/DA==
X-Gm-Message-State: AOAM533dLbM/4LUMUcwfh/3rJWokMIFEtFkK1YOqE8Szrr5uRt+/7MRN
        MgT/ykXKmIMNc353OKTGDWK5ug==
X-Google-Smtp-Source: ABdhPJwufUFdH4CFK3f70UqzTpWzE+7CBPJ5GDsyRhkc++wi+UfbZRth4dUQsR/nEMP9EhXM9/e4lA==
X-Received: by 2002:a17:90a:7e8f:: with SMTP id j15mr2618938pjl.71.1618475291856;
        Thu, 15 Apr 2021 01:28:11 -0700 (PDT)
Received: from chromium.org (2001-b011-30d0-100d-4ff9-30de-85ee-71cc.dynamic-ip6.hinet.net. [2001:b011:30d0:100d:4ff9:30de:85ee:71cc])
        by smtp.gmail.com with ESMTPSA id x30sm1675798pgl.39.2021.04.15.01.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:28:11 -0700 (PDT)
Date:   Thu, 15 Apr 2021 16:28:08 +0800
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: macronix: Add block protection support to
 mx25u6435f
Message-ID: <YHf5GBE+HAFoTDBo@chromium.org>
References: <20210413120210.3671536-1-ikjn@chromium.org>
 <51761f1db840c51bad17f5f275b4ce1a@walle.cc>
 <CAATdQgCYoeEKfvQPNUxzMA+o4Xwtt80SoMmfweTAB1MCijyC6A@mail.gmail.com>
 <a74478aa6fa248f6b6243366055ddd52@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74478aa6fa248f6b6243366055ddd52@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 12:53:24PM +0200, Michael Walle wrote:
> Hi,
> 
> Am 2021-04-14 08:53, schrieb Ikjoon Jang:
> > On Tue, Apr 13, 2021 at 8:26 PM Michael Walle <michael@walle.cc> wrote:
> > > Am 2021-04-13 14:02, schrieb Ikjoon Jang:
> > > > This patch adds block protection support to Macronix mx25u6432f and
> > > > mx25u6435f. Two different chips share the same JEDEC ID while only
> > > > mx25u6423f support section protections. And two chips have slightly
> > > > different definitions of BP bits than generic (ST Micro)
> > > > implementation.
> > > 
> > > What is different compared to the current implementation? Could you
> > > give
> > > an example?
> > 
> > Two chips have different definitions on BP and  T/B bits.
> > - 35f has 4 BPs without T/B, BP3 behaves like T/B bit.
> 
> See below.
> 
> > - 32f has 4 BPs plus T/B on CR.
> 
> Ok, so this scheme looks like what we have right now, only that the
> TB bit is OTP and at a different place, right?

yes, right.

> 
> > 
> > # MX25U6435F
> > 
> >  BPs | BP3=0 | BP3=1
> > ---------------------
> >  000 | None  | 1/2
> >  001 | 1/128 | 3/4
> >  010 | 1/64  | 7/8
> >  011 | 1/32  | 15/16
> >  100 | 1/16  | 31/32
> >  101 | 1/8   | 63/64
> >  110 | 1/4   | 127/128
> >  111 | 1/2   | All
> > 
> > # MX25U6432F
> > 
> >   BPs | T/B=0 | T/B=1
> > ---------------------
> >  0000 | None  | None
> >  0001 | 1/128 | 1/128
> >  0010 | 1/64  | 1/64
> >  0011 | 1/32  | 1/32
> >  0100 | 1/16  | 1/16
> >  0101 | 1/8   | 1/8
> >  0110 | 1/4   | 1/4
> >  0111 | 1/2   | 1/2
> >  1xxx | All   | All
> > 
> > It seems that 35f has a unique definition on bottom protections than
> > others.
> 
> Oh my.. That looks more like an invert and the top protection is also
> different. That is, if you'd treat BP3 as T/B, then BP[2:0] = 111
> should be "lock all", but it is rather lock half.. I just looked at
> the mx25u3235f back then. There it looked correct. But now it looks
> like the top protection scheme clips on the lower end (i.e. always
> starts with 1 block), where on the current supported scheme, we clip
> on the upper end (i.e. we start with protect all and walk backwards).
> 

Yes, indeed, but it's still confusing. :)

Now I'm thinking of adding a 'table' which maps between BP mask
and lock_len in swp.c, instead of ilog2() calculations.

> > Assuming there's no way to distinguish between mx25u6435f and 32f,
> > This patch simply takes the common parts only - BP[2:0]
> > without using T/B or BP3 at all.
> 
> You could look for differences in the SFDP and then distiguish them
> during probe and set the corresponding flags. Where the flags would
> need to be implemented first. I wouldn't have a problem with saying
> we just support top protection for the MX25U6435F but then we'd need
> to make sure the BP3 is set to 0.
> 
> If you want to read out the SFDP, see here:
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=235475

you're right, those chips have different values - JESD216 and JESD216B.

> 
> > But the current swp implementation implies that "BP with all ones"
> > is to be 'all' protection while in this approach it's 1/2,
> > A hidden BP3 should be involved for 'all' protection.
> 
> Yes, so the MX25U6432F needs to have the 4bit BP flag set and the
> MX25U6435F seems to be completely different. Doh..
> 
> > > > So this patch defines a new spi_nor_locking_ops only for macronix
> > > > until this could be merged into a generic swp implementation.
> > > 
> > > TBH, I don't really like the code duplication and I'd presume that it
> > > won't ever be merged with the generic code.
> > 
> > Agree, I hope I could make a more generalized version into swp.c.
> > 
> > Honestly I expected that I just needed to add one line of
> > SPI_NOR_HAS_LOCK
> > to flash_info to support mx256432f (this was the main purpose of my
> > patch)
> > before I read the datasheets. :)
> > 
> > > 
> > > You also assume that both the WPSEL and T/B bit are 0, which might not
> > > be true. Please note that both are write-once, thus should only be
> > > read.
> > 
> > yep, that also should be considered,
> > I'm thinking just not to support WPSEL=1 case for now.
> 
> which is ok, but we should make sure it is not set at all. Now the
> question is what do we do if it is set? I'd say just don't register the
> locking ops and log a message.
> 

So the my current rough plan to support macronix's HAS_LOCK is:

a. respin your patches supporting macronix TB (OTP + CR)
b. fix swp.c to have a mapping between BP_mask and lock_len
   (or similar approach) to support unlinear/assymetric protection levels of
   MX25U35F, instead of calling ilog2()
c. Distinguish MX25U35F and MX25U32F at runtime and apply flags
   only when WPSEL==0 && SFDP==MX25U32F
   set HAS_LOCK | OTP_TB | CR_TB | HAS_4BIT_BP.
   (it's the only MX25U32F I can test the new features for now).

I'm not so sure on b part although..

> -michael

Super thanks for the review!

