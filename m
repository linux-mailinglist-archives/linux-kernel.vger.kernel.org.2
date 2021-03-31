Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9134FF74
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbhCaL0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:26:49 -0400
Received: from ni.piap.pl ([195.187.100.5]:34374 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234995AbhCaL0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:26:19 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ni.piap.pl (Postfix) with ESMTPSA id BDEB7443A98;
        Wed, 31 Mar 2021 13:26:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl BDEB7443A98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1617189972; bh=SNsJycYW6au4fkYqmxQwGi4yWYSKhVvDcjZGyufsCMY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hUo6uOFL2+LM2VVuRAeFIGJNyGfTTSfpSL3WS+lWd5xK5fjfHf9X0ETzWa4xQ1b7/
         eQv/hp1AYHQowZtC+vmmcv+QktN7A9QleGIjCe0nVow7Npx4Kg8mo8+djeBAplfhvh
         dP+ZwO+KikEzJtTAFJx5AxCU2vz2JwbDDAKeUzf8=
From:   =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] soc: ixp4xx: qmgr: Use DEFINE_SPINLOCK() for
 spinlock
References: <20210331095341.2175046-1-yangyingliang@huawei.com>
Sender: khalasa@piap.pl
Date:   Wed, 31 Mar 2021 13:26:09 +0200
In-Reply-To: <20210331095341.2175046-1-yangyingliang@huawei.com> (Yang
        Yingliang's message of "Wed, 31 Mar 2021 17:53:41 +0800")
Message-ID: <m38s63muni.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, whitelist
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yang Yingliang <yangyingliang@huawei.com> writes:

> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().

That's right.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Acked-by: Krzysztof Halasa <khalasa@piap.pl>

> ---
>  drivers/soc/ixp4xx/ixp4xx-qmgr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/soc/ixp4xx/ixp4xx-qmgr.c b/drivers/soc/ixp4xx/ixp4xx=
-qmgr.c
> index 8c968382cea7..dde3b668eb40 100644
> --- a/drivers/soc/ixp4xx/ixp4xx-qmgr.c
> +++ b/drivers/soc/ixp4xx/ixp4xx-qmgr.c
> @@ -16,7 +16,7 @@
>  static struct qmgr_regs __iomem *qmgr_regs;
>  static int qmgr_irq_1;
>  static int qmgr_irq_2;
> -static spinlock_t qmgr_lock;
> +static DEFINE_SPINLOCK(qmgr_lock);
>  static u32 used_sram_bitmap[4]; /* 128 16-dword pages */
>  static void (*irq_handlers[QUEUES])(void *pdev);
>  static void *irq_pdevs[QUEUES];
> @@ -434,7 +434,6 @@ static int ixp4xx_qmgr_probe(struct platform_device *=
pdev)
>  	}
>=20=20
>  	used_sram_bitmap[0] =3D 0xF; /* 4 first pages reserved for config */
> -	spin_lock_init(&qmgr_lock);
>=20=20
>  	dev_info(dev, "IXP4xx Queue Manager initialized.\n");
>  	return 0;

--=20
Krzysztof Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
