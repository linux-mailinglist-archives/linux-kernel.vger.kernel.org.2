Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5AF420B0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbhJDMoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhJDMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:44:12 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BF8C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 05:42:23 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so21335764otb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OVSwl/mXXto5uL+RrHEGqRvQahW/ZfpPh6/yhUtWjo=;
        b=HJ8uQ7DxBnpPf3XPuZlSbUWz53S0T4RwhN6VuHCS4wRZHfCz1LLXdiKQ+ydLW2RUdb
         28+OYtF8ML2eKXjc4NSQy6X8cgloCI86P+SoUO/A6tXiVvjjX7OLR5IQ9p3+sgO3VjWj
         3DPXtdDUBhgaDGOhfLs2Humqr5sF3G5z+ggWRR8TXO98f753b/LAue0gZHq9NTBe9T3f
         0HMjIhyx/4tuYVo0U9QqCbYtMhoutvd7X47QydD51LkEhByiJNhaOR4KvoEwSrHKQo5k
         Vimq0ULM2EvDxO1DFDjQXQIJK8kp2ZuK9qzCTwc3zVBrT7Fv4UWvW1lygVatwvXDNeN/
         ObDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OVSwl/mXXto5uL+RrHEGqRvQahW/ZfpPh6/yhUtWjo=;
        b=3O2Y+Km1dAEXgeO2S1UaQiw9vFM31ZGezSqMX3kYTpRGJuwUNbuswmeiUyx2QZmSKx
         /iEjEkhp/CsUr+x5RlKU+3CcZNr2S91caFHNwyJnetRaHu6xA1Qs/55PVwo8zO5iIgJ7
         2+Se+hqWjOXsHBPFKgCeY2a3GtQpZqYGaGFgRs6TUMgJN6rUfBXFgqZ5Fw7/Fz1Fcf71
         gFt/HNigXUD+lZ12uL+shxr4BAL83XURa/01yC4I5nlT5xVgDrBEsIHI2rXdtJKTzaWx
         Lb+zDPCi884gq/A3yfiDEp5FrOB6eth5ZC4oXsD2GRURym9T7f5nuaHSzFOOquj6BvSs
         7UGg==
X-Gm-Message-State: AOAM533HlGXWwRFeM9tVqY+jzFX/tSsNVp0dewVLUQbEfMxlY3kR5fJ8
        JSna8bOAiorBVXeyccfyg2SB8PPIUekkplZoQsh1ig==
X-Google-Smtp-Source: ABdhPJx2JwdrPZUg8v0yUg8VLP/XIba3nx9KYrRusMF5XCEooJWRHYSk4ge6U+8iAFiktjHfoRdkf6bu/rBFKBMDWSE=
X-Received: by 2002:a9d:2f28:: with SMTP id h37mr9040432otb.196.1633351342781;
 Mon, 04 Oct 2021 05:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005a800a05cd849c36@google.com>
In-Reply-To: <0000000000005a800a05cd849c36@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 4 Oct 2021 14:42:11 +0200
Message-ID: <CACT4Y+ZRrxmLoor53nkD54sA5PJcRjWqheo262tudjrLO2rXzQ@mail.gmail.com>
Subject: Re: [syzbot] BUG: RESTRACK detected leak of resources
To:     Doug Ledford <dledford@redhat.com>,
        syzbot <syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2021 at 12:45, syzbot
<syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c7b4d0e56a1d Add linux-next specific files for 20210930
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=104be6cb300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c9a1f6685aeb48bd
> dashboard link: https://syzkaller.appspot.com/bug?extid=3a992c9e4fd9f0e6fd0e
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3a992c9e4fd9f0e6fd0e@syzkaller.appspotmail.com

+RESTRACK maintainers

(it would also be good if RESTRACK would print a more standard oops
with stack/filenames, so that testing systems can attribute issues to
files/maintainers).

> rdma_rxe: rxe-pd pool destroyed with unfree'd elem
> rdma_rxe: rxe-mr pool destroyed with unfree'd elem
> restrack: ------------[ cut here ]------------
> infiniband syz0: BUG: RESTRACK detected leak of resources
> restrack: Kernel PD object allocated by rds_rdma is not freed
> restrack: ------------[ cut here ]------------
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
