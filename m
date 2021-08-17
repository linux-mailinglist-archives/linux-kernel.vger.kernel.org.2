Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D40A3EEFA4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhHQPyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33196 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbhHQPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:50:36 -0400
Date:   Tue, 17 Aug 2021 17:49:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629215360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aW1Z9xNDCTNFD0ITY/peVEUHbQo36LFq0z8Ne1ql7xo=;
        b=C0alBiBhy7/T0wZRtSTZvpi0VQQp9R4lbSaWzJ8BprUABNctzDivxGDTAIJncMnGS6OSQO
        7r909bSo+dQInkM063AtQIVJrTCpPWfeiEmBWjsCtKEOdF6P9c/DYbZvy4H5ajQ+SMY6Bd
        0KUXUD3zzxtPKvCXVmUBUPaxxuF0EUj5PVdCdv3Ro5Z9npMPJDprj1o/a82dOofMBe/jWK
        A6J/d3+ylnIFpKCwRuIT0QWY6wXeD/+MgbATAeZ85kE+qV0yzCKNF5zrcaojCINnkX32S6
        x5C+TQ21LpPOjDfPESZNz2p2fbYDrV7gsJVsYqSAUNqa8zQJlK984y5TJSczaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629215360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aW1Z9xNDCTNFD0ITY/peVEUHbQo36LFq0z8Ne1ql7xo=;
        b=8+cGza+hRdJGV5ouGXD9vDb8727EhK7SBBhCrHy2MC1HVa4iawTGC4d8PL8m+1L0PChMkD
        IIz0Z9jsDUiooYBw==
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
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
Message-ID: <20210817154918.ryvshtc2x5qkkzqg@linutronix.de>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-36-vbabka@suse.cz>
 <20210817153937.hxnuh7mqp6vuiyws@linutronix.de>
 <0120f82e-9251-9597-442f-8c582134a0d1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0120f82e-9251-9597-442f-8c582134a0d1@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-17 17:41:57 [+0200], Vlastimil Babka wrote:
> Does it mean that version works fine on RT now?

Yes. There is no difference now between RT and !RT regarding the
dep_map member.

Sebastian
