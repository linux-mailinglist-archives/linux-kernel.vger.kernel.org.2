Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3D1417E90
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 02:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbhIYARL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 20:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhIYARJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 20:17:09 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C009FC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 17:15:35 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 72so29931508qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 17:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=OwMFRQCewBEe72WQD4IEpnGvQjjXIJFNkfl2nQKRlT4=;
        b=LIJ5uhukxSORdo2WdWlBRzHsJohiBmb/ZV1wl5CVzbQBoYiGCNqnhzuWAoZxsadM4F
         Prfrg4MNhBkdKbvmwRu4i30yRCYDOi2fEbKsHD2nIid4H/3QshS0mXKDK2VRPyMKTXnn
         rsFB3TcpwyfwRVAAEU+WeA8HXKk1OxoFZ4YK5srGWDYp/cJcqJCa29FefnKD7yVQ3Xhf
         M2NWFlH9eiBZ90yX/2PO9ujdN5cEm6LxLGzAz9cr3ZxKsZ0P8dL+iIDWpMDr4rUHt1h4
         SnLVgFeYtJBVqYtZktGXw6/dJ+rO1MXplq6mBSLjTCuQk38TEUmyvbl8U16n5HQG9T2x
         kh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=OwMFRQCewBEe72WQD4IEpnGvQjjXIJFNkfl2nQKRlT4=;
        b=I6DHu4nq8pKMse9YSNMcjPzeD2btnx+NOTDfWZclS3aqoTc+M357Exby+PmYZWiWnH
         RKX6bFKEhgSB80jYZOyXcaF0gSbZjaI1Sje1dm5JnQ64tgOufRV2CHmuqANv7nVdjQuj
         Es3Kpg+jwX1Si8AoERNa/B5jEOp9GT/KZl57wRMeSbCyUKzo+ydTUakBQcD827Ta5fD3
         tgxNrltv1Nn8popTgI3tBcKI9hn/alLyDwLC1wm6peoQLDy1DocWrdjSsmhMYdYkwMNb
         P/acEKalM0EpoMnkzMMo9iQzO/Xf4EtLTXOg5YEC3GCW5e5zJJa4hM3CvaKDgF5dP1F3
         uQQA==
X-Gm-Message-State: AOAM532xsMcDGEy4SMCNK4ej8yDKQYdOtJ63BnRegg3lFngNN/YIBrLf
        rGGtXDpL0ktMCdESE4DubpmQYg==
X-Google-Smtp-Source: ABdhPJxlyvHAagqCDX6Wz5pDMCTA56s1lBrothTboLcIgFKVu7u8jqfmJoex8UPOEGorzpiqCgWTfw==
X-Received: by 2002:a37:9c09:: with SMTP id f9mr13015689qke.373.1632528934319;
        Fri, 24 Sep 2021 17:15:34 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c10sm6583366qtb.20.2021.09.24.17.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 17:15:33 -0700 (PDT)
Date:   Fri, 24 Sep 2021 17:15:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liu Yintao <liuyuntao10@huawei.com>
cc:     Hugh Dickins <hughd@google.com>, kirill@shutemov.name,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        liusirui@huawei.com, windspectator@gmail.com, wuxu.wu@huawei.com
Subject: Re: [PATCH v2] fix judgment error in shmem_is_huge()
In-Reply-To: <8a5bc69-193e-9b4a-2161-b03b69eebed2@google.com>
Message-ID: <614538e2-16bb-2657-f374-64195c5c7c2@google.com>
References: <20210909032007.18353-1-liuyuntao10@huawei.com> <8a5bc69-193e-9b4a-2161-b03b69eebed2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021, Hugh Dickins wrote:
> On Thu, 9 Sep 2021, Liu Yuntao wrote:
> 
> > In the case of SHMEM_HUGE_WITHIN_SIZE, the page index is not rounded
> > up correctly. When the page index points to the first page in a huge
> > page, round_up() cannot bring it to the end of the huge page, but
> > to the end of the previous one.
> > 
> > an example:
> > HPAGE_PMD_NR on my machine is 512(2 MB huge page size).
> > After allcoating a 3000 KB buffer, I access it at location 2050 KB.
> 
> Your example is certainly helpful, but weird!  It's not impossible,
> but wouldn't it be easier to understand if you said "2048 KB" there?
> 
> > In shmem_is_huge(), the corresponding index happens to be 512.
> > After rounded up by HPAGE_PMD_NR, it will still be 512 which is
> > smaller than i_size, and shmem_is_huge() will return true.
> > As a result, my buffer takes an additional huge page, and that
> > shouldn't happen when shmem_enabled is set to within_size.
> 
> A colleague very recently opened my eyes to within_size on shmem_enabled:
> I've always been dubious of both, but they can work quite well together.
> 
> > 
> > Fixes: f3f0e1d2150b2b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> > Signed-off-by: Liu Yuntao <liuyuntao10@huawei.com>
> 
> Thanks, with a nice simplification from Kirill.
> 
> Acked-by: Hugh Dickins <hughd@google.com>

Andrew has just sent this on to Linus - thanks - and that's fine:
no need to get in the way of that.

But since replying, I have remembered more history, and there is
something that we need to be aware of.

Whereas to you this is a straightforward off-by-one (or off-by-page)
fix, it also results in a significant change in behaviour - I'd say
usually for the better, but some might be surprised.  This patch has
Kirill's Ack and my Ack, and I hope and believe that we can get away
with the change in behaviour: but let's be aware of it.

The change that concerns me is when, for example, copying a large
file into a huge=within_size tmpfs (or more generally, just writing
to the file by appending at EOF in the usual way).

With the old WITHIN_SIZE code, the first 2MB was allocated in small
pages, then subsequent 2MB extents were allocated with huge pages;
including the final extent, even if it only needed a single byte.

I always thought that was very clunky behaviour, the small pages
coming at the wrong end of the file; and that's why I was dubious
about it as a sensible filesystem mount option.  But I was under
the impression that it was the intended behaviour.

With your new WITHIN_SIZE code, all those appending allocations
are outside i_size, and the whole file is allocated in small pages.
(Then maybe later on khugepaged can assemble huge pages for it.)

Your patch makes within_size more sensible than it was for pre-sized
files (and I think it's fair to say that the majority of files in
shmem's internal mount, subject to thp/shmem_enabled, are likely to
be fixed-size files); and better-defined than it used to be on
growing files, but they won't get the huge pages they used to.

Hugh
