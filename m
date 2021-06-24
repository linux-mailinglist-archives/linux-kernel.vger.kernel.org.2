Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89123B34E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbhFXRjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhFXRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:39:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CB0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 10:36:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w71so5803204pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PeRKsgy74/XMQSubNA8psgjoWJKBQi8NTy2S1z7EZtA=;
        b=N/X8xyzRMvKBxZFAr3CR8HD6HGsZwVBeIe1wh3HdrE8VLQVtSsen5KkxX2ZdLIVwAT
         Ko+DoSRx662BsfDGZPoGFnWai4VGGC8J+GL8KPN/UKFYlAr96orvk5HXFA5kWJ45ZtpT
         t7GkirUt+ls5zr4SR2UZToo9tZ91JhYCzI2/QC96FkNcHfZEhXFg4/WY4J59U0TSTdxo
         q+NfcdszvkjEd9hzVIwNvYCWRDDydMgIUrf5oF+x6yuvhDB9WvmDXlrmJrvc82rdMc4s
         ea+njS9uyYa2eOeokpSTb66SogV6aLjpq02mSLTPc9R7V0TwgnsZYVZ/DlnBp2UdV1vx
         ei1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PeRKsgy74/XMQSubNA8psgjoWJKBQi8NTy2S1z7EZtA=;
        b=fq2ZKOvtatyJiLa94DK2mf1oayeLiehWDcJ63yMISbxiVSq8fnBx/hOvGiOCf1X/yz
         114JWdTlzMIJRuFxTglvPKxy8gzBu9ML0pBfJUUmKwwuclWRF9CDrDPF8C1zCzAICNWj
         WMo+fma6fCbPBRapwPeqbUiy/eu7MphghHYaIStN/soO4y1ockpjEr8kAn6VF7N2qICc
         tXBA2yqN0zLyxNJgxqp4Ld9UJykwtPzkOi2XVCT0M66uIkTYBUgyzldw2kQureD+Tjnw
         i4AjqrOZr9b2kNGTMkGw0FURzhbm3Kh3IAafMKhJO8bTaAPqkV47ZB6FnbD5B1lPqvN2
         5ErQ==
X-Gm-Message-State: AOAM5313LbaWXzzbEVg7L19/FQogwSzNkp5PW4hYpKgaJgqG75ccyFyN
        1djvteGzOFxQ9gafpLSkXrg=
X-Google-Smtp-Source: ABdhPJxQicAOfILG7//WbS8jTvHjFyObfpk6flCAdE492wQCWFsR/cO1tsK16a0MK2WxvOVGGOAlRg==
X-Received: by 2002:a63:5c04:: with SMTP id q4mr5637097pgb.127.1624556215056;
        Thu, 24 Jun 2021 10:36:55 -0700 (PDT)
Received: from nuc10 (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id y1sm3542572pfe.72.2021.06.24.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:36:54 -0700 (PDT)
Date:   Thu, 24 Jun 2021 10:36:50 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kmemleak memory scanning
Message-ID: <YNTCsqQUaYnlXGbO@nuc10>
References: <YMe8ktUsdtwFKHuF@nuc10>
 <CACT4Y+ZjSbioNS8oPwUcyOrLhB6-Sf-WZmadAoAm0H-JYRLo1g@mail.gmail.com>
 <YMpCEu9yM5Ppj5jj@nuc10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMpCEu9yM5Ppj5jj@nuc10>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 11:25:22AM -0700, Rustam Kovhaev wrote:
> On Tue, Jun 15, 2021 at 07:15:24AM +0200, Dmitry Vyukov wrote:
> > On Mon, Jun 14, 2021 at 10:31 PM Rustam Kovhaev <rkovhaev@gmail.com> wrote:
> > >
> > > hello Catalin, Andrew!
> > >
> > > while troubleshooting a false positive syzbot kmemleak report i have
> > > noticed an interesting behavior in kmemleak and i wonder whether it is
> > > behavior by design and should be documented, or maybe something to
> > > improve.
> > > apologies if some of the questions do not make sense, i am still going
> > > through kmemleak code..
> > >
> > > a) kmemleak scans struct page (kmemleak.c:1462), but it does not scan
> > > the actual contents (page_address(page)) of the page.
> > > if we allocate an object with kmalloc(), then allocate page with
> > > alloc_page(), and if we put kmalloc pointer somewhere inside that page,
> > > kmemleak will report kmalloc pointer as a false positive.
> > > should we improve kmemleak and make it scan page contents?
> > > or will this bring too many false negatives?
> > 
> > Hi Rustam,
> > 
> > Nice debugging!
> > I assume lots of pages are allocated for slab and we don't want to
> > scan the whole page if only a few slab objects are alive on the page.
> > However alloc_pages() can be called by end kernel code as well.
> > I grepped for any kmemleak annotations around existing calls to
> > alloc_pages, but did not find any...
> > Does it require an explicit kmemleak_alloc() after allocating the page
> > and kmemleak_free () before freeing the page?
> 
> hi Dmitry, thank you!
> yes, as Catalin has pointed out, there are a few places where we call
> kmemleak_alloc()/kmemleak_free() explicitly in order for the pages to be
> scanned, like in blk_mq_alloc_rqs()
> 
> > If there are more than one use case for this, I guess we could add
> > some GFP flag for this maybe.
> 
> and this way kernel users won't have to use kmemleak fuctions mentioned
> above including some or most kmemleak_not_leak() calls and basically
> kmemleak will be kind of "transparent" to them? and they will only need
> to use the GFP flag to instruct kmemleak to scan the page contents?
> it sounds like a good idea to me..
> 

i've been thinking about this and it seems like in the scenario where we
want kmemleak to scan only some part of the page, we will have to either
do separate alloc_page() calls with different flags or use 
kmemleak_scan_area() to limit the memory scan area. maybe this approach
won't simplify things and will produce more code instead of reducing it

