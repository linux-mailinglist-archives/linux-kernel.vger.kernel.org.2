Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351F63C5AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhGLKQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 06:16:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:4281 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235108AbhGLKPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 06:15:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="209929068"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="209929068"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 03:13:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="429593435"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 03:12:57 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m2svj-00Byl3-D6; Mon, 12 Jul 2021 13:12:51 +0300
Date:   Mon, 12 Jul 2021 13:12:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     platform-driver-x86@vger.kernel.org, mgross@linux.intel.com,
        hdegoede@redhat.com, irenic.rajneesh@gmail.com,
        vicamo.yang@canonical.com, srinivas.pandruvada@intel.com,
        david.e.box@intel.com, linux-kernel@vger.kernel.org,
        tamar.mashiah@intel.com, gregkh@linuxfoundation.org,
        rajatja@google.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, mlimonci@amd.com
Subject: Re: [PATCH v4 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
Message-ID: <YOwVo0tMJ/olJs1U@smile.fi.intel.com>
References: <cover.1625965476.git.gayatri.kammela@intel.com>
 <a5221897fa451e5f1cd3657e7025ecd3e8f96d96.1625965477.git.gayatri.kammela@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5221897fa451e5f1cd3657e7025ecd3e8f96d96.1625965477.git.gayatri.kammela@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 06:21:40PM -0700, Gayatri Kammela wrote:
> As part of collecting Intel x86 specific drivers in their own
> folder, move intel_pmc_core* files to its own subfolder there.


>  drivers/platform/x86/Kconfig                  | 21 ------------------
>  drivers/platform/x86/Makefile                 |  1 -
>  drivers/platform/x86/intel/Kconfig            |  1 +
>  drivers/platform/x86/intel/Makefile           |  1 +
>  drivers/platform/x86/intel/pmc/Kconfig        | 22 +++++++++++++++++++
>  drivers/platform/x86/intel/pmc/Makefile       |  5 +++++

Missed MAINTAINERS.

-- 
With Best Regards,
Andy Shevchenko


