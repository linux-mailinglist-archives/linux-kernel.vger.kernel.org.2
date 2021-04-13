Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0175C35DEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhDMM0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:26:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:23725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231337AbhDMM0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:26:21 -0400
IronPort-SDR: NW0aKAIPtnQT+YswojvzPKP4A4OAyLsSRVTZMuVTAXSS+W+QknNJH7UKSE5CYBkgDUSKDlxhIv
 L2dk9aKBb+9g==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194429530"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="194429530"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 05:25:55 -0700
IronPort-SDR: /crXERL2PMluoSFGvQgxCtyWHDLQ5JIDJrH/Io9Js4y7MowQDTKNSjt8vkqt6Wpxj6Gp1NRJdx
 mqvPuJCPnGdg==
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="450379030"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 05:25:49 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lWI6z-003kx1-N9; Tue, 13 Apr 2021 15:25:45 +0300
Date:   Tue, 13 Apr 2021 15:25:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/1] devres: Enable trace events
Message-ID: <YHWNyXdpHBsllTSx@smile.fi.intel.com>
References: <20210413113801.18245-1-andriy.shevchenko@linux.intel.com>
 <YHWH9KWrh2kkoAvU@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHWH9KWrh2kkoAvU@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 03:00:52PM +0300, Heikki Krogerus wrote:
> On Tue, Apr 13, 2021 at 02:38:01PM +0300, Andy Shevchenko wrote:
> > In some cases the printf() mechanism is too heavy and can't be used.
> > For example, when debugging a race condition involving devres API.
> > When CONFIG_DEBUG_DEVRES is enabled I can't reproduce an issue, and
> > otherwise it's quite visible with a useful information being collected.
> > 
> > Enable trace events for devres part of the driver core.

...

> >  struct devres_node {
> >  	struct list_head		entry;
> >  	dr_release_t			release;
> > -#ifdef CONFIG_DEBUG_DEVRES
> >  	const char			*name;
> >  	size_t				size;
> > -#endif
> 
> Those ifdefs are still required.

Oh, yes, otherwise we end up with not filled name and size (as per header
file). I'll rework in order to fill name and size always and get rid of
ifdeffery in the header file.

Thanks!

> >  };

-- 
With Best Regards,
Andy Shevchenko


