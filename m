Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A9838FC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhEYIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:12:47 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:39912 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232320AbhEYIKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:10:45 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 10DA1B005D8; Tue, 25 May 2021 10:09:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 0FDD4B00515;
        Tue, 25 May 2021 10:09:15 +0200 (CEST)
Date:   Tue, 25 May 2021 10:09:15 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC 02/26] mm, slub: allocate private object map for
 validate_slab_cache()
In-Reply-To: <20210524233946.20352-3-vbabka@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2105251008560.107680@gentwo.de>
References: <20210524233946.20352-1-vbabka@suse.cz> <20210524233946.20352-3-vbabka@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Vlastimil Babka wrote:

> validate_slab_cache() is called either to handle a sysfs write, or from a
> self-test context. In both situations it's straightforward to preallocate a
> private object bitmap instead of grabbing the shared static one meant for
> critical sections, so let's do that.

Acked-by: Christoph Lameter <cl@linux.com>

