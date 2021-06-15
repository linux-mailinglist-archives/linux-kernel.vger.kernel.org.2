Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA84B3A73EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhFOC3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFOC3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:29:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5696C0613A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:27:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k25so19816586eja.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 19:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OnwcoTRfTznBR5FwE2vr68m/QZ2qvUP7gDh4qe1Pg+o=;
        b=eFgmZGaMyD2CgAnRsuEZXlPOuXj3vUt19Qq6GQdcMW+mpoif+bfcRjhUyUikAGamnj
         J5cSJGpjRDAjxug0w7rWweFRdou/pZiIttH75lRDs0XoAuUaVDb/83B1axdLvgi8sslV
         65dibn8Bxcolp9BXqjYlHPtRWb5SQydOSXO3gbbYTOiLuEkQCRJBEqbV4ogxKKIpGEUK
         +9SggoZaoBSTgAmfAJnr1J1ALrIoOqN9rAv4Tl2Zv1uwxMUYYc0GMu34lzyTDHQi/yTd
         rxgysyxouCrDNPZAwgp0tKGfTXSUTH6GT5wzMXFEiI+D9ujFW1mZXSBY3BLKxYiSfwUx
         lQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OnwcoTRfTznBR5FwE2vr68m/QZ2qvUP7gDh4qe1Pg+o=;
        b=Agug3kO9giHUxVAl8grGzf8KrWSI6ZDEAnpJKrgrupPopbHEQFbk9mzZkI1EZkOvfO
         Nc6LxY9v3XMSTEt32fafLgMtb/ro79XiRn+PUfEh/r8YXT1RVqAE8Jw+VsxRCbshdWi9
         8Dpz2m7QQYwS3pJwTdlkjoRp+8wv+idG4c/dWCYR4o6/h3YI57TsnvfJoeCQynm08+tU
         K4JIbBIp6LI/05mV+njc36gURr/Q1XTMLqnX9GcsnTUttOGNlDrx7fi/6r/in5uzMHPt
         TmevByvjsbGS7+Qm/AYG8fswnirxVAyNyAxrOxn4VuSrgvfkq7KsAVMmeTJ1TDwH7+oP
         fy7g==
X-Gm-Message-State: AOAM531vLWGHN/4Eav0KMEk/fBxVuZCUpEXfjMbYgu9Z/aMZFHqprjBW
        VJsBEImxK7ztv71Fk3qJ9v2xHqurhNVCK2TLekg=
X-Google-Smtp-Source: ABdhPJzAdbApzsofpW2WZ48tmpCbGJakUt6XAViULJJrKjZyUuf0ylbjMmD3uX6ehAnjYVbIBCTSMVq1OUwm/HPpVbY=
X-Received: by 2002:a17:906:2c4a:: with SMTP id f10mr17928384ejh.493.1623724026406;
 Mon, 14 Jun 2021 19:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210601033319.100737-1-gshan@redhat.com> <76516781-6a70-f2b0-f3e3-da999c84350f@redhat.com>
 <0c0eb8c8-463d-d6f1-3cec-bbc0af0a229c@redhat.com> <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
In-Reply-To: <b45b26ea-a6ac-934c-2467-c6e829b5d3ad@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 14 Jun 2021 19:26:55 -0700
Message-ID: <CAKgT0Ue9SQ8=ju1m6ftKTb4Tai9EJ5NQhnB_uk-DzMc19-R4cQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/page_reporting: Adjust threshold according to MAX_ORDER
To:     David Hildenbrand <david@redhat.com>
Cc:     Gavin Shan <gshan@redhat.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        shan.gavin@gmail.com, Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 4:03 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 11.06.21 09:44, Gavin Shan wrote:
> > On 6/1/21 6:01 PM, David Hildenbrand wrote:
> >> On 01.06.21 05:33, Gavin Shan wrote:
> >>> The PAGE_REPORTING_MIN_ORDER is equal to @pageblock_order, taken as
> >>> minimal order (threshold) to trigger page reporting. The page reporti=
ng
> >>> is never triggered with the following configurations and settings on
> >>> aarch64. In the particular scenario, the page reporting won't be trig=
gered
> >>> until the largest (2 ^ (MAX_ORDER-1)) free area is achieved from the
> >>> page freeing. The condition is very hard, or even impossible to be me=
t.
> >>>
> >>>     CONFIG_ARM64_PAGE_SHIFT:              16
> >>>     CONFIG_HUGETLB_PAGE:                  Y
> >>>     CONFIG_HUGETLB_PAGE_SIZE_VARIABLE:    N
> >>>     pageblock_order:                      13
> >>>     CONFIG_FORCE_MAX_ZONEORDER:           14
> >>>     MAX_ORDER:                            14
> >>>
> >>> The issue can be reproduced in VM, running kernel with above configur=
ations
> >>> and settings. The 'memhog' is used inside the VM to access 512MB anon=
ymous
> >>> area. The QEMU's RSS doesn't drop accordingly after 'memhog' exits.
> >>>
> >>>     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64          =
\
> >>>     -accel kvm -machine virt,gic-version=3Dhost                      =
  \
