Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A9F377C88
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 08:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhEJGzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 02:55:15 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:41540 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJGzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 02:55:14 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 14A6rwkp023595
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 15:53:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 14A6rwkp023595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1620629639;
        bh=22hDFl0cusAOv5rw9cqlxGveWP5pEizhRqaB+nqD+sw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M1I8COxKK5r5krmc6f2W7ntkuq1jNrqeY8YOOkGcAj43eRZnq+HQSRCda8lcnBRpW
         eyMPEcM1K1A5HZTXa0T7BRnozjLCO9pj2z7GABZJurqjXjD7Q6sGGE01fRBtlE++OV
         nJQP9stiiGgfAZ71Xo7VeI3bc82Tn1xz2yCbcAJzIrqJJ9hIrBCLKWWFl+rW48UR63
         jN1J0LvVjrRZuF8Kvw7jRuyVOQAk8+r7q/cd9HF5l6z41QnE7TTHazrFJzf0IAoIBp
         PJCyAFBLGrtUpF1FuFzeHrHFVB8cn8u2wtckpR097Qyt3yVFk9qIie/p+ASDyKB/vb
         RzectykXKqndQ==
X-Nifty-SrcIP: [209.85.215.174]
Received: by mail-pg1-f174.google.com with SMTP id m190so12653235pga.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 23:53:59 -0700 (PDT)
X-Gm-Message-State: AOAM530X7/NIZP13Ai2V+8pGPpmmjlgbnQWDepWAkgqmHrglukTQX7f8
        a1Ov7TfmPX/CQrhhT1Ht6ldomxMt8V/bImAQo5Q=
X-Google-Smtp-Source: ABdhPJx/gP93ju4P/Ch6YZAqY8/RDdEojGY88wEPvUEdrR+MYI28b2rOJBBGd+KTKSt8sbnAiGq/5sB2wCR0VTM3Q3M=
X-Received: by 2002:a63:36c1:: with SMTP id d184mr20237541pga.47.1620629638407;
 Sun, 09 May 2021 23:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210510063450.412055-1-masahiroy@kernel.org> <YJjVw/N7nRlGTVMU@kroah.com>
In-Reply-To: <YJjVw/N7nRlGTVMU@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 10 May 2021 15:53:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNASuFkROQOadqjOyutdcCMK7zZMUpTCuTKAOcRTX6BuA+w@mail.gmail.com>
Message-ID: <CAK7LNASuFkROQOadqjOyutdcCMK7zZMUpTCuTKAOcRTX6BuA+w@mail.gmail.com>
Subject: Re: [PATCH] comedi: remove editor modelines and cruft (again)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        Qiheng Lin <linqiheng@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 3:42 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 10, 2021 at 03:34:50PM +0900, Masahiro Yamada wrote:
> > Commit fa60ce2cb450 ("treewide: remove editor modelines and cruft")
> > is different from what I submitted.
> >
> > My original patch [1] did treewide cleanups including the comedi driver.
> >
> > Unfortunately, commit 8ffdff6a8cfb ("staging: comedi: move out of staging
> > directory") moved drivers/staging/comedi/ to drivers/comedi/ before my
> > patch landed on Linus' tree from akpm tree.
> >
> > If Andrew Morton had used Git, 'git merge' would have resolved such file
> > moves properly without any manual intervention.
> >
> > Patches in akpm tree often get broken in his quilt workflows, and then
> > people end up with sending fixup patches.
> >
> > [1] https://lkml.kernel.org/r/20210324054457.1477489-1-masahiroy@kernel.org
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > I really hope Andrew Morton will use Git.
>
> Nah, quilt is really really good :)


git is much much better.   :)




> I'll take this in my tree, no worries.
>
> greg k-h



-- 
Best Regards
Masahiro Yamada
