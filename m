Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E437F30A9D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBAOdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhBAOdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:33:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E80B260C41;
        Mon,  1 Feb 2021 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612189970;
        bh=x4+3l0UdNcDzr1PlE1GkVrmAHixB98fndyTsyj43jWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oEv8LsIzcY7H7ZW51MhbO9OxtTa8b/62cg4S+ZeB4JiMAUQOBEc1xEqFcyTxfgtYy
         ihnuI4YzMClv4IsNoc7nmdLYxxnxmff6AXYgRPU2HXZ8lED6MPrU6LT4W/Yzq1nbsX
         OPTCyMIjbaPGd7Cq3X9KtWLBWVN5cWjas/WVDe04=
Date:   Mon, 1 Feb 2021 15:32:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        pmalani@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        bleung@google.com
Subject: Re: [PATCH 0/6] usb: typec: and platform/chrome: Add PD revision
 numbers
Message-ID: <YBgRDwszRs3ULl5J@kroah.com>
References: <20210129061406.2680146-1-bleung@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129061406.2680146-1-bleung@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:14:00PM -0800, Benson Leung wrote:
> USB Power Delivery has a 3 entity handshake (port, cable, partner), and as
> of USB PD R3.0, each entity may independently support either Revision 2 or
> Revision 3 signaling and protocol. In order for userspace and the kernel
> to properly process the data objects received from a particular SOP*, we
> must know to which revision of the spec each conforms.
> 
> This series adds individual version numbers for the partner and the cable,
> and exposes them in the appropriate sysfs in /sys/class/typec.
> 
> I provide as a first implementation of this, platform/chrome's cros_ec_typec
> driver, whose underlying status messages convey the SOP and SOP' revisions
> already.

I've taken the first 3 patches in my tree now, but the last 3 (for the
chrome_ec_typec.c driver), they do not apply at all.

thanks,

greg k-h
