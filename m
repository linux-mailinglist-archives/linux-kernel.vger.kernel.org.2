Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A29324CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhBYJYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbhBYJYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:24:21 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F13CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:23:40 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p193so4755821yba.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pxx1aE4upinJUUc21Ne6rYhrLXeZ2CxJBUqm3Et7V4Q=;
        b=rpSCD+xEPFJ9lUjp7VFI7jzPgfauraPH1TY1aXUxne1IO/mffCs7SMbrfWP6t46Ivp
         LduArL8qm4iANnrbfwuI4PMGCo9DWNGvz7KoMzeaXyCOVzobajAWIMSbLoit/xYPJRSD
         BG45YX3vaH4orwoLb6KBSnusV06P8I1LMnn0HuQF+3NAQI/eAY1+n9rPNVpM4MT47Gbe
         0DTeUVowUGG77u1b6M6cxkZEcluAHrytVwnhdL4msUd9gEO5FMYCqW9UNfNSglLmzuSW
         AZTjVwiT76UIthibn+MILznOQP12/yBlzahs2OE2mA0YR5FxxyQxvN1Tosnr3YVMJEa7
         Rmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pxx1aE4upinJUUc21Ne6rYhrLXeZ2CxJBUqm3Et7V4Q=;
        b=qqyQir7sI2BTBLVMt3LX2RH0DH0GqfV13ekgUA5py05v0e08Abu4iVJeKIs9H7CLWF
         6uVFPyIonQ6Ra/LDqLDPkpEEZJAG4ioyNDuTUv5s897XnwiGGWYnlCFWw/8UtndDgOdl
         AE6FN3TOCX8mwDKHfqaH1v7RY3VH+FW251sUUi1iVpWbaVnVR+mPA2B3mnsEqZ1zat0A
         qgSHVjWtPpYkg3hDn8g2UwXVJGmnEzvai8TUidwQnqaB80j7wUJ68+pFsO/qPyd7FSdL
         MppWjrEf6yJNAuCZysLgRL6L0jnUUBgnw4GPwblBg/jnFdG4k+b80GdHisayIVQWoTAb
         pKFg==
X-Gm-Message-State: AOAM5300TfvtH+w8MT4y+oMJupB8GmS3HuBE0fmPy+NUSEAI6g223VFm
        vmz1uDmdc0Ar2mnKSjrFtoCHIbJ43Voes0KMxrZQ/Q==
X-Google-Smtp-Source: ABdhPJypIkzDyztgtnOMTWm4XuOgIvA8QI4HROnDm+Y8hKpVwxJOtbu1qyhfa5YE360TYicYFpmU7C5/XdwjMduJIKs=
X-Received: by 2002:a25:7306:: with SMTP id o6mr2826464ybc.132.1614245018897;
 Thu, 25 Feb 2021 01:23:38 -0800 (PST)
MIME-Version: 1.0
References: <20210219014852.GA16580@xsang-OptiPlex-9020> <CADVnQym38g5fjMU-S7fqoRS6sxDjK4y7-9c3XZeGVXjLTN5Xog@mail.gmail.com>
 <20210224141302.GA13714@xsang-OptiPlex-9020> <20210225082118.GA22949@xsang-OptiPlex-9020>
In-Reply-To: <20210225082118.GA22949@xsang-OptiPlex-9020>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 25 Feb 2021 10:23:26 +0100
Message-ID: <CANn89iJx5eFnTqgsa_cqan6xKesFfwaaWRbj=BJMvizvOsSR1w@mail.gmail.com>
Subject: Re: [tcp] 9d9b1ee0b2: packetdrill.packetdrill/gtests/net/tcp/user_timeout/user-timeout-probe_ipv4-mapped-v6.fail
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Neal Cardwell <ncardwell@google.com>,
        Enke Chen <enchen@paloaltonetworks.com>,
        Jakub Kicinski <kuba@kernel.org>,
        William McCall <william.mccall@gmail.com>,
        Yuchung Cheng <ycheng@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 9:06 AM Oliver Sang <oliver.sang@intel.com> wrote:
