Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F173D91B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbhG1PT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:19:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:42774 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237139AbhG1PTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:19:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="192278909"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="192278909"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 08:19:20 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="517571065"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 08:19:18 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m8lKy-0026Y2-5R; Wed, 28 Jul 2021 18:19:12 +0300
Date:   Wed, 28 Jul 2021 18:19:12 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Dennis Giaya <dgiaya@whoi.edu>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: max310x: Use clock-names property
 matching to recognize EXTCLK
Message-ID: <YQF1cK3lxJs2ND9U@smile.fi.intel.com>
References: <20210723125943.22039-1-andriy.shevchenko@linux.intel.com>
 <19b100cfa0c1eb8b5d321ff852f18f7ce5768149.camel@whoi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b100cfa0c1eb8b5d321ff852f18f7ce5768149.camel@whoi.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 02:52:17PM +0000, Dennis Giaya wrote:
> > v2: added Tested-by tag (Dennis), inverted comparison to leave
> > original flow
> 
> I've tested v2 with the inverted comparison and it works under the same
> test conditions as v1.

Thanks! It's pending for v5.15-rc1.

-- 
With Best Regards,
Andy Shevchenko


