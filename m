Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03D7360F76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhDOPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbhDOPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:53:57 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:53:33 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id x8so21529970ybx.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F9TuoPKL8IRzmmWmBzazLUtdnRWucaC/+xmjl6G5cBA=;
        b=cKW8yX6vsGEJwivjF201Y+85frWjALXhCEZ5pki1xv7haWooMSh4XOTKxd6iMY7vyQ
         QnJPJlF+BGsfj9VBqQSNkjGB1VK4oSsc6YEdSJj9Xe1EpbeGHMtJZSg0hL0RXpHT0SMN
         KJZROGIDTtvaUGhVvA/sMVUdoT+4at0sOqc/PVNwnX4dOYzdyR69fCWn/+4DwWbh6IsW
         gjEVLT8rIyKI6L/2oLgrtP9QexfDmrX+EzHZ7ox9UxH7/M1Otts4Mkcc2qhXOpsRUXTu
         ivY1YKYivJfnz4eCpudiJn/wZFSDAFpSNzlSGVW51+D0KKHesoUp4MHl0a1tTyZwfCCq
         htbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F9TuoPKL8IRzmmWmBzazLUtdnRWucaC/+xmjl6G5cBA=;
        b=hW4+tBWGUyYt8udg/vZAxjcq41tgb/n0MgB0fbiG0G/L4KiidfJNxD8y/jPDcRV2zF
         bZPurIojroCrVH+k7ZCwbMLYZEvXkK/T8PgINCsvbwfuX0dlEdLaCqSt3uGQ9R9u9nEx
         dKi3mDdwmoHogy3+ua00HvFlq7MizByWWoSXYBxbHbSpUlr0aPl53Xj+6WtkyvR8CgYo
         nORdvEuTxVjtEw7S8dirQJ435PBmEl/lBRhC4u7KRr8giieyEevR1i/PjtrG2QpFovaw
         5ojThxKyc+VAbtCAHF7y3WihUIzTlXxRZL1gWYzdnQNKkexpO6YRZWK9v3Gshm35UVTO
         BJAA==
X-Gm-Message-State: AOAM5320KakyjUF117OGvyfXTA61TFPfEnmZB1bZB2N6mFzqWhbuESVk
        3uZtESi804ieOul0mP65eLt+iiJ9Q0ELvAA4Q25tbVYIb3A=
X-Google-Smtp-Source: ABdhPJwukdgNksnwyXSJzWK6NDpaILOTHD0IvzT6+j8yxtbAbhP/Nc4hU1rXHC45j6Tlvqq7oTbIPRw3k25/27+MWoY=
X-Received: by 2002:a25:b906:: with SMTP id x6mr5196823ybj.504.1618502012217;
 Thu, 15 Apr 2021 08:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <A63CB783-F5AF-419A-89B9-3755E6896D41@purdue.edu>
In-Reply-To: <A63CB783-F5AF-419A-89B9-3755E6896D41@purdue.edu>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 15 Apr 2021 17:53:20 +0200
Message-ID: <CANn89iLdP+FFb7+TR-RHW1Kdm5XAoP1_4ypYp+Cm5wzPbx-K1w@mail.gmail.com>
Subject: Re: [PROBLEM] a data race between tcp_set_default_congestion_control()
 and tcp_set_congestion_control()
To:     "Gong, Sishuai" <sishuai@purdue.edu>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "dsahern@kernel.org" <dsahern@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 5:47 PM Gong, Sishuai <sishuai@purdue.edu> wrote:
>
> Hi,
>
> We found a data race between tcp_set_default_congestion_control() and tcp=
_set_congestion_control() in linux-5.12-rc3.
> In general, when tcp_set_congestion_control() is reading ca->flags with a=
 lock grabbed, tcp_set_default_congestion_control()
> may be updating ca->flags at the same time, as shown below.
>
> When the writer and reader are running parallel, tcp_set_congestion_contr=
ol()=E2=80=99s control flow
> might be non-deterministic, either returning a -EPERM or calling tcp_rein=
it_congestion_control().
>
> We also notice in tcp_set_allowed_congestion_control(), the write to ca->=
flags is protected by tcp_cong_list_lock,
> so we want to point it out in case the data race is unexpected.
>
> Thread 1                                                        Thread 2
> //tcp_set_default_congestion_control()  //tcp_set_congestion_control()
>                                                                 // lock_s=
ock() grabbed
>                                                                 if (!((ca=
->flags & TCP_CONG_NON_RESTRICTED) || cap_net_admin))
>                                                                         e=
rr =3D -EPERM;
>                                                                 else if (=
!bpf_try_module_get(ca, ca->owner))
>                                                                         e=
rr =3D -EBUSY;
>                                                                 else
>                                                                         t=
cp_reinit_congestion_control(sk, ca);
> ca->flags |=3D TCP_CONG_NON_RESTRICTED;
>
>
>
> Thanks,
> Sishuai
>

Yes, obviously reading ca->flags while another thread might set the bit is =
racy.

This is of no consequence, if you want to silence KCSAN please a patch.
