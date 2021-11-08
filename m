Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B59447E9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 12:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhKHLO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 06:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236176AbhKHLOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 06:14:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D888F603E9;
        Mon,  8 Nov 2021 11:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636369930;
        bh=bTAmO8fcH2oI7/afPGINULK3ln3ZC3LHIelJWfKO57E=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=CvIaDbKiy0o/iCprhp6dYxuvrOskHmrO0Qjd/WlyRY3GriSRUcssdfHGhxg2rS4e1
         Ngu81DlF3cySMWFicy/6TwvnHYRNa0IvIjvhXPonpcpsrWBIBLtdscHHVv+eMC27At
         NwrH2bS7zyMiPNFyhNEYrni4FbqkpvX5tkiLTFJs=
Date:   Mon, 8 Nov 2021 12:12:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/15] usb: typec: fusb302: Fix masking of comparator and
 bc_lvl interrupts
Message-ID: <YYkGARf1Y4S0lnxY@kroah.com>
References: <20211107185435.2540185-1-megous@megous.com>
 <20211107185724.ik6wthsl3e6qlbj3@core>
 <YYjbdw+QrUfvpcjx@kroah.com>
 <20211108092523.jfp7a2q2onxqlizt@core>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211108092523.jfp7a2q2onxqlizt@core>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 10:25:23AM +0100, Ondřej Jirman wrote:
> On Mon, Nov 08, 2021 at 09:10:31AM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Nov 07, 2021 at 07:57:24PM +0100, Ondřej Jirman wrote:
> > > Hi,
> > > 
> > > On Sun, Nov 07, 2021 at 07:54:33PM +0100, megous hlavni wrote:
> > > > The masks are swapped (interrupts are enabled when the mask is 0).
> > > 
> > > Please ignore the 06/15 in the subject. This is just a single patch
> > > from my local series and I forgot to edit the subject.
> > 
> > But I see 2 patches sent in this series?
> 
> The other one is unrelated. This patch is a fix for a real bug.
> 
> The other seemed like an independent correctness issue that I noticed from code
> review I had to do to figure out the reason for failure to handle disconnect
> detection properly. It's unrelated to this patch other than touching the same driver.

Please resend anything you wish to have reviewed and applied properly,
with the correct subject lines, so we can do so and do not get confused.

Remember, we deal with thousands of patches a week...

thanks,

greg k-h
