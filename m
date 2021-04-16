Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD513626F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243146AbhDPRgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:36:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:30793 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242995AbhDPRgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:36:42 -0400
IronPort-SDR: CUvtflCDenYtdx1J3Y5U3HRC7apm0zmd3LUHAPlxzB8zoUsbV6ra6WBG7veX2L0mnYyoGXARjP
 Owiw7a1bBhug==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="182202343"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="182202343"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 10:36:14 -0700
IronPort-SDR: /G8uWyJoqpYxFkZQD8VLD5Dqg8KkxE+HRNc5pUt16jLXo3D9rjLp7z4QNfAQZgV6fimW794iI4
 VbkG1qA30tNg==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="522771315"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 10:36:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lXSO2-004iS7-PW; Fri, 16 Apr 2021 20:36:10 +0300
Date:   Fri, 16 Apr 2021 20:36:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
Message-ID: <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 05:37:54PM +0300, Andy Shevchenko wrote:
> Strictly speaking the comparison between guid_t and raw buffer
> is not correct. Return to plain memcmp() since the data structures
> haven't changed to use uuid_t / guid_t the current state of affairs
> is inconsistent. Either it should be changed altogether or left
> as is.

Dan, please review this one as well. I think here you may agree with me.

-- 
With Best Regards,
Andy Shevchenko


