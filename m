Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5933983C1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 10:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhFBICs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 04:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232296AbhFBICj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 04:02:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BFFA613B4;
        Wed,  2 Jun 2021 08:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622620847;
        bh=Z54hpubbgVT9NT7jn4an5DgBd9VzYodLFQCiBkzQmMA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ze/jRPfT84VUKPhhGb8h20NBsOSmpeg2O4oiMcOeK2yFctrzaStBYXLr5zw4Z/Dwm
         Fc3VSLo+p8eJmcYfZJLKe7c25EIqjLLc1RDjvCSbOykadpt6UtbDTh/zPRYED28DId
         V0IJVYY5oafhOiRWHfdUMlw0/ys7lY3FedycE+XZb2qdomQdC8AMfPDvbOO7nyyrev
         8hg+TZAHAj2/cBp2NXYpUXkzZ7CoZRtCZO18Tf0egoqPES9nICQ7o9WH8nNuc765Sl
         H89rvvRC+t9su9rYt9q2Lre+bpV8VzP3vsjgGZgJKF7nocn/KR6NAotRj2vo/TZQvG
         cJiuPS2wae20A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210527211647.1520720-1-luca@lucaceresoli.net>
References: <20210527211647.1520720-1-luca@lucaceresoli.net>
Subject: Re: [PATCH RESEND] clk: vc5: fix output disabling when enabling a FOD
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Adam Ford <aford173@gmail.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-clk@vger.kernel.org
Date:   Wed, 02 Jun 2021 01:00:45 -0700
Message-ID: <162262084596.4130789.198191855440093780@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luca Ceresoli (2021-05-27 14:16:47)
> On 5P49V6965, when an output is enabled we enable the corresponding
> FOD. When this happens for the first time, and specifically when writing
> register VC5_OUT_DIV_CONTROL in vc5_clk_out_prepare(), all other outputs
> are stopped for a short time and then restarted.
>=20
> According to Renesas support this is intended: "The reason for that is VC=
6E
> has synced up all output function".
>=20
> This behaviour can be disabled at least on VersaClock 6E devices, of which
> only the 5P49V6965 is currently implemented by this driver. This requires
> writing bit 7 (bypass_sync{1..4}) in register 0x20..0x50.  Those registers
> are named "Unused Factory Reserved Register", and the bits are documented
> as "Skip VDDO<N> verification", which does not clearly explain the relati=
on
> to FOD sync. However according to Renesas support as well as my testing
> setting this bit does prevent disabling of all clock outputs when enabling
> a FOD.
>=20
> See "VersaClock =C2=AE 6E Family Register Descriptions and Programming Gu=
ide"
> (August 30, 2018), Table 116 "Power Up VDD check", page 58:
> https://www.renesas.com/us/en/document/mau/versaclock-6e-family-register-=
descriptions-and-programming-guide
>=20
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Reviewed-by: Adam Ford <aford173@gmail.com>
>=20
> ---

Any Fixes tag for this patch?
