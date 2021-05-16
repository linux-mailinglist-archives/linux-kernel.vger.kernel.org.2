Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C95381D70
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 10:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhEPIug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 04:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhEPIuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 04:50:35 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75823C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 01:49:20 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id c14so4595846ybr.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 01:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XG3a5Hb3geeSt25VSdjtrGAMkkbu3DIMscuexQdcgtQ=;
        b=lBHLzVqlqY8pk6P6j713JJbkNCGZ3ZI2D4KrA4oRkkKO0K5EaHwcH4TIwfo/hhiZ/f
         wYFKN1nMX1RmtBfjYQVOPWEakjr/QgmSNuasl6tDM8cOiDC3FQv+F2BY6UL/B+4qsdAZ
         qXtzjN+htV0fYs1G6Nu6V8gl2JKx0vB7Z0FibDOmMpWInRLUtSKzoHcRp3caO5qb9eD7
         GE/ZneXx0J2x1Rx9IViEuz4rNrAFVJU4iriuwkf8YEkzbNXsFSyUepSH05jrBr7Ls92L
         ieS8pKM0miz8c+1RhgnzJ9o1QnNMt1vUCNchnY41VCWTyQcwDKKM8uCS0vI1V5pMzc4U
         Y9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XG3a5Hb3geeSt25VSdjtrGAMkkbu3DIMscuexQdcgtQ=;
        b=bkmeMsXsSKzyHcuAQ+KdpAr3CBqR8nd0WAduM5hzmLu+OVFc6lD8A0Xzzq3DdnDfAL
         nkR1pnNfhF1ERfJUn4LWAJsPqEYmtsZ73ghOzqmjkwvprWKjXiTOXJL2nobltdPvsDtU
         GhBbrxuVng9IfXzwA1n9sXgX6TY7t30Q/LcpagWEQmkgUZWpCZBzT1LfnzSZlWpw4tuS
         5nEoa+E/Qu0QGc9UkViE/41CmKKafWiPPa3I/XlBwyFmAzli0O8ufet53kKjDoNdrjKy
         kvj3T19XUes2AgxmBEie4PCwQBrdBZs8x+F+7ygLbTc+boE8UosJpP2smyzZo5w32D3y
         QfFg==
X-Gm-Message-State: AOAM533wmjVyCAmSvPcy3XKDR1Ph8byoADSUJJCznP9Z89dxwvo9aN5R
        DoR3QNKvwUzV+fDgNOsjyWgrAown27q3APttnAerADoPMyE=
X-Google-Smtp-Source: ABdhPJzp9vCbNo6gWtvIbU11IzCyfjJV7sA385Bpzyar/Zyxcej0AMPE4WwszdF12x8ww4dlnl9vJ2Li489iNmvHOp0=
X-Received: by 2002:a25:5d08:: with SMTP id r8mr70521015ybb.464.1621154959554;
 Sun, 16 May 2021 01:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <1621052131-16309-1-git-send-email-yangtiezhu@loongson.cn> <68e897fec0e6258b2a964908af650d8608189454.camel@perches.com>
In-Reply-To: <68e897fec0e6258b2a964908af650d8608189454.camel@perches.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sun, 16 May 2021 10:49:21 +0200
Message-ID: <CAKXUXMw-XGs2s0tvx8JULddWhG8=i3wJk2=efpdZC5z2ah6kVg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Print some info if no filenames are given
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 6:26 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2021-05-15 at 12:15 +0800, Tiezhu Yang wrote:
> > After commit 45107ff6d526 ("checkpatch: if no filenames then read stdin"),
> > if no filenames are given, it will read patch from stdin rather than exit
> > directly, it is better to print some info about what to do next, otherwise
> > it is a bit confusing whether the script hangs.
>
> I think this is unnecessary.
> It's like trying to make cat without command line arguments emit something.
>

Tiezhu, if you think this behaviour of checkpatch needs a description
and explanation that the informed users* of checkpatch would value,
you may submit a patch to the kernel's checkpatch documentation,
./Documentation/dev-tools/checkpatch.rst (or to see a rendered
version, e.g., https://www.kernel.org/doc/html/latest/dev-tools/checkpatch.html).
You might want to add a few example invocations of checkpatch and then
explain with an example that checkpatch consumes stdin, if no patch
file is given as argument.

Looking forward to your patch to the documentation...

*informed user = "somebody that actually reads the available kernel
documentation on checkpatch"

Lukas
