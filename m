Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B5036D1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 07:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbhD1FcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 01:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1FcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 01:32:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D58F6141B;
        Wed, 28 Apr 2021 05:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619587874;
        bh=Bbz7tDZCRyzsvge9J9D6KIus82wVTdMttDSFF/WezMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AG2+QR5tvSjFfjsC1pu/a0Uw56ZI3/LkoirLLFXgcr/Nh7G7oxLd1X8XrYOihS0pF
         2qSh2shWw4Mwyaidtl6I8g0vQ69nOimgr/HQdrX3BHVZzpmA9hH/gYrA6c77LFGqnG
         6V7n2ACcu9JOGsTbICCNg7m21oIJiH1XPMhwTZp0=
Date:   Wed, 28 Apr 2021 07:31:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: [PATCH 076/190] Revert "net: ixgbevf: fix a missing check of
 ixgbevf_write_msg_read_ack"
Message-ID: <YIjzIPuyA0Oz73dJ@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-77-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-77-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:59:11PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 20d437ee8f4899573e6ea76c06ef0206e98bccb6.
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
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Andrew Bowers <andrewx.bowers@intel.com>
> Cc: Mukesh Ojha <mojha@codeaurora.org>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
> index bfe6dfcec4ab..501823f2d1c0 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
> @@ -508,8 +508,9 @@ static s32 ixgbevf_update_mc_addr_list_vf(struct ixgbe_hw *hw,
>  		vector_list[i++] = ixgbevf_mta_vector(hw, ha->addr);
>  	}
>  
> -	return ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf,
> -			IXGBE_VFMAILBOX_SIZE);
> +	ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, IXGBE_VFMAILBOX_SIZE);
> +
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.31.1
> 

This commit is fine, I'll drop the revert.

greg k-h
