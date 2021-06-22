Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D5F3B0521
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFVMtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:49:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:54192 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231381AbhFVMtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:49:49 -0400
IronPort-SDR: DqybjwP6/w9xLxzWUwvIhNGbff5L78jGVAumMnSAIjRIzqbr0onN4GIaup5mVNpL0J5rDP+C6t
 5GXl5nA29tFg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="187426934"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="187426934"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 05:47:32 -0700
IronPort-SDR: YEsZAytSydJ9ZEEyXdHQKV+xEWIRoClVPExk3AvAamRvPCwsJ1bnbduRlQZClO8TDmSr9/4hj3
 AnQvP68YEh2Q==
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="480801356"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 05:47:30 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lvfoM-004TK5-FQ; Tue, 22 Jun 2021 15:47:26 +0300
Date:   Tue, 22 Jun 2021 15:47:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] powerpc/papr_scm: Properly handle UUID types and
 API
Message-ID: <YNHb3mm0l9i/+Asm@smile.fi.intel.com>
References: <20210616134303.58185-1-andriy.shevchenko@linux.intel.com>
 <YNHbSGzdgQh+6F+O@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNHbSGzdgQh+6F+O@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 03:44:56PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 16, 2021 at 04:43:03PM +0300, Andy Shevchenko wrote:
> > Parse to and export from UUID own type, before dereferencing.
> > This also fixes wrong comment (Little Endian UUID is something else)
> > and should eliminate the direct strict types assignments.
> 
> Any comments on this version? Can it be applied?

"Any _other_ comments..."

> > Fixes: 43001c52b603 ("powerpc/papr_scm: Use ibm,unit-guid as the iset cookie")
> > Fixes: 259a948c4ba1 ("powerpc/pseries/scm: Use a specific endian format for storing uuid from the device tree")

AFAIU it's fine to have Fixes tags, but if anybody insist I will remove them
and send v3.

> > ---
> > v2: added missed header (Vaibhav), updated comment (Aneesh),
> >     rewrite part of the commit message to avoid mentioning the Sparse

-- 
With Best Regards,
Andy Shevchenko


