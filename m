Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC73FF8E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 04:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345961AbhICClq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 22:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhICCln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 22:41:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0579C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 19:40:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id u19so5890436edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBoQoaTiYtK3jTeSr+aYlP+7i6ZNKdqcsaKoqVgHVcI=;
        b=MAMK10WnO69ZQGt/AV/ai9IGr1xPmcFKgv2lKaLMkfBxmlFh2I7hsT+I9PYCXotPHt
         FNYNhkoLI2rNDO8XQtT7eISt4apD1j0tH9jdyQE08zUK3Ku0NLNnyVs192D6EA7hLLbM
         iILmeOAnGHt+k4CtVBlUeDfDLvFFFJUVzOGxl+6EqjTqPrk5AwA1UGQX7gqin5iUQ1l5
         ND6kDQgGqp6xSb0BhjGGiH1PIrkXucLLFgjAuqrY5Ij/2P3fTTcwW1JuwOUlGPlHOyKM
         Hc651oWGgLrtjpymwPvXFHLBvf/bkZk1V05H1q6eyNgPRanyc3dHfvu+cyBdhUjzckZB
         ErSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBoQoaTiYtK3jTeSr+aYlP+7i6ZNKdqcsaKoqVgHVcI=;
        b=ktho+KYLUYQMDrHu7vKuWBv7sLWOyoJmrh9Tm6G0Mo47GMtUmbazNhAEz1QeCWn/U+
         oJlqzkAxueZToKocWI4OCa0bLMzRwuTVUBOaumaz6t2PnDgH51oDsZlIXU6e41BdnE0d
         YJk62uWyZu/6b25nHRFFGzUjzeVdPddkTa8jVD1oZrtZ7wL4mM0wNlOpA4EMDMXI9ha4
         NLeiL4KcQe7cVsCkNVTqz1Riqxr/r+Mvdngv5Ivo2bFX+lE0HR/Xa5pGuBx4mkNkFPXq
         O2pI1yAwgN1T9RzOitX1w2Xz4AIo97WSYHR1RzKEMIVnXydA+WkhfQCGF+fkdd6eYsxv
         O07A==
X-Gm-Message-State: AOAM532miYJG4NHORbfpB4tU5Cie5arZB1nlo3UD5nT8q5Y3lT8R5bFU
        DsazKCv9Y0Zz84UrT8GzpoW2oAQOneozEVokNF5J
X-Google-Smtp-Source: ABdhPJy89YnZf21uJRW1ZgPAt8L+w08+ibmCAlY9DmXQqRwXm39AZPgdQQFyUo/8UyhrNDBw41WJzAEh+ueDXTqJ5go=
X-Received: by 2002:a05:6402:1642:: with SMTP id s2mr1445756edx.135.1630636842406;
 Thu, 02 Sep 2021 19:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210902005238.2413-1-hdanton@sina.com> <0000000000002d262305caf9fdde@google.com>
 <20210902041238.2559-1-hdanton@sina.com> <CAHC9VhQBX8SsKBDHJGSyNC_Ewn3JgWK1_VixK48V8FRi7Tf=pA@mail.gmail.com>
In-Reply-To: <CAHC9VhQBX8SsKBDHJGSyNC_Ewn3JgWK1_VixK48V8FRi7Tf=pA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Sep 2021 22:40:31 -0400
Message-ID: <CAHC9VhS08Mewdtmxr-v2EPfWUGBNX+vgDsErX01KjAVW5g8UQg@mail.gmail.com>
Subject: Re: [syzbot] WARNING: refcount bug in qrtr_node_lookup
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+c613e88b3093ebf3686e@syzkaller.appspotmail.com>,
        bjorn.andersson@linaro.org, dan.carpenter@oracle.com,
        eric.dumazet@gmail.com, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 9:58 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Sep 2, 2021 at 12:13 AM Hillf Danton <hdanton@sina.com> wrote:
> > On Wed, 01 Sep 2021 19:32:06 -0700
> > >
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > UBSAN: object-size-mismatch in send4
> > >
> > > ================================================================================
> > > UBSAN: object-size-mismatch in ./include/net/flow.h:197:33
> > > member access within address 000000001597b753 with insufficient space
> > > for an object of type 'struct flowi'
> > > CPU: 1 PID: 231 Comm: kworker/u4:4 Not tainted 5.14.0-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > > Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
> > > Call Trace:
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x15e/0x1d3 lib/dump_stack.c:105
> > >  ubsan_epilogue lib/ubsan.c:148 [inline]
> > >  handle_object_size_mismatch lib/ubsan.c:229 [inline]
> > >  ubsan_type_mismatch_common+0x1de/0x390 lib/ubsan.c:242
> > >  __ubsan_handle_type_mismatch_v1+0x41/0x50 lib/ubsan.c:271
> > >  flowi4_to_flowi_common include/net/flow.h:197 [inline]
> >
> > This was added in 3df98d79215a ("lsm,selinux: pass flowi_common instead of
> > flowi to the LSM hooks"), could you take a look at the UBSAN report, Paul?
>
> Sure, although due to some flooding here at home it might take a day
> (two?) before I have any real comments on this.

I'm looking quickly at this tonight after a long day so it's possible
I'm missing something, but in the original report if you look one step
before the backtrace above you see the caller is send4 in the
wireguard code, which starts off by creating it's own flowi4 variable
on the stack and then eventually passing it down to
flowi4_to_flowi_common() for use as the second parameter to
security_sk_classify_flow().  Because the wireguard code only
allocates a flowi4 and not a full flowi struct it seems like this
would explain the size mismatch warning (flowi is larger than flowi4
due to the union containing flowi6 as well as flowi4).

Off the top of my head it isn't clear to me if it is considered "safe"
to allocate just a flowi4 in this way, you may need to allocate a full
flowi; if none of the netdev folks reply we could always check the
other flowi4 users in the kernel.

Depending on the above, the fix may be either to adjust send4() to use
a full flowi, or to adjust flowi4_to_flowi_common() to use the
flowi_common struct at the top of the flowi4 struct instead of first
looking for the flowi struct and going from there.

-- 
paul moore
www.paul-moore.com
