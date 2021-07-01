Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F050C3B99BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 01:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhGAXwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 19:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhGAXwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 19:52:32 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D452C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 16:50:01 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id j10so4032500qtx.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 16:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XdggwryIUp9QtckUNzdZvsJzKexlZ+NGR6XKEUlG0tk=;
        b=JhO/r7KTD/sn2gY+rlBgDO2A8GJC4yCyDOe+QQtQTFbxnRrQd7HYgtKbPvsagxRZQD
         1XnUkCjVNwzbnOIVBsTuDcwaaZJMqOuy+7XYSNpxaBRRsWwyL38///A22cTQ7GkT02C+
         +XeY28vzty/smthsGg5qtpk5IsHTJgBYjo23ctVuqJYoV6T/HKv0A/3PoT0jCyFaldLs
         BYBDYSnrtp2zhvwf12gyeoGK64RYQk1RkumzRK/i6AfGq0hMRPDff0rxUajnY6KVS+Ia
         v+2ZjxoOBDC8Zh1yjScRtTsVwOQa3AlHEUFuTkN8BPYwwboBJVDNCOvxEA36slsPWkth
         z08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdggwryIUp9QtckUNzdZvsJzKexlZ+NGR6XKEUlG0tk=;
        b=in5X9Lrijeo4uonUqBOb/gsX7NoGCfOX9Rrpuijs8Q5cDkeYPh7mHLfYJKvx6KfTBP
         qP2KfYp/OiR5QiXNrAXr5ISP28it7PJz9G8vPjbDMlVwsY5bExAciNqxB8IcIovZmhTe
         uY7AygKVq14D+oH7g6uiPqxype0/yVILtHgXrVkSmrcUGpqvL9WdAcx1GAZssD8Tn03t
         grKWNUNBB5qdhpp+b9pERrjuPijl44OkoZA+qMEk9KNnxqb0QYOUG1fWrHL1AsNHo3Rc
         dvJUt1aYbmw4GOMqCagHZSKoikkg2Xbgr+0R2KnBlP2Gpe72tDFKIMUy0/+kHTw513dH
         u8Ng==
X-Gm-Message-State: AOAM531eQUvFtICY/MPwR7/YksnvSVoRHWUrlyXo02y50AnbO7B/KG1z
        jYJEBAyu9jZUsRCE9a/saHhq266rWWgwdLZG1HcyvQ==
X-Google-Smtp-Source: ABdhPJzLTtm3sQdESTRNPGYHm3SYeT9dgI4UrSvDrQZ10wk/+gwcF4B56Gor+2HriupEN0NnfSwPz+jqwqiNVIMxfl0=
X-Received: by 2002:ac8:57d6:: with SMTP id w22mr1260062qta.153.1625183400171;
 Thu, 01 Jul 2021 16:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210630003406.4013668-1-paulburton@google.com>
 <CAJWu+ooRQ6hFtaA4tr3BNs9Btss1yan8taua=VMWMopGmEVhSA@mail.gmail.com>
 <YN38D3dg0fLzL0Ia@google.com> <20210701140754.5847a50f@oasis.local.home>
 <YN4Fpl+dhijItkUP@google.com> <20210701142624.44bb4dde@oasis.local.home>
 <51babd56c2fe53ba011152700a546151@perches.com> <20210701155100.3f29ddfb@oasis.local.home>
 <5666edba28107559db23ba0f948c1f82@perches.com>
In-Reply-To: <5666edba28107559db23ba0f948c1f82@perches.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 1 Jul 2021 19:49:49 -0400
Message-ID: <CAJWu+orwiU805LxM87TPXwL1Ptkx7yLrRKpCfpT2Tp3ROVDgww@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing: Simplify & fix saved_tgids logic
To:     Joe Perches <joe@perches.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Paul Burton <paulburton@google.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 5:07 PM Joe Perches <joe@perches.com> wrote:
>
> On 2021-07-01 12:51, Steven Rostedt wrote:
> > On Thu, 01 Jul 2021 12:35:29 -0700
> > Joe Perches <joe@perches.com> wrote:
> >
> >> C99 comments are allowed since about 5 years ago.
> >
> > Really, I thought Linus hated them. Personally, I find them rather ugly
> > myself. The only user of them I see in the kernel/ directory appears to
> > be for RCU. But Paul's on the C/C++ committee, so perhaps he favors
> > them.
> >
> > The net/ directory doesn't have any, except perhaps to comment out code
> > (which I sometimes use it for that too).
> >
> > The block/, arch/x86/ directories don't have them either.
> >
> > I wouldn't go and change checkpatch, but I still rather avoid them,
> > especially for multi line comments.
> >
> >  /*
> >   * When it comes to multi line comments I prefer using something
> >   * that denotes a start and an end to the comment, as it makes it
> >   * look like a nice clip of information.
> >   */
> >
> > Instead of:
> >
> >   // When it comes to multi line comments I prefer using something
> >   // that denotes a start and an end to the comment, as it makes it
> >   // look like a nice clip of information.
> >
> > Which just looks like noise. But hey, maybe that's just me because I
> > find "*" as a sign of information and '//' something to ignore. ;-)
>
> May I suggest using something other than an amber vt220?

Steve - mostly comments are to be ignored and the code is the ultimate
source of truth ;-), so // is fine :-D

That said, don't discard the amber vt220 I recently sent you just
because Joe says so ;-) <:o)

- Joel
