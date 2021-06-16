Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4D3AA326
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhFPS3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbhFPS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:29:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C620DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:27:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x16so2857963pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 11:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bRtaAEoX3Wl0MO3YfnMNq5KlU2cGESsyfs3QuKUrWMQ=;
        b=CAoFIeiN+kNL5A5BZHLElpwpf4fB4PXibrFkfkDg8jZjg15B195hYji4FYq8ABOz5h
         fhMq9LN8zMSFD0XsprRhS/FWD2vwOdmBVW9O2ZCM68g+Ry9OJBV3CkZ2kgolm0Cm37Kb
         vhSXd75tmELfkUSVvZoVFuDtYjaakHpmlrvaWQlQVeCEs8zURtwXiGWnX2M4qtVP0C1M
         +MhVTCxOIMV1MQC5MrO/dzWR3ZnmYQOWxig2p+zr01yYHgMSRsFljmm9x82tqhk67qGo
         Cnw8Y43FPg7HAUqhj5U1e+EaMFF81qaouNrfEi3sw1LBeTwn4BTHyxOitSwcdRcsQ6hz
         2mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bRtaAEoX3Wl0MO3YfnMNq5KlU2cGESsyfs3QuKUrWMQ=;
        b=QcL5uGLhC+VztUDc1rfRzmBwalzcIfFtwhtJM0GlwH9y9ehSX+T7yNoGAGH3lkNogg
         MErW7mjTq9ICcscCMia87x1OHN3GPRZY0VHvofDTrvoFfj5+4oAoeusI0PWdi1qgypFm
         nXlQXhRZs74xCWh57XP9IADg8zbMOFvXGA2EkbihVFdZeSRDTlOhQ8eVGs79zitIDQgH
         /7xuygA577Lbs+4QWJPiHjEFp9aG4qsGfgmeLv9/sPpPDxlk/8Amodgh1Apa9sglFVKb
         OxTUJch0He6iUTfxCV7bzzyjNtLfRH5vFD22nXYdEAxZzckQwdlSLcPQujs+4t6LV37w
         x1dA==
X-Gm-Message-State: AOAM533qvvtCMBuWYLusWGk28og8SWqM1APC9oVqHLLeRHPM01SEMCXz
        nqQjyR0Zf1b+60nlffFNUBQ=
X-Google-Smtp-Source: ABdhPJxPM7mvIl/8AHyY05ylR3UYZjbw17Y8+HETLuFbf204YUSvzO/B3HPbmXfo4skYWltbWWTqwg==
X-Received: by 2002:a63:4e4d:: with SMTP id o13mr892766pgl.361.1623868051314;
        Wed, 16 Jun 2021 11:27:31 -0700 (PDT)
Received: from nuc10 (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id g8sm3145642pja.14.2021.06.16.11.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 11:27:31 -0700 (PDT)
Date:   Wed, 16 Jun 2021 11:27:26 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        gregkh@linuxfoundation.org
Subject: Re: kmemleak memory scanning
Message-ID: <YMpCjmCrhPwpCiid@nuc10>
References: <YMe8ktUsdtwFKHuF@nuc10>
 <f60e2a4f-2eb8-1097-60b5-eee998478068@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60e2a4f-2eb8-1097-60b5-eee998478068@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 10:12:06AM +0200, David Hildenbrand wrote:
> On 14.06.21 22:31, Rustam Kovhaev wrote:
> > hello Catalin, Andrew!
> > 
> > while troubleshooting a false positive syzbot kmemleak report i have
> > noticed an interesting behavior in kmemleak and i wonder whether it is
> > behavior by design and should be documented, or maybe something to
> > improve.
> 
> Hi,
> 
> See below regarding documentation.
> 
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
> I looked into this a while ago to see which parts of the kernel end up
> reading random physical page content and was happy to see that kmemleak does
> *not* scan random physical memory :)
> 
> We have to be very careful when reading random physical page content,
> especially in virt environments this is really undesired, or when dealing
> with memory holes, memory with problematic semantics like gart memory ...

i see, makes sense, thank you for the info!

> 
> The doc (Documentation/dev-tools/kmemleak.rst) states "Page allocations and
> ioremap are not tracked.", which includes the alloc_page() example you gave
> I think.

i see it now, ty!

