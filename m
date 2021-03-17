Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0BC33F7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhCQSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232912AbhCQSDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:03:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A1B364F20;
        Wed, 17 Mar 2021 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616004185;
        bh=XuRIVNL9+2MBbMZJe/8H2fvfyJAhzhCls7VjVDwKWf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EqM+Hp2RsgellPxUqzYkk4f62fmn1oxuNKe6LC1lGDDVtdScLIOA3jYjWQeAX3qLO
         gMOb4mgH1bEUPAtFd/EG9TpI1ZeY5VLybvR5E8SENCOc9UVwsUZDA4CFTSNt2tZnMe
         JEMz185kRJQZbImOU8DNHkaPgWtu8t+OL+Uf5q4U=
Date:   Wed, 17 Mar 2021 19:03:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpci: Added few missing TCPCI register
 definitions
Message-ID: <YFJEVjRCLsnJ3/hg@kroah.com>
References: <20210316221304.391206-1-badhri@google.com>
 <4f077e6c-4e95-ab54-c549-e953bf3c00f3@roeck-us.net>
 <YFIxkh8XLDiszci7@kroah.com>
 <9d8747e0-c23a-6dd2-8cd8-fbbc0501d673@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d8747e0-c23a-6dd2-8cd8-fbbc0501d673@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 10:58:24AM -0700, Guenter Roeck wrote:
> On 3/17/21 9:42 AM, Greg Kroah-Hartman wrote:
> > On Tue, Mar 16, 2021 at 03:52:58PM -0700, Guenter Roeck wrote:
> >> On 3/16/21 3:13 PM, Badhri Jagan Sridharan wrote:
> >>> This change adds some of the register bit definitions from the TCPCI spec:
> >>> https://www.usb.org/sites/default/files/documents/
> >>> usb-port_controller_specification_rev2.0_v1.0_0.pdf
> >>>
> >>> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> >>
> >> Are those going to be used ?
> > 
> > For values and #defines that are in public specs, does it matter?  It's
> > good to have full definitions in the .h files for whenever possible for
> > stuff like this to make it easy for people to write code to use them :)
> > 
> 
> Good to know your position on this. It is one of the per-maintainer
> thingies: Some maintainers don't accept defines if they are not used.
> Usually I stay away from defining them to avoid the resulting arguments/
> discussions. If you are ok with it, so am I.

#defines are trivial, and are good for documenting things.  We have loads
of drivers that do this to make it a good way to document the full
hardware or specification despite not using all of the defines.  They
also are not a maintenance burden.

I don't take new apis that no one uses in-kernel as that's just ripe for
deletion and is a maintenance burden.  It makes no sense to add and then
remove something right away :)

thanks,

greg k-h
