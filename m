Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBCC3E3EA2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 06:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhHIEF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 00:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhHIEFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 00:05:22 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71900C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 21:05:02 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id z6-20020a0568302906b02904f268d34f86so16249391otu.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 21:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=+Km123qF5UZjXQrQY9gJ4kGz6G0cVtGBqQanbfm5Z/0=;
        b=vx1qqg2jLbPcZte6V2okNj/rQRWqQowG5tBL+Zpnwfp4ITodmBR3e/EBmIaRkoQvsW
         0/zxXEZXIUdBgcN6WNoSSfRwcd3NZ78zPIpEHjD7s+FtE6kykEQGieNAgMapajzKmrbF
         QUBgdBHlvcQXT5N/Grk3HJG46F+431r2bJHE1Jlza4l9hH1i0HyQN6NIAvuUw2BVigcq
         UU8X38P5Z/cLgGDyQ2Dv8zBMwif3uudApr4+8lvu4I4V1tdIf1PxZqT/wWD06nAZsgAW
         8IFky7ZfgRCBfBqM73BAvTed3Ky7JF1mpU3CZseSGUVpf8FLCLi4SVwOKZdOZuZCOo+C
         RAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=+Km123qF5UZjXQrQY9gJ4kGz6G0cVtGBqQanbfm5Z/0=;
        b=BNmRZWGnwZ/nmJgcIlxof+Bnfymmy5u0CszfGbYb9XOmUv1Pyvh3bS9VGuQ3/v5uJF
         Snzt9aoE3/d4IIvjOJg9kgCg8hL1XtAu5QLgjkSLOTWk1/kjcdOPPVj+ckbfzzfTiOor
         L/fDoq86dE8j+LNVBmsu2Rxq2KsoAjy40q/qOX7rbsXXmG/60fUkq4cEvZ0Q2whRT/zr
         os0Ia3MlNnheAp2cfeolSUKIaMkeTO2Z0hLTtLgDs73ipRkFBp0QICgvfdbhFGH1FAHv
         WNQGz8GV0XPqPPhd68sAqutZjt5wktX7XWyCGIKpzHVRe3TSKSQV23QIDyV9pE3nlV1w
         3jeg==
X-Gm-Message-State: AOAM532m+ucwTUpgWZOZKntptKo79YOUoX0X283cG6AOTCpdIyc/l+us
        dyyEsC/0ezCpsCKESQPSqxbjEQ==
X-Google-Smtp-Source: ABdhPJzmRRREgLqTdsWiXcPBVHi1wDdjqZafF236xlUGPeq8JULCpKZYPPzTrhqoX2h8NhuS9v08eQ==
X-Received: by 2002:a05:6830:19fa:: with SMTP id t26mr15668444ott.58.1628481901582;
        Sun, 08 Aug 2021 21:05:01 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k26sm1212506otb.53.2021.08.08.21.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 21:05:01 -0700 (PDT)
Date:   Sun, 8 Aug 2021 21:04:36 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Zi Yan <ziy@nvidia.com>
cc:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [RFC PATCH 00/15] Make MAX_ORDER adjustable as a kernel boot
 time parameter.
