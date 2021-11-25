Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867D345E2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 23:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343521AbhKYWGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 17:06:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:48863 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343530AbhKYWEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 17:04:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="222442931"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="222442931"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 14:01:30 -0800
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="509867616"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 14:01:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mqMo2-00AblY-LD;
        Fri, 26 Nov 2021 00:01:26 +0200
Date:   Fri, 26 Nov 2021 00:01:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH v1 0/3] misc: at25: Fix issues brought with FRAM support
Message-ID: <YaAHtmcTYvEHeaEs@smile.fi.intel.com>
References: <20211125212729.86585-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a3Z5o-hJu1LfeZrD2dps+WTTa6U8vCDoQK2aMAO1WEaBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Z5o-hJu1LfeZrD2dps+WTTa6U8vCDoQK2aMAO1WEaBw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:47:43PM +0100, Arnd Bergmann wrote:
> On Thu, Nov 25, 2021 at 10:27 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > A few fixes to the AT25 driver that have been brought by FRAM support series.
> >
> > Andy Shevchenko (3):
> >   misc: at25: Make driver OF independent again
> >   misc: at25: Don't copy garbage to the at25->chip in FRAM case
> >   misc: at25: Check proper value of chip length in FRAM case
> 
> Looks all good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thank you!
There is also cleanup series if you are interested of looking into...

-- 
With Best Regards,
Andy Shevchenko


