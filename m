Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594E935FA10
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350949AbhDNRsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:48:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:6222 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347548AbhDNRsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:48:16 -0400
IronPort-SDR: AnoPP3E8d8vjuCFMEndTITgHT+dwOzSascGcx/YUxg/Du1uMpERIaey9szqUB3RS59/4OjlELe
 nfuHJhFsc0KQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="181819973"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="181819973"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:47:52 -0700
IronPort-SDR: 03bq64kSY2elvsiAhmZgjE30QST8Yse36lzk12d1PYG9635GKYhu/hTLN6NQ1hEWUkcv7cK4Mz
 HGyppFRHgvlg==
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="522073477"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 10:47:50 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lWjcC-0043yy-8l; Wed, 14 Apr 2021 20:47:48 +0300
Date:   Wed, 14 Apr 2021 20:47:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] stm class: Replace uuid_t with plain u8 uuid[16]
Message-ID: <YHcqxMLR44laX2PZ@smile.fi.intel.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
 <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
 <YHcnckePpKDujCU+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHcnckePpKDujCU+@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 07:33:38PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 14, 2021 at 08:12:46PM +0300, Alexander Shishkin wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > It appears that uuid_t use in STM code abuses UUID API.
> 
> How is it being abused?

We are using it against the buffer that is u8, and neither uuid_t nor guid_t.

> Moreover,
> > this type is only useful when we parse user input. Due to above
> > replace uuid_t with u8 uuid[16] and use uuid_t only when parse
> > user input.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > ---
> >  drivers/hwtracing/stm/p_sys-t.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/stm/p_sys-t.c b/drivers/hwtracing/stm/p_sys-t.c
> > index 360b5c03df95..04d13b3785d3 100644
> > --- a/drivers/hwtracing/stm/p_sys-t.c
> > +++ b/drivers/hwtracing/stm/p_sys-t.c
> > @@ -76,7 +76,7 @@ enum sys_t_message_string_subtype {
> >  				 MIPI_SYST_SEVERITY(MAX))
> >  
> >  struct sys_t_policy_node {
> > -	uuid_t		uuid;
> > +	u8		uuid[UUID_SIZE];
> 
> This feels wrong, what is wrong with the uuid_t type usage here?

Nothing, just will require additional export_uuid() / import_uuid() call.

> >  	bool		do_len;
> >  	unsigned long	ts_interval;
> >  	unsigned long	clocksync_interval;
> > @@ -92,7 +92,7 @@ static void sys_t_policy_node_init(void *priv)
> >  {
> >  	struct sys_t_policy_node *pn = priv;
> >  
> > -	generate_random_uuid(pn->uuid.b);
> 
> Ok, that's not good, but that looks to be a flaw in the
> generate_random_uuid() api, not this driver implementation.
> 
> I don't understand why this change is needed?

Using raw buffer APIs against uuid_t / guid_t.

We can import_uuid() first and call uuid_gen() against it. Will it work for
you?

-- 
With Best Regards,
Andy Shevchenko


