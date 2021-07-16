Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C123CB73A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhGPMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:15:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:21005 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238234AbhGPMPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:15:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="197908713"
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="197908713"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 05:12:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="631056040"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 05:12:18 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1m4MhP-00EDdj-Lk; Fri, 16 Jul 2021 15:12:11 +0300
Date:   Fri, 16 Jul 2021 15:12:11 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: drivers/media/v4l2-core/v4l2-ioctl.c:303:28: warning: taking
 address of packed member 'pixelformat' of class or structure
 'v4l2_pix_format_mplane' may result in an unaligned pointer value
Message-ID: <YPF3m01nYlt3On7V@smile.fi.intel.com>
References: <202107150148.RpWnKapX-lkp@intel.com>
 <CAHp75Vfu1rhUV+SOq2ikFWd2G6x9j3BT6OLPhPcf8VZE5Umeqw@mail.gmail.com>
 <20210716114105.GF3@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716114105.GF3@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 02:41:05PM +0300, Sakari Ailus wrote:
> On Wed, Jul 14, 2021 at 10:45:26PM +0300, Andy Shevchenko wrote:
> > > >> drivers/media/v4l2-core/v4l2-ioctl.c:347:37: warning: taking address of packed member 'pixelformat' of class or structure 'v4l2_sdr_format' may result in an unaligned pointer value [-Waddress-of-packed-member]
> > 
> > Why is it packed in the first place? Is it used on unaligned addresses
> > in other structures? But even so, why should it matter?
> 
> It's packed since we wanted to avoid having holes in the structs. There are
> other ways to do that but it's ABI dependent and is prone to human errors,
> too.

What holes can you think about in the above mention structure?

In case if you are going to extend it you will need anyway changes somewhere
else as well.

-- 
With Best Regards,
Andy Shevchenko


