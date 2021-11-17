Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658FA454367
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhKQJSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbhKQJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:18:35 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C00DC061746
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 01:15:37 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p23so2184197iod.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 01:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACk4PQn1vHaB69W6op8gJKxf1Pf6xKsSVuPol3FfX/A=;
        b=SuluchQWArbxgL5qmDgWWfc+O7ICKPX5WVqb0/N1A4SiQ3JRWm1O7I/dH2arLeglgv
         VaC3zz/rnFSMEuzbnzVMXBiA/fK2eVMq4Kc3Z/wwSrRjcmqV21YrM/R/N2YwLRpW2Wvv
         EWOBJixWR+t2wsOVNt9VHrA9n3im+i0w3TeUbL9OWTUbV10ij3qwG5kBVJctG7GXhAdZ
         kdzwBWSx0fupB4NSvMAh939l1lWjihYzKhlVPok8NVqtwNMEnbrkrDKXEXomc4rvfw6g
         yWG/p5hy+TU+ofwkt8EdSsDHCHrINxhzC9GdqMzqAb1Pi/wYhl0C4E1anXIJqcdYfSWI
         2Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACk4PQn1vHaB69W6op8gJKxf1Pf6xKsSVuPol3FfX/A=;
        b=t/ukKNksmDewuS78cN6R1bsYY2IyVXHZEO0y7DN+Z93P4Q695cKMaRL+cf4S1FmuDr
         joF1ghpl0vonHAp5nOH3Ntv2FG/OSKr7U6v5uhf1nV+17VDUfhegFuYRfnq3hJ3nKgrG
         OPR/aEnbCNDVA8I62Ppfo4te5if1lrkkHkJ/28FMWEMMm37j+GmJK6pgEqPN5fGkRp2d
         mzP1vjLxm6+BWTxoqUklsiXEmp+Jfs7isc/+3cTjMmlC1I9dYm2IfjX4TdJs4cBiHjoX
         yTmNjAxHIqRegHcEuNY2OAMy41b+BLTPrbpJVVWlJyNPEuEog0+avrOtTDx6NmXjxbvz
         zQvw==
X-Gm-Message-State: AOAM531Kl3dvXaurZrb3vPhwSLbhALg3bOeGsaYbpebLmhR9b01jzoZm
        q9nv7ww0UPYDDd0bVz63b4zhR79h5/Qxw60RZhsyWw==
X-Google-Smtp-Source: ABdhPJwfBJa/yjPKJtEvFS3/zGqHa65jlsGNCyxub5+PPgySGbOE8Fu5Ad4LbmZMc0zgCsOVut1PK5NEUUNaYDfen+8=
X-Received: by 2002:a05:6602:1549:: with SMTP id h9mr9934680iow.30.1637140536222;
 Wed, 17 Nov 2021 01:15:36 -0800 (PST)
MIME-Version: 1.0
References: <20211111084415.663951-1-eranian@google.com> <20211111084415.663951-12-eranian@google.com>
 <689f7b71-32b8-ba0e-22ff-c2248662b1e1@amd.com>
In-Reply-To: <689f7b71-32b8-ba0e-22ff-c2248662b1e1@amd.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 17 Nov 2021 01:15:25 -0800
Message-ID: <CABPqkBQNpFUGm0Eu3KtPwex1r7G5C0yp-F+fsjiS+2KJ0uuRqQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] perf tools: improve IBS error handling
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        mpe@ellerman.id.au, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kim,

On Tue, Nov 16, 2021 at 8:46 AM Kim Phillips <kim.phillips@amd.com> wrote:
>
> On 11/11/21 2:44 AM, Stephane Eranian wrote:
> > From: Kim Phillips <kim.phillips@amd.com>
> >
> > This patch improves the error message returned on failed perf_event_open() on
> > AMD when using IBS.
> >
> > Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> > ---
>
> Hi, AFAICT this v2 == v1, i.e., this patch doesn't address the comments
> raised in v1:
>
> https://lore.kernel.org/lkml/aa40b532-0e95-76c0-6c9c-a91d45bf3468@amd.com/
>
> Arnaldo, orthogonal to this series, it'd be great if you could apply
> these two patches:
>
> https://lore.kernel.org/lkml/20211004214114.188477-1-kim.phillips@amd.com/T/#mc4c9c582e3816ab31af6d0187e6803de1a98ac84
>
I don't understand why this patch is related to the IBS error
handling. Patch 11/13 does not modify the evsel__env() function.
I have included your change in the new version of the patch.
Thanks.


> Then, Stephane, you could drop this patch and in your next
> version, patch 12/13 of this series would be replaced with
> what's at the end of this email:
>
> https://lore.kernel.org/lkml/20211004214114.188477-1-kim.phillips@amd.com/T/#m885ead1f280445357c91cce53c01217913bd017b
>
> Thanks,
>
> Kim
