Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029C1332361
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 11:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCIKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 05:51:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:39112 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhCIKvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 05:51:11 -0500
IronPort-SDR: 3A5rwzF/L3XB/vy8S8pAbkF5lZ8ym/UkvJUnSesKA8PS1KH21vNrUHZBcuCnGRMfIPI66Sxv4F
 ZEAHpco9Uh8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="207982146"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="207982146"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 02:51:10 -0800
IronPort-SDR: J3H42NSM3SOMFkDg3V79kYgs0as9pXVpJ930PY/dLyco5pq0tOYfOuP6cxy1Rd2T+u28FWa41W
 PwB0zSJbIqQg==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="386186550"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 02:51:09 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lJZxC-00B2VY-O7; Tue, 09 Mar 2021 12:51:06 +0200
Date:   Tue, 9 Mar 2021 12:51:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] software node: Two fixes
Message-ID: <YEdTGsr6CjUirOsn@smile.fi.intel.com>
References: <20210301143012.55118-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301143012.55118-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 05:30:10PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> The second one only affects 5.12-rc1.

Rafael, Greg, can this be applied for v5.12-rcX?

-- 
With Best Regards,
Andy Shevchenko


