Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4FD3CC342
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 14:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhGQMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 08:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGQMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 08:38:14 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EB6C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 05:35:18 -0700 (PDT)
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id DB435B3A141;
        Sat, 17 Jul 2021 14:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626525316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pwPW8ZBvYJ1j6+zanxZpBpf+XE4okDGSxJ4O6NxNGC4=;
        b=OgUN6xJYnj2LxCuxDio9SMp9DICiOTdRp2n7hAcLY2ZuQERSVY9LN892F+OClOEZO1Jiqz
        TW4GliCHxiv9WwwKctKqqFOL8A0bE+g4tBLkrnwBVs2CW7H4MnUl+6h7qlKN52v3IspiVW
        qzCa3bBmWlkrI3uUXnBzhCkXhusGrLg=
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
Date:   Sat, 17 Jul 2021 14:35:14 +0200
Message-ID: <3383530.3bVf3B8HMu@natalenko.name>
In-Reply-To: <8988303.mDXGIdCtx8@natalenko.name>
References: <4729812.CpyZKHjjVO@natalenko.name> <5053297.vgnLoh5Ws3@natalenko.name> <8988303.mDXGIdCtx8@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sobota 17. =C4=8Dervence 2021 14:19:59 CEST Oleksandr Natalenko wrote:
> On sobota 17. =C4=8Dervence 2021 14:11:05 CEST Oleksandr Natalenko wrote:
> > On sobota 17. =C4=8Dervence 2021 11:35:32 CEST Ming Lei wrote:
> > > Maybe you need to check if the build is OK, I can't reproduce it in my
> > > VM, and BFQ is still builtin:
> > >=20
> > > [root@ktest-01 ~]# uname -a
> > > Linux ktest-01 5.14.0-rc1+ #52 SMP Fri Jul 16 18:56:36 CST 2021 x86_64
> > > x86_64 x86_64 GNU/Linux [root@ktest-01 ~]# cat
> > > /sys/block/nvme0n1/queue/scheduler
> > > [none] mq-deadline kyber bfq
> >=20
> > I don't think this is an issue with the build=E2=80=A6 BTW, with `initc=
all_debug`:
> >=20
> > ```
> > [    0.902555] calling  bfq_init+0x0/0x8b @ 1
> > [    0.903448] initcall bfq_init+0x0/0x8b returned -28 after 507 usecs
> > ```
> >=20
> > -ENOSPC? Why? Also re-tested with the latest git tip, same result :(.
>=20
> OK, one extra pr_info, and I see this:
>=20
> ```
> [    0.871180] blkcg_policy_register: BLKCG_MAX_POLS too small
> [    0.871612] blkcg_policy_register: -28
> ```
>=20
> What does it mean please :)? The value seems to be hard-coded:
>=20
> ```
> include/linux/blkdev.h
> 60:#define BLKCG_MAX_POLS               5
> ```

OK, after increasing this to 6 I've got my BFQ back. Please see [1].

[1] https://lore.kernel.org/linux-block/20210717123328.945810-1-oleksandr@n=
atalenko.name/

=2D-=20
Oleksandr Natalenko (post-factum)


