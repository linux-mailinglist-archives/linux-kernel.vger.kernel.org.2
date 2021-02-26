Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5CC326992
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 22:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBZVau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 16:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhBZVam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 16:30:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE7FC061788
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:30:02 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g3so12650657edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oq+ziV5W+4fEB7+AhqNfzmL/v56Klno9yJ5KkNDHbIk=;
        b=lgCtW/Yjv2mimZpK+rAl0afo5lamoHgXB1ZyR3nf/HIVD3AkIrzv8F68PpHt4s4RoC
         DDJoegJdMQ2Tcae3+I6sSpnDorPEb11zApmi29GJPNjLCdN2no5i2PdSMSaZnfbb7+yo
         YRFEySb1DigFpXmu2Q7g0DWZzrBhqyptwEO8IinjATl71E69DE0Y3r3qZqj4zQfsndB6
         OMgjNIpKEG7cxVanbYHd6ZRNRd8pcTNFxCSJtYeyj8d0bNIylOAOuTf2dyl40im30IoH
         ElkJK6JOR3Y5vL7jzdVWrc/6XtmvTdkeKIgENLsdSUtuhj5AgMsVl7g9N4btIliIudx9
         WvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oq+ziV5W+4fEB7+AhqNfzmL/v56Klno9yJ5KkNDHbIk=;
        b=kaLFrjOL1rdFKfIj2VHxVB6pnjeOgMjCxpwBmaAEEhX5x+1qX1r/SSfH+l5RC/iknI
         T4PQIUvgMb9r7pVmlGkUHOI3M8XRvGtrLSoC7E7WAsYKY4sFsdyP0GyHBudkHxfu2iOY
         Y9egKTSSH0qd/TspsUfCOjzmn9SqNyWaQgvAUzBBwqC+3qz4OVKGwo6uq021zKdpCACD
         GmaYqdi21+IRHJaChF4XxLBiOD3XfNr8shXe3pj+ed1LpUGaf5HvdNk5PLkXBmcEH2gA
         Y8mTgepFUinugmTHVOPm1IV+smqOhtrCfUL5AKZeFLxCOzK0nFyUrTKY+TIGck4Y756a
         /1+Q==
X-Gm-Message-State: AOAM530Tcymi2sm3Hc67tPOtxjOk1fZGghjxZs4DAlRnDHh6whfzHLAP
        e11JeXfhYmAc4sO84flCHANXU5nvYtU=
X-Google-Smtp-Source: ABdhPJyfg/mm7yAA091OwnEtTEi97HOlDmY2zLZBD/YZhBo8rmyrkAAcft0QS723uHNHMfyL/kU8yw==
X-Received: by 2002:a05:6402:ce:: with SMTP id i14mr5572238edu.42.1614375000794;
        Fri, 26 Feb 2021 13:30:00 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id j17sm6784557edv.66.2021.02.26.13.29.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 13:29:59 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id f12so6108431wrx.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 13:29:59 -0800 (PST)
X-Received: by 2002:a5d:6cab:: with SMTP id a11mr5220400wra.419.1614374998947;
 Fri, 26 Feb 2021 13:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20210226035721.40054-1-hxseverything@gmail.com> <CAM_iQpUAc5sB1xzqE7RvG5pQHQeCPJx5qAz_m9LaJYZ4pKfZsQ@mail.gmail.com>
In-Reply-To: <CAM_iQpUAc5sB1xzqE7RvG5pQHQeCPJx5qAz_m9LaJYZ4pKfZsQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 26 Feb 2021 16:29:21 -0500
X-Gmail-Original-Message-ID: <CA+FuTSfrE_brf_KO+swvsqTVGuoXYhPNTvnyK-1gC8PxSKneUA@mail.gmail.com>
Message-ID: <CA+FuTSfrE_brf_KO+swvsqTVGuoXYhPNTvnyK-1gC8PxSKneUA@mail.gmail.com>
Subject: Re: [PATCH/v3] bpf: add bpf_skb_adjust_room flag BPF_F_ADJ_ROOM_ENCAP_L2_ETH
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Xuesen Huang <hxseverything@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>, bpf <bpf@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuesen Huang <huangxuesen@kuaishou.com>,
        Zhiyong Cheng <chengzhiyong@kuaishou.com>,
        Li Wang <wangli09@kuaishou.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 3:15 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 7:59 PM Xuesen Huang <hxseverything@gmail.com> wrote:
> > v3:
> > - Fix the code format.
> >
> > v2:
> > Suggested-by: Willem de Bruijn <willemb@google.com>
> > - Add a new flag to specify the type of the inner packet.
>
> These need to be moved after '---', otherwise it would be merged
> into the final git log.
>
> >
> > Suggested-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Xuesen Huang <huangxuesen@kuaishou.com>
> > Signed-off-by: Zhiyong Cheng <chengzhiyong@kuaishou.com>
> > Signed-off-by: Li Wang <wangli09@kuaishou.com>
> > ---
> >  include/uapi/linux/bpf.h       |  5 +++++
> >  net/core/filter.c              | 11 ++++++++++-
> >  tools/include/uapi/linux/bpf.h |  5 +++++
> >  3 files changed, 20 insertions(+), 1 deletion(-)
>
> As a good practice, please add a test case for this in
> tools/testing/selftests/bpf/progs/test_tc_tunnel.c.

That's a great idea. This function covers a lot of cases. Can use the
code coverage against regressions.

With that caveat, looks great to me, thanks.
