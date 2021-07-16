Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27A33CB219
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 07:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhGPFxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 01:53:51 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:55400 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbhGPFxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:53:48 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 2AFA8B3727F;
        Fri, 16 Jul 2021 07:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1626414650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MkD1+YfJKD2PbtLEBpDTmJMAI+qwaETSYREVcgaWIu0=;
        b=HoXZu9PfqtrdHb2zQonHLuFGrpPVulQTpblRdFNvLRIyBGF3xW3VbriAUaoFoIMM47JotH
        7lOUpbc1FyUGIn8cuGhcRpSPiSQN2guogSu5nyfP2KD0pcTzGMbO5lBgKGWrp+Ec56WWLd
        GG3kq3mfqcqNNvUvQShd29kdxKMDrwU=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurence Oberman <loberman@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        David Jeffery <djeffery@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date:   Fri, 16 Jul 2021 07:50:47 +0200
Message-ID: <6257454.2i5GHAlHl1@natalenko.name>
In-Reply-To: <8b0023f5ba9ede85f6f75159847b4c185ab68f6f.camel@redhat.com>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPBD8z+yqC0ShjrZ@kroah.com> <8b0023f5ba9ede85f6f75159847b4c185ab68f6f.camel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On =C4=8Dtvrtek 15. =C4=8Dervence 2021 23:37:21 CEST Laurence Oberman wrote:
> [root@ml150 ~]# uname -a
> Linux ml150 5.14.0-rc1+ #1 SMP Thu Jul 15 16:41:08 EDT 2021 x86_64
> x86_64 x86_64 GNU/Linux
>=20
> [root@ml150 ~]# nvme list
> Node             SN                   Model
>         Namespace Usage                      Format           FW Rev
> ---------------- -------------------- -------------------------------
> --------- --------- -------------------------- ---------------- -----
> ---
> /dev/nvme0n1     CVCQ536300C9400AGN   INTEL
> SSDPEDMW400G4                      1         400.09  GB /
> 400.09  GB    512   B +  0 B   8EV10135
> /dev/nvme1n1     CVFT7383000W400BGN   INTEL
> SSDPEDMD400G4                      1         400.09  GB /
> 400.09  GB    512   B +  0 B   8DV10171
>=20
> fwiw
>=20
> I built 5.14 and I have 2 nvme devices and I am not seeing this even
> using them to build the kernel on.

Thanks for trying. What about v5.13.2? Also, are using BFQ? Is device mappe=
r=20
in use?

=2D-=20
Oleksandr Natalenko (post-factum)


