Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD6231DCDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 17:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhBQQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 11:03:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233568AbhBQQDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:03:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23ED564DA1;
        Wed, 17 Feb 2021 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613577756;
        bh=TnkCAPqi2+40XxKgYb1MbyFrVPkhuEhfYPYpxM73w1Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e6TApfzdOFamoprxfBybvivJ4zU2KDZmsT3W0OinEi0BbeeFOpyUARWZz48P6a1E5
         PgZ0IIid1EJgZlI4SsSRuWHEghaXd2As0y9Dx4QWn38y80dvE/csyFj7rOx/+XiwFn
         IrQ8N/f6nfS3PLD7l1X760DLdb5fe1wRM+5d5TtDYhHMuv4wWpGp8Yy+ULfLaWyOiB
         lrK3Brrnj5nUir5b7rdIzEmhZurDIC4YBiTqCzZta3gxxulub1qF8pwg+xRAhYNmQg
         9zNpyMtyU7ffKEFcb8OoQy1JMsEtB+2+DJExghfNXVWMpyczf5tjpsBoKfeCxZtXZM
         cMkJ2G3vW7zcw==
Date:   Wed, 17 Feb 2021 17:02:32 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
Message-ID: <20210217170232.67fc02cc@kernel.org>
In-Reply-To: <20210217153038.1068170-1-rsalvaterra@gmail.com>
References: <20210217153038.1068170-1-rsalvaterra@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021 15:30:38 +0000
Rui Salvaterra <rsalvaterra@gmail.com> wrote:

> Hardware buffer management has never worked on the Turris Omnia, as the
> required MBus window hadn't been reserved. Fix thusly.
>=20
> Fixes: 018b88eee1a2 ("ARM: dts: turris-omnia: enable HW buffer management=
")
>=20
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