> >>>     -cpu host -smp 8,sockets=3D2,cores=3D4,threads=3D1 -m 4096M,maxme=
m=3D64G \
> >>>     -object memory-backend-ram,id=3Dmem0,size=3D2048M                =
    \
> >>>     -object memory-backend-ram,id=3Dmem1,size=3D2048M                =
    \
> >>>     -numa node,nodeid=3D0,cpus=3D0-3,memdev=3Dmem0                   =
      \
> >>>     -numa node,nodeid=3D1,cpus=3D4-7,memdev=3Dmem1                   =
      \
> >>>       :                                                              =
\
> >>>     -device virtio-balloon-pci,id=3Dballoon0,free-page-reporting=3Dye=
s
> >>>
> >>> This tries to fix the issue by adjusting the threshold to the smaller=
 value
> >>> of @pageblock_order and (MAX_ORDER/2). With this applied, the QEMU's =
RSS
> >>> drops after 'memhog' exits.
> >>
> >> IIRC, we use pageblock_order to
> >>
> >> a) Reduce the free page reporting overhead. Reporting on small chunks =
can make us report constantly with little system activity.
> >>
> >> b) Avoid splitting THP in the hypervisor, avoiding downgraded VM perfo=
rmance.
> >>
> >> c) Avoid affecting creation of pageblock_order pages while hinting is =
active. I think there are cases where "temporary pulling sub-pageblock page=
s" can negatively affect creation of pageblock_order pages. Concurrent comp=
action would be one of these cases.
> >>
> >> The monstrosity called aarch64 64k is really special in that sense, be=
cause a) does not apply because pageblocks are just very big, b) does somet=
imes not apply because either our VM isn't backed by (rare) 512MB THP or us=
es 4k with 2MB THP and c) similarly doesn't apply in smallish VMs because w=
e don't really happen to create 512MB THP either way.
> >>
> >>
> >> For example, going on x86-64 from reporting 2MB to something like 32KB=
 is absolutely undesired.
> >>
> >> I think if we want to go down that path (and I am not 100% sure yet if=
 we want to), we really want to treat only the special case in a special wa=
y. Note that even when doing it only for aarch64 with 64k, you will still e=
nd up splitting THP in a hypervisor if it uses 64k base pages (b)) and can =
affect creation of THP, for example, when compacting (c), so there is a neg=
ative side to that.
> >>
> >
> > [Remove Alexander from the cc list as his mail isn't reachable]
> >
>
> [adding his gmail address which should be the right one]
>
> > David, thanks for your time to review and sorry for the delay and late =
response.
> > I spent some time to get myself familiar with the code, but there are s=
till some
> > questions to me, explained as below.
> >
> > Yes, @pageblock_order is currently taken as page reporting threshold. I=
t will
> > incur more overhead if the threshold is decreased as you said in (a).
>
> Right. Alex did quite some performance/overhead evaluation when
> introducing this feature. Changing the reporting granularity on most
> setups (esp., x86-64) is not desired IMHO.

Yes, generally reporting pages comes at a fairly high cost so it is
important to find the right trade-off between the size of the page and
the size of the batch of pages being reported. If the size of the
pages is reduced it maybe important to increase the batch size in
order to avoid paying too much in the way of overhead.

The other main reason for holding to pageblock_order on x86 is to
avoid THP splitting. Anything smaller than pageblock_order will
trigger THP splitting which will significantly hurt the performance of
the VM in general as it forces it down to order 0 pages.
