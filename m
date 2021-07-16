Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D783CB797
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbhGPM7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:59:23 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:55430 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239816AbhGPM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:59:21 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 2D03BB37ED7;
        Fri, 16 Jul 2021 14:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626440184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdNG86x5tAHY5kRYAKVl3QeUKKUSEoSK6HtMC+ianxA=;
        b=rXsqa7AbS+FmuQaz9U6i68cIAiWgJZosBiV+kq0TDBFydFZOE6o1IdwhEKGKjRnoJgMk+o
        gOly5ZBAR5BYA1SaK+xANX34NDhuxQPowQ8Gnc46GAtoNTHELTir/MH+Cx3uhfAp3Noj3b
        VopDjLK2JsofkDMHxoeK4mZ8+RGdh50=
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
Date:   Fri, 16 Jul 2021 14:56:22 +0200
Message-ID: <1687461.6WkTYu5mUM@natalenko.name>
In-Reply-To: <YPFicCW90Jse4oms@T590>
References: <4729812.CpyZKHjjVO@natalenko.name> <2455133.St5lIfLNcX@natalenko.name> <YPFicCW90Jse4oms@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On p=C3=A1tek 16. =C4=8Dervence 2021 12:41:52 CEST Ming Lei wrote:
> > Do I understand correctly that this will be something like:
> >=20
> > Fixes: 2705dfb209 ("block: fix discard request merge")
> >=20
> > ?
> >=20
> > Because as the bisection progresses, I've bumped into this commit only.
> > Without it the issue is not reproducible, at least so far.
>=20
> It could be.
>=20
> So can you just test v5.14-rc1?

Doing it right now, but I've got another issue. Why BFQ is not listed here:

```
/sys/class/block/nvme0n1/queue/scheduler:[mq-deadline] kyber none
/sys/class/block/nvme1n1/queue/scheduler:[mq-deadline] kyber none
```

?

It is a built-in, FWIW:

```
$ modinfo bfq
name:           bfq
filename:       (builtin)
description:    MQ Budget Fair Queueing I/O Scheduler
license:        GPL
file:           block/bfq
author:         Paolo Valente
alias:          bfq-iosched
```

So far the issue is not reproducible with your patch + 5.13.2 as well as 5.=
14-
rc1 (but I don't have BFQ either with v5.14-rc1).

=2D-=20
Oleksandr Natalenko (post-factum)


