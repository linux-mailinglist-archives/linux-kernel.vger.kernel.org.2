Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA593E7C23
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbhHJP1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243048AbhHJP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:27:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36DCC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:27:18 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f12so21593836qkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i/IO9oWNb+i2H/cOJnKsi5t0uzz0lcp3OlV5Jwlr/e0=;
        b=jh7k7d+rNKkrGDbIfDRpAEZb0pVUBzH1X4uupkMqmO6ZiVpBDlXH39QrJLRXgGeurH
         PREcp1yE/NqtCAkpETQltOxYcblwSY0BGX5y7TxycLjGE/kHPAETej7aQrGF5cCYpqZ1
         qWBpTOgKkvKM7d5T1jm7AoJWyJhPoCvUO0TWGSpWiUO/buLXdD/0gnCjARxcjEJN0dqW
         Mv6ZKbOlIv6UZZO3INwr5cEPDX6G52ADNWgyFEDy4lfIi+bluzAsvjnajBfnNaPmFtkE
         Fa7Sl1WYS88fyUHXcI7vP4OuhinwhD0XxG1UnfilomcYVmMPXyXcSVGYfhAFiAirEsBb
         Hwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i/IO9oWNb+i2H/cOJnKsi5t0uzz0lcp3OlV5Jwlr/e0=;
        b=ocx+M4hSzKzZ9SwaIEeZpWm+UiG5y6FZeL2t/o/kgIDCiMn4Re0BsUNT2WkzH3EV5t
         V/29E/+H2YfqVmDnXlUs7Cn3P16atYycMBjdS23Pg5aPelg55Tk/p2ptgQyFbWPE4XFN
         5J6QLLQ6u2Y3lG2T3dXrwTKujgTLWMNVg6lc7ej30cpeHNc4skJRbOF//z0HsL43Pq/I
         dKnzqQzYihsZ7dBllqxkVDiV+hKU3Rsoqi5qq2d0ntcxoOX44ME3V+SF9wv1CokDX7DJ
         7gwwYvfWrRNOpEZ8yAoRODN0ee/Vpy6NBn2GY/4vkPhFI06cmy8uW05zQCZwnTo6ixbs
         ZnoQ==
X-Gm-Message-State: AOAM533iwXrTv5m/lejCTFWKhkWunxHaqH6zHQCi8aSx8fHH1n3LcoRB
        3ltCqUHFY3ImImbzekJhrOTaIA==
X-Google-Smtp-Source: ABdhPJyoKzeNHUGRc6Y0Fqw2m7K28MQLpkXHJysKiWIuwSbR09ZOTlQwsRsHEPw4UAclJ4vMyIQFBw==
X-Received: by 2002:a37:9401:: with SMTP id w1mr28916847qkd.166.1628609237211;
        Tue, 10 Aug 2021 08:27:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6a88])
        by smtp.gmail.com with ESMTPSA id bm7sm10611557qkb.79.2021.08.10.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:27:16 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:27:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, aquini@redhat.com,
        shakeelb@google.com, llong@redhat.com, mhocko@suse.com,
        hakavlad@inbox.lv
Subject: Re: [PATCH v3] vm_swappiness=0 should still try to avoid swapping
 anon memory
Message-ID: <YRKa0yzEDALtvSZO@cmpxchg.org>
References: <20210809223740.59009-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809223740.59009-1-npache@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nico,

On Mon, Aug 09, 2021 at 06:37:40PM -0400, Nico Pache wrote:
> Since commit 170b04b7ae49 ("mm/workingset: prepare the workingset detection
> infrastructure for anon LRU") and commit b91ac374346b ("mm: vmscan: enforce
> inactive:active ratio at the reclaim root") swappiness can start prematurely

Could clarify what you mean by "prematurely"?

The new balancing algorithm targets the lowest amount of overall
paging IO performed across the anon and file sets. It doesn't swap
unless it has an indication that a couple of swap writes are
outweighed by a reduction of reads on the cache side.

Is this not working for you?

> swapping anon memory. This is due to the assumption that refaulting anon should
> always allow the shrinker to target anon memory.

This doesn't sound right. Did you mean "refaulting file"?

> Add a check for swappiness being >0 before indiscriminately
> targeting Anon.

> Before these commits when a user had swappiness=0 anon memory would
> rarely get swapped; this behavior has remained constant sense
> RHEL5. This commit keeps that behavior intact and prevents the new
> workingset refaulting from challenging the anon memory when
> swappiness=0.

I'm wondering how you're getting anon scans with swappiness=0. If you
look at get_scan_count(), SCAN_FRACT with swappines=0 should always
result in ap = fraction[0] = 0, which never yields any anon scan
targets. So I'm thinking you're running into sc->file_is_tiny
situations, meaning remaining file pages alone are not enough to
restore watermarks anymore. Is that possible?

In that case, anon scanning is forced, and always has been. But the
difference is that before the above-mentioned patches, we'd usually
force scan just the smaller inactive list, whereas now we disable
active list protection due to swapins and target the entire anon
set. I suppose you'd prefer we go back to that, so that more pressure
remains proportionally on the file set, and just enough anon to get
above the watermarks again.

One complication I could see with that is that we no longer start anon
pages on the active list like we used to. We used to say active until
proven otherwise; now it's inactive until proven otherwise. It's
possible for the inactive list to contain a much bigger share of the
total anon set now than before, in which case your patch wouldn't have
the desired effect of targetting just a small amount of anon pages to
get over the watermark hump.

We may need a get_scan_count() solution after all, and I agree with
previous reviews that this is the better location for such an issue...

One thing I think we should do - whether we need more on top or not -
is allowing file reclaim to continue when sc->file_is_tiny. Yes, we
also need anon to meet the watermarks, but it's not clear why we
should stop scanning file pages altogether: it's possible they get us
there 99% of the way, and somebody clearly wanted us to swap as little
as possible to end up in a situation like that, so:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index eeab6611993c..90dac3dc9903 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2477,7 +2477,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	 * If the system is almost out of file pages, force-scan anon.
 	 */
 	if (sc->file_is_tiny) {
-		scan_balance = SCAN_ANON;
+		scan_balance = SCAN_EQUAL;
 		goto out;
 	}
 
