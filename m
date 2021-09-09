Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA10404889
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 12:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhIIKgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbhIIKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 06:36:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1784C061575;
        Thu,  9 Sep 2021 03:35:20 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id s16so2965891ybe.0;
        Thu, 09 Sep 2021 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ee8LEXKkUKUyHlSJckOaaYjlfie0ZNeZPC2GhqMmKu0=;
        b=RKTBKhGq06+iGlozL0IoYiyBtBgpYufbZMfvGjneHvo7Piqg7mqJ3ccOvy3V4EL6L9
         l6J7DYrb6Xa+scZjHwHyvz+WQUuR3Fvxhie/fdBJhto7MHTLbx8I3jlR8/dohKdLHRZ3
         CZVGZ0NMI9nqeQOUX8MXBA9JxnpgIK+aO8/+jyHniJh04z6grK5nDs9hOOjAeaYun04X
         DtmoPGXQTbHFTRr+lP3g1WEdc6GQ+Mmx2g1G9PiL+iUAg7noK77vsbuDdMTfUoDsVT/B
         BP0Fdhe9ntTh7U5Tuebxwb9jqI634spp/sAMibmrb5SprPIyS63jM7e4ueuvcdmOGZkU
         VHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ee8LEXKkUKUyHlSJckOaaYjlfie0ZNeZPC2GhqMmKu0=;
        b=1B6cyJwOVKq3VUP5Yc3F4D/j52oHG7lKrwrSL7rz2yNz7mx4yaBTPZd7PyDa3iT0Sp
         BBEbJ6RWev4y+Vauh01qBMnnOGRAYcJ65DSg+k1sESZDqVQBoQR00QmCj7PeW8Kx4QXa
         QJ8wwJJDHqmBLbMSBe5xWEHKqk+7qCXFMDcPhxJodl1mGuhTmns5OqboSRXNjU3Ds8Ux
         NXNZ3+S8j4TGPEkD23m/LNreQ0BBUl0ZH/3rUWws2L1+af7d8I5niC9zBYtNf/9wDv9m
         6g5wB0HaE1PVDHtBgwsHxdsCfARbTzCVRm0kvPOOkG7KJ0nhuauGsOY/N5Q0+OkCZRr/
         6uTQ==
X-Gm-Message-State: AOAM530te+2axlwgAbMifGMV/PlAVZH+w07aFp3oj89FNDEh294PkrrE
        7fcOedt/fPULG1pZvb2d9ZeqfOdZLk6gKmxbW0o=
X-Google-Smtp-Source: ABdhPJyA1YEdL197huY5ypPEzFi0is3ewe7cMQulhENJeJFc6h9rnYGANFcagzLuxxCjYStnD2gUrK54E80zzKMtyRE=
X-Received: by 2002:a25:5e06:: with SMTP id s6mr2954834ybb.142.1631183719883;
 Thu, 09 Sep 2021 03:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210902065902.81943-1-yaozhenguo1@gmail.com> <d445cda6-873b-5be5-cda1-1f886bce700c@oracle.com>
In-Reply-To: <d445cda6-873b-5be5-cda1-1f886bce700c@oracle.com>
From:   zhenguo yao <yaozhenguo1@gmail.com>
Date:   Thu, 9 Sep 2021 18:35:09 +0800
Message-ID: <CA+WzARmQ95vEYmgDG1Rd-Lj7CeZHut2ufWZrmtthELsp_+ERHQ@mail.gmail.com>
Subject: Re: [v3] hugetlbfs: Extend the definition of hugepages parameter to
 support node allocation
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     corbet@lwn.net, Andrew Morton <akpm@linux-foundation.org>,
        yaozhenguo@jd.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your careful review. The processing of those parameters are
really complicated. I will fix all you mentioned soon

