Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A173305D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 03:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhCHCJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 21:09:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:15891 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232344AbhCHCJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 21:09:40 -0500
IronPort-SDR: j37sA0m7dhYl72y92/FPhTIluh13O+ov1RruZCE2r9/LwnjxrDHN8lMQCyDLWFSMqVSh4Utlq1
 1GxT1R990Qvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="187310087"
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="187310087"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 18:09:39 -0800
IronPort-SDR: 9h3gC4IHLcYivNlFevevEPpJC5Wajy5pa6iV5ZWsmZdZnkil+p3U8azKmvWFBebU6SlMF1U4fm
 OqXPrWtiEprA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,231,1610438400"; 
   d="scan'208";a="601966996"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 07 Mar 2021 18:09:38 -0800
Date:   Mon, 8 Mar 2021 10:04:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v3 0/4] Some improvement for Intel MAX 10 MFD drivers
Message-ID: <20210308020454.GA32151@yilunxu-OptiPlex-7050>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee:

Could you please help on review this patchset? They are some
improvements for intel-m10-bmc MFD driver.

Thanks,
Yilun

On Mon, Mar 01, 2021 at 01:59:41PM +0800, Xu Yilun wrote:
> This patchset is some improvements for intel-m10-bmc and its subdevs.
> 
> Main changes from v1:
> - Add a patch (#2) to simplify the definition of the legacy version reg.
> - Add a patch (#4), add entry in MAINTAINERS for intel-m10-bmc mfd driver
>   and the subdev drivers.
> 
> Main changes from v2:
> - Add Tom Rix as the reviewer for intel-m10-bmc mfd driver and the subdev
>   drivers.
> - Rebased to 5.12-rc1
> 
> 
> Matthew Gerlach (1):
>   mfd: intel-m10-bmc: Add access table configuration to the regmap
> 
> Xu Yilun (3):
>   mfd: intel-m10-bmc: Fix the register access range
>   mfd: intel-m10-bmc: Simplify the legacy version reg definition
>   MAINTAINERS: Add entry for Intel MAX 10 mfd driver
> 
>  MAINTAINERS                       | 10 ++++++++++
>  drivers/mfd/intel-m10-bmc.c       | 25 ++++++++++++++++++-------
>  include/linux/mfd/intel-m10-bmc.h |  7 +++++--
>  3 files changed, 33 insertions(+), 9 deletions(-)
> 
> -- 
> 2.7.4
