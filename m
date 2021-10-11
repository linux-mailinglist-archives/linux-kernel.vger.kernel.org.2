Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD08C428793
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhJKHXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:23:18 -0400
Received: from vmi485042.contaboserver.net ([161.97.139.209]:45454 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234526AbhJKHWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:22:37 -0400
Received: by gentwo.de (Postfix, from userid 1001)
        id 44B44B00691; Mon, 11 Oct 2021 09:20:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 42397B0025F;
        Mon, 11 Oct 2021 09:20:36 +0200 (CEST)
Date:   Mon, 11 Oct 2021 09:20:36 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, slub: Use prefetchw instead of prefetch
In-Reply-To: <20211008133602.4963-1-42.hyeyoo@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110110919050.130815@gentwo.de>
References: <20211008133602.4963-1-42.hyeyoo@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021, Hyeonggon Yoo wrote:

> It's certain that an object will be not only read, but also
> written after allocation.

get_freepointer is used in multiple code path not only in allocation. It
is for example used when scanning through a freelist.

With this change all objects get needlessly dirtied and the cross cpu
cache contention is increased.