Mike Kravetz <mike.kravetz@oracle.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=889=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:13=E5=86=99=E9=81=93=EF=BC=9A
>
> On 9/1/21 11:59 PM, yaozhenguo wrote:
> > We can specify the number of hugepages to allocate at boot. But the
> > hugepages is balanced in all nodes at present. In some scenarios,
> > we only need hugepages in one node. For example: DPDK needs hugepages
> > which is in the same node as NIC. if DPDK needs four hugepages of 1G
> > size in node1 and system has 16 numa nodes. We must reserve 64 hugepage=
s
> > in kernel cmdline. But, only four hugepages are used. The others should
> > be free after boot.If the system memory is low(for example: 64G), it wi=
ll
>                     ^ add space after . please
> > be an impossible task. So, extend hugepages kernel parameter to specify
> > node number of hugepages to allocate at boot.
> > For example add following parameter:
> >
> > hugepagesz=3D1G hugepages=3D0:1,1:3
> >
> > It will allocate 1 hugepages in node0 and 3 hugepages in node1.
> >
> > Signed-off-by: yaozhenguo <yaozhenguo1@gmail.com>
>
> Thank you for continuing to work this!  This kernel command line parsing
> code is tricky, and there is still something missing in your changes.
> I also added some suggestions to change working of documentation.
>
> > ---
> > v3:   1. Skip gigantic hugepages allocation if hugetlb_cma is enabled.
> >       2. Fix wrong behavior for parameter: hugepagesz=3D2M hugepages=3D=
2 hugepages=3D5.
> >       3. Update hugetlbpage.rst.
> >       4. Fix side effects which v2 brings in.
> >       5. add cond_resched in hugetlb_hstate_alloc_pages_onenode.
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   8 +-
> >  Documentation/admin-guide/mm/hugetlbpage.rst  |  12 +-
> >  include/linux/hugetlb.h                       |   1 +
> >  mm/hugetlb.c                                  | 116 ++++++++++++++++--
> >  4 files changed, 126 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index bdb22006f..64a128924 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1588,9 +1588,11 @@
> >                       the number of pages of hugepagesz to be allocated=
.
> >                       If this is the first HugeTLB parameter on the com=
mand
> >                       line, it specifies the number of pages to allocat=
e for
> > -                     the default huge page size.  See also
> > -                     Documentation/admin-guide/mm/hugetlbpage.rst.
> > -                     Format: <integer>
> > +                     the default huge page size. If using node format,=
 It
> > +                     specifies numbers of hugepage in a specific node.
>
> Perhaps rewrite as?
>                         the default huge page size. If using node format,=
 the
>                         number of pages to allocate per-node can be speci=
fied.
>
> > +                     See also Documentation/admin-guide/mm/hugetlbpage=
.rst.
> > +                     Format: <integer> or (node format)
> > +                             <node>:<numbers>[,<node>:<numbers>]
>
> Perhaps node format should be written as?
>                                 <node>:<integer>[,<node>:<integer>]
>
> >
> >       hugepagesz=3D
> >                       [HW] The size of the HugeTLB pages.  This is used=
 in
> > diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentati=
on/admin-guide/mm/hugetlbpage.rst
> > index 8abaeb144..bc5f674ff 100644
> > --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> > +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> > @@ -128,7 +128,9 @@ hugepages
> >       implicitly specifies the number of huge pages of default size to
> >       allocate.  If the number of huge pages of default size is implici=
tly
> >       specified, it can not be overwritten by a hugepagesz,hugepages
> > -     parameter pair for the default size.
> > +     parameter pair for the default size. This parameter also has node
> > +     format. It specifies numbers of hugepage in a specific node when
> > +     using node format.
>
> Perhaps rewrite as?
>
>         parameter pair for the default size. This parameter also has a
>         node format.  The node format specifies the number of huge pages
>         to allocate on specific nodes.
> >
> >       For example, on an architecture with 2M default huge page size::
> >
> > @@ -138,6 +140,14 @@ hugepages
> >       indicating that the hugepages=3D512 parameter is ignored.  If a h=
ugepages
> >       parameter is preceded by an invalid hugepagesz parameter, it will
> >       be ignored.
> > +
> > +     Node format example::
> > +
> > +             hugepagesz=3D2M hugepages=3D0:1,1:2
> > +
> > +     It will allocate 1 2M hugepages in node0 and 2 2M hugepages in no=
de1.
> > +     If the node number exceeds the maximum node, the parameter will b=
e
> > +     ignored.
>
> Perhaps rewrite as?
>
>         It will allocate 1 2M hugepage on node0 and 2 2M hugepages on nod=
e1.
>         If the node number is invalid,  the parameter will be ignored.
>
> >  default_hugepagesz
> >       Specify the default huge page size.  This parameter can
> >       only be specified once on the command line.  default_hugepagesz c=
an
> <snip>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> <snip>
> > @@ -3580,6 +3641,10 @@ static int __init hugetlb_init(void)
> >                               default_hstate_max_huge_pages;
> >               }
> >       }
> > +     for (i =3D 0; i < nodes_weight(node_states[N_MEMORY]); i++)
> > +             if (default_hugepages_in_node[i] > 0)
> > +                     default_hstate.max_huge_pages_node[i] =3D
> > +                                     default_hugepages_in_node[i];
>
> Logic like the above for loop also needs to be added to the routine
> default_hugepagesz_setup.  See the code block starting with:
>
>         if (default_hstate_max_huge_pages) {
>
> The kernel command line parameters,
>         hugepages=3D0:1,1:3 default_hugepagesz=3D1G
>
> should allocate 1 1G page on node 0 and 3 1G pages on node 1.  With this
> patch it will allocate 2 1G pages on node 0 and 2 1G pages on node 1.
> --
> Mike Kravetz
