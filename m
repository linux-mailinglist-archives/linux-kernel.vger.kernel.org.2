Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F873CC2EC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 14:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhGQMOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 08:14:10 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:55448 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhGQMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 08:14:08 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 2DE27B3A08A;
        Sat, 17 Jul 2021 14:11:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626523868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZiYmFhPrslmr76pYV3BfLEoydJp7cUW1ZKuTXoytCwI=;
        b=YZujDnMBrkFpzQGzkoFW9B2bWknm9tOvyaVlFaB+Z0/FpJb/lzOjxiPxvN91gpT5iawQnm
        SOPJJ/z8NYNuUJNJbGkhCmznPHAT7GXup8QG19ekSVrgWZeqOntWJJ25P+cufOH5gu8Tne
        3NArO+yn9Q8P1XcFMoPp+BUojmikwCc=
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
Date:   Sat, 17 Jul 2021 14:11:05 +0200
Message-ID: <5053297.vgnLoh5Ws3@natalenko.name>
In-Reply-To: <YPKkZJWsD84mmKuk@T590>
References: <4729812.CpyZKHjjVO@natalenko.name> <1687461.6WkTYu5mUM@natalenko.name> <YPKkZJWsD84mmKuk@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sobota 17. =C4=8Dervence 2021 11:35:32 CEST Ming Lei wrote:
> Maybe you need to check if the build is OK, I can't reproduce it in my
> VM, and BFQ is still builtin:
>=20
> [root@ktest-01 ~]# uname -a
> Linux ktest-01 5.14.0-rc1+ #52 SMP Fri Jul 16 18:56:36 CST 2021 x86_64
> x86_64 x86_64 GNU/Linux [root@ktest-01 ~]# cat
> /sys/block/nvme0n1/queue/scheduler
> [none] mq-deadline kyber bfq

I don't think this is an issue with the build=E2=80=A6 BTW, with `initcall_=
debug`:

```
[    0.902555] calling  bfq_init+0x0/0x8b @ 1
[    0.903448] initcall bfq_init+0x0/0x8b returned -28 after 507 usecs
```

=2DENOSPC? Why? Also re-tested with the latest git tip, same result :(.

> > So far the issue is not reproducible with your patch + 5.13.2 as well as
> > 5.14- rc1 (but I don't have BFQ either with v5.14-rc1).
>=20
> You have to verify it with BFQ applied, :-)

Understandable=E2=80=A6 BTW, I'm still running v5.13.2 with your patch appl=
ied and do=20
not see the issue.

=2D-=20
Oleksandr Natalenko (post-factum)


