Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26373330C72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 12:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhCHLcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 06:32:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:44301 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhCHLcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 06:32:09 -0500
IronPort-SDR: dlAk49sxeUJG+Wa0CPQ1vO6c+VelSKD+L6o894HlyKMk3EBAoS0/iDtg/V70K0N2JDEBIEuyrm
 cvqez6uVw4NA==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="185624426"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="185624426"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 03:32:09 -0800
IronPort-SDR: +mak97OBL3juCr+i7WkueujhfRP8T2t4LH5mFxGvFtT+WhoTPijhL20RdVureOMqMVJ5OXy9+s
 2tahbAajZOSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="508897555"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Mar 2021 03:32:07 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 08 Mar 2021 13:32:06 +0200
Date:   Mon, 8 Mar 2021 13:32:06 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] device property: Sync descriptions of swnode
 array and group APIs
Message-ID: <YEYLNvR3RMVX1wh6@kuha.fi.intel.com>
References: <20210308103644.81960-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308103644.81960-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 12:36:44PM +0200, Andy Shevchenko wrote:
> After a few updates against swnode APIs the kernel documentation, i.e.
> for swnode group registration and unregistration deviates from the one
> for swnode array. In general, the same rules are applied to both.
> Hence, synchronize descriptions of swnode array and group APIs
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/swnode.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 37179a8b1ceb..46c48d602915 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -880,7 +880,11 @@ EXPORT_SYMBOL_GPL(software_node_unregister_nodes);
>   * software_node_register_node_group - Register a group of software nodes
>   * @node_group: NULL terminated array of software node pointers to be registered
>   *
> - * Register multiple software nodes at once.
> + * Register multiple software nodes at once. If any node in the array
> + * has its .parent pointer set (which can only be to another software_node),
> + * then its parent **must** have been registered before it is; either outside
> + * of this function or by ordering the array such that parent comes before
> + * child.
>   */
>  int software_node_register_node_group(const struct software_node **node_group)
>  {
> @@ -906,10 +910,14 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
>   * software_node_unregister_node_group - Unregister a group of software nodes
>   * @node_group: NULL terminated array of software node pointers to be unregistered
>   *
> - * Unregister multiple software nodes at once. The array will be unwound in
> - * reverse order (i.e. last entry first) and thus if any members of the array are
> - * children of another member then the children must appear later in the list such
> - * that they are unregistered first.
> + * Unregister multiple software nodes at once. If parent pointers are set up
> + * in any of the software nodes then the array **must** be ordered such that
> + * parents come before their children.
> + *
> + * NOTE: If you are uncertain whether the array is ordered such that
> + * parents will be unregistered before their children, it is wiser to
> + * remove the nodes individually, in the correct order (child before
> + * parent).
>   */
>  void software_node_unregister_node_group(
>  		const struct software_node **node_group)
> -- 
> 2.30.1

-- 
heikki
