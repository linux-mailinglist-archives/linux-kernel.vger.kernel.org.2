Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B36373F27
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 18:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhEEQFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 12:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233502AbhEEQFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 12:05:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6893613B3;
        Wed,  5 May 2021 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620230677;
        bh=cTM8g/gKs3w7f3SKpfx5R9tQ4aTb7xARUcSs/9imTcI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XuD8VZzVX2EySNepWfffqri6VedVVZQGkeTDWQIzwXT+4xV3nRr7KQ3BaL8uBhOj2
         oRdBt1iLLzQwLBt5vpJXTK60/knqkx87AJdwTvw1lhwhqWUMNTpUZnNmwtwgsvS+z/
         hm2TUwUqepC+tiHwpX+VVcBc92bVuLPh53jiyy/sx3yJ7k+iY7i1PDH84ZqXKAij8z
         GbbUxf/HFT/GAqn9QTlgyR/vASAO3uu1lqHbO38tlWasAhe82wMc6XUmMUUMBD5uIi
         vRcezoa9KzvwWeN7ANAJHZ2HSiaprrmRSxELqbpibgeaL9SDVOdvgm5k9+A2/IdX1Y
         H8yRQSEHJwW3w==
Date:   Wed, 5 May 2021 18:04:33 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 mvebu + mvebu/dt64 1/6] firmware: turris-mox-rwtm:
 fix reply status decoding function
Message-ID: <20210505180433.550178c8@thinkpad>
In-Reply-To: <YI/rGQfWdMdanPcN@lunn.ch>
References: <20210308153703.23097-1-kabel@kernel.org>
        <20210429083636.22560-1-pali@kernel.org>
        <YI/rGQfWdMdanPcN@lunn.ch>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2021 14:22:49 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Apr 29, 2021 at 10:36:31AM +0200, Pali Roh=C3=A1r wrote:
> > From: Marek Beh=C3=BAn <kabel@kernel.org>
> >=20
> > The status decoding function mox_get_status() currently contains a dead
> > code path: if the error status is not MBOX_STS_SUCCESS, it always
> > returns -EIO, so the comparison to MBOX_STS_FAIL is never executed and
> > we don't get the actual error code sent by the firmware.
> >=20
> > Fix this.
> >=20
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver") =
=20
>=20
> You have put a fixes tag here, meaning you want it in stable? How does
> dead code elimination fulfil the stable requirements?
>=20
> Do any of these changes contain real fixes?
>=20
>    Andrew

Andrew, this is not dead code elimination. Rather it is that there is
dead code path due to an incorrect check. By correcting the check, the
dead code path becomes alive and starts reporting errors correctly.
This fix is nedeed in stable so that stable will report errors
correctly.

Marek
