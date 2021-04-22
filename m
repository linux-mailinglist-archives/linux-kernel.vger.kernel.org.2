Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA312367F91
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbhDVLay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:30:54 -0400
Received: from mga18.intel.com ([134.134.136.126]:9335 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhDVLay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:30:54 -0400
IronPort-SDR: Hy5ZOjw7gcmZJWmyQwLvXUeZhdYTY+F8GCrRcXdf+e4zGl+ijtYNEeyZlE0y6CBueD8CB5zpFs
 3fneHl+a7YHQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="183354268"
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="183354268"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 04:30:17 -0700
IronPort-SDR: YJGwiAxivQKFTylL65EEflzNINeQUXp7qYh18VEGH+WkkGlH7NmEMboTf7anjXZ3niTjyfIazb
 dAZc/9cExRqQ==
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="455758180"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 04:30:15 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 22 Apr 2021 14:30:12 +0300
Date:   Thu, 22 Apr 2021 14:30:12 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: Re: [PATCH 115/190] Revert "thunderbolt: Fix a missing check of
 kmemdup"
Message-ID: <20210422113012.GT3511397@lahna.fi.intel.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-116-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-116-gregkh@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:50PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit e4dfdd5804cce1255f99c5dd033526a18135a616.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.

This one too is valid.

> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/thunderbolt/property.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
> index 841314deb446..ee76449524a3 100644
> --- a/drivers/thunderbolt/property.c
> +++ b/drivers/thunderbolt/property.c
> @@ -176,10 +176,6 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
>  	} else {
>  		dir->uuid = kmemdup(&block[dir_offset], sizeof(*dir->uuid),
>  				    GFP_KERNEL);
> -		if (!dir->uuid) {
> -			tb_property_free_dir(dir);
> -			return NULL;
> -		}
>  		content_offset = dir_offset + 4;
>  		content_len = dir_len - 4; /* Length includes UUID */
>  	}
> -- 
> 2.31.1
