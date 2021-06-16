Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F0F3A9CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhFPOHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:07:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:46500 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhFPOHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:07:21 -0400
IronPort-SDR: csX7rbVSL6HOcA1gsVzYpv6R2vywBNftXEQqifo+Qowbx3m3YBehnh/nBMhapghw3//rHYl7TF
 59z3W5So5X0Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291813084"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="291813084"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 07:05:15 -0700
IronPort-SDR: dV2AwjTcL1XgrGLea/lTCqvSmWGX79q1zgcOfVt2RnTLz9AGIkyqcnxHK8cmqUz5/bNv8nr2FE
 Ih/VEAxYqCdQ==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="554048291"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 07:05:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ltWAI-002pmh-5s; Wed, 16 Jun 2021 17:05:10 +0300
Date:   Wed, 16 Jun 2021 17:05:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH v2 1/1] powerpc/papr_scm: Properly handle UUID types and
 API
Message-ID: <YMoFFn3J+eUzkUYh@smile.fi.intel.com>
References: <20210616134303.58185-1-andriy.shevchenko@linux.intel.com>
 <6f895afd-3469-c330-a4da-72db89dba6b3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f895afd-3469-c330-a4da-72db89dba6b3@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 07:17:03PM +0530, Aneesh Kumar K.V wrote:
> On 6/16/21 7:13 PM, Andy Shevchenko wrote:
> > Parse to and export from UUID own type, before dereferencing.
> > This also fixes wrong comment (Little Endian UUID is something else)
> > and should eliminate the direct strict types assignments.
> > 
> > Fixes: 43001c52b603 ("powerpc/papr_scm: Use ibm,unit-guid as the iset cookie")
> > Fixes: 259a948c4ba1 ("powerpc/pseries/scm: Use a specific endian format for storing uuid from the device tree")
> 
> Do we need the Fixes: there? It didn't change any functionality right? The
> format with which we stored cookie1 remains the same with older and newer
> code. The newer one is better?

Depends if you are okay with Sparse warnings.

> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


