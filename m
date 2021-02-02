Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA2A30BBD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhBBKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:12:45 -0500
Received: from gentwo.org ([3.19.106.255]:45882 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhBBKMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:12:40 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id C01833F511; Tue,  2 Feb 2021 10:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id BDE3A3F13E;
        Tue,  2 Feb 2021 10:11:53 +0000 (UTC)
Date:   Tue, 2 Feb 2021 10:11:53 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Abel Wu <abel.w@icloud.com>
cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, hewenliang4@huawei.com,
        wuyun.wu@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: embed __slab_alloc to its caller
In-Reply-To: <20210202080515.2689-1-abel.w@icloud.com>
Message-ID: <alpine.DEB.2.22.394.2102021009470.50959@www.lameter.com>
References: <20210202080515.2689-1-abel.w@icloud.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021, Abel Wu wrote:

> Since slab_alloc_node() is the only caller of __slab_alloc(), embed
> __slab_alloc() to its caller to save function call overhead. This
> will also expand the caller's code block size a bit, but hackbench
> tests on both host and guest didn't show a difference w/ or w/o
> this patch.

slab_alloc_node is an always_inline function. It is intentional that only
the fast path was inlined and not the slow path.
