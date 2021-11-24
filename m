Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF9C45BA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 13:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbhKXMJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:09:46 -0500
Received: from shark4.inbox.lv ([194.152.32.84]:55624 "EHLO shark4.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234102AbhKXMGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:06:50 -0500
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id 6EBE5C0178;
        Wed, 24 Nov 2021 14:03:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1637755418; bh=uswn3I7yKCxPCF1aTOeqCga4G4QdRDC7HAODYeFv594=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=l+rZ9MrZepDspl9ywUI9wcU7I3kWzUlyHmFIQnNaLcPusZuPcgmO7mRdgn++8HY27
         zdxG7mw04bCo2Q0GBM3kgCz2b60ha+tJMe4P4AqeAQAkG2GRyh+QtARkF7FA6kwRaA
         730g/9DrGn/ygPXKSBYHKc+yqkZUGJVc+E094Hd0=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 62F84C016E;
        Wed, 24 Nov 2021 14:03:38 +0200 (EET)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id RSopZvB9lvWL; Wed, 24 Nov 2021 14:03:38 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 1C440C00AF;
        Wed, 24 Nov 2021 14:03:38 +0200 (EET)
Received: from mail.inbox.lv (unknown [79.105.116.237])
        (Authenticated sender: hakavlad@inbox.lv)
        by mail.inbox.lv (Postfix) with ESMTPA id 7F59B3E6014F;
        Wed, 24 Nov 2021 14:03:33 +0200 (EET)
Date:   Wed, 24 Nov 2021 21:03:20 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        vbabka@suse.cz, neilb@suse.de, akpm@linux-foundation.org,
        corbet@lwn.net, riel@surriel.com, hannes@cmpxchg.org,
        david@fromorbit.com, willy@infradead.org, hdanton@sina.com,
        penguin-kernel@i-love.sakura.ne.jp, oleksandr@natalenko.name,
        kernel@xanmod.org, michael@michaellarabel.com, aros@gmx.com,
        hakavlad@gmail.com
Subject: Re: mm: 5.16 regression: reclaim_throttle leads to stall in
 near-OOM conditions
Message-ID: <20211124210320.591dd883@mail.inbox.lv>
In-Reply-To: <20211124115007.GG3366@techsingularity.net>
References: <20211124011954.7cab9bb4@mail.inbox.lv>
        <20211124103550.GE3366@techsingularity.net>
        <20211124195449.33f31e7f@mail.inbox.lv>
        <20211124115007.GG3366@techsingularity.net>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: AJ2EQ38cmnBBsMa9LpgflO6Go8rKNlcktDn7zrgu6HNfqLHCtMIXA2KUEpicZw/5LSPD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>but can you test this?

I have already tested different parameters, and 
found that even zero timeout is unsatisfactory.

The introduction of reclaim_throttle() itself 
dramatically worsens the stall in near-OOM.

More info: 
https://lore.kernel.org/lkml/20211124011954.7cab9bb4@mail.inbox.lv/

What test else I should perform?

Okay, on one side of the scale is the use of the CPU, on the other 
side is the risk of stall.

My dissatisfaction is caused by the fact that the scale has now 
tipped sharply in favor of stall.
Although even before this change, users complained about the inability 
to wait for OOM:
https://lore.kernel.org/lkml/d9802b6a-949b-b327-c4a6-3dbca485ec20@gmx.com/
