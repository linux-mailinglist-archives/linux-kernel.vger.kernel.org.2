Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5672535E44B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbhDMQnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:43:47 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:36442 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhDMQnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:43:42 -0400
Received: by mail-qt1-f178.google.com with SMTP id h7so13211237qtx.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=9C4EXys7cfIjUEHZK7V1tkpT8BGL1Zx4nV/4LT6f7X8=;
        b=e3C2Ub3I4o7ldTDk1Ko8Qak8H2nmpHyi7XE2plryEViwGZXXL9seW93xNGYI0f1d2a
         QRjLpi56L5hH5jMEG9zHFqs5Nfc5HT0yJ4dRCxmOeCQzdzkrkA5Gh0yQVBLJ+MKuMXYH
         B6H1j1ZY6VpsxQcs5XSSrA4i6LIn0Bw7TqpTVjG8McA2wESJgrspeeLwXMO4Mkine5cU
         6W24MApQoPCT8iRUeaB0PNvdljKHfy8mP+ChraXDpb4MV/U3uAYh6dUH+d5eZP9XOVv1
         eicumsrhEHlqgNcFOUqTAigw6dheO84KX793u/GbMA8vziRO+Jy7p11j4bKgjFLP9qY4
         XdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=9C4EXys7cfIjUEHZK7V1tkpT8BGL1Zx4nV/4LT6f7X8=;
        b=NXpyfJYtHW7j65kMyRarkce+DKlE5Fd0PpUBrHVEnnqjpQa54nE7IGknBTe4K2JMO6
         TYqvTOXml5rEAy7Sut9Th7DJRXIRrDhb90LXBJm20K3OQ+85Ms5qSu9LKwWm9H9tbNmo
         wKoafvktEt+2xQOsdkv281DBfHlkiOFL2u5Gz+x/mlA0PGEjNrDokfX8OmHoVHPEKdgI
         vf9mrkrE+h71ZT4djufJN1I7qAh4WXPPTEhnkXyjAzXX+LcVKYwuPfd9/IGyWdlN2bGW
         nDiV88KJ58ug/+zOvKZsW7cSO2Ga+JGEP4YG0fSqZGLJaLScsjlPgMK1tnZkjEvV85yV
         6lig==
X-Gm-Message-State: AOAM532mjXkRuoQDhFkDO4/zMjiPrg9ZO+7Z4vRwoWWFlNUvVJhEBWiw
        ea3ffvadmoxi2EtlSarwLIM=
X-Google-Smtp-Source: ABdhPJzaJgljHQoEYt/fgq2USOZ2hDDjmlKLTlGc2HSfWdaGG9y+rOvBqkhop8Mzs9Uf0SG866pPPA==
X-Received: by 2002:ac8:6d31:: with SMTP id r17mr2722436qtu.255.1618332142011;
        Tue, 13 Apr 2021 09:42:22 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id o12sm3099258qtg.14.2021.04.13.09.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 09:42:21 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     SeongJae Park <sj38.park@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        page-reclaim@google.com
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
Date:   Tue, 13 Apr 2021 16:42:15 +0000
Message-Id: <20210413164215.30555-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Tue, 13 Apr 2021 10:13:24 -0600 Jens Axboe <axboe@kernel.dk> wrote:

> On 4/13/21 1:51 AM, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Hello,
> > 
> > 
> > Very interesting work, thank you for sharing this :)
> > 
> > On Tue, 13 Apr 2021 00:56:17 -0600 Yu Zhao <yuzhao@google.com> wrote:
> > 
> >> What's new in v2
> >> ================
> >> Special thanks to Jens Axboe for reporting a regression in buffered
> >> I/O and helping test the fix.
> > 
> > Is the discussion open?  If so, could you please give me a link?
> 
> I wasn't on the initial post (or any of the lists it was posted to), but
> it's on the google page reclaim list. Not sure if that is public or not.
> 
> tldr is that I was pretty excited about this work, as buffered IO tends
> to suck (a lot) for high throughput applications. My test case was
> pretty simple:
> 
> Randomly read a fast device, using 4k buffered IO, and watch what
> happens when the page cache gets filled up. For this particular test,
> we'll initially be doing 2.1GB/sec of IO, and then drop to 1.5-1.6GB/sec
> with kswapd using a lot of CPU trying to keep up. That's mainline
> behavior.
> 
> The initial posting of this patchset did no better, in fact it did a bit
> worse. Performance dropped to the same levels and kswapd was using as
> much CPU as before, but on top of that we also got excessive swapping.
> Not at a high rate, but 5-10MB/sec continually.
> 
> I had some back and forths with Yu Zhao and tested a few new revisions,
> and the current series does much better in this regard. Performance
> still dips a bit when page cache fills, but not nearly as much, and
> kswapd is using less CPU than before.
> 
> Hope that helps,

Appreciate this kind and detailed explanation, Jens!

So, my understanding is that v2 of this patchset improved the performance by
using frequency (tier) in addition to recency (generation number) for buffered
I/O pages.  That makes sense to me.  If I'm misunderstanding, please let me
know.


Thanks,
SeongJae Park

> -- 
> Jens Axboe
> 
