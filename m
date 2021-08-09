Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1A93E4740
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhHIOMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhHIOMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:12:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD5C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 07:12:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b15so5100517ejg.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbEqHeQWK/LPgTWzyZ8GR03WKkNPEpinF3U/H1OFgTs=;
        b=RbTqP57SNdmg5Ko5v7a25j0pgLWHyoDmSCsQjeMU2i49vbQMJICtocflgalQRqHRs0
         lEvT48OXxeQ9ibQ6Gjv5vyej3Lv2FwAFXNj/7NRodGJzAz5ghStneYJDUfhYbMebVhSd
         L8ZD3o1nWWP0s14+kHaSf/JgElr9+lFf1CIXhBm/LhLlD8BfhKpcWZHTe0FXSGCiXFN8
         XVBdzBoC8xkXoN+62PZCEQxFEtC15pyzcd2fumav9m4LDOlEYY+8skzWQRhFHy9fllUY
         IU4UjiqZGp6jco3OXDD1OhNDhD2AixumFyyGaj4jodo+k5pRnntsFFTBXWZNfmHo3fMI
         5FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbEqHeQWK/LPgTWzyZ8GR03WKkNPEpinF3U/H1OFgTs=;
        b=cr5JECpbxBcIm2pZ1/Xj03ZjVXDn9Dx6oCxNJ9NjwnCm3oK6fiYlcFmuy6JsBNthkH
         0hBvAkkWnxJIm2MXEm8O57s3v068zO3eZJRj2LcTgTYwE/+FU2RZi4Am5nmARmGVm8VN
         H9blh55l52fjLon0ozGWQuw5/cRucGYw0rXHyrjzGPdpgls/dQWbw2QaJxsCEBFkVsfh
         C4vJmfR02jhYMU1BzdPALcQGfhVyGi2yd1JEZlfzNA22G3Hyf6xPYbkayznjobkEyQMC
         COOlnHzo1kP73M0+0dmetAKof6xMZ+LjLKDVAHotgcS/rOu6BE4P2ZESBFrmsWbaxa44
         ztMg==
X-Gm-Message-State: AOAM530gpXGuu14FYytMHa7avtR1cYqjmsUEXslXNJfO/XzGMO37b4j1
        SA/gWS/A2/rLpVRU1r4Vaxe55UPjYO7IsFI8z8k=
X-Google-Smtp-Source: ABdhPJyz+W3DDmMJVT1/YdURzVnHR41n2Hf20CNB9uEXLrdkdPYLu3UdLVhAoJAGLNoggNO0I2dHnRirOk9Z8mLyzcY=
X-Received: by 2002:a17:906:d0d5:: with SMTP id bq21mr3824098ejb.470.1628518335552;
 Mon, 09 Aug 2021 07:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210805190253.2795604-1-zi.yan@sent.com> <20210805190253.2795604-12-zi.yan@sent.com>
 <c2fa6c99-ac48-bf0b-a8ca-d1c0ffb633b6@redhat.com>
In-Reply-To: <c2fa6c99-ac48-bf0b-a8ca-d1c0ffb633b6@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 9 Aug 2021 07:12:04 -0700
Message-ID: <CAKgT0UdCVTYiiGHuhBv7VnyJeD3ZAijBcZPLEPc=r7QD=9veNA@mail.gmail.com>
Subject: Re: [RFC PATCH 11/15] mm/page_reporting: report pages at section size
 instead of MAX_ORDER.
To:     David Hildenbrand <david@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 12:25 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 05.08.21 21:02, Zi Yan wrote:
> > From: Zi Yan <ziy@nvidia.com>
> >
> > page_reporting_order was set to MAX_ORDER, which is always smaller than
> > a memory section size. An upcoming change will make MAX_ORDER larger
> > than a memory section size. Set page_reporting_order to
> > PFN_SECTION_SHIFT to match existing size assumption.
> >
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   mm/page_reporting.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> > index 382958eef8a9..dc4a2d699862 100644
> > --- a/mm/page_reporting.c
> > +++ b/mm/page_reporting.c
> > @@ -11,7 +11,8 @@
> >   #include "page_reporting.h"
> >   #include "internal.h"
> >
> > -unsigned int page_reporting_order = MAX_ORDER;
> > +/* Set page_reporting_order at section size */
> > +unsigned int page_reporting_order = PFN_SECTION_SHIFT;
> >   module_param(page_reporting_order, uint, 0644);
> >   MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
> >
> >
>
> If you look closely, this is only a placeholder and will get overwritten
> in page_reporting_register(). I don't recall why we have the module
> parameter at all. Most probably, to adjust the reporting order after we
> already registered a user. Can't we just initialize that to 0 ?

Yeah, it is pretty much there for debugging in the event that we are
on an architecture that is misconfigured.
