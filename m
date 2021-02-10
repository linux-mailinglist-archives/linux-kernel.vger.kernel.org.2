Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60C031708F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 20:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhBJTsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 14:48:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:50804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231596AbhBJTs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 14:48:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85741AB98;
        Wed, 10 Feb 2021 19:47:46 +0000 (UTC)
Date:   Wed, 10 Feb 2021 11:47:39 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kgdb-bugreport@liss.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH] kgdb: Remove kgdb_schedule_breakpoint()
Message-ID: <20210210194739.sj5ye473k4ufkxza@offworld>
References: <20210210142525.2876648-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210210142525.2876648-1-daniel.thompson@linaro.org>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021, Daniel Thompson wrote:

>To the very best of my knowledge there has never been any in-tree
>code that calls this function. It exists largely to support an
>out-of-tree driver that provides kgdb-over-ethernet using the
>netpoll API.
>
>kgdboe has been out-of-tree for more than 10 years and I don't
>recall any serious attempt to upstream it at any point in the last
>five. At this stage it looks better to stop carrying this code in
>the kernel and integrate the code into the out-of-tree driver
>instead.
>
>The long term trajectory for the kernel looks likely to include
>effort to remove or reduce the use of tasklets (something that has
>also been true for the last 10 years). Thus the main real reason
>for this patch is to make explicit that the in-tree kgdb features
>do not require tasklets.

I'm happy to see another user gone, I missed that it was even an option
to remove this altogether. Yeah so in general I started sending random
patches to get rid of some tasklets after seeing the recent extentions
in 12cc923f1cc (tasklet: Introduce new initialization API), which is
really the wrong way to go imo. Some driver maintainers/authors push
back in the name of performance (albeit tasklets provide no guarantees
because of ksoftirqd, for example), some don't care as much. There are
also constantly new users being added (despite the explicit deprecation
of the api) defering through tasklets, which makes me wonder if the tasklet
removal is anything but a pipe dream.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
>
>Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>---
>
>Notes:
>    During this cycle two developers have proposed tidying up the
>    DECLARE_TASKLET_OLD() in the debug core. Both threads ended with a
>    suggestion to remove kgdb_schedule_breakpoint() but I don't recall
>    seeing a follow up patch for either thread... so I wrote it myself.

Thanks,
Davidlohr
