Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE54C362DBD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 06:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhDQEpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 00:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhDQEpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 00:45:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D9C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:44:53 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k73so26124519ybf.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 21:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlzkXq0M+W1cpjaBF2fQqqPjR+95Za5NCaFJKXmKppg=;
        b=hK+Wgu+8IEvCbonKlxwvZkSoipVtAgcCO/pYJv2zHcLCCNPhYDVLbtEWjKHb1c+yhw
         lPqd5lDhiqlvuzBfBu0j5T/K9oK1zSRdK2z/4YwFuxioaphgZ1ulybfvcXxuqCUGqypZ
         YzVIrjvJrVx3b4oEy/rW3NGkzrf7NTVfMC9PcHK7bP5Wy2uyJquQap/s3k+KSZ4kFRgq
         3OsDr28S7m/EJydr80SALoA0ib1weskcURLbI+Wmc1bXa6jLu/HQYmMVjw7AkBlrgKUg
         +tLSHylq4h1vnxZehk9QI5hglBS4bp2KVx6awhedV3iv6qQnRrd0PLIkRfmfulh+Evh5
         5MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlzkXq0M+W1cpjaBF2fQqqPjR+95Za5NCaFJKXmKppg=;
        b=tIsyBQDaJqeiMRf4mYiWgWFPhyNxDiDBLhi0886Z0R5cZ+aEs9wIQCB2pu8L52IuQ+
         5eFP2zf9iJAnRSCDo5JR3oWnoy47hNSySEzrWOgdl+2mhBq543JbHiQ/hh0sK34k25Za
         B/a9oO3R7YEjc4eN66oC0N+8x8d7VVsOLD3BbiOympm1qILpPiOxIrUkXcHLXcOtRB7s
         3fn3m7T9Dz0FrmD2jjUdxOJweCgHo47w8gE3J0XcdVTgfakNEXclcD0q10dTyaMqJiwA
         ep08BKsOUnzrCugw/CXsfJfo/E8KVDaLjaGFkwVaQdsN0rjr/uWy04NmZ0uDBmglZ0kO
         8TPQ==
X-Gm-Message-State: AOAM532RXheh5zEAL2Ryam8NV6XrcK/+kLkggn86sDBwYeIlWdIFNHQa
        0olGGqwBoo7MJ0R62ZlM6YG4GMKBOawlchRBnw3llQ==
X-Google-Smtp-Source: ABdhPJwnh8zlbnBww30d5GLeHdlT+Hcx8XcVqiiHSAC8Vjc+C1c6af1fnZmhW9Sd4j/+rS58auI3P67nTq3IO8WCsaM=
X-Received: by 2002:a25:850b:: with SMTP id w11mr3477819ybk.518.1618634691937;
 Fri, 16 Apr 2021 21:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <02917697-4CE2-4BBE-BF47-31F58BC89025@hxcore.ol> <52098fa9-2feb-08ae-c24f-1e696076c3b9@gmail.com>
In-Reply-To: <52098fa9-2feb-08ae-c24f-1e696076c3b9@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 17 Apr 2021 06:44:40 +0200
Message-ID: <CANn89iL_V0WbeA-Zr29cLSp9pCsthkX9ze4W46gx=8-UeK2qMg@mail.gmail.com>
Subject: Re: PROBLEM: DoS Attack on Fragment Cache
To:     David Ahern <dsahern@gmail.com>, Florian Westphal <fw@strlen.de>
Cc:     Keyu Man <kman001@ucr.edu>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 2:31 AM David Ahern <dsahern@gmail.com> wrote:
>
> [ cc author of 648700f76b03b7e8149d13cc2bdb3355035258a9 ]



I think this has been discussed already. There is no strategy that
makes IP reassembly units immune to DDOS attacks.

We added rb-tree and sysctls to let admins choose to use GB of RAM if
they really care.



>
> On 4/16/21 3:58 PM, Keyu Man wrote:
> > Hi,
> >
> >
> >
> >     My name is Keyu Man. We are a group of researchers from University
> > of California, Riverside. Zhiyun Qian is my advisor. We found the code
> > in processing IPv4/IPv6 fragments will potentially lead to DoS Attacks.
> > Specifically, after the latest kernel receives an IPv4 fragment, it will
> > try to fit it into a queue by calling function
> >
> >
> >
> >     struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void
> > *key) in net/ipv4/inet_fragment.c.
> >
> >
> >
> >     However, this function will first check if the existing fragment
> > memory exceeds the fqdir->high_thresh. If it exceeds, then drop the
> > fragment regardless whether it belongs to a new queue or an existing queue.
> >
> >     Chances are that an attacker can fill the cache with fragments that
> > will never be assembled (i.e., only sends the first fragment with new
> > IPIDs every time) to exceed the threshold so that all future incoming
> > fragmented IPv4 traffic would be blocked and dropped. Since there is no
> > GC mechanism, the victim host has to wait for 30s when the fragments are
> > expired to continue receive incoming fragments normally.
> >
> >     In practice, given the 4MB fragment cache, the attacker only needs
> > to send 1766 fragments to exhaust the cache and DoS the victim for 30s,
> > whose cost is pretty low. Besides, IPv6 would also be affected since the
> > issue resides in inet part.
> >
> > This issue is introduced in commit
> > 648700f76b03b7e8149d13cc2bdb3355035258a9 (inet: frags: use rhashtables
> > for reassembly units) which removes fqdir->low_thresh, and GC worker as
> > well. We would gently request to bring GC worker back to the kernel to
> > prevent the DoS attacks.
> >
> > Looking forward to hear from you
> >
> >
> >
> >     Thanks,
> >
> > Keyu Man
> >
>
