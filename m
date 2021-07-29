Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748BE3DA7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhG2Pa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhG2Pa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:30:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A421CC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 08:30:54 -0700 (PDT)
Date:   Thu, 29 Jul 2021 17:30:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627572653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8f/Z7h7p5XN76alpWFTQVfe+x6kv+BpazmgM35bjCc=;
        b=PExNJ5YyDT5t57t9HCpkFVspECZuobQv4hafuBuTgAwXtQJOASM0eKXLJ6Jb5xlbDrokBz
        NUuM4Ls2g08Ps+RKN8aI0Ky0wSW0g+TjUUGznoDCmeCS/H1QhSzCPESTPgx5XZhikljtA6
        zS6uZdWAYF9sKjRZ1siD74RBxPi97DvEoXiR0jmSo/q8Ryj0b9SPs4gMluCr3tZZu+0JMK
        9XD9OqaZvPeXHy+mfoRIhbH+uINRnbD8u8/nG9AModeT5jqwUjHBwvSg8QIv26d4z2sK/o
        AZAHC9YxMWoy1YVKaDVBkEfv8/3MHPoQEvdXUEMWnY0bO6weAZULD4mCQhs9YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627572653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a8f/Z7h7p5XN76alpWFTQVfe+x6kv+BpazmgM35bjCc=;
        b=HTw1CohKQQCdshOhsU1+q3g3VzuiSQ0pM6p+LsGf1j5W39fH2J5vD+Ln3kN1W0sgj2skRW
        UvTILHnLOlJXdxBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210729153051.oactl35fc5zrzprs@linutronix.de>
References: <20210729132132.19691-1-vbabka@suse.cz>
 <20210729152400.ed35ocv5jtpf3ns5@linutronix.de>
 <803269ba-d4f4-6016-067f-8f9e02b3c794@suse.cz>
 <20210729152901.uvbgquzwyk7lt7a3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210729152901.uvbgquzwyk7lt7a3@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-07-29 17:29:02 [+0200], To Vlastimil Babka wrote:
> On 2021-07-29 17:27:18 [+0200], Vlastimil Babka wrote:
> > On 7/29/21 5:24 PM, Sebastian Andrzej Siewior wrote:
> > > On 2021-07-29 15:20:57 [+0200], Vlastimil Babka wrote:
> > >> Changes since v2 [5]:
> > > 
> > > With PARTIAL enabled on top of -rc3:
> > 
> > Is that also PREEMPT_RT? Interesting...
> 
> No, plain -rc3.

but it also happens with PREEMPT_RT. Just wanted to make sure that it
happens without RT before I report :)

Sebastian
