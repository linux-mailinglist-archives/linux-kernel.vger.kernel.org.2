Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C787B3D14CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhGUQY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 12:24:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:52220 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229600AbhGUQY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:24:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="208361412"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="208361412"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 10:05:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="576755219"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 10:05:30 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m6Feu-00Gibw-Cj; Wed, 21 Jul 2021 20:05:24 +0300
Date:   Wed, 21 Jul 2021 20:05:24 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
Message-ID: <YPhT1APE8QweDCoP@smile.fi.intel.com>
References: <mvmtukn6bmu.fsf@suse.de>
 <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
 <mvmpmvb68cg.fsf@suse.de>
 <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
 <mvmlf5z66l9.fsf@suse.de>
 <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
 <mvmh7gn649v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmh7gn649v.fsf@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 06:05:48PM +0200, Andreas Schwab wrote:
> On Jul 21 2021, Andy Shevchenko wrote:
> 
> > What is your DT excerpt for it?
> 
> arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts:
> 
> &qspi2 {
> 	status = "okay";
> 	mmc@0 {
> 		compatible = "mmc-spi-slot";
> 		reg = <0>;
> 		spi-max-frequency = <20000000>;
> 		voltage-ranges = <3300 3300>;
> 		disable-wp;
> 	};
> };

Hmm...

I have counted 89 device drivers in the kernel that have OF ID table without
SPI ID table. I'm wondering if all of them need to be fixed.

Or problem is somewhere else?


-- 
With Best Regards,
Andy Shevchenko


