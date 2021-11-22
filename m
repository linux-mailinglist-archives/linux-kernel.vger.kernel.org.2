Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27BA458C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 11:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbhKVKj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 05:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbhKVKjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 05:39:54 -0500
X-Greylist: delayed 4454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Nov 2021 02:36:47 PST
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13E3C061574;
        Mon, 22 Nov 2021 02:36:47 -0800 (PST)
Received: by gentwo.de (Postfix, from userid 1001)
        id 58BDEB003B1; Mon, 22 Nov 2021 11:36:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 545DFB002E6;
        Mon, 22 Nov 2021 11:36:46 +0100 (CET)
Date:   Mon, 22 Nov 2021 11:36:46 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Rustam Kovhaev <rkovhaev@gmail.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, corbet@lwn.net, djwong@kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        dvyukov@google.com
Subject: Re: [PATCH v4] slob: add size header to all allocations
In-Reply-To: <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz> <20211122013026.909933-1-rkovhaev@gmail.com> <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de> <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021, Vlastimil Babka wrote:

> But it seems there's no reason we couldn't do better? I.e. use the value of
> SLOB_HDR_SIZE only to align the beginning of actual object (and name the
> define different than SLOB_HDR_SIZE). But the size of the header, where we
> store the object lenght could be just a native word - 4 bytes on 32bit, 8 on
> 64bit. The address of the header shouldn't have a reason to be also aligned
> to ARCH_KMALLOC_MINALIGN / ARCH_SLAB_MINALIGN as only SLOB itself processes
> it and not the slab consumers which rely on those alignments?

Well the best way would be to put it at the end of the object in order to
avoid the alignment problem. This is a particular issue with SLOB because
it allows multiple types of objects in a single page frame.

If only one type of object would be allowed then the object size etc can
be stored in the page struct.

So I guess placement at the beginning cannot be avoided. That in turn runs
into trouble with the DMA requirements on some platforms where the
beginning of the object has to be cache line aligned.

I dont know but it seems that making slob that sophisticated is counter
productive. Remove SLOB?

