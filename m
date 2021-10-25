Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A434390F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhJYISV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:18:21 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:34550 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231685AbhJYISL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:18:11 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 678CBB00100; Mon, 25 Oct 2021 10:15:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 66D47B0006A;
        Mon, 25 Oct 2021 10:15:48 +0200 (CEST)
Date:   Mon, 25 Oct 2021 10:15:48 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Do we really need SLOB nowdays?
In-Reply-To: <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Message-ID: <alpine.DEB.2.22.394.2110251014370.3145@gentwo.de>
References: <20211017042852.GA3050@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <20211017133618.GA7989@kvm.asia-northeast3-a.c.our-ratio-313919.internal> <20211017135708.GA8442@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021, Hyeonggon Yoo wrote:

> And one more question:
>     in Christoph's presentation [1], it says SLOB uses
>     300 KB of memory. but on my system it uses almost 8000 KB.
>     what's is differences?

Hmmm.... Someone already made "improvements" to SLOB? Kernel needs to be
compiled for minimal overhead and debugging removed.
