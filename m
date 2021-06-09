Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF313A1F17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFIVg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhFIVg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:36:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4614A613EE;
        Wed,  9 Jun 2021 21:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623274503;
        bh=AbkTqiqwokqEuxOjwzbARmRprGytNMuk0VTnsM6Erlg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MVVCCXdRxXe3/nyZ1ITqTYtVuurVv9RRQ20kVSUIMP4kvVnUvcl01gtH2b30cik+t
         OVvr8hSLX2l+ySBmA13BFDU2cCSKCsiQhS8jJOeTZLPIdQIct5ohx9qdM91ziSUTjC
         QY+JJGAaxAP/F6ppRtBCPWYhHtMn6vvjnPXGKq0Gp3EiVe216LH4qAjniWXEkyd/Pw
         PsYAbFlLsb4fo48k/SUJoratBhcFFIN+X1IivPaXXr/4TpNYaQgg6ei96KYUGqhgz3
         0mq0A3Gro53jrSZoumqrTlpCbHFn0WGB4uPI+nxoXsCaGuGPX4ZZ9494WuFpS3Y0W1
         5TAuaokkrR4xw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210607110154.1291335-1-sean@geanix.com>
References: <20210607110154.1291335-1-sean@geanix.com>
Subject: Re: [RFC PATCH] clk: fix possible circular locking in clk_notifier_register()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Sean Nyekjaer <sean@geanix.com>
Date:   Wed, 09 Jun 2021 14:35:02 -0700
Message-ID: <162327450202.9598.6919065223406836263@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sean Nyekjaer (2021-06-07 04:01:54)
> Allocating memory with prepare_lock mutex held makes lockdep unhappy
> when memory pressure makes the system do fs_reclaim on eg. rawnand using
> clk.
>=20
[...]
> [  462.949628]  *** DEADLOCK ***
> [  462.949628]
> [  462.955563] 1 lock held by kswapd0/22:
> [  462.959322]  #0: 11f3c233 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire=
+0x0/0x48
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>=20
> Could have used GPF_NOWAIT, but it seems wrong during memory reclaim.
>=20
>  drivers/clk/clk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 65508eb89ec9..eb2a547487d6 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4348,7 +4348,7 @@ int clk_notifier_register(struct clk *clk, struct n=
otifier_block *nb)
>                         goto found;
> =20
>         /* if clk wasn't in the notifier list, allocate new clk_notifier =
*/
> -       cn =3D kzalloc(sizeof(*cn), GFP_KERNEL);
> +       cn =3D kzalloc(sizeof(*cn), GFP_ATOMIC);

We could not allocate this here and instead allocate it before taking
the lock with the assumption that we'll insert the notifier. That's
probably the normal case. If we allocated it but didn't use it then we
can free it on exit, outside the lock. Can you make that change and
resend? Using GFP_ATOMIC is not the best solution here.