In-Reply-To: <13DF8783-289F-4ED7-AC13-E60DF7CD0710@nvidia.com>
Message-ID: <6aaa9e7c-5ac4-a490-46f1-31d71edf72cf@google.com>
References: <20210805190253.2795604-1-zi.yan@sent.com> <0d374eed-cc52-a656-b338-1156782bdf7e@suse.cz> <F34DBD0A-22DE-4CF2-B784-BBDD80A8E85A@nvidia.com> <6ae6cd92-3ff4-7ed3-b337-a4dfe33da1c@google.com> <13DF8783-289F-4ED7-AC13-E60DF7CD0710@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1676730323-1628481900=:2587"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1676730323-1628481900=:2587
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 Aug 2021, Zi Yan wrote:
> On 6 Aug 2021, at 16:27, Hugh Dickins wrote:
> > On Fri, 6 Aug 2021, Zi Yan wrote:
> >>
> >> In addition, I would like to share more detail on my plan on supportin=
g 1GB PUD THP.
> >> This patchset is the first step, enabling kernel to allocate 1GB pages=
, so that
> >> user can get 1GB THPs from ZONE_NORMAL and ZONE_MOVABLE without using
> >> alloc_contig_pages() or CMA allocator. The next step is to improve ker=
nel memory
> >> fragmentation handling for pages up to MAX_ORDER, since currently page=
block size
> >> is still limited by memory section size. As a result, I will explore s=
olutions
> >> like having additional larger pageblocks (up to MAX_ORDER) to counter =
memory
> >> fragmentation. I will discover what else needs to be solved as I gradu=
ally improve
> >> 1GB PUD THP support.
> >
> > Sorry to be blunt, but let me state my opinion: 2MB THPs have given and
> > continue to give us more than enough trouble.  Complicating the kernel'=
s
> > mm further, just to allow 1GB THPs, seems a very bad tradeoff to me.  I
> > understand that it's an appealing personal project; but for the sake of
> > of all the rest of us, please leave 1GB huge pages to hugetlbfs (until
> > the day when we are all using 2MB base pages).
>=20
> I do not agree with you. 2MB THP provides good performance, while letting=
 us
> keep using 4KB base pages. The 2MB THP implementation is the price we pay
> to get the performance. This patchset removes the tie between MAX_ORDER
> and section size to allow >2MB page allocation, which is useful in many
> places. 1GB THP is one of the users. Gigantic pages also improve
> device performance, like GPUs (e.g., AMD GPUs can use any power of two up=
 to
> 1GB pages[1], which I just learnt). Also could you point out which part
> of my patchset complicates kernel=E2=80=99s mm? I could try to simplify i=
t if
> possible.
>=20
> In addition, I am not sure hugetlbfs is the way to go. THP is managed by
> core mm, whereas hugetlbfs has its own code for memory management.
> As hugetlbfs gets popular, more core mm functionalities have been
> replicated and added to hugetlbfs codebase. It is not a good tradeoff
> either. One of the reasons I work on 1GB THP is that Roman from Facebook
> explicitly mentioned they want to use THP in place of hugetlbfs[2].
>=20
> I think it might be more constructive to point out the existing issues
> in THP so that we can improve the code together. BTW, I am also working
> on simplifying THP code like generalizing THP split[3] and planning to
> simplify page table manipulation code by reviving Kirill=E2=80=99s idea[4=
].

You may have good reasons for working on huge PUD entry support;
and perhaps we have different understandings of "THP".

Fragmentation: that's what horrifies me about 1GB THP.

The dark side of THP is compaction.  People have put in a lot of effort
to get compaction working as well as it currently does, but getting 512
adjacent 4k pages is not easy.  Getting 512*512 adjacent 4k pages is
very much harder.  Please put in the work on compaction before you
attempt to support 1GB THP.

Related fears: unexpected latencies; unacceptable variance between runs;
frequent rebooting of machines to get back to an unfragmented state;
page table code that most of us will never be in a position to test.

Sorry, no, I'm not reading your patches: that's not personal, it's
just that I've more than enough to do already, and must make choices.

Hugh

>=20
> [1] https://lore.kernel.org/linux-mm/bdec12bd-9188-9f3e-c442-aa33e25303a6=
@amd.com/
> [2] https://lore.kernel.org/linux-mm/20200903162527.GF60440@carbon.dhcp.t=
hefacebook.com/
> [3] https://lwn.net/Articles/837928/
> [4] https://lore.kernel.org/linux-mm/20180424154355.mfjgkf47kdp2by4e@blac=
k.fi.intel.com/
>=20
> =E2=80=94
> Best Regards,
> Yan, Zi
--0-1676730323-1628481900=:2587--
