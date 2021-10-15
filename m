Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AF642F494
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbhJOOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239577AbhJOOBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:01:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CA1161090;
        Fri, 15 Oct 2021 13:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634306371;
        bh=tHCAgydHYCdUAD+HzPMssFmmvgjn4jyjNVTgtu+4eEw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k42TqYhkmGmaE+EtfizqtlY/kh6oTSZCb5+sO8CXY8k/W0acjH9ZmUU7LnG2vj0hV
         2RCoYDTUjzKMoP5b9rq9bsVAaJuswXgYZnm7V+xnWuGgYYb5hHg8VaQnN5ILzp2peG
         ZEIkd7+AvL881MhjotOmjJfyspnDBx64fMJcfjTBByJmktQoPaqjhzOyt4mBM8RyFb
         UMHMNexoPIOuP64CqEb6HwV/yOuzRVoN0bJ8h1yO/PHAGcgx1CVXOH/TC/vbQkyqCQ
         cse0xOpVS5ZYtS4xq4/aizSC1QWr1HkrF8Chz34DZ7KEcqqee/7f4LPxggRxRaJzLg
         XFjbAQBw3sznA==
Received: by mail-ed1-f43.google.com with SMTP id w19so38393075edd.2;
        Fri, 15 Oct 2021 06:59:31 -0700 (PDT)
X-Gm-Message-State: AOAM532dExKFDVwsp/3cjfxyaayrioyPJpsNotz/ybO2um61epO+X8ld
        SRfNA/QOprvvsaFsrKZzvIrYVnPnhwbTsltUbQ==
X-Google-Smtp-Source: ABdhPJz5gjHqCTPm3hhHQQda5+tmnHnI+OJ0yzrp124Rt8HUd7Oj79eh0WY1zgZ3TL2WJ+4/wDNCJHf38OPe5F3Fc2M=
X-Received: by 2002:a05:6402:1778:: with SMTP id da24mr17737518edb.318.1634306350756;
 Fri, 15 Oct 2021 06:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com> <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
 <YWVD0RXHVLxuXEIN@google.com> <CAMuHMdWqYVp1JyzZoidAJhPy9ypRnSOWHJLz5knDUMcFHPOzAw@mail.gmail.com>
 <YWfSz00Rj5AVhkgT@google.com> <CAL_Jsq+GHt+DqHa0GeLKWoni+Lghg5wg5ssREZBdSD-=K3XQ1A@mail.gmail.com>
 <163425256290.1688384.5646232860050218479@swboyd.mtv.corp.google.com>
In-Reply-To: <163425256290.1688384.5646232860050218479@swboyd.mtv.corp.google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 15 Oct 2021 08:58:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJV_CoPH7VrX-D5=u2WsoUpp-pTKbcR2y+gWxhv+WKcEg@mail.gmail.com>
Message-ID: <CAL_JsqJV_CoPH7VrX-D5=u2WsoUpp-pTKbcR2y+gWxhv+WKcEg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 6:02 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Rob Herring (2021-10-14 09:18:16)
> > On Thu, Oct 14, 2021 at 1:48 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > I don't explicitly build DT documentation.
> > >
> > > Since I use the build bots to let me know if there are strange !(C,
> > > ASM, arm, aarch64, mips, ppc, x86) build issues or ones with odd
> > > configuration possibilities (randconfig) in the repos I maintain, you
> > > might have to convince them that this is important too.
> >
> > It's really just a matter of turning on the build in
> > allyesconfig/allmodconfig builds. I've not done that primarily because
> > there's one person I don't want to yell at me, but I could probably
> > make it arm and/or arm64 only. It's really arch and config
> > independent, so doing it multiple times is kind of pointless.
> >
> > I assume for bots you mean kernel-ci mainly? Do you run that before
> > stuff gets into linux-next? IMO, that's too late. But still a slight
> > improvement if things go in via one tree. Otherwise, I see the
> > breakage twice, 1st linux-next then the merge window.
> >
>
> I run `make dt_binding_check DT_SCHEMA_FILES="<path to yaml file>"` but
> nowadays this seems to check all the bindings and not just the one
> binding I care to check. Did something break?

It should apply all the schemas to the example in DT_SCHEMA_FILES.
Originally, it only applied DT_SCHEMA_FILES schema to the example in
DT_SCHEMA_FILES.

Rob
