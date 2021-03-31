Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BF834F8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 08:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbhCaGjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 02:39:06 -0400
Received: from muru.com ([72.249.23.125]:49172 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232805AbhCaGie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 02:38:34 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 692A780C3;
        Wed, 31 Mar 2021 06:39:37 +0000 (UTC)
Date:   Wed, 31 Mar 2021 09:38:31 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: arch/arm/mach-omap2/sr_device.c:207:51: warning: variable
 'sr_inst' is uninitialized when used here
Message-ID: <YGQY53/F5morEPN/@atomide.com>
References: <202103271303.BNY18cjh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103271303.BNY18cjh-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <lkp@intel.com> [210327 05:06]:
> >> arch/arm/mach-omap2/sr_device.c:207:51: warning: variable 'sr_inst' is uninitialized when used here [-Wuninitialized]
>                            name = kasprintf(GFP_KERNEL, "smartreflex_%s", sr_inst[i]);
>                                                                           ^~~~~~~
>    arch/arm/mach-omap2/sr_device.c:191:29: note: initialize the variable 'sr_inst' to silence this warning
>            const char * const *sr_inst;
>                                       ^
>                                        = NULL
>    1 warning generated.

Thanks for the report, FYI I posted a fix for this at:

https://lore.kernel.org/linux-omap/20210331063556.30654-1-tony@atomide.com/T/#u

Regards,

Tony
