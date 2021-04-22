Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E57367F85
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 13:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhDVLZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 07:25:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:2642 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235917AbhDVLZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:25:40 -0400
IronPort-SDR: 9nEHau783CfJRiPx+tG3MvCgpXcFdglReKH/abScqe1Na/kzF90SYo0KQ+ID2AAOKL0n4OH7lE
 SRIaIGR0aNeA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="259823087"
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="259823087"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 04:25:05 -0700
IronPort-SDR: 8vVVH6b06ZhqkfgOOyyadzZOojawz2gqpVQjhEjpgD7/IrA6SdRN7tyKZDvnIgMRNrXlpNyJZz
 WbOOxPvhnLRQ==
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="384740068"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 04:25:03 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 22 Apr 2021 14:25:00 +0300
Date:   Thu, 22 Apr 2021 14:25:00 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 103/190] Revert "thunderbolt: property: Fix a missing
 check of kzalloc"
Message-ID: <20210422112500.GS3511397@lahna.fi.intel.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-104-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-104-gregkh@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:38PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 6183d5a51866f3acdeeb66b75e87d44025b01a55.
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

This one is a valid, although minor, fix.

> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/thunderbolt/property.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
> index d5b0cdb8f0b1..841314deb446 100644
> --- a/drivers/thunderbolt/property.c
> +++ b/drivers/thunderbolt/property.c
> @@ -587,12 +587,7 @@ int tb_property_add_text(struct tb_property_dir *parent, const char *key,
>  		return -ENOMEM;
>  
>  	property->length = size / 4;
> -	property->value.text = kzalloc(size, GFP_KERNEL);
> -	if (!property->value.text) {
> -		kfree(property);
> -		return -ENOMEM;
> -	}
> -
> +	property->value.data = kzalloc(size, GFP_KERNEL);
>  	strcpy(property->value.text, text);
>  
>  	list_add_tail(&property->list, &parent->properties);
> -- 
> 2.31.1
