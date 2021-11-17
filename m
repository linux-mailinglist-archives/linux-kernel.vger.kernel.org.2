Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1654546AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbhKQMyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:54:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:47772 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237331AbhKQMxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:53:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="220825545"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="220825545"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 04:50:49 -0800
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="593341576"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 04:50:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mnKOb-007nEs-Sq;
        Wed, 17 Nov 2021 14:50:37 +0200
Date:   Wed, 17 Nov 2021 14:50:37 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "A, Rashmi" <rashmi.a@intel.com>
Cc:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Subject: Re: [RESEND PATCH v2 4/4] phy: intel: Add Thunder Bay eMMC PHY
 support
Message-ID: <YZT6nTI0aJXsJ1o2@smile.fi.intel.com>
References: <20211027115516.4475-1-rashmi.a@intel.com>
 <20211027115516.4475-5-rashmi.a@intel.com>
 <DM6PR11MB3065C3329182A196C46DE5F68C9A9@DM6PR11MB3065.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3065C3329182A196C46DE5F68C9A9@DM6PR11MB3065.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 06:38:59AM +0000, A, Rashmi wrote:
> > -----Original Message-----
> > From: A, Rashmi <rashmi.a@intel.com>
> > Sent: Wednesday, October 27, 2021 5:25 PM

> Thank you Rob for the review of emmc dt-bindings.
> 
> Hi Vinod/Kishon,
> 
> Please let me know if there are any comments.
> Looking forward for your acknowledgement for the patch, phy: intel: Add Thunder Bay eMMC PHY support

Please, learn how not to put 450 unrelated lines in your responce(s) via email.
(Yes, I know that one may try to configure folding, but by default not many
 MUAs support this)

-- 
With Best Regards,
Andy Shevchenko


