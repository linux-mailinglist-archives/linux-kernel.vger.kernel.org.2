Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC031E920
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhBRLZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232591AbhBRKKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:10:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B33B864EAD;
        Thu, 18 Feb 2021 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613642999;
        bh=zaWHyoh91bO/x1e3pm+5Nn3sQ06OCkntg0lilcJqvvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/FrMqw7434MBE86fAMPULCgRFDVFfB8HEZiAKOYnTJFaYxVc7/k6gVvjBhh2FLvF
         KwENkVPEvB+F1DHJneutPYhKdLtBIYvBz5H0TIwvq6kkK3EjVZiwrNc2JdC4KiwfTR
         KBQezUooyiaV+4WfVkXCm5EGokGUWUMODN11/hME=
Date:   Thu, 18 Feb 2021 11:09:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Wait for vbus discharge to VSAFE0V
 before toggling
Message-ID: <YC489HGT/yVHykAs@kroah.com>
References: <20210218100243.32187-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218100243.32187-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 02:02:43AM -0800, Badhri Jagan Sridharan wrote:
> When vbus auto discharge is enabled, TCPM can sometimes be faster than
> the TCPC i.e. TCPM can go ahead and move the port to unattached state
> (involves disabling vbus auto discharge) before TCPC could effectively
> discharge vbus to VSAFE0V. This leaves vbus with residual charge and
> increases the decay time which prevents tsafe0v from being met.
> This change introduces a new state VBUS_DISCHARGE where the TCPM waits
> for a maximum of tSafe0V(max) for vbus to discharge to VSAFE0V before
> transitioning to unattached state and re-enable toggling. If vbus
> discharges to vsafe0v sooner, then, transition to unattached state
> happens right away.
> 
> Also, while in SNK_READY, when auto discharge is enabled, drive
> disconnect based on vbus turning off instead of Rp disappearing on
> CC pins. Rp disappearing on CC pins is almost instanteous compared
> to vbus decay.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 60 +++++++++++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 7 deletions(-)

As this seems to be a bugfix, what commit does it fix?  Should it go to
stable kernels?  If so, how far back?

And as this is the merge window, I can't do anything with this until
5.12-rc1 is out, so be prepared for the delay...

thanks,

greg k-h
