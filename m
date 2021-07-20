Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2963CF6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhGTI2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:28:51 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:55732 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhGTIZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:25:04 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 6D05AB41E7E;
        Tue, 20 Jul 2021 11:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626771931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zTkNNItkMBlaqFMYurWQMqTjRu8UVH4wWx+Z1y3Sv9o=;
        b=NsWnK6DIEsHFO/M0/bzgppZTDvUtPXdBU0oyQHXWoDFC+rtKa0p9TmNGrulekbWKkUGV22
        wIwfi0LscB5GHq+4sJa8fi9yyKoY8CnOfMvQ/nq+BgNwkR8NtqjvetL8vTCFQzQG8Bx0LQ
        ZM8huj4wu4W8qKswXrpe1JIxbSqrvB4=
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
Date:   Tue, 20 Jul 2021 11:05:29 +0200
Message-ID: <2356877.Yf5hrMSTGe@natalenko.name>
In-Reply-To: <2407736.Le3fEKZpXq@natalenko.name>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPTYGD1zeae1x7Yp@T590> <2407736.Le3fEKZpXq@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ming.

On pond=C4=9Bl=C3=AD 19. =C4=8Dervence 2021 8:27:29 CEST Oleksandr Natalenk=
o wrote:
> On pond=C4=9Bl=C3=AD 19. =C4=8Dervence 2021 3:40:40 CEST Ming Lei wrote:
> > On Sat, Jul 17, 2021 at 02:35:14PM +0200, Oleksandr Natalenko wrote:
> > > On sobota 17. =C4=8Dervence 2021 14:19:59 CEST Oleksandr Natalenko wr=
ote:
> > > > On sobota 17. =C4=8Dervence 2021 14:11:05 CEST Oleksandr Natalenko =
wrote:
> > > > > On sobota 17. =C4=8Dervence 2021 11:35:32 CEST Ming Lei wrote:
> > > > > > Maybe you need to check if the build is OK, I can't reproduce it
> > > > > > in
> > > > > > my
> > > > > > VM, and BFQ is still builtin:
> > > > > >=20
> > > > > > [root@ktest-01 ~]# uname -a
> > > > > > Linux ktest-01 5.14.0-rc1+ #52 SMP Fri Jul 16 18:56:36 CST 2021
> > > > > > x86_64
> > > > > > x86_64 x86_64 GNU/Linux [root@ktest-01 ~]# cat
> > > > > > /sys/block/nvme0n1/queue/scheduler
> > > > > > [none] mq-deadline kyber bfq
> > > > >=20
> > > > > I don't think this is an issue with the build=E2=80=A6 BTW, with
> > > > > `initcall_debug`:
> > > > >=20
> > > > > ```
> > > > > [    0.902555] calling  bfq_init+0x0/0x8b @ 1
> > > > > [    0.903448] initcall bfq_init+0x0/0x8b returned -28 after 507
> > > > > usecs
> > > > > ```
> > > > >=20
> > > > > -ENOSPC? Why? Also re-tested with the latest git tip, same result
> > > > > :(.
> > > >=20
> > > > OK, one extra pr_info, and I see this:
> > > >=20
> > > > ```
> > > > [    0.871180] blkcg_policy_register: BLKCG_MAX_POLS too small
> > > > [    0.871612] blkcg_policy_register: -28
> > > > ```
> > > >=20
> > > > What does it mean please :)? The value seems to be hard-coded:
> > > >=20
> > > > ```
> > > > include/linux/blkdev.h
> > > > 60:#define BLKCG_MAX_POLS               5
> > > > ```
> > >=20
> > > OK, after increasing this to 6 I've got my BFQ back. Please see [1].
> > >=20
> > > [1]
> > > https://lore.kernel.org/linux-block/20210717123328.945810-1-oleksandr=
@na
> > > t
> > > alenko.name/
> >=20
> > OK, after you fixed the issue in blkcg_policy_register(), can you
> > reproduce the discard issue on v5.14-rc1 with BFQ applied? If yes,
> > can you test the patch I posted previously?
>=20
> Yes, the issue is reproducible with both v5.13.2 and v5.14-rc1. I haven't
> managed to reproduce it with v5.13.2+your patch. Now I will build v5.14-
> rc2+your patch and test further.

I'm still hammering v5.14-rc2 + your patch, and I cannot reproduce the issu=
e.=20
Given I do not have a reliable reproducer (I'm just firing up the kernel bu=
ild,=20
and the issue pops up eventually, sooner or later, but usually within a cou=
ple=20
of first tries), for how long I should hammer it for your fix to be conside=
red=20
proven?

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


