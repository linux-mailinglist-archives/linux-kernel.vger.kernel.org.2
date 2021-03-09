Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788E7332352
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhCIKsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:48:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:48083 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhCIKr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:47:58 -0500
IronPort-SDR: qGUeqrREt+MF4iSZUZmlKivBAiuXT2Se62ihKRfqb2xPLddlOIwW/y3qo93zSftmZBFcXPkJzg
 Lu5CfS+sEL/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="188249792"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="188249792"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 02:47:57 -0800
IronPort-SDR: upZqClzCq/7a5XYCA8+7dk0b4qvLc2tBLgBJyzMmBxpG1w2RaMUoeTmmQ9a1fkVYPlfylKego2
 Xlxhb29V9BhQ==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="509248637"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 02:47:50 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJZu0-00B2TR-36; Tue, 09 Mar 2021 12:47:48 +0200
Date:   Tue, 9 Mar 2021 12:47:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rodolfo Giometti <giometti@enneenne.com>,
        Ryan Govostes <rgovostes@whoi.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/7] pps: clients: gpio: Bail out on error when
 requesting GPIO echo line
Message-ID: <YEdSVD+hU+Il5W/7@smile.fi.intel.com>
References: <20210216113154.70852-1-andriy.shevchenko@linux.intel.com>
 <YDkp5Jh8ZXWgr+zl@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDkp5Jh8ZXWgr+zl@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Greg

On Fri, Feb 26, 2021 at 07:03:32PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 16, 2021 at 01:31:48PM +0200, Andy Shevchenko wrote:
> > When requesting optional GPIO echo line, bail out on error,
> > so user will know that something wrong with the existing property.
> 
> Guys, any comments on this series?

Greg, seems PPS maintainer keeps silent, can I route this series thru one of
yours tree (resend implied)?

-- 
With Best Regards,
Andy Shevchenko


