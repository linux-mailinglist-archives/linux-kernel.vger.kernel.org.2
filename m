Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB28F3329AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhCIPGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:06:01 -0500
Received: from vmi485042.contaboserver.net ([161.97.139.209]:54778 "EHLO
        gentwo.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231660AbhCIPFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:05:48 -0500
Received: by gentwo.de (Postfix, from userid 1001)
        id C06D0B00BAC; Tue,  9 Mar 2021 15:56:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id BF87DB0096F;
        Tue,  9 Mar 2021 15:56:04 +0100 (CET)
Date:   Tue, 9 Mar 2021 15:56:04 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Georgi Djakov <georgi.djakov@linaro.org>
cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Add slub_debug option to panic on memory
 corruption
In-Reply-To: <20210309134720.29052-1-georgi.djakov@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2103091554430.109061@gentwo.de>
References: <20210309134720.29052-1-georgi.djakov@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021, Georgi Djakov wrote:

> Being able to stop the system immediately when a memory corruption
> is detected is crucial to finding the source of it. This is very
> useful when the memory can be inspected with kdump or other tools.

Hmmm.... ok.

>  static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
>  						void *from, void *to)
>  {
> +	if (slub_debug & SLAB_CORRUPTION_PANIC)
> +		panic("slab: object overwritten\n");
>  	slab_fix(s, "Restoring 0x%p-0x%p=0x%x\n", from, to - 1, data);
>  	memset(from, data, to - from);
>  }

Why panic here? This should only be called late in the bug reporting when
an error has already been printed.

