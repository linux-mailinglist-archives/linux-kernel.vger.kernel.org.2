Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BA2443DED
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhKCIBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhKCIBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:01:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC2E46109F;
        Wed,  3 Nov 2021 07:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635926318;
        bh=Rl7lz8GNjFRdlMbmYLnI1tew/T4cpypsk+ho58waK7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nwvjqouuvaL6lGuN+U8vFU1oob7IGU21izB0BD20OetyABN8mcboCo95tFe0RIRks
         2k2BVU3ayx/QGYFpHovubxobb88p6q9cahJYi7VF4cdUyQId5l8MWDj7MwQJC+HBa7
         WjfZza6N9RCKIjoTJh1sgMYuXetSNAM/PFcEmSUk=
Date:   Wed, 3 Nov 2021 08:58:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     ira.weiny@intel.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] Improve Auxiliary Device documentation
Message-ID: <YYJBKrTlaqPfVYiJ@kroah.com>
References: <20211102215317.3676782-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102215317.3676782-1-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 02:53:14PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The auxiliary device documentation was not wrong but it was a bit difficult to
> follow.  Add clarifications to ensure that details are not missed.
> 
> 
> Ira Weiny (3):
>   Documentation/auxiliary_bus: Clarify auxiliary_device creation
>   Documentation/auxiliary_bus: Clarify match_name
>   Documentation/auxiliary_bus: Update Auxiliary device lifespan
> 
>  Documentation/driver-api/auxiliary_bus.rst | 136 ++++++++++++++++-----

Any chance that we can move this documentation into the .c file itself
to make it easier to maintain and keep up to date over time?  I think
the v4l2 and drm subsystems do this pretty well, right?

thanks,

greg k-h
