Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8B93DA68D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhG2Ohn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhG2Ohl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:37:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC3C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:37:38 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:37:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627569457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q3j0ee1psoaa6qUiXuAcXFw3sFimJ34Oy5I7OWpLkmI=;
        b=MG2n9jfbbMMlEIiPGNcIjnU83vFV51DifEPCp1izB501UMtNFb7jBZA2Vj5tM5Q17/SAtF
        uNkm0SkhrtEInJ4W0Y7lFU7Q8qEFJRLtdaNZFJczE2Xa16XZyFgt3acAvgbVkIN4k2YVbv
        R5ZSuxuVK87QOiUEkH0Q8GbwS1iFmKsWA6WMOhDWcBXHM7H7F6pH28VKPj3v2gyFBjMRCb
        fa0JH58S2LZtfnfMLx7rc3G10d7dw5IiHmzoj5H3ebQglccf0J8dfjQiYdHoZcP35q6Z01
        ieY+42PUdquQYzyXJfi6ou6nuWnLwPjNP46GhQH/SBWZY3lD/ebGFeSwXaZ0UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627569457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q3j0ee1psoaa6qUiXuAcXFw3sFimJ34Oy5I7OWpLkmI=;
        b=tCkHw3Nyv12WLuyHqnC0Vc17D5SA8ZLH3RugHTc5YaYGLmFjX4LbdPBctX644AKOQhHB+J
        TbT6SUWoRSzbeSDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210729143735.wuql2keewd444nvq@linutronix.de>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210702182944.lqa7o2a25to6czju@linutronix.de>
 <35b26e48-a96a-41b0-826e-43e43660c9d6@suse.cz>
 <20210729134939.iulryxjarhjmpugz@linutronix.de>
 <627eddeb-3dc0-056e-ae07-f14c4b1a1b8e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <627eddeb-3dc0-056e-ae07-f14c4b1a1b8e@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-29 16:17:26 [+0200], Vlastimil Babka wrote:
> I forgot to point that out in the cover letter, but with v3 this change to
> raw_spinlock_t is AFAICS no longer possible (at least with
> CONFIG_SLUB_CPU_PARTIAL) because in put_cpu_partial() we now take the local_lock
> and it can be called from get_partial_node() which takes the list_lock.

I saw increased latency numbers with CONFIG_SLUB_CPU_PARTIAL before it
got disabled for other reasons so I'm not too sad if it remains
disabled.

> Hm but SLUB should never call the page allocator from under list_lock in my series?

oh yes. I run into CPU_PARTIAL instead. Sorry for the confusion. So
without PARTIAL it says "24,643 CPUs utilized" and no warnings :)

Sebastian
