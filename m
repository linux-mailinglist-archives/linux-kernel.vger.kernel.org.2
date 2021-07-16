Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7123CB518
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 11:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhGPJRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 05:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhGPJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 05:17:09 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5471BC06175F;
        Fri, 16 Jul 2021 02:14:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j184so8009448qkd.6;
        Fri, 16 Jul 2021 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5nHyHeeg0sAwOgeidjlIYb/LHCQuXohNm0EqxrfVk9k=;
        b=UqN4ny2Ni4+BsBB84HzqT3PiWlMw6FunTBIC8Ua2q71hIEaqc5NudukFFVCgGAPgPd
         w/GSCwFA9z2KgYiIJ5f/KFKDTo/NqrUwo/cV12zjFM6Fzni/xI6NLhmAJwOyK7lwLocM
         f7nnz1VHF7hjCw083/Oe/5TRtWsnbUPD+i9lwHuNwmoKBgodl1J7fLUHUT+ezp5VKV/A
         aUBejtQHR/BlPOw9m4iMxjqs9IpCn4BpWY+U7oq1FJ47sL/K+X6ypdQ7hpw6jTdqcCvS
         aIxQcVYAjzvuHIRriyeJWcJipAGm/MunmX9zkyc9+cjxlgLXyF7js71Ns6OTSQss+wmG
         KkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5nHyHeeg0sAwOgeidjlIYb/LHCQuXohNm0EqxrfVk9k=;
        b=NZJDw+eGJ5yUp8SgvDIHbvHzIc9AuX/SwKVDk1uma6zff4WMOfkCrVkWMUsbekuGuR
         Y8WxaOMd1hnx7Bz4HUMBcdJjslNPahmSVwgVzDdEjHSD/V/UlNapUv4nbZF+7wVlMIh2
         orE1YSJS0PNJhNh4fMRR8Lk4YD6le/va5yVy+4zdq8XOKkpyNu08FsAyqBaNRNA458+D
         KwTd6Y3Q4SP+AYMw+EGQwQv71XPWNKOaX3sbzGvMgb6Bh/bW7fjpZoVSuthNA4czs3qr
         F343OT/DBv4CNgXsG1qXF1PEHULV9uo6akRZRyVQlpktDxcTVkeDkTWALNtn84qv4vai
         zyqg==
X-Gm-Message-State: AOAM532MZG1ailA+kynqz3iXDMn9Gu1qjA/3tSbAak/Ql7lsxF9JlbIQ
        HOCAEOsslpiFIZkVXwOthQ0/jFvVtNgT1fGC1FE=
X-Google-Smtp-Source: ABdhPJyv8vRrrVwRbL05wQBF4Q8RvwkM8M53S1zfEw6SidleJEHeKW0gtfeX4hjK76PLX0zynuRGX7FJoBYu/PQkC88=
X-Received: by 2002:a05:620a:6c9:: with SMTP id 9mr8753638qky.303.1626426853528;
 Fri, 16 Jul 2021 02:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002de98c05c61dba72@google.com> <162525917933.3570193.3861451207856095054@swboyd.mtv.corp.google.com>
In-Reply-To: <162525917933.3570193.3861451207856095054@swboyd.mtv.corp.google.com>
From:   Dongjiu Geng <gengdongjiu1@gmail.com>
Date:   Fri, 16 Jul 2021 17:14:01 +0800
Message-ID: <CABSBigQw_zSi6akKKXneqSHe56Q1Q_Y25CPQ4ZmT88n72BQgrg@mail.gmail.com>
Subject: Re: [syzbot] upstream build error (16)
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Dongjiu Geng <gengdongjiu@huawei.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        syzbot <syzbot+567c9f52d94ad483cac5@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for my late response,  I just saw it.
Thanks very much for Stephen Boyd's fix.

Stephen Boyd <sboyd@kernel.org> =E4=BA=8E2021=E5=B9=B47=E6=9C=883=E6=97=A5=
=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=884:56=E5=86=99=E9=81=93=EF=BC=9A
>
> Quoting syzbot (2021-07-01 23:04:23)
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.or=
g/p..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D11c93764300=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcaee64f929f=
74d56
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D567c9f52d94ad=
483cac5
> > userspace arch: arm
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+567c9f52d94ad483cac5@syzkaller.appspotmail.com
> >
> > drivers/clk/hisilicon/clk-hi3559a.c:818: undefined reference to `hisi_r=
eset_exit'
> > drivers/clk/hisilicon/clk-hi3559a.c:800: undefined reference to `hisi_r=
eset_init'
> > arm-linux-gnueabi-ld: drivers/clk/hisilicon/clk-hi3559a.c:806: undefine=
d reference to `hisi_reset_exit'
> >
>
> I think we fixed it. It's staged to merge in the next couple days.
>
> #syz fix: clk: hisilicon: hi3559a: Drop __init markings everywhere
