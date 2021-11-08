Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A3B447D50
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbhKHKNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:13:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:46944 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235856AbhKHKM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:12:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10161"; a="232043743"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="232043743"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 02:10:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="641365835"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 08 Nov 2021 02:10:08 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 08 Nov 2021 12:10:07 +0200
Date:   Mon, 8 Nov 2021 12:10:07 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/15] usb: typec: fusb302: Fix masking of comparator and
 bc_lvl interrupts
Message-ID: <YYj3f9nAFjZzbgJp@kuha.fi.intel.com>
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

Hi,

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

If this fixes a bug, then please include the appropriate Fixes tag and
CC stable@vger.kernel.org. I'm guessing this is what the Fixes tag
should look like:

        Fixes: 48242e30532b ("usb: typec: fusb302: Revert "Resolve fixed power role contract setup"")

You probable also want to CC Hans de Goede <hdegoede@redhat.com> since
you are patching his code.

> The other seemed like an independent correctness issue that I noticed from code
> review I had to do to figure out the reason for failure to handle disconnect
> detection properly. It's unrelated to this patch other than touching the same driver.

It still says "PATCH 07/15..." which means it's a part of a series,
no? So..

> > Can you just fix this up and resend them correctly?

thanks,

-- 
heikki
