Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC87424A41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 00:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbhJFWzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 18:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhJFWzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 18:55:38 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C32C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 15:53:45 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id j12so2969637qvk.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=S1ArjmdVM5/CQn0/TN/e+j2KUxSm5jTQpFZ+7YalclQ=;
        b=MplgysbrNxONTnuN7aE/ULFC4Q5y3j4L/xuqPqmiAun7tdaYaO/mIw3SpcBRAsiebM
         KkqWWWKUgBfrDuMMvovqc/3srxu2ubfYGY/Lr40SzCAb5WL1HV7gkGwJbrwhCg5/0xou
         oPELpMLHDHSCmHighWguqu2pSPRJ8X+Mpb5EdiuT3EkRp6MSVxnd70M/9lXB6anEMYeH
         +k/XQfVEMS7y+Awhv1WTc+42ULgRanAzkt/7lbj/QpvAwHsyg892rQhZQOWtJfe5L0vN
         Zwz/Bx/nJG2u0mUOACh4Jml8qVmL6wbtjxd4VQhxz0p3SbBhFC0Jskuc9QLHyOYwH/x5
         CMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=S1ArjmdVM5/CQn0/TN/e+j2KUxSm5jTQpFZ+7YalclQ=;
        b=VzsKtmsFNLY9o/Mx8YWGl51Cpcjr2MnmtQbStQ4AaS+snBtTOmoW1uOIHECAkykoxK
         lqT6lDs5Q4sEiZIs5LqHTyKwdOQ1tro7hPcnrv+I1ELa6ceImsnFpKLsKAxe/LeQ0EJw
         +jAqYdFbYbgD/5uV+GmwPDGyQNFfMR3vWLKGjczM3+RZLmUk8JB1HyiYFKVKR/RWDQ1v
         F7nC8p10wv6QxvkSrQ+Yu8Fw7IE2dUVYz2SHo1SaY9grGxanBzUdECp8ldPixvF5pBEv
         P1UjFdjKi7AEncACaJLpO9rD7NLYVqFgy0jZKcI/j3rZp28vHVe2BuPdzRAGxL0aAy4T
         lQ4g==
X-Gm-Message-State: AOAM530Srj9+37chetZWrLDsrZsWhyHFYIaX+oIhqa1GQJUGEjsB+W09
        sDzR0GO+v9NxW+77GF6gsjDZKaaxcA==
X-Google-Smtp-Source: ABdhPJzhX4DDbZM2IVXfT34uF6z1jB2xRk40uoQmwb+7nZ0nhv/cY5T9h0Ge/IhQdtEYMGMU+ICqIQ==
X-Received: by 2002:a0c:e1c1:: with SMTP id v1mr755124qvl.26.1633560824221;
        Wed, 06 Oct 2021 15:53:44 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t24sm4567359qkj.38.2021.10.06.15.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 15:53:43 -0700 (PDT)
Date:   Wed, 6 Oct 2021 18:53:41 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     hannes@cmpxchg.org, willy@infradead.org, rientjes@google.com
Subject: Compaction & folios
Message-ID: <YV4o9SxfYuLm1i4d@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I have some observations on memory compaction & hugepages.

Right now, the working assumption in MM is that compaction is hard and
expensive, and right now it is - because most allocations are order 0, with a
small subset being hugepage order allocations. This means any time we need a
hugepage, compaction has to move a bunch of order 0 pages around, and memory
reclaim is no help here - when we reclaim memory, it's coming back as fragmented
order 0 pages.

But what if compaction wasn't such a difficult, expensive operation?

With folios, and then folios for anonymous pages, we won't see nearly so many
order 0 allocations anymore - we'll see a spread of allocation sizes based on a
mixture of application usage patterns - something much closer to a poisson
distribution, vs. our current very bimodal distribution. And since we won't be
fragmenting all our allocations up front, memory reclaim will be freeing
allocations in this same distribution.

Which means that any time an order n allocation fails, it's likely that we'll
still have order n-1 pages free - and of those free order n-1 pages, one will
likely have a buddy that's moveable and hasn't been fragmented - meaning the
common case is that compaction will have to move _one_ (higher order) page -
we'll almost never be having to move a bunch of 4k pages.

Another way of thinking of this is that memory reclaim will be doing most of the
work that compaction has to do now to allocate a high order page. Compaction
will go from an expensive, somewhat unreliable operation to one that mostly just
works - it's going to be _much_ less of a pain point.

It may turn out that allocating hugepages still doesn't work as reliably as we'd
like - but folios are still a big help even when we can't allocate a 2MB page,
because we'll be able to fall back to an order 6 or 7 or 8 allocation, which is
something we can't do now. And, since multiple CPU vendors now support
coalescing contiguous PTE entries in the TLB, this will still get us most of the
performance benefits of using hugepages.
