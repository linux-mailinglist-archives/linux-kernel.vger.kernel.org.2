Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23653447CBE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhKHJ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:28:10 -0500
Received: from vps.xff.cz ([195.181.215.36]:41356 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236707AbhKHJ2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1636363523; bh=nVyQ9dFQrqiwLD+fct/FoZkJzctY87nIhEtqMUvnSL4=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=EF2rrHZ2E/tty/UG0bZUh0K5+hNP5Kv4oX+xiWN+9KwswUmAYeL8Z1ZIM+JhPCG06
         fekqe3QN5j5ifF2m09H+rOvzhviuT6Gy80TbSULE5VS9FAcRP76OsgbixiMe6XYRI4
         ygy7/RknG8AQGCnAFfAnxYJkp3qxhvu4H985XfjA=
Date:   Mon, 8 Nov 2021 10:25:23 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/15] usb: typec: fusb302: Fix masking of comparator and
 bc_lvl interrupts
Message-ID: <20211108092523.jfp7a2q2onxqlizt@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "open list:USB TYPEC PORT CONTROLLER DRIVERS" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20211107185435.2540185-1-megous@megous.com>
 <20211107185724.ik6wthsl3e6qlbj3@core>
 <YYjbdw+QrUfvpcjx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYjbdw+QrUfvpcjx@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 09:10:31AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Nov 07, 2021 at 07:57:24PM +0100, Ondřej Jirman wrote:
> > Hi,
> > 
> > On Sun, Nov 07, 2021 at 07:54:33PM +0100, megous hlavni wrote:
> > > The masks are swapped (interrupts are enabled when the mask is 0).
> > 
> > Please ignore the 06/15 in the subject. This is just a single patch
> > from my local series and I forgot to edit the subject.
> 
> But I see 2 patches sent in this series?

The other one is unrelated. This patch is a fix for a real bug.

The other seemed like an independent correctness issue that I noticed from code
review I had to do to figure out the reason for failure to handle disconnect
detection properly. It's unrelated to this patch other than touching the same driver.

regards,
	o.

> Can you just fix this up and resend them correctly?
> 
> thanks,
> 
> greg k-h
