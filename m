Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F261A3BC59F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 06:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGFElk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 00:41:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:42895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhGFElj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 00:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625546315;
        bh=ZxhGIG2OkUGFZUIh7V4unqo2ELzbDu8A5k97ZBWkPeY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Y45UnbzpVH8Lb+x3gchSikFLPaurgNQyZUIgkW6tKlfSwEyFsoKzcW4vx1IuyFiO7
         pjzj0z5aXya7ohB/j8ieHTCJ7ERdQFEeIU5JvWA/zu5AStpKbVrqGzPzdCBhbRWP14
         oB77AEVAb19NfTImXY474NKYdYh8pcHc6Dx+eLPE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.125]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MqJqN-1lM5BQ2cXj-00nTYm; Tue, 06
 Jul 2021 06:38:35 +0200
Message-ID: <cf420c0c0e64d9ee9681bf81d3dd84a2a048e2db.camel@gmx.de>
Subject: Re: [RFC v2 12/34] mm, slub: move disabling/enabling irqs to
 ___slab_alloc()
From:   Mike Galbraith <efault@gmx.de>
To:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
Date:   Tue, 06 Jul 2021 06:38:33 +0200
In-Reply-To: <20210609113903.1421-13-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
         <20210609113903.1421-13-vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SoPOq+KD3SxRHu3cf1jBAsXMnKo3MzQ1yoFH9tukdoczdrINLNT
 9uZUg0RHltb+UFIpZ7VrF0gh8Z6snGWK9iUVQVBEWYOhEs87mfOjyk5CN1LomZV8cfdEPqi
 LQH/YmTMX6twRHx7hCDeZY48oDk85l7nhXo29x3pWO1APbzxAj2vukYOyG4C7fLCfG7Ze9P
 W+beDwDuKwVq7zVJ5mZKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nuqWi4z6tPE=:SlR2/A5bg92+1/XFOw/JC3
 0YT4DrhQZafl2z0EfBHB5kre0Nmr6tIHiS/enoA1jn4h1qptkDX7eqYjgT7IxwCEvwbyWSc3C
 qp/yE39Q4kNLsCzEzGLyZ3XQWIwFFeLGv5KtawKfHW0bxurZuohc3WKhp/ldOO/hl4dOneoNw
 WDGe2tQ5flXzbb8K+zfT7IZX07t8QF80l/h+EFkpt6eqwQNQulWyNN2vK1M5X1uJzlT5P0Scm
 KzrHjBc5VFyI2JplMZRtXk8F2KwAHvUp2BDE47HToQ57HEymOPlxTY1uxyedEsSOj2MC19Jbh
 o7mmA1sO2ph+U2dUaRiwykCMkzwNVzpWea1CA9yp7qLRM+KfwdSqUnoW3vUHt5Psx2aMMunBl
 /FbGODXRRE3pp6qBl0PPTdcjNZ6eNCWbDVdZ97Kxgy8yMGnRJa3IMaAMsqFZe3+Z2KFvkfNts
 3xs2tgSBae38ExvB4nkfvGesymVP4O16ToRz5pav9vRyZJs04Vyw45b+4pU2hc13/RCXVaASL
 pZd6sBN9YfCgSiqFjGE35n6stxrkiVqAzjhFmvXIrT7PMiCJ3Oh/jXDQIfsWNU6kB4ceiUUXz
 yDvRCmOXHVBVBGU0uqbRuRpNK+oRwR/F2Z2ucP7FJm+wGhYCW6vLmGQVS5lL2/uQ0fyY2lh5y
 pYVpfvoJ4gYdwoLDzT2M049awh4m48fiuvgEuCUV7SnSAL85mp183vj9ge/KrjQ4jpW7MGTC2
 KAXycR2kP3hm5e8nGM3EhbrnZSyn7TPW1VU9/navAyH8d69xKxZwfJN4zikp7s76TTjivObgt
 7GsPgvqDAn+zaipIvctzCYLV1GcG67/UutAdFpmLyAuBFjTgHxGWU5VxU24wQ8zezwtSJ8+V1
 BeiDYU2hUmhxGb0hRbASA+gZkH90wYQYYr3i2jKOdcPfNVHXyPWXBov8dVp8RdMTiTqcpPawU
 qo9s7h5mMZwy2PyfSVYlmqPRg0zWPlQfaktemrBCDwkp5YAfGDEAehY2Vc4y3kr86y8wMUgMB
 DaoD7VGuLGHuFcZwl0WErzbmRZhifpsOMM30BHUw1xAoywYJJlwMYPXEv7xvOKeCOzvlB8Ylh
 2LMD8Q0akwLbR783ndECAJnt4XrieAq/l/A
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On Wed, 2021-06-09 at 13:38 +0200, Vlastimil Babka wrote:
> @@ -3313,6 +3320,8 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s,
> gfp_t flags, size_t size,
>  			 */
>  			c->tid =3D next_tid(c->tid);
>
> +			local_irq_enable();
> +
>  			/*
>  			 * Invoking slow path likely have side-effect
>  			 * of re-populating per CPU c->freelist

This addition should have been followed by removal of the one in the
error path.  At the end of the series, RT ends up doing a double
local_unlock_irq() instead of post ___slab_alloc() slub_put_cpu_ptr().

	-Mike

