Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A078F3D3562
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhGWGx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:53:57 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:8924 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233209AbhGWGx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627025670; x=1658561670;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PM8f3fwg4vTHmRJ/1+StMf0BPVsuDWi5DwRx/RiHunA=;
  b=BrbVp0Jd7yVosdT2g0B2nmfQSyYtSYdUPAmviZtHCaw8LeKKjWz02HaU
   QGuB8V11B6dFELyChLNrjGkNqIvr6HRsy5C05iiPkk30LLpVVDPUUetV9
   Hv1uXM5Hlph5ItiCKL6wbg5Wzk/eeZGD8EUl/wfsPtSohQUSzDgCn6eFG
   MqxKwYSRC0Euw8K3SFOM8osodTAcFfwIXLsX4gAIteEZNn3ncgiBc14qD
   fRb6roMAnFAUJl8A4u908gs9f5u7eL2RSmRg8DWtEZNI4ywCBgXO95uTn
   tS75I3nC878hiTEK4iSgRAU0jMd5oB9FiLT5nn6qTizSWgWIIGb/2/pyO
   w==;
X-IronPort-AV: E=Sophos;i="5.84,263,1620684000"; 
   d="scan'208";a="18606297"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 Jul 2021 09:34:29 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 23 Jul 2021 09:34:29 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 23 Jul 2021 09:34:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627025669; x=1658561669;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PM8f3fwg4vTHmRJ/1+StMf0BPVsuDWi5DwRx/RiHunA=;
  b=McEY8QCiFpR1v/k0fVBTtcBvwvw8Tzr6pT208JDM9xYKiuPBbhlfhyst
   8IjDlE7vHyXp9ak7jGZEvN3vbmtacjy99krE4p6pOWfqb4iKQchJ+4e7U
   t60CGOGxfNq8atugP64wU8XBqqLsH2vm+4uoDn6Ywbu3XI0QF+lEbbchy
   Vi//alKCp9TaJLxnB0j0cJQVRjbqsrlP8C9IxYWTOp9Y6msFp+d8ECo+h
   chjQwRdX4h9H1Dvm5pEYFOKmBm2/a7a3dFi7hHaK891wVTUVA9laq2DJV
   HP/O3w75mbeBiGs0r+5gbI5tT3aoEugsmdnhIigd2r5Dlm/t3YzVUKTt7
   w==;
X-IronPort-AV: E=Sophos;i="5.84,263,1620684000"; 
   d="scan'208";a="18606296"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Jul 2021 09:34:29 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 2B08D280070;
        Fri, 23 Jul 2021 09:34:29 +0200 (CEST)
Message-ID: <75670688fbec759e8ab8b42356a16cca465dc430.camel@ew.tq-group.com>
Subject: Re: Duplicate calls to regmap_debugfs_init() through
 regmap_attach_dev()
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 23 Jul 2021 09:34:26 +0200
In-Reply-To: <eb27b79ce46bde0202a4e7b047a3aaec8338fb6d.camel@ew.tq-group.com>
References: <eb27b79ce46bde0202a4e7b047a3aaec8338fb6d.camel@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-19 at 15:53 +0200, Matthias Schiffer wrote:
> Hi everyone,
> 
> I hope I got the right list of maintainers for this issue, which seems
> to be rooted in the interaction between regmap, syscon and pinctrl-imx.
> 
> With recent kernels (observed on v5.10.y, but the code doesn't look
> significantly different on master/next) I've seen the following message
> on boot on i.MX6UL SoCs:
> 
> > debugfs: Directory 'dummy-iomuxc-gpr@20e4000' with parent 'regmap' already present!
> 
> I've tracked this down to this piece of code in the pinctrl-imx driver:
> 
> > 		gpr = syscon_regmap_lookup_by_compatible(info->gpr_compatible);
> > 		if (!IS_ERR(gpr))
> > 			regmap_attach_dev(&pdev->dev, gpr, &config);
> 
> __regmap_init() (called by syscon_regmap_lookup_by_compatible()) has:
> 
> > 	if (dev) {
> > 		ret = regmap_attach_dev(dev, map, config);
> > 		if (ret != 0)
> > 			goto err_regcache;
> > 	} else {
> > 		regmap_debugfs_init(map);
> > 	}
> 
> As dev is NULL in this call, regmap_debugfs_init() will be called.
> 
> pinctrl-imx then calls regmap_attach_dev(), which calls
> regmap_debugfs_init() again. Unless I'm missing something, this is very
> problematic: regmap_debugfs_init() does a lot more than just adding
> debugfs files - it also initializes list heads and mutices in the
> regmap structure.
> 
> It seems to me that there is no correct way to use regmap_attach_dev()
> from outside of __regmap_init(). In particular on a syscon regmap that
> may be shared between different drivers, setting map->dev looks wrong
> to me.
> 
> The total number of drivers that call regmap_attach_dev() is very low
> (I count 5), but all of them use it on a syscon regmap. Some of them
> perform further operations on the regmap as if they owned it, like
> modifying the cache configuration.
> 
> While not directly related, could anyone tell me why the locking around
> syscon_list in the syscon driver is correct (or if it is in fact
> incorrect)? It looks to me like two tasks might call
> device_node_get_regmap() at the same time, leading to two concurrent
> constructions of the same syscon regmap.
> 
> Kind regards,
> Matthias


Another question regarding the syscon driver: Does the syscon platform
device still have any use after bdb0066df96e ("mfd: syscon: Decouple
syscon interface from platform devices")? All exported syscon functions
use the regmaps stored in the global "syscon_list", which are
compeletely independent of the devices handled by syscon_probe().

As the syscon platform_driver doesn't do anything, it seems to me like
that part could just be removed, leaving only the handling of shared
regmaps. Maybe that code should live under drivers/base/regmap instead
of drivers/mfd?

