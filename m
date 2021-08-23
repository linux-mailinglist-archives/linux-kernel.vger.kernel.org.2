Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE133F4D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhHWPLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:11:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41326 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhHWPLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 11:11:47 -0400
Date:   Mon, 23 Aug 2021 17:11:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629731464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eCFrC4m530guZJWKO640JQOEUhD9r6AZvPB2M38f6fs=;
        b=zKDDWovbamlceZYOgkSrv3GG9F/6XzzaxctbZHcDuFhkKhwhXLqp8ElnJF8GjjPZo9QEti
        H6YSegAw8tHpTRwpdg7NeMpX9AMdUAVLlGwF5wiwkjSXUtB6eZSRZ58kz2pk6SYHg8WDpd
        yMrfgM4WvyTrfC1+3bVHt3zYxqbbZg/JbDovFEnYY/YGcQPHSmCDSYaZsv5wnkQ1BzwcvA
        7D2TR6KoRa/wMWB23noWwD9f9r95iHCBI7VG5kaptyzQ8nizZIYt90+dDCOYkM1YILfX5t
        Dtn14c7PlNmc4fr062bvZve8DgvPG9ODhPswGsqtjJvqpqSBKZZFgMu/L3Zxcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629731464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eCFrC4m530guZJWKO640JQOEUhD9r6AZvPB2M38f6fs=;
        b=+Hat64Ht4kUjUDpeivV4lXCBO4AVLbazRFL1PfeJKqHcqZWQYDyX59mZ4LsHZS72onFe1J
        CnqB07HHnUgdz5Aw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210823151102.r2bjujnfgxhf5ceb@linutronix.de>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-23 16:57:51 [+0200], Vlastimil Babka wrote:
> The v5 is just accumulated fixes since posting v4 to allow checking that mmotm
> is identical. I've checked my tree against next-20210823 and diff of mm/slub.c
> was empty, git range-diff against fixups-squashed range of commits made from
> mmotm also showed no difference in patch contents.
The v5 in its current form was already part of v5.14-rc6-rt11.

Sebastian
