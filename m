Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678D8458D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 12:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhKVLoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 06:44:02 -0500
Received: from gentwo.de ([161.97.139.209]:50218 "EHLO gentwo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231697AbhKVLoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 06:44:01 -0500
Received: by gentwo.de (Postfix, from userid 1001)
        id AFCA0B003BD; Mon, 22 Nov 2021 12:40:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id AD1BAB0034F;
        Mon, 22 Nov 2021 12:40:53 +0100 (CET)
Date:   Mon, 22 Nov 2021 12:40:53 +0100 (CET)
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
In-Reply-To: <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111221239050.205511@gentwo.de>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz> <20211122013026.909933-1-rkovhaev@gmail.com> <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de> <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz> <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
 <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021, Vlastimil Babka wrote:

> It's no problem to have the real beginning of the object aligned, and the
> prepended header not. The code already does that before this patch for the
> kmalloc power-of-two alignments, where e.g. the object can be aligned to 256
> bytes, but the prepended header to a smaller ARCH_KMALLOC_MINALIGN /
> ARCH_SLAB_MINALIGN.

Ok but then the first object in a page may still have those issues.

> > I dont know but it seems that making slob that sophisticated is counter
> > productive. Remove SLOB?
>
> I wouldn't mind, but somebody might :)

Well run a space efficiency analysis after this patch. If the memory used
is larger than SLUB (with the configuration for minimal data footprint)
then there is no reason for SLOB to continue.