>
> Hi, Neal,
>
> On Wed, Feb 24, 2021 at 10:13:02PM +0800, Oliver Sang wrote:
> > Hi, Neal,
> >
> > On Fri, Feb 19, 2021 at 09:52:04AM -0500, Neal Cardwell wrote:
> > > On Thu, Feb 18, 2021 at 8:33 PM kernel test robot <oliver.sang@intel.com> wrote:
> > > >
> > > >
> > > > Greeting,
> > > >
> > > > FYI, we noticed the following commit (built with gcc-9):
> > > >
> > > > commit: 9d9b1ee0b2d1c9e02b2338c4a4b0a062d2d3edac ("tcp: fix TCP_USER_TIMEOUT with zero window")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > I have pushed to the packetdrill repo a commit that should fix this test:
> > >
> > > 094da3bc77e5 (HEAD, packetdrill/master) net-test: update TCP tests for
> > > USER_TIMEOUT ZWP fix
> > > https://github.com/google/packetdrill/commit/094da3bc77e518d820ebc0ef8b94a5b4cf707a39
> > >
> > > Can someone please pull that commit into the repo used by the test
> > > bot, if needed? (Or does it automatically use the latest packetdrill
> > > master branch?)
> >
> > We updated our tool to use this latest packetdrill. seems improved, but not totally fix.
> >
> > before upgrading, we have:
> > b889c7c8c02ebb0b 9d9b1ee0b2d1c9e02b2338c4a4b
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :6          100%           6:6     packetdrill.packetdrill/gtests/net/tcp/user_timeout/user-timeout-probe_ipv4-mapped-v6.fail
> >            :6          100%           6:6     packetdrill.packetdrill/gtests/net/tcp/user_timeout/user-timeout-probe_ipv4.fail
> >
> > after upgrading, we have:
> > b889c7c8c02ebb0b 9d9b1ee0b2d1c9e02b2338c4a4b
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :6          100%           5:6     packetdrill.packetdrill/gtests/net/tcp/user_timeout/user-timeout-probe_ipv4-mapped-v6.fail
> >            :6          100%           3:6     packetdrill.packetdrill/gtests/net/tcp/user_timeout/user-timeout-probe_ipv4.fail
> >
> >
> > attached kmsg.xz and packetdrill from one run where both tests failed.
>
> here is an update. we did't re-test parent with latest packetdrill yesterday,
> so above results about b889c7c8c02ebb0b are still from old version packetdrill.
>
> today, we did further tests based on latest packetdrill, and found the tests
> always failed upon b889c7c8c02ebb0b. not sure if a kernel before your commit
> (9d9b1ee0b2d1c9e02b2338c4a4b) is still valid to run latest packetdrill?)

