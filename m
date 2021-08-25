Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE213F77F9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 17:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhHYPHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 11:07:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51548 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhHYPHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 11:07:01 -0400
Received: from maud (unknown [IPv6:2600:8800:8c06:1000::c8f3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D41DC1F43B19;
        Wed, 25 Aug 2021 16:06:04 +0100 (BST)
Date:   Wed, 25 Aug 2021 11:05:49 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/panfrost: Handle non-aligned lock addresses
Message-ID: <YSZcTbRglJWz67r/@maud>
References: <20210824173028.7528-1-alyssa.rosenzweig@collabora.com>
 <20210824173028.7528-5-alyssa.rosenzweig@collabora.com>
 <6fe675c4-d22b-22da-ba3c-f6d33419b9ed@arm.com>
 <YSZOgzaYN2Vub4w+@maud>
 <8db73065-e8e8-7894-7eac-befd082a25e1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8db73065-e8e8-7894-7eac-befd082a25e1@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Horrifying, and not what I wanted to read my last day before 2 weeks of
> > leave. Let's drop this patch, hopefully by the time I'm back, your
> > friends in GPU can confirm that's a spec bug and not an actual
> > hardware/driver one...
> > 
> > Can you apply the other 3 patches in the mean time? Thanks :-)
> > 
> 
> Yeah, sure. I'll push the first 3 to drm-misc-next-fixes (should land in
> v5.15).
> 
> It's interesting that if my (new) reading of the spec is correct then
> kbase has been horribly broken in this respect forever. So clearly it
> can't be something that crops up very often. It would have been good if
> the spec could have included wording such as "naturally aligned" if
> that's what was intended.

Indeed. Fingers crossed this is a mix-up. Although the text you quoted
seems pretty clear unfortunately :|

> Enjoy your holiday!

Thanks!
