Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34383F5298
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 23:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhHWVME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 17:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhHWVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:12:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCCEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 14:11:19 -0700 (PDT)
Received: from maud (unknown [IPv6:2600:8800:8c06:1000::c8f3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4FC031F416C0;
        Mon, 23 Aug 2021 22:11:14 +0100 (BST)
Date:   Mon, 23 Aug 2021 17:11:09 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/3] drm/panfrost: Use u64 for size in lock_region
Message-ID: <YSQO7exgqnk0ZLJT@maud>
References: <20210820213117.13050-1-alyssa.rosenzweig@collabora.com>
 <20210820213117.13050-3-alyssa.rosenzweig@collabora.com>
 <71392001-a5a9-fee2-79a5-91df55ba3081@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71392001-a5a9-fee2-79a5-91df55ba3081@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Mali virtual addresses are 48-bit. Use a u64 instead of size_t to ensure
> > we can express the "lock everything" condition as ~0ULL without relying
> > on platform-specific behaviour.
> 
> 'platform-specific behaviour' makes it sound like this is something to
> do with a particular board. This is 32bit/64bit - it's going to be
> broken on 32bit: large lock regions are not going to work.

Oh, my. I used the term as a weasel word since the spec is loose on how
big a size_t actually is. But if this is causing actual breakage on
armv7 we're in trouble. I'll add a Cc stable tag on v2, unless the Fixes
implies that?

Thanks for pointing this out.
