Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD91240DAA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 15:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbhIPNGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbhIPNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 09:06:22 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9503C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:05:01 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id r18so4014656qvy.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=acPxGanWudVp0KiXHdjtVTDLfzNEsbUYMSqmQk92sDI=;
        b=BqSjPT7X1NzzdHsX8YIObaF7E3kv9ttGWXhE/fKF8+/SvXJmsRT3sVeBJ5loU/NEk5
         tHTgHEFmuVAGxxQfkVXVbvvAgxxPDrtkPgdc/i1e871vE2JFhiY8AjQLUhlADU7zDY+l
         AwneVt4STcQs7miWFgJ/7sZaylwFoRBKc0KCUzsp+wmGjk9ZfbF1iSFUaKYXAOao0/5o
         qFtMNtOf1oH+ZBVuj2SlES7EEdBPFotKIJKkfK941TYw6ZuiCgPRJxdDFXOBpxWFgDHm
         6k6Mq64k36gK/cuDtlhvLY7sz/29XDjRwhTVxlaaKYxU7poxfKeBNLB/1ra/SiW0RVMA
         adhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=acPxGanWudVp0KiXHdjtVTDLfzNEsbUYMSqmQk92sDI=;
        b=O03C8oZLxgoEYH6wO2rYriuisuUjAUcJ6VxOJDSJ4PjRJ9lVWV/Tzo5PPY4Yzg/kZb
         MFszOT74AZPPP2+r3u7sQ7PvSANdpGZtc0iz4a/j6dPRitdKTMI5oaBbuBRw01QMKqkq
         YGQPvItR6raUcCWsBh/EumWhaJUq0gRbTIqYz38kmcOzVVXeVG4p2GABTjaUd8DtGCM3
         8GsNAGHW1hFJee9mB3mshDGzqNgU+EAhov11IUdWkIZTIaiMUXUwdhgBT62emWdwELks
         l7QPLAG7ELXPX1wpyRGZgGcKx3fsYYrVGGZg/hyTQFWwuZtILIQ5ta84gVtbz1wDSFsx
         Yqag==
X-Gm-Message-State: AOAM533WPagSHAdmVJKUJMwYAc9TQN4243R+e0tsY23RRCOCbZAxE3Jq
        S6zZcPsQqlFJOnsGVJ+blw8tXQ==
X-Google-Smtp-Source: ABdhPJwGR/9rt1lMFSmo/fGCtn7y0alVkwxO63R7/ik+cH+HR/fyXg+bbMT6Ll22OSbvRsdIhIoowA==
X-Received: by 2002:a0c:be85:: with SMTP id n5mr5081009qvi.59.1631797500834;
        Thu, 16 Sep 2021 06:05:00 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id h17sm1964816qtu.68.2021.09.16.06.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 06:05:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQr4V-001Me8-4O; Thu, 16 Sep 2021 10:04:59 -0300
Date:   Thu, 16 Sep 2021 10:04:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com>,
        dledford@redhat.com, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in addr_handler (4)
Message-ID: <20210916130459.GJ3544071@ziepe.ca>
References: <000000000000ffdae005cc08037e@google.com>
 <20210915193601.GI3544071@ziepe.ca>
 <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bxDuLggCzkLAchrGkKQxC2v4bhc01ciBg+oc17q2=HHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 09:43:19AM +0200, Dmitry Vyukov wrote:
> On Wed, 15 Sept 2021 at 21:36, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Sep 15, 2021 at 05:41:22AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    926de8c4326c Merge tag 'acpi-5.15-rc1-3' of git://git.kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=11fd67ed300000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=37df9ef5660a8387
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=dc3dfba010d7671e05f5
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+dc3dfba010d7671e05f5@syzkaller.appspotmail.com
> >
> > #syz dup: KASAN: use-after-free Write in addr_resolve (2)
> >
> > Frankly, I still can't figure out how this is happening
> >
> > RDMA_USER_CM_CMD_RESOLVE_IP triggers a background work and
> > RDMA_USER_CM_CMD_DESTROY_ID triggers destruction of the memory the
> > work touches.
> >
> > rdma_addr_cancel() is supposed to ensure that the work isn't and won't
> > run.
> >
> > So to hit this we have to either not call rdma_addr_cancel() when it
> > is need, or rdma_addr_cancel() has to be broken and continue to allow
> > the work.
> >
> > I could find nothing along either path, though rdma_addr_cancel()
> > relies on some complicated properties of the workqueues I'm not
> > entirely positive about.
> 
> I stared at the code, but it's too complex to grasp it all entirely.
> There are definitely lots of tricky concurrent state transitions and
> potential for unexpected interleavings. My bet would be on some tricky
> hard-to-trigger thread interleaving.

From a uapi perspective the entire thing is serialized with a mutex..

> The only thing I can think of is adding more WARNINGs to the code to
> check more of these assumptions. But I don't know if there are any
> useful testable assumptions...

Do you have any idea why we can't get a reproduction out of syzkaller
here? 

I feel less comfortable with syzkaller's debug output, can you give
some idea what it might be doing concurrently?

Jason
