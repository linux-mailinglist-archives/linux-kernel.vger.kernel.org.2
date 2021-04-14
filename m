Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A06335FB61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhDNTMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:12:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:22337 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234378AbhDNTMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:12:40 -0400
IronPort-SDR: R5N/FHnBdgfYqbba85zyWnoCARHy21qItLk8cK+o3/yFRN8ebzioT3qzsmtkvV0C2rBTv61v0z
 UGQ17Lg4bWUw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="191528850"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="191528850"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:12:18 -0700
IronPort-SDR: SbYrAMIG0Pb5MgtqhxeBJpGZ5CVAn0NP4DKcBnM/d5K0ofKcYtCFFtu2VekZBRLaP7vDrMnuI/
 Fu0AbuuX1m2w==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="532880222"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 12:12:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lWkvu-00455M-5i; Wed, 14 Apr 2021 22:12:14 +0300
Date:   Wed, 14 Apr 2021 22:12:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] stm class: Replace uuid_t with plain u8 uuid[16]
Message-ID: <YHc+jpfOX9xiZLMh@smile.fi.intel.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
 <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
 <YHcnckePpKDujCU+@kroah.com>
 <YHcqxMLR44laX2PZ@smile.fi.intel.com>
 <YHc68v7keeITnA3K@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHc68v7keeITnA3K@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 08:56:50PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 14, 2021 at 08:47:48PM +0300, Andy Shevchenko wrote:
> > On Wed, Apr 14, 2021 at 07:33:38PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Apr 14, 2021 at 08:12:46PM +0300, Alexander Shishkin wrote:

...

> > Nothing, just will require additional export_uuid() / import_uuid() call.
> 
> Isn't that the "correct way" here?

I agree that it is better, yes.

> > > > -	generate_random_uuid(pn->uuid.b);
> > > 
> > > Ok, that's not good, but that looks to be a flaw in the
> > > generate_random_uuid() api, not this driver implementation.
> > > 
> > > I don't understand why this change is needed?
> > 
> > Using raw buffer APIs against uuid_t / guid_t.
> 
> So you want to do that, or you do not want to do that?  Totally
> confused,

It is matter of consistency, so two possibilities here:
- use types _and_ APIs for raw buffer (this patch)
- use types _and_ APIs for uuid_t (suggested in this discussion)

Currently it uses uuid_t type _and_ raw buffer APIs — inconsistency.

-- 
With Best Regards,
Andy Shevchenko


