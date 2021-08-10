Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D28F3E57F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 12:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbhHJKGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 06:06:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:59569 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239669AbhHJKGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 06:06:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="278619487"
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="278619487"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 03:05:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,310,1620716400"; 
   d="scan'208";a="638755375"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 03:05:48 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 10 Aug 2021 13:05:45 +0300
Date:   Tue, 10 Aug 2021 13:05:45 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 09/20] Move Intel SCU IPC of pdx86 to intel directory to
 increase readability.
Message-ID: <YRJPebbK3uQBU9K8@lahna>
References: <20210810095832.4234-1-hpa@redhat.com>
 <20210810095832.4234-10-hpa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810095832.4234-10-hpa@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No objections, I think this is good idea but..

On Tue, Aug 10, 2021 at 05:58:21PM +0800, Kate Hsuan wrote:

.. I suggest to add proper commit message here. Many maintainers ignore
patches that don't have one.

> Signed-off-by: Kate Hsuan <hpa@redhat.com>
> ---
>  drivers/platform/x86/Kconfig                  | 47 -----------------
>  drivers/platform/x86/Makefile                 |  6 +--
>  drivers/platform/x86/intel/Kconfig            |  1 +
>  drivers/platform/x86/intel/Makefile           |  5 ++
>  drivers/platform/x86/intel/scu/Kconfig        | 52 +++++++++++++++++++
>  drivers/platform/x86/intel/scu/Makefile       | 11 ++++
>  .../x86/{ => intel/scu}/intel_scu_ipc.c       |  0
>  .../x86/{ => intel/scu}/intel_scu_ipcutil.c   |  0
>  .../x86/{ => intel/scu}/intel_scu_pcidrv.c    |  0
>  .../x86/{ => intel/scu}/intel_scu_pltdrv.c    |  0
>  .../x86/{ => intel/scu}/intel_scu_wdt.c       |  0
>  11 files changed, 70 insertions(+), 52 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/scu/Kconfig
>  create mode 100644 drivers/platform/x86/intel/scu/Makefile
>  rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipc.c (100%)
>  rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipcutil.c (100%)
>  rename drivers/platform/x86/{ => intel/scu}/intel_scu_pcidrv.c (100%)
>  rename drivers/platform/x86/{ => intel/scu}/intel_scu_pltdrv.c (100%)
>  rename drivers/platform/x86/{ => intel/scu}/intel_scu_wdt.c (100%)
