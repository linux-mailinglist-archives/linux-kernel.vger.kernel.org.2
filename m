Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7B31E9ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhBRMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhBRK4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:56:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A34864E4B;
        Thu, 18 Feb 2021 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613644969;
        bh=ZVEU0Q4v1c0QFBCQIPsDVziRocJEP0A7qMixZrKXSRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmUp03bp01fFVhuOtS4zYNrRo05P/MHjCURv84sjfVQ+9zWYsOMpbvWOYpHeuVbAi
         oQynA6AuV3SFXcUY5F4Q6SqAzxh1AhwfjM+QB4ZBCn9DfCPe/yY/rsk5GUwCkMcoE9
         dRe+VOjSsRjh4L68f0pVpld/UnKtBpLxuy/wqx0g=
Date:   Thu, 18 Feb 2021 11:42:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kyle Tso <kyletso@google.com>, USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] usb: typec: tcpm: Wait for vbus discharge to VSAFE0V
 before toggling
Message-ID: <YC5EpqqNM+gnD6Zg@kroah.com>
References: <20210218100243.32187-1-badhri@google.com>
 <YC489HGT/yVHykAs@kroah.com>
 <CAPTae5+qhE9uo2s20oEQd0x+nW21zGE3S7QWkR=oqqVX-3uHmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5+qhE9uo2s20oEQd0x+nW21zGE3S7QWkR=oqqVX-3uHmg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 02:38:45AM -0800, Badhri Jagan Sridharan wrote:
> Hi Greg,
> 
> This patch is a bug fix for the following patch which was introduced in 5.11.
> 
> commit f321a02caebdd0c56e167610cda2fa148cd96e8b
> Author: Badhri Jagan Sridharan <badhri@google.com>
> Date:   Wed Oct 28 23:31:35 2020 -0700
> 
>     usb: typec: tcpm: Implement enabling Auto Discharge disconnect support
> 
>     TCPCI spec allows TCPC hardware to autonomously discharge the vbus
>     capacitance upon disconnect. The expectation is that the TCPM enables
>     AutoDischargeDisconnect while entering SNK/SRC_ATTACHED states. Hardware
>     then automously discharges vbus when the vbus falls below a certain
>     threshold i.e. VBUS_SINK_DISCONNECT_THRESHOLD.
> 
>     Apart from enabling the vbus discharge circuit, AutoDischargeDisconnect
>     is also used a flag to move TCPCI based TCPC implementations into
>     Attached.Snk/Attached.Src state as mentioned in
>     Figure 4-15. TCPC State Diagram before a Connection of the
>     USB Type-C Port Controller Interface Specification.
>     In such TCPC implementations, setting AutoDischargeDisconnect would
>     prevent TCPC into entering "Connection_Invalid" state as well.
> 
>     Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>     Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>     Link: https://lore.kernel.org/r/20201029063138.1429760-8-badhri@google.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Great, then can you resend the patch and add a proper Fixes: tag, along
with a cc: stable as well?

thanks,

greg k-h
