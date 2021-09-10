Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE857406F46
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhIJQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 12:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhIJQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 12:14:52 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C27C05BD41
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:10:04 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n27so3647657oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 09:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YP9Ab5m+Hjg9ARQLrR23rN0JCja+NHLmenUVBYO1EeA=;
        b=V2GARmrFRKtY79d6yGjXeWzc7+bpdEesWhQfEEl2jqHoa5Mhati/mkq0zWI2Mi8v+o
         QGpiiMmPx3JQIwIekGlmr6Za36w2rAzk3x0nHVTbhy2G7/K/m1aN28nHRdtD/JwMMKuG
         7XdMlbs8TlY60NeXHNYKBhUHNF9eC5PJUUauY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YP9Ab5m+Hjg9ARQLrR23rN0JCja+NHLmenUVBYO1EeA=;
        b=GfTUd3eEPb9vO7rl1ifkScWymGN/KEzREltrv9Edyo/qnNTJjDudkilSg8IvfNUM9s
         2YSzRQtSxP5rWWXKN9Wy4PhveRR77TDERgTBLTEk3dKFJupnWHONegbfHS0QysYtsAKX
         mp6skXkBxawAxPXgirYNbTA0Thr9Y4S/PM0lHtEvJKHcdKPlFjs93SiKlocViKb0spug
         OBZnR4ayUCcX+W45cMKtBZTKx3q64ja4IDRogxR6mI4VADBWPfiqXB1yW8zfugKy0Bmk
         uuV4R23MDdqyC+vbdc5xF1qp1CVlur0sJAk3ReuwtBMqa9WCfanx5CVYuPtTcC0uU+OZ
         AFcQ==
X-Gm-Message-State: AOAM5322fAS+TNlVdV+ZqVvG2aB+meWdJai0zbZ3dJVLXU+z8K7DY5FF
        wffolxDriW92HaFodM3L6Ct0J3+y08K7mCYYD6fGSbJyPDo=
X-Google-Smtp-Source: ABdhPJxs4fUn/m+MuqnjHOM/VEB/8+xSNMIgT5ivkOgkv/cVfd3dTEFPoj6zI/tIGdT6k10pMqInUsZpbfo1ObTvDls=
X-Received: by 2002:a05:6808:2116:: with SMTP id r22mr4802701oiw.128.1631290203092;
 Fri, 10 Sep 2021 09:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf119s7iXk+qpwoVPnRtOGcxeuZb3rnihf6NWWoVT-4ODHA@mail.gmail.com>
 <YTsQJ753sm701R/n@kroah.com>
In-Reply-To: <YTsQJ753sm701R/n@kroah.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri, 10 Sep 2021 18:09:51 +0200
Message-ID: <CAKMK7uFLBmdHphtnEa1nyAGUHdcP1KgmaK+vtV_GOU6wZZAOxg@mail.gmail.com>
Subject: Re: Habanalabs Open-Source TPC LLVM compiler and SynapseAI Core library
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>, mzuckerman@habana.ai,
        dsinger@habana.ai, Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 9:58 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Sep 10, 2021 at 10:26:56AM +0300, Oded Gabbay wrote:
> > Hi Greg,
> >
> > Following our conversations a couple of months ago, I'm happy to tell you that
> > Habanalabs has open-sourced its TPC (Tensor Processing Core) LLVM compiler,
> > which is a fork of the LLVM open-source project.
> >
> > The project can be found on Habanalabs GitHub website at:
> > https://github.com/HabanaAI/tpc_llvm
> >
> > There is a companion guide on how to write TPC kernels at:
> > https://docs.habana.ai/en/latest/TPC_User_Guide/TPC_User_Guide.html
>
> That's great news, thanks for pushing for this and releasing it all!

Yeah this is neat.

There's still the problem that we spent the past 2.5 years pissing off
a lot of people for an imo questionable political project, bypassing
all the technical review and expertise. Now that the political
nonsense is resolved I think we need to look at at least the technical
cleanup. The angered people are much harder to fix, so let's maybe
ignore that (or perhaps a ks topic, no idea, I'm honestly not super
motivated to rehash this entire story again). Here's what I think we
should do:

- move drivers/misc/habanalabs under drivers/gpu/habanalabs and
review/discussions on dri-devel
- grandfather the entire current situation in as-is, it's not the only
driver we have with a funny uapi of its own (but the other driver did
manage to get their compiler into upstream llvm even, and not like 2
years late)
- review the dma-buf stuff on dri-devel and then land it through
standard flows, not the gregk-misc bypass
- close drivers/misc backdoor for further accel driver submissions,
I'd like to focus on technical stuff in this area going forward and
not pointless exercises in bypassing due process and all that

I expect we'll have a proper discussion what the stack should look
like with the next submission (from a different vendor maybe), that
ship kinda sailed with habanalabs.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
