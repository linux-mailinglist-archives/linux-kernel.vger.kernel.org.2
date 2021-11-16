Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC55453B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 22:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhKPVDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 16:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhKPVDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 16:03:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66208C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:00:09 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so536538pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mAplr8PEhIO15cAUUnB3At6He73Gp4yXfbaxAwrFMC4=;
        b=QFyDwAWi6oJ+VSdIKJL9RUtbF18X5siPqog6ctZUw774YLWAQK9BXfeg53Nietm3Bc
         XkGX3KcHjcsOTs5OAMIt1twjcv+ne1A2500yOi95W/iEHLLPbVM2Y7bk6GtFF5RNXTZK
         Ys3MWcFL0M39Tz2R9J5l0x33YPliX4aUdCr2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mAplr8PEhIO15cAUUnB3At6He73Gp4yXfbaxAwrFMC4=;
        b=dKdpzoGOOsRFMiElz2OzD06pH3qdDNof+4Noqd3eZBnVs5sw9M2VvCreMDiE4eKBKo
         dq9KmOQaUDAqxGRYc8tSgNNbUKo8Fz/MAQTHBR8ty7gBuxNNuG6RCs7t0Hgw2biZ2OAz
         d1b2QSKq3qdL82d57y8mFfpG9E/PjmtZRWGgIfjYVdkGVBSmMldNXPiG+BYDhVuD2Jxw
         +MB8nAb3yLoqT1IOVbPJWXxkgyYzeq2Nnwf7oCCwnJUyFnMmL1Ls6oBTSS6iNdSY2Bxr
         +ySUv+iu1GCeOelvIaR/58a/sUr4XzEWROt2XRK3k9Hv0E64OTQwT4OPm3B/bCAMOtCU
         uGhg==
X-Gm-Message-State: AOAM532l12l4q9556TQcyx1fNxZAQ4BWKcv/7BYGg+mdJsM6jFxBVCa+
        t1S130HdFr7VqgqeiCkv0UmqJw==
X-Google-Smtp-Source: ABdhPJzvb/gvYUlnL/n45uWkDIt5hoxsNQHjJAXMd0zkfxI5AEQ4EMNhTfD2aCecaz8NxUGOhzw+pw==
X-Received: by 2002:a17:90b:380d:: with SMTP id mq13mr2536745pjb.110.1637096409013;
        Tue, 16 Nov 2021 13:00:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c6sm18702233pfd.114.2021.11.16.13.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 13:00:08 -0800 (PST)
Date:   Tue, 16 Nov 2021 13:00:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        kernel@pengutronix.de, Colin Cross <ccross@android.com>
Subject: Re: [PATCH] pstore/ftrace: add a kernel parameter to start pstore
 recording
Message-ID: <202111161259.D0972333@keescook>
References: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
 <20211116120603.4e0c04c2@gandalf.local.home>
 <20211116172835.r3puikipzryxnsoj@pengutronix.de>
 <20211116123705.7f99e35e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211116123705.7f99e35e@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2021 at 12:37:05PM -0500, Steven Rostedt wrote:
> On Tue, 16 Nov 2021 18:28:35 +0100
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> 
> > > Is this still needed? It's still in my internal patchwork, and I haven't
> > > seen any responses.  
> > 
> > I didn't see any responses either, and unless someone else implemented
> > something similar somewhere else, it's still needed.
> > 
> > The change was actually useful to debug a clk problem, where the machine
> > freezed when a certain driver was loaded.
> 
> Perhaps I should ask this. Would anyone object if I just take this change
> through my tree for the next merge window?

If you can Ack it, I'll take it via the pstore tree; I've got a few
other things that will likely need to go in for the next merge window
too.

-Kees

-- 
Kees Cook
