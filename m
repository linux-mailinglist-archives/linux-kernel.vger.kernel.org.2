Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2023AA325
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhFPS1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhFPS1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:27:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836EBC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:25:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x16so2853984pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BTmsE+92xrRcRnUpJMWS6o0+6/wbwvfCRpmMzrKD9ZE=;
        b=JL7xEMpRwJHDVBWIgNFYzRy3m1aVbJO09xI/NtfBc4gJlyc7L7mQJf1tCUq2jKWNN8
         PZZmo9803amxI6dbXTa6J1eTb5VIztY/Vrq35A2WFaG4+tWM/KedcvT49YxGTO29BAjW
         iXGR+yB5SztAEXqt4k9NB8E1jMpdFNzvOYkXI/EgQl8z/7hQuPge7Mvr/CzqNVPNaoQE
         NMC9fkBUJRKq+DJGiWoiLjb1/B5LJSYTzzhlg0aPHGRefx9A28ZlnAiI6T3V6tw/CZZY
         Kz42Rnp0SyQLL2zp6Kj71v8GFNFF8hFJpvG6fnCFTPyiyYatlRE9vtEo3nKYhbA6xqCU
         rb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BTmsE+92xrRcRnUpJMWS6o0+6/wbwvfCRpmMzrKD9ZE=;
        b=UyXcUvCoAb5i5UYsJSv65gGQorbdIy8Zoe8aoeyUQHrdpITDM4ba9NE6ZRguIbuiw4
         j6D9q7TCbIzDmTVfxKEuuhbGB73iWVv43THY9/imfEB7lR5dXBb89M2J4toTSjk95ZKL
         L7/p/cqEE/o/+ZfDzo7wNye6tSt8nM70vixZz9wQc59pvlFirdXLSscowGjTv80Ao9ot
         rg8f4JJueTPlsA1FNITMZd/Er5bACARSlfiRBVE1tVWWHfCu0TxVPxI4M2gO6gyWMYKj
         +V38TDKlCXdsJB3KQRMD+UKW2N9ZFcfpsBljJpLbtDWp96HFy3Fr3RtDY09IttxyMsnE
         0ecQ==
X-Gm-Message-State: AOAM530oWC7zKCtbdDhQjdo2IrU0P9L/R0f5/f8qBvVtmzpYtB87XnCt
        VE4PmzJFX5YptugiGAzyWSE=
X-Google-Smtp-Source: ABdhPJwkKS7dVl3+J070nSltDopnuD5OxEwP8XdWQod6/DkGvGggvhElYFFasXhn15t6jxLmMO+aOw==
X-Received: by 2002:a63:1d2:: with SMTP id 201mr931080pgb.3.1623867926988;
        Wed, 16 Jun 2021 11:25:26 -0700 (PDT)
Received: from nuc10 (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id a11sm2707864pjq.45.2021.06.16.11.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:25:26 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:25:22 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kmemleak memory scanning
Message-ID: <YMpCEu9yM5Ppj5jj@nuc10>
References: <YMe8ktUsdtwFKHuF@nuc10>
 <CACT4Y+ZjSbioNS8oPwUcyOrLhB6-Sf-WZmadAoAm0H-JYRLo1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZjSbioNS8oPwUcyOrLhB6-Sf-WZmadAoAm0H-JYRLo1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:15:24AM +0200, Dmitry Vyukov wrote:
> On Mon, Jun 14, 2021 at 10:31 PM Rustam Kovhaev <rkovhaev@gmail.com> wrote:
> >
> > hello Catalin, Andrew!
> >
> > while troubleshooting a false positive syzbot kmemleak report i have
> > noticed an interesting behavior in kmemleak and i wonder whether it is
> > behavior by design and should be documented, or maybe something to
> > improve.
> > apologies if some of the questions do not make sense, i am still going
> > through kmemleak code..
> >
> > a) kmemleak scans struct page (kmemleak.c:1462), but it does not scan
> > the actual contents (page_address(page)) of the page.
> > if we allocate an object with kmalloc(), then allocate page with
> > alloc_page(), and if we put kmalloc pointer somewhere inside that page,
> > kmemleak will report kmalloc pointer as a false positive.
> > should we improve kmemleak and make it scan page contents?
> > or will this bring too many false negatives?
> 
> Hi Rustam,
> 
> Nice debugging!
> I assume lots of pages are allocated for slab and we don't want to
> scan the whole page if only a few slab objects are alive on the page.
> However alloc_pages() can be called by end kernel code as well.
> I grepped for any kmemleak annotations around existing calls to
> alloc_pages, but did not find any...
> Does it require an explicit kmemleak_alloc() after allocating the page
> and kmemleak_free () before freeing the page?

hi Dmitry, thank you!
yes, as Catalin has pointed out, there are a few places where we call
kmemleak_alloc()/kmemleak_free() explicitly in order for the pages to be
scanned, like in blk_mq_alloc_rqs()

> If there are more than one use case for this, I guess we could add
> some GFP flag for this maybe.

and this way kernel users won't have to use kmemleak fuctions mentioned
above including some or most kmemleak_not_leak() calls and basically
kmemleak will be kind of "transparent" to them? and they will only need
to use the GFP flag to instruct kmemleak to scan the page contents?
it sounds like a good idea to me..

