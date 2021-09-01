Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572663FD8DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbhIALhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 07:37:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:55785 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241703AbhIALhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:37:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="279729838"
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="279729838"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 04:36:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="466840713"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.51])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 04:36:41 -0700
Date:   Wed, 1 Sep 2021 12:36:33 +0100
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: Re: drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c:102:28:
 warning: taking address of packed member 'csr_ops' of class or structure
 'adf_hw_device_data' may result in an unaligned pointer value
Message-ID: <YS9lwVU2Ie9Q62+X@silpixa00400314>
References: <202109010001.5r11IRSX-lkp@intel.com>
 <YS9heetW+E+1Nr1w@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS9heetW+E+1Nr1w@smile.fi.intel.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 02:18:17PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 01, 2021 at 12:19:08AM +0800, kernel test robot wrote:
> > >> drivers/crypto/qat/qat_c62xvf/adf_c62xvf_hw_data.c:102:28: warning: taking address of packed member 'csr_ops' of class or structure 'adf_hw_device_data' may result in an unaligned pointer value [-Waddress-of-packed-member]
> >            adf_gen2_init_hw_csr_ops(&hw_data->csr_ops);
> >                                      ^~~~~~~~~~~~~~~~
> >    3 warnings generated.
> 
> 
> Why on Earth the struct adf_hw_device_data, that contains a lot of pointers,
> marked as __packed?! That __packed has to be dropped.
That struct doesn't need to be marked as __packed.
I'm going to send a patch that drops that attribute for all the
structures that do not need to be packed in the QAT driver.

-- 
Giovanni
