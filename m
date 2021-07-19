Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2353CD625
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbhGSNNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:13:08 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:6370 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241026AbhGSNNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1626702821; x=1658238821;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=Zqzcp0xqv3eYdauf8qb63WRm1VeBKPhKQJtvMJl77Sg=;
  b=PlUTGbdLHpCTG5XOErQyT3viGq9B5jOAlAsW/0Hkm71bmqmNQQYZCWpW
   9RNORWQfk78jqSqPLyRiFdndjnIkQMs289bsVMCapF3o49GsPuN4X9Q0H
   31dzCyne7CEcgb9i7AHA8VNcxGCS5kgfQ7CW0l8Fwwq7t+mnb+e2KXfti
   WZjWa9rYS89u86E+osWEl2ImgyL6fl598m8MSbJQDIakGqjnlt6i/d/Gn
   Sl7hyIL0FBPM60X5IeDkPe2D8GcZiFJBVdUZTSrza7ZoEUZwkLn/LVFoX
   AmslZ6CDYgLdoTfLasiP4bsPOG4zTom++UNDFjdq4fK8t3H/FzRMr39rv
   g==;
X-IronPort-AV: E=Sophos;i="5.84,252,1620684000"; 
   d="scan'208";a="18524165"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 19 Jul 2021 15:53:40 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 19 Jul 2021 15:53:40 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 19 Jul 2021 15:53:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1626702820; x=1658238820;
  h=message-id:subject:from:to:cc:date:mime-version:
   content-transfer-encoding;
  bh=Zqzcp0xqv3eYdauf8qb63WRm1VeBKPhKQJtvMJl77Sg=;
  b=XC+jPQQZcft8tbKvcrOoqjAKgRNYGrdDMq+8SvzhVrkZOeRc2j1GsL0i
   dM/p60WUjhiiODjaW/4c60i5P1v1xT9s6nkN2mF6SBEGr4c36MFO5lpp4
   Nt1oY0j/vtjoKQRnAndgmZiK7meQlGkPJfyin7eA+q+vXST+8taaWG0FF
   DNhcBvoaZGxUVXiPawnJyJI14R3UzB7LHdVEBTxldd/UHFT6M/q12WHT3
   kQwPmq9aj+0pylq0lFIpy4t8p73GXpn2YoWRVpJThUSSENdek6KKWyzmu
   tVngIZ82KBdBkr0/dQY+eP92Miftj+FoDJQLVT4StiKfLEietgtRPSRO0
   A==;
X-IronPort-AV: E=Sophos;i="5.84,252,1620684000"; 
   d="scan'208";a="18524164"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 19 Jul 2021 15:53:40 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3FD39280070;
        Mon, 19 Jul 2021 15:53:40 +0200 (CEST)
Message-ID: <eb27b79ce46bde0202a4e7b047a3aaec8338fb6d.camel@ew.tq-group.com>
Subject: Duplicate calls to regmap_debugfs_init() through regmap_attach_dev()
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 19 Jul 2021 15:53:38 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I hope I got the right list of maintainers for this issue, which seems
to be rooted in the interaction between regmap, syscon and pinctrl-imx.

With recent kernels (observed on v5.10.y, but the code doesn't look
significantly different on master/next) I've seen the following message
on boot on i.MX6UL SoCs:

> debugfs: Directory 'dummy-iomuxc-gpr@20e4000' with parent 'regmap' already present!

I've tracked this down to this piece of code in the pinctrl-imx driver:

> 		gpr = syscon_regmap_lookup_by_compatible(info->gpr_compatible);
> 		if (!IS_ERR(gpr))
> 			regmap_attach_dev(&pdev->dev, gpr, &config);

__regmap_init() (called by syscon_regmap_lookup_by_compatible()) has:

> 	if (dev) {
> 		ret = regmap_attach_dev(dev, map, config);
> 		if (ret != 0)
> 			goto err_regcache;
> 	} else {
> 		regmap_debugfs_init(map);
> 	}

As dev is NULL in this call, regmap_debugfs_init() will be called.

pinctrl-imx then calls regmap_attach_dev(), which calls
regmap_debugfs_init() again. Unless I'm missing something, this is very
problematic: regmap_debugfs_init() does a lot more than just adding
debugfs files - it also initializes list heads and mutices in the
regmap structure.

It seems to me that there is no correct way to use regmap_attach_dev()
from outside of __regmap_init(). In particular on a syscon regmap that
may be shared between different drivers, setting map->dev looks wrong
to me.

The total number of drivers that call regmap_attach_dev() is very low
(I count 5), but all of them use it on a syscon regmap. Some of them
perform further operations on the regmap as if they owned it, like
modifying the cache configuration.

While not directly related, could anyone tell me why the locking around
syscon_list in the syscon driver is correct (or if it is in fact
incorrect)? It looks to me like two tasks might call
device_node_get_regmap() at the same time, leading to two concurrent
constructions of the same syscon regmap.

Kind regards,
Matthias

