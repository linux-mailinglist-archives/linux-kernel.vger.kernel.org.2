Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3823E4A50
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhHIQwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbhHIQvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:51:36 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124A9C06179E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:51:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n12so1728734edx.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RxmdItFZkEi/9iGP3rK4lcNwD3SStqnhhfXgrwX8fQo=;
        b=fkfImuK2CwAkrjwvRu6A970SoVBxWoYKVn6s5C7o6zFPf1aZTEfddk/uRJQvnc6PLF
         6b9LgJgcCaiRLCY7hryTS4/uY4OkJcNXdIsdfFtl7/KXQPOpFT4yUYcXiJI675gVd0Ds
         0jHJg4Zn8gtADMtBwRtFoOnkG09qeVTc5J4+dAtsbgEAbNoQoJPsPWcsebscGpVG+zCM
         pc1iql2Ptxf9gbpLAtpp9fLJ1XryRf9WilD2zxJ0qGCtp5rhC+DTBGqaEMxS3NHHaU/l
         el+zq9pTeGVnuRL9B8+dUUzyJVPqkft2FRIsrRmUoDyTQ5A0Vy1xkP8M+EzONyV4M1Na
         kGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RxmdItFZkEi/9iGP3rK4lcNwD3SStqnhhfXgrwX8fQo=;
        b=j2+58BQif+KVHpDZ6cjDYtgJbA9jX594hIR4bqAyBQ4rtwodVVrhH5V4xfrQQfjKbn
         RZU72tdJ3F5TlrWvypO4G5bihsfaqJm2uPpnMci8EC/Nc0teOPccCj3gTK9RlLp139Rm
         rxRDRuYBKzLDBKs/mcLJSY8S9U0/wZwBKNmUhw0LCTHHBYqnPWwgpRNnT4Gql+KMnasJ
         1eVNy6Z74dHXVc3w3jyjdOaX8McYf1jEUhZluTw/5U8CChT+iqXMSa8WeghrPIsqApm2
         6b4d/b1DVeKSLiV7klZ2GEeGZWEURJrNYTfzP8g4QJoC+7eZb/qqfeIxwPsuDeBAxyLR
         GD9w==
X-Gm-Message-State: AOAM530EjciUnN7P/l2WUEWG342yq65Qo6rcC9Om6ZGpXOkqwxXN/A/r
        e/lmuFOpen8/Vu38owDGWZTtBZHWtbQP25Ttjk0=
X-Google-Smtp-Source: ABdhPJzKBvR7Xh7W1WPD+fdEdxDiLbn9Xad+iIj5BsEr34bkeBfaQU6933hThF8to/pk17mhhXTWvmmXUqxfmwxXibA=
X-Received: by 2002:a50:d651:: with SMTP id c17mr31525573edj.69.1628527874597;
 Mon, 09 Aug 2021 09:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210805190253.2795604-1-zi.yan@sent.com> <20210805190253.2795604-12-zi.yan@sent.com>
 <c2fa6c99-ac48-bf0b-a8ca-d1c0ffb633b6@redhat.com> <CAKgT0UdCVTYiiGHuhBv7VnyJeD3ZAijBcZPLEPc=r7QD=9veNA@mail.gmail.com>
 <42FD7031-5C3D-4EED-BD54-2F5839823E22@nvidia.com>
In-Reply-To: <42FD7031-5C3D-4EED-BD54-2F5839823E22@nvidia.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 9 Aug 2021 09:51:03 -0700
Message-ID: <CAKgT0UdLnS3CV47kOY4O5cvgUFFCLo=L5C_shga=cU6UEBZv6w@mail.gmail.com>
Subject: Re: [RFC PATCH 11/15] mm/page_reporting: report pages at section size
 instead of MAX_ORDER.
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 8:08 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 9 Aug 2021, at 10:12, Alexander Duyck wrote:
>
> > On Mon, Aug 9, 2021 at 12:25 AM David Hildenbrand <david@redhat.com> wr=
ote:
> >>
> >> On 05.08.21 21:02, Zi Yan wrote:
> >>> From: Zi Yan <ziy@nvidia.com>
> >>>
> >>> page_reporting_order was set to MAX_ORDER, which is always smaller th=
an
> >>> a memory section size. An upcoming change will make MAX_ORDER larger
> >>> than a memory section size. Set page_reporting_order to
> >>> PFN_SECTION_SHIFT to match existing size assumption.
> >>>
> >>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>> Cc: David Hildenbrand <david@redhat.com>
> >>> Cc: linux-mm@kvack.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> ---
> >>>   mm/page_reporting.c | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> >>> index 382958eef8a9..dc4a2d699862 100644
> >>> --- a/mm/page_reporting.c
> >>> +++ b/mm/page_reporting.c
> >>> @@ -11,7 +11,8 @@
> >>>   #include "page_reporting.h"
> >>>   #include "internal.h"
> >>>
> >>> -unsigned int page_reporting_order =3D MAX_ORDER;
> >>> +/* Set page_reporting_order at section size */
> >>> +unsigned int page_reporting_order =3D PFN_SECTION_SHIFT;
> >>>   module_param(page_reporting_order, uint, 0644);
> >>>   MODULE_PARM_DESC(page_reporting_order, "Set page reporting order");
> >>>
> >>>
> >>
> >> If you look closely, this is only a placeholder and will get overwritt=
en
> >> in page_reporting_register(). I don't recall why we have the module
> >> parameter at all. Most probably, to adjust the reporting order after w=
e
> >> already registered a user. Can't we just initialize that to 0 ?
> >
> > Yeah, it is pretty much there for debugging in the event that we are
> > on an architecture that is misconfigured.
>
> MAX_ORDER is changed to a boot time variable in Patch 15, thus cannot be =
used
> for page_reporting_order initialization after that.
>
> Thanks for David=E2=80=99s explanation. I will initialize page_reporting_=
order to 0
> and fix the commit message.

Rather than 0 it might be better to use (unsigned)-1 as that would
prevent page reporting from being able to run until the value is
overwritten.
