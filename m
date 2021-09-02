Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CEF3FEF0A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbhIBN7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 09:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbhIBN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 09:59:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A49C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 06:58:44 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u19so3043233edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXEJdGninkBdVtpXQoG13dqQs8Qs+Jfbydk0oWk896M=;
        b=Nls/IV4MSQuu3HJFeiLRnplV4yq96ldDKDyz8BGmf/lYykqGly+V3DRC3aYr81i/4N
         LA8f7+nfAe3DgnlL6YnyXMLM0X2nWRa1jTXj9S7k4HaCGpzBmjzlufRQp7rx14D44QEJ
         CbD1NjZyH1P70Ts8g1Ss/+n6oGegK5PPgrK3azF9ItKkUSY00LwjPdkrDDHn7JW4vVw6
         8TfUn0jeZTy1CgPPB2E02YpgD3JfZ+nJaPnxf+C/N/cEoPasKqabw2YB/bch4ytIWFkA
         I29vWhap8RtKiU/PsrV5ikjOjgrRlWrljWQ0l1YH6JZyv+IPy1xEeZvxiseu+Gm2NNxy
         gFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXEJdGninkBdVtpXQoG13dqQs8Qs+Jfbydk0oWk896M=;
        b=ErUCgJHWAiVhHQe5CZEXuQy5e4FAo0xnLw300UKxPzoypx7/i0JmE7a/mfhLb6AUrA
         RKSgNzMZNW+BIDlD6L9oh4oiZriyy6nbPe/QAyHX9X0AFawTZlDU64W4A/oh5r/28v1I
         A7w7LHqfwAavG/+/BZwJA1jGiKqD/K6/i/cJsz9meShK4vrWuV95P5wp42KVLTFhZV76
         wKWxmGxgZrhjJDAaTv98XIEhj4QmFPBV89QLedFl5YFo4Ybq2ma/rhwUjXPcj+yozBLW
         SYmr1aIjf1DofRHGWJcqTkuW7Bwr3/H/i28ziny9iQ6Q6bv3Eg5W2A20FcBfQzTH+ZTW
         e6xQ==
X-Gm-Message-State: AOAM533txeFumzkv5yYD1VTmR7LbAgVbiBIYAwHlcGzHZzUDjJG1XC5b
        heOyo/mr0EcmHO5nh3dHPh770RHQgGuxlJBHjVmv
X-Google-Smtp-Source: ABdhPJw6QC4FMVNA86SoALbyyyEG6UMKskge2SDZ8noyZveyOk2NS6c2yrsdp8J/q7V+M4RSUyJzH5IVh/rven6EEo0=
X-Received: by 2002:aa7:d613:: with SMTP id c19mr3671822edr.196.1630591122604;
 Thu, 02 Sep 2021 06:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210902005238.2413-1-hdanton@sina.com> <0000000000002d262305caf9fdde@google.com>
 <20210902041238.2559-1-hdanton@sina.com>
In-Reply-To: <20210902041238.2559-1-hdanton@sina.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Sep 2021 09:58:33 -0400
Message-ID: <CAHC9VhQBX8SsKBDHJGSyNC_Ewn3JgWK1_VixK48V8FRi7Tf=pA@mail.gmail.com>
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

On Thu, Sep 2, 2021 at 12:13 AM Hillf Danton <hdanton@sina.com> wrote:
> On Wed, 01 Sep 2021 19:32:06 -0700
> >
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > UBSAN: object-size-mismatch in send4
> >
> > ================================================================================
> > UBSAN: object-size-mismatch in ./include/net/flow.h:197:33
> > member access within address 000000001597b753 with insufficient space
> > for an object of type 'struct flowi'
> > CPU: 1 PID: 231 Comm: kworker/u4:4 Not tainted 5.14.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x15e/0x1d3 lib/dump_stack.c:105
> >  ubsan_epilogue lib/ubsan.c:148 [inline]
> >  handle_object_size_mismatch lib/ubsan.c:229 [inline]
> >  ubsan_type_mismatch_common+0x1de/0x390 lib/ubsan.c:242
> >  __ubsan_handle_type_mismatch_v1+0x41/0x50 lib/ubsan.c:271
> >  flowi4_to_flowi_common include/net/flow.h:197 [inline]
>
> This was added in 3df98d79215a ("lsm,selinux: pass flowi_common instead of
> flowi to the LSM hooks"), could you take a look at the UBSAN report, Paul?

Sure, although due to some flooding here at home it might take a day
(two?) before I have any real comments on this.

-- 
paul moore
www.paul-moore.com
