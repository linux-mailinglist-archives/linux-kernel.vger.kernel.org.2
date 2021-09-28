Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36C41ABF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbhI1JeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:34:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:29357 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239724AbhI1JeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:34:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="288319708"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="288319708"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 02:32:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="476227861"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 02:32:35 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 28 Sep 2021 12:32:32 +0300
Date:   Tue, 28 Sep 2021 12:32:32 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Isaac Hazan <isaac.hazan@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: fix -Wrestrict warning
Message-ID: <YVLhMNdk0TkURA89@lahna>
References: <20210927131620.1587294-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927131620.1587294-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 03:16:11PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-11 warns when building with W=1:
> 
> drivers/thunderbolt/xdomain.c: In function 'modalias_show':
> drivers/thunderbolt/xdomain.c:733:16: error: 'sprintf' argument 3 overlaps destination object 'buf' [-Werror=restrict]
>   733 |         return sprintf(buf, "%s\n", buf);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/thunderbolt/xdomain.c:727:36: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
>   727 |                              char *buf)
>       |                              ~~~~~~^~~
> 
> There is no need for the sprintf() here when a strcat() does
> the same thing.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!
