Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D00A3D7970
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhG0PML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 11:12:11 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:57500 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhG0PMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 11:12:10 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D4363B5A46B;
        Tue, 27 Jul 2021 17:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1627398728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+u6eFB12YZ1NCrj7Q9V4Jck5qxdhuaziUeq3IRaHAM=;
        b=iT8WAcuG8Zbp1m3DR97NkkyBWUJbGjHXR49VIDYoSes7UmojArxLze8zKS8wObxOA9zUds
        3bmVrh5KU+8fa+ugk4cgQQjWb10aNYy4o1OQbKgoVzOUyNB9mGzkOHiD7MshxZ+XE2p2OR
        Q4TnXkMe1dFkZ1riTMWneRF9M+EdZYY=
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
Date:   Tue, 27 Jul 2021 17:12:03 +0200
Message-ID: <17691292.WCMSeNvH9h@natalenko.name>
In-Reply-To: <YPfUOKrxGs6FjaOZ@T590>
References: <4729812.CpyZKHjjVO@natalenko.name> <2356877.Yf5hrMSTGe@natalenko.name> <YPfUOKrxGs6FjaOZ@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On st=C5=99eda 21. =C4=8Dervence 2021 10:00:56 CEST Ming Lei wrote:
> > I'm still hammering v5.14-rc2 + your patch, and I cannot reproduce the
> > issue. Given I do not have a reliable reproducer (I'm just firing up the
> > kernel build, and the issue pops up eventually, sooner or later, but
> > usually within a couple of first tries), for how long I should hammer it
> > for your fix to be considered proven?
>=20
> You mentioned that the issue is reproducible with v5.14-rc, that means
> it can be always reproduced in limited time(suppose it is A). If the issue
> can't be reproduced any more after applying the patch in long enough time
> B(B >> A), we can think it is fixed by the patch.
>=20
> For example, if A is one hour, we can set B as 5*A or bigger to simulate
> the long enough time.

With your patch the issue is still not reproducible for me. Hence, from my=
=20
side the patch looks to be verified.

Thanks.

=2D-=20
Oleksandr Natalenko (post-factum)


