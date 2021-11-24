Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7102245B8B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbhKXK6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:58:32 -0500
Received: from shark1.inbox.lv ([194.152.32.81]:55130 "EHLO shark1.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233895AbhKXK6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:58:31 -0500
Received: from shark1.inbox.lv (localhost [127.0.0.1])
        by shark1-out.inbox.lv (Postfix) with ESMTP id DB0D9111814A;
        Wed, 24 Nov 2021 12:55:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1637751319; bh=Ii1Ydxju31WL8qCm5cQWmdVpFT2pD3ONL0XsQqWqs80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=bva11nH58ebVa6TSvQbhUwp6ZfGxFU1zteYf82RnctQ1wv8eOrZxTSrQrU/Yv8gtf
         nXb1meixEJVC4GaaLkATaC+bYV8x/XhWM6UM6IxRU0CMJcRFaTHvaNYGin93DB1VVg
         XwyvjG9yZ97gHvGd5RzqGWLck1xZ6TA2a4zmz8JI=
Received: from localhost (localhost [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id D2BF4111810E;
        Wed, 24 Nov 2021 12:55:19 +0200 (EET)
Received: from shark1.inbox.lv ([127.0.0.1])
        by localhost (shark1.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id Lg2GQz0JWiX7; Wed, 24 Nov 2021 12:55:19 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark1-in.inbox.lv (Postfix) with ESMTP id 88767111810D;
        Wed, 24 Nov 2021 12:55:19 +0200 (EET)
Received: from mail.inbox.lv (unknown [79.105.116.237])
        (Authenticated sender: hakavlad@inbox.lv)
        by mail.inbox.lv (Postfix) with ESMTPA id 82EFC3E6014F;
        Wed, 24 Nov 2021 12:55:14 +0200 (EET)
Date:   Wed, 24 Nov 2021 19:54:49 +0900
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
Message-ID: <20211124195449.33f31e7f@mail.inbox.lv>
In-Reply-To: <20211124103550.GE3366@techsingularity.net>
References: <20211124011954.7cab9bb4@mail.inbox.lv>
        <20211124103550.GE3366@techsingularity.net>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: G4mERXADmHlDpsG/LZpu5OT4taW+ND8/31T3z7QsmgxU9uyBr7wBfW6TGofmHgq/cWbD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> it does eventually get killed OOM

However, a full minute freeze can be a great evil in many situations - 
during such a freeze, the system is completely unresponsive. 

So my next question is: How reasonable is the value MAX_RECLAIM_RETRIES?
Is it also get "out of thin air"?

And would it make sense to have buttons to adjust the timeouts?
