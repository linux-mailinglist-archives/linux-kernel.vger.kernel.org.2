Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB29E38850F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 04:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352941AbhESDAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 23:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbhESDAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 23:00:09 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC7C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:58:50 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v5so13782095ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izMZCHf4ztCeuhhLAt3vYQRnDj7l1KFc/eOQyb+nJRA=;
        b=CQ+blHxrxXFFnRNKFD1XbhqMBx75Ss5aJIAgCcZlFybb61KSDs939EXAWOk/lgLQWI
         NP4p9qdyuFrzJn07hVf6E1CtK4WpBuamLNMzYuQ59+w7OOh6x5i4gSwuc8koUY3w4SnL
         dKHwxTD+lSQStJoQwzQp9NLunq0Dp4fQCp5o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izMZCHf4ztCeuhhLAt3vYQRnDj7l1KFc/eOQyb+nJRA=;
        b=T7R79dzXY61bLNiPq+1++Mi/LI57Z1NFp7e3BNfQARma3+tVzKyN3WwkX9/hkOE3BS
         jI7xI4gzMeWP4kLaPyH1ph3unrtu15sV0bkJ60LCSSBQZdAMtPnP7AiEJbssuRmcFOrw
         PKP5zWGFQEDD/M2ecf9rgygb8OKyH6mVAvermPWpGqKi+65BaqDF3a2QxytwxxIYFl6h
         KuhsPKEj3/8c5OnQuOx6rG30/S6Ny/WHQNMXNIHkwvZPqw9czqElYIrTSzwLkb8FLTYp
         s2LiH9B4Tw+LulT3aPFTluzb7U30h2AczX0VKyVllLWk0G2erDyAZ/FGqWcsDCWCjXYA
         zEOA==
X-Gm-Message-State: AOAM532WyNXVXon8ZOaaRUx831uVBM4wZiLkyaEm2Hvaxzh+qgEnXaC+
        CmMlwY8xNqwxiZrH/CH74kBM3WQ4FRwGE87BuwM=
X-Google-Smtp-Source: ABdhPJzJ3JNIYmjJta2Fk0H8oXTdQqHVNGIBWXF4kxx4Gp/Tq7/yGaLa1Ai/Guqv/uuYP1ZB6A2cPQ==
X-Received: by 2002:a2e:7207:: with SMTP id n7mr6658767ljc.352.1621393128420;
        Tue, 18 May 2021 19:58:48 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id h4sm2443450lfv.264.2021.05.18.19.58.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 19:58:47 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id e11so13766222ljn.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 19:58:47 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr6477220lja.48.1621393127267;
 Tue, 18 May 2021 19:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210519024322.GA29704@xsang-OptiPlex-9020>
In-Reply-To: <20210519024322.GA29704@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 May 2021 16:58:31 -1000
X-Gmail-Original-Message-ID: <CAHk-=whcr5M=4Mz2ydu4XtxTL_34WkXPnmFmA4f8r+ELXDC6hg@mail.gmail.com>
Message-ID: <CAHk-=whcr5M=4Mz2ydu4XtxTL_34WkXPnmFmA4f8r+ELXDC6hg@mail.gmail.com>
Subject: Re: [i915] b12d691ea5: kernel_BUG_at_mm/memory.c
To:     kernel test robot <oliver.sang@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Serge Belyshev <belyshev@depni.sinp.msu.ru>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 4:26 PM kernel test robot <oliver.sang@intel.com> wrote:
>
> commit: b12d691ea5e01db42ccf3b4207e57cb3ce7cfe91 ("i915: fix remap_io_sg to verify the pgprot")
> [...]
> [  778.550996] kernel BUG at mm/memory.c:2183!
> [  778.559015] RIP: 0010:remap_pfn_range_notrack (kbuild/src/consumer/mm/memory.c:2183 kbuild/src/consumer/mm/memory.c:2211 kbuild/src/consumer/mm/memory.c:2233 kbuild/src/consumer/mm/memory.c:2255 kbuild/src/consumer/mm/memory.c:2311)
> [  778.688951] remap_pfn_range (kbuild/src/consumer/mm/memory.c:2342)
> [  778.692700] remap_io_sg (kbuild/src/consumer/drivers/gpu/drm/i915/i915_mm.c:71) i915

Yeah, so that BUG_ON() checks that theer isn't any old mapping there.

You can't just remap over an old one, but it does seem like that is
exactly what commit b12d691ea5e0 ("i915: fix remap_io_sg to verify the
pgprot") ends up doing.

So the code used to just do "apply_to_page_range()", which admittedly
was odd too. But it didn't mind having old mappings and re-applying
something over them.

Converting it to use remap_pfn_range() does look better, but it kind
of depends on it ever being done *once*. But the caller seems to very
much remap the whole vmsa at fault time, so...

I don't know what the right thing to do here is, because I don't know
the invalidation logic and when faults happen.

I see that there is another thread about different issues on the
intel-gfx list. Adding a few people to this kernel test robot thread
too.

I'd be inclined to revert the commits as "not ready yet", but it would
be better if somebody can go "yeah, this should be done properly like
X".

Anybody?

            Linus
