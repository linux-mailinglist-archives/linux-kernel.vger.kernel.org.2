Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E9C398F6F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhFBP71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhFBP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:59:27 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE56EC061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 08:57:43 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 65so1419934qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PiMEsGQpq3LUehhbI8DOf0dylmS1YX1XfHq3USTeXx8=;
        b=Rj1zqFpwGJJYnqtQOl3TcsAYTj3xtbT5PfSAXG3eEavAMAU5SvPpMcgBZgEGjK4rPg
         k5w+LwuyhEPnXVL40E1e2x8z4SpVtSJhFVR3VUCR/pL+YCFEoOuduILwYN2DDhwVJTjS
         aVQZ6KgI8OlYaAKMJ4Omp1YW+akz8nkMlmLVYZ78XLjI+KysadcnG4uJ2Tqmcx1RX+u5
         VbukluowEeVqyk6MXmL/s3p9qaTPpadjDilPV0+0cMqpICTcF8X7GJpf4Bn7LTrBBt8d
         joK7TWQKn12xipPA18uaIHmNJYk3CI5dnxO48P8ndxuBGoCjY8rXVpOhw7yoI6Bjplon
         qlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PiMEsGQpq3LUehhbI8DOf0dylmS1YX1XfHq3USTeXx8=;
        b=cvIJXXOC/TGz2U1x/rg7OwlRejhIkOLCun6xtVJAUTSYBXURjKOQNIzUbHnawf66M6
         upWNgMSxmCxDWQ8+g8AOHTczmVmvQMVWXywKOTjUitwKNNd6cJdQ2tEMtt/DUgsDplXI
         mZtzHJStBjPndbiC1XpPH5V5Ww0FbHBHhjqCwELMT7XPgRuwAigRDb8ELWQhqG0UxxRV
         FW2sGnDJY6B4A8dq+EaaRVSSUdGiXqEMnkhhT68fHTNOPk+D3XfF+czsd5UmYc7R1Mx/
         m2X66n4XfUpmx0mDkWiY3WEaroUmABe8RzrvPheX0l7POkNstjRNfHQ36Z9+1fVfSCmg
         KGhg==
X-Gm-Message-State: AOAM531oIufWtkFABU/KQy3lEbsmgZsfZK6r485GXAwIpqynumn4z20d
        7hSodQh/LaH+Gwufy1ufgAsdvg==
X-Google-Smtp-Source: ABdhPJyWQfsfxT1L5lCPdfWfPjEw/x6wcP/E4fn6J1XvXlUXBVyD89H0Er+4Md1KjO84oQCapmheQA==
X-Received: by 2002:a05:620a:a85:: with SMTP id v5mr8137500qkg.285.1622649462162;
        Wed, 02 Jun 2021 08:57:42 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x15sm58080qtq.60.2021.06.02.08.57.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 02 Jun 2021 08:57:41 -0700 (PDT)
Date:   Wed, 2 Jun 2021 08:57:25 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yu Xu <xuyu@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        gavin.dg@linux.alibaba.com, Greg Thelen <gthelen@google.com>,
        Wei Xu <weixugc@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
In-Reply-To: <b05ab98d-3a0d-ec23-96dd-5c970aa61580@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2106020831590.6388@eggly.anvils>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com> <alpine.LSU.2.11.2106010947370.1090@eggly.anvils> <b05ab98d-3a0d-ec23-96dd-5c970aa61580@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021, Yu Xu wrote:
> On 6/2/21 12:55 AM, Hugh Dickins wrote:
> > On Wed, 2 Jun 2021, Xu Yu wrote:
> > 
> > > We notice that hung task happens in a conner but practical scenario when
> > > CONFIG_PREEMPT_NONE is enabled, as follows.
> > > 
> > > Process 0                       Process 1                     Process
> > > 2..Inf
> > > split_huge_page_to_list
> > >      unmap_page
> > >          split_huge_pmd_address
> > >                                  __migration_entry_wait(head)
> > >                                                                __migration_entry_wait(tail)
> > >      remap_page (roll back)
> > >          remove_migration_ptes
> > >              rmap_walk_anon
> > >                  cond_resched
> > > 
> > > Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
> > > copy_to_user, which will immediately fault again without rescheduling,
> > > and thus occupy the cpu fully.
> > > 
> > > When there are too many processes performing __migration_entry_wait on
> > > tail page, remap_page will never be done after cond_resched.
> > > 
> > > This relaxes __migration_entry_wait on tail page, thus gives remap_page
> > > a chance to complete.
> > > 
> > > Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
> > > Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> > 
> > Well caught: you're absolutely right that there's a bug there.
> > But isn't cond_resched() just papering over the real bug, and
> > what it should do is a "page = compound_head(page);" before the
> > get_page_unless_zero()? How does that work out in your testing?
> 
> compound_head works. The patched kernel is alive for hours under
> our reproducer, which usually makes the vanilla kernel hung after
> tens of minutes at most.

Oh, that's good news, thanks.

(It's still likely that a well-placed cond_resched() somewhere in
mm/gup.c would also be a good idea, but none of us have yet got
around to identifying where.)

> 
> If we use compound_head, the behavior of __migration_entry_wait(tail)
> changes from "retry fault" to "prevent THP from being split". Is that
> right?  Then which is preferred? If it were me, I would prefer "retry
> fault".

As Matthew remarked, you are asking very good questions, and split
migration entries are difficult to think about.  But I believe you'll
find it works out okay.

The point of *put_and_* wait_on_page_locked() is that it does drop
the page reference you acquired with get_page_unless_zero, as soon
as the page is on the wait queue, before actually waiting.

So splitting the THP is only prevented for a brief interval.  Now,
it's true that if there are very many tasks faulting on portions
of the huge page, in that interval between inserting the migration
entries and freezing the huge page's refcount to 0, they can reduce
the chance of splitting considerably.  But that's not an excuse for 
for doing get_page_unless_zero() on the wrong thing, as it was doing.

Hugh
