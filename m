Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD62640D3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 09:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhIPHoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 03:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhIPHov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 03:44:51 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69841C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 00:43:31 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so7228649otk.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 00:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0973SIYeyvLe0PABo/a4x/q6xona/kNY49YwWzDv8M=;
        b=Wob4O6w2GRy+fSbLyxCRiPzl8Ql7tarSJUyemEoQbYc+2ZCeXKzmWrRgfrwEh8XmF4
         kb1Hh9Inq5kMfvz+upj8kwYLybWdrghojlqPvLL/kpKdlziyMDeQ4O6cdYd6BMbwdpXN
         n8CZm3xQ2TOw27/nSenHG25UNG56/CgsafSI+0j6mazGeFnezphMP6VNGEC6G7/YxcSB
         XG80rAo6elzXJ4yNKq20O/ZzuaQuJqxeU4WSM1QE3We1yJKKleuelF7prJfslsQbuEDU
         quucuUCWJbXpIsDEdX5P2rDt+BjO+HVcSvklCzqM203FINDGYWftr7AXSky3plqm1MgH
         qFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0973SIYeyvLe0PABo/a4x/q6xona/kNY49YwWzDv8M=;
        b=Wi64nLwYWEAH1MJqh2y+bmbgKGY1VOMsWT3LEvshZTa9QKzlKB0f/x8b5S+eVY9qXa
         ZgdLz2PDItVrelG7M3qtWUdfScdJfwZPIwiHyFV+bj9DxWabo4kzxHC9MJNFMRsWJ9CL
         UWkox++WzSD/a8+CU6ESqKl6ZRD/Zw950WX6xtFA2QcreeGjWO3xOQYZaD/NrlQ9qXmo
         qNtl2lE+bjyY84mcoo9+M+PIcYfujOWdEo83PmiW2Yy9NRblAlFagDEgtBs6gYpFLcRV
         L2bKmivLnYE9Zg6IYeoU2M3sLtuQ68UAVBj/U7Gnl2FUZUMhtsoFDohkKh4jI4wgOM+K
         6vtw==
X-Gm-Message-State: AOAM531B2g6RlYpmjIWMLhye2J+1nvu6PhttFu84WpNt2d8d/FddyJEs
        /7Tr/iLW7HwLMrupE1xYr0aQhE0jwBq0PwiXHQCegw==
X-Google-Smtp-Source: ABdhPJx7fCOE5+sRz9QDeOVeV7YMacgCTG3TI/ALk3dR6MIQ//PfzFmci9hmlDiKHKWgCvNUMJi6lTS8KlAuGCZ/S44=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr3607252ote.319.1631778210493;
 Thu, 16 Sep 2021 00:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ffdae005cc08037e@google.com> <20210915193601.GI3544071@ziepe.ca>
In-Reply-To: <20210915193601.GI3544071@ziepe.ca>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Sep 2021 09:43:19 +0200
Message-ID: <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sept 2021 at 21:36, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Sep 15, 2021 at 05:41:22AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    926de8c4326c Merge tag 'acpi-5.15-rc1-3' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11fd67ed300000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=37df9ef5660a8387
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dc3dfba010d7671e05f5
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
>
> #syz dup: KASAN: use-after-free Write in addr_resolve (2)
>
> Frankly, I still can't figure out how this is happening
>
> RDMA_USER_CM_CMD_RESOLVE_IP triggers a background work and
> RDMA_USER_CM_CMD_DESTROY_ID triggers destruction of the memory the
> work touches.
>
> rdma_addr_cancel() is supposed to ensure that the work isn't and won't
> run.
>
> So to hit this we have to either not call rdma_addr_cancel() when it
> is need, or rdma_addr_cancel() has to be broken and continue to allow
> the work.
>
> I could find nothing along either path, though rdma_addr_cancel()
> relies on some complicated properties of the workqueues I'm not
> entirely positive about.

I stared at the code, but it's too complex to grasp it all entirely.
There are definitely lots of tricky concurrent state transitions and
potential for unexpected interleavings. My bet would be on some tricky
hard-to-trigger thread interleaving.

The only thing I can think of is adding more WARNINGs to the code to
check more of these assumptions. But I don't know if there are any
useful testable assumptions...
