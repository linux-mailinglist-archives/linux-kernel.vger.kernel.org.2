Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FAD3C5CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 15:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhGLNEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 09:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhGLNEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 09:04:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C415DC0613DD;
        Mon, 12 Jul 2021 06:01:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z2so6226304plg.8;
        Mon, 12 Jul 2021 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+aFtULaKErdQkNCH667VJ7igbSjkwkw+EfOQK8WfnY=;
        b=Go0Cdsb4toLPKQzSxay8kk4ijr5MotTcItmGrxse0vAwkEl1DEdVYYUU/WGXpvlSsP
         TtcJUri8t1uj2/AQ9BlkmHHF+Ce12TKrWfiag23UMvre+rr2ZHc05ReQGTYIC2wIT0Ji
         n4Rf9OsguHHs2tGLjgtazo1ZUPWa0BBTQZ1E8/FjC1tQcPp3AgGav4zJf61fXdd5fltc
         7qHa3jZUo8DGCvmNuFRNbPJP4OhjxMIPIXK+nUOfjlL/poT8+lgtjAEC3k9c2NNtTXbA
         FJp5IGuCBbzu1AiHIBTFOd7HAPkHBUdBBUd7Sl3U1gZmGXzBa0nIbQj331gUSwI7pRzU
         x7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+aFtULaKErdQkNCH667VJ7igbSjkwkw+EfOQK8WfnY=;
        b=iNU3/oGxipYbjoelJXin++Hh2s58Yt+DENe0vrZdKrBsZUMGCdn4gyNBcD697WouD+
         ysMUfIwOsiyGJg/ph40Dq8e9U1VbMRD2YZJX5+W5d+unZGrtDxk72r0d6OdyF4FvR7TT
         KYUEj+FxN0gH4GjfunEcsTAF872YVDHYRUZG6Ca6+RGy8aJmsAeA7jGjxA+gfUSyK0Zk
         prhac6PxOAza2p16GLspfFMmCClThnQcIKg/dvow6Cmg/t3+S9EQbA8jofDFxVAhS+9m
         iEgkzGoibHTcgrcdJM24BbNWEbsXXcFP5xAq9vxzPvlDmeuwsPzY1tXV8MIt2Vya0iiN
         UAvg==
X-Gm-Message-State: AOAM532wL7btxX966rkOacK9FLVl/ZUqTJNF0LZQOkZuyfzHysHi1saI
        Q1kYVxUUqhQynjvCzST/hdH02ab5OBzeOnrFMLI=
X-Google-Smtp-Source: ABdhPJyYn+pLYImqxdLn6L+MQs/zG+bC9USb1B2VR6owgwQKloZm5ftZ3HBfTyOJFIvLd9WaCdXtuc/V8j5ncn5whLc=
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr14266539pja.181.1626094905294;
 Mon, 12 Jul 2021 06:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210708224226.457224-1-djrscally@gmail.com> <20210709170426.GC4112@sirena.org.uk>
 <CAHp75VeugcuwWAq5p_rx+8J2FsX7igV+UJ3QKw3XG6BiDqTtNQ@mail.gmail.com> <20210712124223.GB4435@sirena.org.uk>
In-Reply-To: <20210712124223.GB4435@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jul 2021 16:01:05 +0300
Message-ID: <CAHp75VeyNyYSbTMgS+5tXxOZehfxt6Wws9jScKYRKQhRRGDwsg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add software node support to regulator framework
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 3:42 PM Mark Brown <broonie@kernel.org> wrote:
> On Sun, Jul 11, 2021 at 12:37:03PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 9, 2021 at 8:05 PM Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Jul 08, 2021 at 11:42:24PM +0100, Daniel Scally wrote:
>
> > > What is a software node and why would we want to use one here?
>
> > Software node is a representation of (missed and / or quirked)
> > firmware nodes in the code.
>
> > > Why are we not just using board files, what does this new abstraction
> > > solve?
>
> > Software node _is_ a board file part. The idea behind that is that the
> > driver, which requires any additional / necessary property that has
> > been missed in the firmware nodes, wouldn't need special treatment if
> > that property comes from a board file rather than firmware.
>
> This doesn't seem to correspond with what these patches are doing,
> they're creating something which bears no relation to any firmware
> interface and the code is specifically looking for swnodes.

Okay, this seems like a different story.
The software nodes shouldn't appear on its own in the generic code.
When we use software nodes API in it, it means that we have tried
other providers _explicitly_ and haven't found what we are looking for
and hence we have to check if software nodes are providing the same.
For example, here it's done that way:
https://elixir.bootlin.com/linux/v5.14-rc1/source/kernel/irq/irqdomain.c#L178.

In all other cases it shouldn't be called explicitly.

-- 
With Best Regards,
Andy Shevchenko
