Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D58433FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhJSUfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSUfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:35:36 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E72C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:33:23 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so5587736otq.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+4poghJVfR5IIyOI0aZxVj4qcymkEjZY6HDS+AxT1xI=;
        b=YeAF5weJGF7920fNVCJlPozj1e0pKIU1brMRC4cL7uf4ZMYs+sZDz2U986NdfT5sv1
         HJq/AVucVc1aUAh6CN5uE0nYTuiCs1SLWhRp0LcnPlgoUu4BAIIhRJJP++OSqZjOuxcj
         Yrv0wvaIREN/XlvuV0Sch4mO9DR8HzCPrOzFnYjoQljU7IhgViNN1oHn/174buUZSiHl
         8o75ofj0AevjJGWCnrPpjVrM6F7c+rtJn7rf8LAfu8l4SX5fRfrR3DIFxyFfiR1NNs4h
         ghOn6r37Z18Z/bATT7ik/kxNtmTuA0R4D3ILt17JQP9FQYOEWSZNCTbs6JzdXCQF7th5
         qcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+4poghJVfR5IIyOI0aZxVj4qcymkEjZY6HDS+AxT1xI=;
        b=Z5wGmbpQYtAoinfOVAcoynNEKQm7WWTuM1dL3FBcur1u3nRf2Q2ywlXtYpMMK5nJJ8
         R2h3ulxKL//qKtFvqA9V9y46tn/8m+UZBxL30lhSw37D6TMSM5P9f0d309lkb7f8sHr/
         EXzAYFc+3OhYNrU2aArs2McnQBpH26RBArt3P+idZ2xRPjZ3rAjS5u/EhxrwKGPtg+Mf
         zxGZ42sZ5d2WXdRoSVT9xIlQTpNJ+dan+zRe1VPRNZPQa2tDCYWn8+NNfuvdS5Y4jmNj
         hV+2mChw6kGNDqpItDkPTJhsBoojsKHj1jzYcgw1xZ7pz62pZalFkHKXpepg/ql0TdQI
         HRqA==
X-Gm-Message-State: AOAM530QxjtAQDXPAq0jyMcSFb5T1hSu7XufPsWi7vuyAKJSSo1sdWBN
        ogduodLf9rQz3CBEuFZFLraA5FMgnuM=
X-Google-Smtp-Source: ABdhPJxC+XleAM98Bhn8sz4k/dhquAtK3nkPTJL/5FaKwp9CutmbT245GiT+3DENWp53u0+L1evHIw==
X-Received: by 2002:a9d:728d:: with SMTP id t13mr7343655otj.370.1634675602952;
        Tue, 19 Oct 2021 13:33:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r184sm16936oia.38.2021.10.19.13.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:33:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 19 Oct 2021 13:33:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.15-rc6
Message-ID: <20211019203320.GA748645@roeck-us.net>
References: <CAHk-=wjbXW13Eh6YnB4C5ghLrhJCq0u2bpSNA0JbK8eDb6o_XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjbXW13Eh6YnB4C5ghLrhJCq0u2bpSNA0JbK8eDb6o_XA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 08:14:59PM -1000, Linus Torvalds wrote:
> So here we are, slightly later on a Sunday than usual due to travel,
> but rc6 is out.
> 
> I'd love to say that it's all looking average, but rc6 is actually
> bigger han rc5 was, and larger than normal for this time in the
> release cycle.
> 
> It's not _enormously_ larger than normal, and it's not the largest rc6
> we've had, but it's still slightly worrisome. By rc6 I really do
> expect things to have started calming down.
> 
> I'm hoping it's just one of those random timing effects, with a couple
> of slightly bigger pulls having come in the last week, and we'll see
> the next week being extra quiet because rc6 got some of the stuff that
> would normally have hit rc7. It happens. But let's see how this goes.
> 
> The 5.15 cycle over-all remains one of the smaller cycles (at least
> counting commits), so I wouldn't have expected this to be one that
> requires an extra rc, but that may be what ends up happening unless
> the upcoming week is really nice and calm.
> 
> That said, nothing in here looks _particularly_ worrisome. It really
> smells like just random timing effects to me, with networking, GPU
> drivers, and ntfs3 all having had a somewhat active week.  Other than
> that it all really looks fairly normal.
> 
> Full details in the shortlog below.
> 
> Please give it a whirl. And let's hope for a nice calm next week and a
> smaller rc7.
> 

Build results:
	total: 153 pass: 149 fail: 4
Failed builds:
	alpha:allmodconfig
	m68k:allmodconfig
	parisc:allmodconfig
	s390:allmodconfig
Qemu test results:
	total: 480 pass: 480 fail:

The error is:

Building alpha:allmodconfig ... failed
--------------
Error log:
<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]
drivers/spi/spi-tegra20-slink.c:1197:12: error: 'tegra_slink_runtime_resume' defined but not used [-Werror=unused-function]
 1197 | static int tegra_slink_runtime_resume(struct device *dev)

This was introduced by a bad conflict resolution between the following
two patches.

efafec27c565 spi: Fix tegra20 build with CONFIG_PM=n
2bab94090b01 spi: tegra20-slink: Declare runtime suspend and resume functions conditionally

The fix is at
https://patchwork.kernel.org/project/spi-devel-general/patch/20211013144538.2346533-1-arnd@kernel.org/
and queued in -next.

Guenter
