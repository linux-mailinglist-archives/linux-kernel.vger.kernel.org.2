Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B420E3D456D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 08:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhGXGIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 02:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhGXGIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 02:08:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23D8F60EAF;
        Sat, 24 Jul 2021 06:48:51 +0000 (UTC)
Date:   Sat, 24 Jul 2021 08:48:48 +0200
From:   Greg KH <greg@kroah.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.or, rajatxjain@gmail.com
Subject: Re: [PATCH v2] thunderbolt: For dev authorization changes, include
 the actual event in udev change notification
Message-ID: <YPu30AL27UwnfOrI@kroah.com>
References: <20210724004043.2075819-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724004043.2075819-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 05:40:43PM -0700, Rajat Jain wrote:
> For security, we would like to monitor and track when the thunderbolt
> devices are authorized and deauthorized (i.e. when the thunderbolt sysfs
> "authorized" attribute changes). Currently the userspace gets a udev
> change notification when there is a change, but the state may have
> changed (again) by the time we look at the authorized attribute in
> sysfs. So an authorization event may go unnoticed. Thus make it easier
> by informing the actual change (new value of authorized attribute) in
> the udev change notification.
> 
> The change is included as a key value "authorized=<val>" where <val>
> is the new value of sysfs attribute "authorized", and is described at
> Documentation/ABI/testing/sysfs-bus-thunderbolt under
> /sys/bus/thunderbolt/devices/.../authorized
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/thunderbolt/switch.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
