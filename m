Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8194E323B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhBXLR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhBXLPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:15:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8470CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:15:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e9so1105083pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnxmbrJl3ncJzefv0p6O6XxT6Ruw5b+PDMn2hcJSbTM=;
        b=aPu+yWud0UCrEToLW+lpLQ4h4EV+PsvQjah2djnJb38SFMYBLX2o/PLUcdxtB8/O26
         f3A3TeLp1BbbDQPSPrJxs4JF6cQzlGs7YGCUH1BkGJ6U4MhoQ/naWVWjNg4GPJQyZdRS
         vA24WPpcBxto9Wk6w0dKpcb1N53gshhoGAAmbTnOsdUqyyFRwI9bpASTbkcRRawG2QO0
         0TRrLXKExrhUfQGuPAMzepDBo4x3GMUgFAVwxCcJoH27lUjLsRS6UqpAZuodaI8K7xGl
         QqRws0xlgACoHRD2fgWe94a3BnirgDNpFV845GdF6hb2AuXM6x9/uCHzYMOQAfQP2IQu
         DfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnxmbrJl3ncJzefv0p6O6XxT6Ruw5b+PDMn2hcJSbTM=;
        b=FJ9IPSunofEn7Wz+XnTtLUTlZ1l75a5Y5C2xygGlarINJpgNEtBVhEDPGyV/1BHrxo
         3un9CdV28PXwXmz3t0AF63I3xHmuJ3uVCL+GhzV3lhyUW53jeGzeADWPsMteOmvUIFjX
         bwoJ9gdV7tN7S5BH+knJj9V17uFQdtZck9w1z8BYBn7kdfPhQOb8kmXsREWJopm97qMy
         PMPzm6kLcj5QbUcu/r/pyQVQdGdbIjsmZwx2F1YTwt7oL208FwEqIM1YkBb8HFYSBU21
         30AEnV+QGmYApp9jzYRXluSJS/yNAQOPKA++QBgf+CHzaqCSsc3BSjsuEF/1KssXL044
         W2Sw==
X-Gm-Message-State: AOAM531EttFUVfsUb95kfRn3CsLa5lo6K1W4Na76Fa6GVcDYnQ6x/oBV
        lWGWm1wV2zt0bs6Jcc5W+g6Bgs2g2/jRfUQrTTI=
X-Google-Smtp-Source: ABdhPJwR2fo2oiDO1KRidBzMFxH9tO/+LuW9/rTeGMkqbX1rumoTIFd9BaVChWk4i7+KY+zcN0RMb/XG5IwrOK8WuiE=
X-Received: by 2002:a17:90a:4dc1:: with SMTP id r1mr4064898pjl.12.1614165305152;
 Wed, 24 Feb 2021 03:15:05 -0800 (PST)
MIME-Version: 1.0
References: <1609738534-14369-1-git-send-email-liang26812@gmail.com>
 <CAG_0j0D9Vhc5F659ZrORLD4vh56MtGK8Zf4V1Ex3nXOjkLL1gg@mail.gmail.com> <20210224103944.GQ1463@shell.armlinux.org.uk>
In-Reply-To: <20210224103944.GQ1463@shell.armlinux.org.uk>
From:   liang wang <liang26812@gmail.com>
Date:   Wed, 24 Feb 2021 19:14:54 +0800
Message-ID: <CAG_0j0BmczxbsScvJeoe9eC0JAEExvZY2wLfNCK5=bufBRTmvA@mail.gmail.com>
Subject: Re: [PATCH] [RFC]ARM: ftrace: pause/unpause function graph tracer in cpu_suspend()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, geert@linux-m68k.org,
        penberg@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Wed, 24 Feb 2021 at 18:39, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Feb 24, 2021 at 06:35:47PM +0800, liang wang wrote:
> > Hi,all
> >
> > ftrace function_graph tracer always cause kernel panic on my ARM device with
> > multiple CPUs, I found a solution for the problem on ARM64, refers to
> > the patch above,
> > I was wondering why this bugfix on ARM64 hasn't been upstreamed to ARM,
>
> Patches get applied to the ARM tree after they've been submitted to
> the patch system. If they don't get submitted to the patch system,
> then they get buried and forgotten.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

Thanks for replying,
So I refers to the solution on ARM64 and sent my patch on January as below.

http://lists.infradead.org/pipermail/linux-arm-kernel/2021-January/628460.html

But I haven't got any replies on my patch. How can I get my patch reviewed
and submitted to the patch system?Should I resend a new patch to this maillist?
Thanks!
