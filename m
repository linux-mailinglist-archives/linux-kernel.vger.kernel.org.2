Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911703CC333
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 14:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhGQMXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 08:23:00 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:55450 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGQMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 08:22:59 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 6924EB3A0CD;
        Sat, 17 Jul 2021 14:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626524401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gcD4BlYO0MJODsDv5lWH6aB5PZKfy3UHMX4EeHIRze0=;
        b=UKdaankAPr0jcxwYSuFajzao+2C+/kY0QI+E6w340ovOHUIsN1phoIGsFcMj9LIFiZOpM2
        +/dLezd7sR5sIby7C34UAOCtGj9Y1wmx+8vTOlWE2cyeaaKQiOyiGU2sRcv/a+z2KYX183
        +5HO5bMs8da6m8YE4NcwQWxmw40YKVo=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        David Jeffery <djeffery@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date:   Sat, 17 Jul 2021 14:19:59 +0200
Message-ID: <8988303.mDXGIdCtx8@natalenko.name>
In-Reply-To: <5053297.vgnLoh5Ws3@natalenko.name>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPKkZJWsD84mmKuk@T590> <5053297.vgnLoh5Ws3@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sobota 17. =C4=8Dervence 2021 14:11:05 CEST Oleksandr Natalenko wrote:
> On sobota 17. =C4=8Dervence 2021 11:35:32 CEST Ming Lei wrote:
> > Maybe you need to check if the build is OK, I can't reproduce it in my
> > VM, and BFQ is still builtin:
> >=20
> > [root@ktest-01 ~]# uname -a
> > Linux ktest-01 5.14.0-rc1+ #52 SMP Fri Jul 16 18:56:36 CST 2021 x86_64
> > x86_64 x86_64 GNU/Linux [root@ktest-01 ~]# cat
> > /sys/block/nvme0n1/queue/scheduler
> > [none] mq-deadline kyber bfq
>=20
> I don't think this is an issue with the build=E2=80=A6 BTW, with `initcal=
l_debug`:
>=20
> ```
> [    0.902555] calling  bfq_init+0x0/0x8b @ 1
> [    0.903448] initcall bfq_init+0x0/0x8b returned -28 after 507 usecs
> ```
>=20
> -ENOSPC? Why? Also re-tested with the latest git tip, same result :(.

OK, one extra pr_info, and I see this:

```
[    0.871180] blkcg_policy_register: BLKCG_MAX_POLS too small
[    0.871612] blkcg_policy_register: -28
```

What does it mean please :)? The value seems to be hard-coded:

```
include/linux/blkdev.h
60:#define BLKCG_MAX_POLS               5
```

=2D-=20
Oleksandr Natalenko (post-factum)


