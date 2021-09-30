Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E5841D586
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348581AbhI3Ifa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:35:30 -0400
Received: from muru.com ([72.249.23.125]:39088 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348460AbhI3If1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:35:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 358BC8050;
        Thu, 30 Sep 2021 08:34:14 +0000 (UTC)
Date:   Thu, 30 Sep 2021 11:33:43 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/tty/serial/serial_core.c:621 uart_write_room() warn:
 unsigned 'ret' is never less than zero.
Message-ID: <YVV2ZwjFU4n8IClN@atomide.com>
References: <202109281901.W4GmIDOG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109281901.W4GmIDOG-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <lkp@intel.com> [210928 11:48]:
> tree:   https://github.com/0day-ci/linux/commits/Tony-Lindgren/Get-rid-of-pm_runtime_irq_safe-for-8250_omap/20210922-152808
> head:   4456f28c1932b70461a0d8c45d4e863fa9d1be29
> commit: 3c7e2a8d4353263d8c5607fc7eca5e4b009f45eb serial: core: Add new prep_tx for power management
> date:   6 days ago
> config: i386-randconfig-m021-20210927 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> New smatch warnings:
> drivers/tty/serial/serial_core.c:621 uart_write_room() warn: unsigned 'ret' is never less than zero.
> 
> Old smatch warnings:
> drivers/tty/serial/serial_core.c:308 uart_shutdown() error: we previously assumed 'uport' could be null (see line 304)
> drivers/tty/serial/serial_core.c:329 uart_shutdown() error: uninitialized symbol 'flags'.
> drivers/tty/serial/serial_core.c:2753 iomem_base_show() warn: argument 3 to %lX specifier is cast from pointer

FYI, this patch is no longer needed, updated series posted at [0] below.

Thanks,

Tony

[0] https://lore.kernel.org/linux-kernel/20210930062906.58937-1-tony@atomide.com/T/#m8aa4dc5d38218d17c652d45d3611fc8a696b96c1
