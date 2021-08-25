Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAFC3F76E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhHYOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:08:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51072 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHYOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:08:46 -0400
Received: from maud (unknown [IPv6:2600:8800:8c06:1000::c8f3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1C7811F4169F;
        Wed, 25 Aug 2021 15:07:35 +0100 (BST)
Date:   Wed, 25 Aug 2021 10:07:21 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/panfrost: Handle non-aligned lock addresses
Message-ID: <YSZOgzaYN2Vub4w+@maud>
References: <20210824173028.7528-1-alyssa.rosenzweig@collabora.com>
 <20210824173028.7528-5-alyssa.rosenzweig@collabora.com>
 <6fe675c4-d22b-22da-ba3c-f6d33419b9ed@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fe675c4-d22b-22da-ba3c-f6d33419b9ed@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > In practice, the current callers pass PAGE_SIZE aligned inputs, avoiding
> > the bug. Therefore this doesn't need to be backported. Still, that's a
> > happy accident and not a precondition of lock_region, so we let's do the
> > right thing to future proof.
> 
> Actually it's worse than that due to the hardware behaviour, the spec
> states (for LOCKADDR_BASE):
> 
> > Only the upper bits of the address are used. The address is aligned to a
> > multiple of the region size, so a variable number of low-order bits are
> > ignored, depending on the selected region size. It is recommended that software
> > ensures that these low bits in the address are cleared, to avoid confusion.
> 
> It appears that indeed this has caused confusion ;)
> 
> So for a simple request like locking from 0xCAFE0000 - 0xCB010000 (size
> = 0x30000) the region width gets rounded up (to 0x40000) which causes
> the start address to be effectively rounded down (by the hardware) to
> 0xCAFC0000 and we fail to lock 0xCB000000-0xCB010000.
> 
> Interestingly (unless my reading of this is wrong) that means to lock
> 0xFFFF0000-0x100010000 (i.e. crossing the 4GB boundary) requires locking
> *at least* 0x00000000-0x200000000 (i.e. locking the first 8GB).
> 
> This appears to be broken in kbase (which actually does zero out the low
> bits of the address) - I've raised a bug internally so hopefully someone
> will tell me if I've read the spec completely wrong here.

Horrifying, and not what I wanted to read my last day before 2 weeks of
leave. Let's drop this patch, hopefully by the time I'm back, your
friends in GPU can confirm that's a spec bug and not an actual
hardware/driver one...

Can you apply the other 3 patches in the mean time? Thanks :-)
