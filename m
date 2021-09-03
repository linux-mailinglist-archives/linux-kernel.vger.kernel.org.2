Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F0E3FFC62
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348471AbhICIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:55:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:19915 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348434AbhICIzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:55:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="217511123"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="217511123"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 01:54:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="543421460"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.51])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 01:54:36 -0700
Date:   Fri, 3 Sep 2021 09:54:30 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c:229:28:
 warning: taking address of packed member 'csr_ops' of class or structure
 'adf_hw_device_data' may result in an unaligned pointer value
Message-ID: <YTHixlBTl5/uVPtd@silpixa00400314>
References: <202109031540.4K5y259V-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109031540.4K5y259V-lkp@intel.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 03:26:45PM +0800, kernel test robot wrote:
> >> drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c:229:28: warning: taking address of packed member 'csr_ops' of class or structure 'adf_hw_device_data' may result in an unaligned pointer value [-Waddress-of-packed-member]
>            adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
>                                      ^~~~~~~~~~~~~~~~
>    3 warnings generated.
I already sent a fix to resolve such warnings:
https://patchwork.kernel.org/project/linux-crypto/patch/20210902083459.238983-1-giovanni.cabiddu@intel.com/

Regards,

-- 
Giovanni
