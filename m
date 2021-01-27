Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0587305B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbhA0MfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:35:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:47962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236186AbhA0M3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:29:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6D852072C;
        Wed, 27 Jan 2021 12:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611750547;
        bh=hxuzGbmnwkNBdgbojepoPNLiqgLDJ/AeSXRpsta57Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bX6Ug26TAC318pky1F0mN8U1HV6omoKn3NLVZUi2XriVfborCCXUNji7rD7w6qhYs
         TbHa42z+Btz02hTQHUALlkzgwe/ZZyW8/LJ1ROSaeikubpnb6Hnm52Tf7qkbcpY00W
         RJa1nsIOwYPlnOMK79VDQ3/jash7hXfRMzicyA1k=
Date:   Wed, 27 Jan 2021 13:29:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Ximing Chen <mike.ximing.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com,
        Gage Eads <gage.eads@intel.com>
Subject: Re: [PATCH v9 04/20] dlb: add device ioctl layer and first three
 ioctls
Message-ID: <YBFckMGGRKZBYXRd@kroah.com>
References: <20210122190138.7414-1-mike.ximing.chen@intel.com>
 <20210122190138.7414-5-mike.ximing.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122190138.7414-5-mike.ximing.chen@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 01:01:22PM -0600, Mike Ximing Chen wrote:
> --- /dev/null
> +++ b/include/uapi/linux/dlb.h
> @@ -0,0 +1,167 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

As the bot points out, this is an "odd" license for a uapi .h file, are
you SURE about this?

If so, I need an Intel lawyer's signed-off-by on it as well, so we know
to talk to in the future about it.

thanks,

greg k-h
