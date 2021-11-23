Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF245A777
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238814AbhKWQXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:23:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:24423 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235988AbhKWQXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:23:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="215081455"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="215081455"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:20:38 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="538304991"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:20:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mpYX0-009pkf-JQ;
        Tue, 23 Nov 2021 18:20:30 +0200
Date:   Tue, 23 Nov 2021 18:20:30 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 0/2] Update ASUS WMI supported boards
Message-ID: <YZ0UziuWdEnaUGrm@smile.fi.intel.com>
References: <20211116205744.381790-1-pauk.denis@gmail.com>
 <f0bf01fa-ccd8-3a6a-8fd2-4c785fa212ef@roeck-us.net>
 <CAHp75Vfbh+O39C_k9zQqSqsoSro7_gv6QmsxgmdO=woA32Q0HQ@mail.gmail.com>
 <20211123155040.GA2184678@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123155040.GA2184678@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 07:50:40AM -0800, Guenter Roeck wrote:
> On Tue, Nov 23, 2021 at 12:22:46PM +0200, Andy Shevchenko wrote:
> > >
> > > Series applied to hwmon-next.
> > 
> > What is the repository it has been applied to? I don't see it in
> > neither Linux Next nor [1]. It might be that I am missing the
> > workflow.
> 
> I had not pushed the branch out. Done now.

I can see it now, thanks!

-- 
With Best Regards,
Andy Shevchenko