Well, the packetdrill test was relying on old kernel behavior (not
very precise USER_TIMEOUT implementation),
and the test had comments explaining this (
https://github.com/google/packetdrill/commit/094da3bc77e518d820ebc0ef8b94a5b4cf707a39

So old packetdrill test only pass on old kernels.

Really the new packetdrill test is now checking the behavior of recent kernels
and making sure future kernels won't regress.



>
> attached kmsg and test log from latest packetdrill upon parent commit FYI.
>
>
> >
> >
> > >
> > > thanks,
> > > neal
>
>
> > Running packetdrill/tests/bsd/fast_retransmit/fr-4pkt-sack-bsd.pkt ...
> > 2021-02-24 08:46:09 packetdrill/packetdrill --tolerance_usecs=40000 packetdrill/tests/bsd/fast_retransmit/fr-4pkt-sack-bsd.pkt
> > packetdrill/tests/bsd/fast_retransmit/fr-4pkt-sack-bsd.pkt:25: error handling packet: live packet payload: expected 1000 bytes vs actual 2000 bytes
> > packetdrill/tests/bsd/fast_retransmit/fr-4pkt-sack-bsd.pkt failed
> > Running packetdrill/tests/linux/fast_retransmit/fr-4pkt-sack-linux.pkt ...
> > 2021-02-24 08:46:10 packetdrill/packetdrill --tolerance_usecs=40000 packetdrill/tests/linux/fast_retransmit/fr-4pkt-sack-linux.pkt
> > packetdrill/tests/linux/fast_retransmit/fr-4pkt-sack-linux.pkt pass
> > Running packetdrill/tests/linux/packetdrill/socket_err.pkt ...
> > 2021-02-24 08:46:10 packetdrill/packetdrill --tolerance_usecs=40000 packetdrill/tests/linux/packetdrill/socket_err.pkt
> > packetdrill/tests/linux/packetdrill/socket_err.pkt:6: runtime error in socket call: Expected non-negative result but got -1 with errno 93 (Protocol not supported)
> > packetdrill/tests/linux/packetdrill/socket_err.pkt failed
> > Running packetdrill/tests/linux/packetdrill/socket_wrong_err.pkt ...
> > 2021-02-24 08:46:10 packetdrill/packetdrill --tolerance_usecs=40000 packetdrill/tests/linux/packetdrill/socket_wrong_err.pkt
> > packetdrill/tests/linux/packetdrill/socket_wrong_err.pkt:4: runtime error in socket call: Expected result -99 but got -1 with errno 93 (Protocol not supported)
> > packetdrill/tests/linux/packetdrill/socket_wrong_err.pkt failed
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-accept.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-accept.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-connect.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-read.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-read.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-write.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/close/close-local-close-then-remote-fin.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/close/close-local-close-then-remote-fin.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/close/close-on-syn-sent.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/close/close-remote-fin-then-close.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/close/close-remote-fin-then-close.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/cwnd_moderation/cwnd-moderation-disorder-no-moderation.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cwnd_moderation/cwnd-moderation-ecn-enter-cwr-no-moderation-700.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cwnd_moderation/cwnd-moderation-ecn-enter-cwr-no-moderation-700.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ecn/ecn-uses-ect0.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-large.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-large.pkt (ipv6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-retrans.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-small.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-small.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-subsequent.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_in_edge.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_in_edge.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_out_edge.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_out_edge_default_notsent_lowat.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_out_edge_default_notsent_lowat.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_out_edge_notsent_lowat.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/gro/gro-mss-option.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/inq/client.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/inq/client.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/inq/server.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ioctl/ioctl-siocinq-fin.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ioctl/ioctl-siocinq-fin.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/limited_transmit/limited-transmit-no-sack.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/limited_transmit/limited-transmit-sack.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/md5/md5-only-on-client-ack.pkt (ipv4)]
> > stdout:
> > /proc/net/tcp:   1: 0200A8C0:1F90 00000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 54376 2 00000000533bbe98 100 0 0 10 1
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mss/mss-setsockopt-tcp_maxseg-client.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/nagle/https_client.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-route-refresh-ip-tos.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-accept.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-connect.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-write.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/close/close-local-close-then-remote-fin.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/close/close-on-syn-sent.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/cwnd_moderation/cwnd-moderation-disorder-no-moderation.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/cwnd_moderation/cwnd-moderation-ecn-enter-cwr-no-moderation-700.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ecn/ecn-uses-ect0.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-retrans.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-small.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-subsequent.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_out_edge.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_out_edge_default_notsent_lowat.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_out_edge_notsent_lowat.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/gro/gro-mss-option.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/inq/client.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/inq/server.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/limited_transmit/limited-transmit-no-sack.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/limited_transmit/limited-transmit-sack.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/md5/md5-only-on-client-ack.pkt (ipv4-mapped-v6)]
> > stdout:
> > /proc/net/tcp6:   1: 0000000000000000FFFF00000200A8C0:1F90 00000000000000000000000000000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 57703 2 00000000b5e42e7e 100 0 0 10 1
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mss/mss-getsockopt-tcp_maxseg-server.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mss/mss-getsockopt-tcp_maxseg-server.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mss/mss-setsockopt-tcp_maxseg-client.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mss/mss-setsockopt-tcp_maxseg-server.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/nagle/https_client.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/nagle/sockopt_cork_nodelay.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/notsent_lowat/notsent-lowat-default.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/notsent_lowat/notsent-lowat-setsockopt.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/notsent_lowat/notsent-lowat-sysctl.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-shift-sacked-2-6-8-3-9-nofack.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-shift-sacked-7-3-4-8-9-fack.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-shift-sacked-7-5-6-8-9-fack.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sendfile/sendfile-simple.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rd-close.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-connect.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-write.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/close/close-remote-fin-then-close.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ecn/ecn-uses-ect0.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-retrans.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_in_edge.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_out_edge_notsent_lowat.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/gro/gro-mss-option.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ioctl/ioctl-siocinq-fin.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/limited_transmit/limited-transmit-sack.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mss/mss-getsockopt-tcp_maxseg-server.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mss/mss-setsockopt-tcp_maxseg-server.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/nagle/https_client.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/nagle/sendmsg_msg_more.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/nagle/sockopt_cork_nodelay.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/notsent_lowat/notsent-lowat-setsockopt.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/notsent_lowat/notsent-lowat-sysctl.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-shift-sacked-2-6-8-3-9-nofack.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-shift-sacked-7-5-6-8-9-fack.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rd-wr-close.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rdwr-send-queue-ack-close.pkt (ipv6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/tcp_info/tcp-info-rwnd-limited.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/tcp_info/tcp-info-sndbuf-limited.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/blocking/blocking-read.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/cwnd_moderation/cwnd-moderation-disorder-no-moderation.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-subsequent.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/fastopen/server/client-ack-dropped-then-recovery-ms-timestamps.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/limited_transmit/limited-transmit-no-sack.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mss/mss-setsockopt-tcp_maxseg-client.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mtu_probe/basic-v4.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/nagle/sendmsg_msg_more.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/nagle/sockopt_cork_nodelay.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/notsent_lowat/notsent-lowat-setsockopt.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-route-refresh-ip-tos.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-shift-sacked-2-6-8-3-9-nofack.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-shift-sacked-7-5-6-8-9-fack.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rdwr-close.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-wr-close.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/syscall_bad_arg/syscall-invalid-buf-ptr.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ts_recent/invalid_ack.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/basic.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/close/close-on-syn-sent.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/epoll/epoll_out_edge.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/md5/md5-only-on-client-ack.pkt (ipv6)]
> > stdout:
> > /proc/net/tcp6:   1: 7BFA3DFD00007DD10000000000000000:1F90 00000000000000000000000000000000:0000 0A 00000000:00000000 00:00000000 00000000     0        0 55408 2 00000000ce767bbd 100 0 0 10 1
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mtu_probe/basic-v4.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/nagle/sendmsg_msg_more.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/notsent_lowat/notsent-lowat-default.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-shift-sacked-7-3-4-8-9-fack.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rd-wr-close.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rdwr-close.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rdwr-send-queue-ack-close.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rdwr-write-queue-close.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-wr-close.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/syscall_bad_arg/fastopen-invalid-buf-ptr.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/syscall_bad_arg/sendmsg-empty-iov.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/tcp_info/tcp-info-last_data_recv.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/tcp_info/tcp-info-sndbuf-limited.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/timestamping/client-only-last-byte.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ts_recent/reset_tsval.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ts_recent/reset_tsval.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/batch.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/eor/no-coalesce-large.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mss/mss-setsockopt-tcp_maxseg-server.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/notsent_lowat/notsent-lowat-default.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-route-refresh-ip-tos.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sendfile/sendfile-simple.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rd-close.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rd-wr-close.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rdwr-send-queue-ack-close.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rdwr-write-queue-close.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/splice/tcp_splice_loop_test.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/syscall_bad_arg/fastopen-invalid-buf-ptr.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/syscall_bad_arg/sendmsg-empty-iov.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/syscall_bad_arg/syscall-invalid-buf-ptr.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/tcp_info/tcp-info-last_data_recv.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/tcp_info/tcp-info-rwnd-limited.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/tcp_info/tcp-info-sndbuf-limited.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/timestamping/client-only-last-byte.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/timestamping/partial.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/timestamping/server.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/timestamping/server.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ts_recent/fin_tsval.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ts_recent/invalid_ack.pkt (ipv6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/user_timeout/user-timeout-probe.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/validate/validate-established-no-flags.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/validate/validate-established-no-flags.pkt (ipv6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/basic.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/batch.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/client.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/closed.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/closed.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/epoll_edge.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/epoll_exclusive.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/epoll_exclusive.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/epoll_oneshot.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/fastopen-client.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/fastopen-client.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/fastopen-server.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/maxfrags.pkt (ipv6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/small.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/inq/server.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/notsent_lowat/notsent-lowat-sysctl.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sendfile/sendfile-simple.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rdwr-close.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-wr-close.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/syscall_bad_arg/fastopen-invalid-buf-ptr.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/syscall_bad_arg/syscall-invalid-buf-ptr.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/tcp_info/tcp-info-rwnd-limited.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/timestamping/partial.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/timestamping/server.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ts_recent/fin_tsval.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ts_recent/reset_tsval.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/user_timeout/user_timeout.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/user_timeout/user_timeout.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/basic.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/client.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/closed.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/epoll_edge.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/epoll_oneshot.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/fastopen-client.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/fastopen-server.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/small.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/mtu_probe/basic-v6.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rd-close.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/splice/tcp_splice_loop_test.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/syscall_bad_arg/sendmsg-empty-iov.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/timestamping/client-only-last-byte.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ts_recent/fin_tsval.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/validate/validate-established-no-flags.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/client.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/epoll_exclusive.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/fastopen-server.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/maxfrags.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/sack/sack-shift-sacked-7-3-4-8-9-fack.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/tcp_info/tcp-info-last_data_recv.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/ts_recent/invalid_ack.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/user_timeout/user-timeout-probe.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/batch.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/epoll_oneshot.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/small.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/shutdown/shutdown-rdwr-write-queue-close.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/timestamping/partial.pkt (ipv6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/user_timeout/user_timeout.pkt (ipv4-mapped-v6)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/maxfrags.pkt (ipv4)]
> > stdout:
> > stderr:
> > FAIL [/lkp/benchmarks/packetdrill/gtests/net/tcp/user_timeout/user-timeout-probe.pkt (ipv4)]
> > stdout:
> > stderr:
> > OK   [/lkp/benchmarks/packetdrill/gtests/net/tcp/zerocopy/epoll_edge.pkt (ipv4)]
> > stdout:
> > stderr:
> > KILL [/lkp/benchmarks/packetdrill/gtests/net/tcp/splice/tcp_splice_loop_test.pkt (ipv6)]
> > stdout:
> > stderr:
> > Ran  222 tests:  194 passing,   27 failing,    1 timed out (180.71 sec): tcp
>
