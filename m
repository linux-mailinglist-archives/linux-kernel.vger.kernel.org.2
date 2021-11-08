Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BA9447B9B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 09:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbhKHINV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 03:13:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237570AbhKHINR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 03:13:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87D066120D;
        Mon,  8 Nov 2021 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636359034;
        bh=HTLfmFrruDz3mzi0xnkJivgiJ3ijSqm9sjS78iHFZ/k=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=agf7z0N0uUh1AfJAUGU4TpV04XlTpnSw5pBjvNnU0DEiN6QbGwwFd0iduwvptYnaJ
         Ej83dh2CbB+NoZ6FwkmXfp6SyLUirtg1XIkyOSiiTXhbQrYDdQSMNdeDIu5ZhMOYBl
         110KBU52c4NDbfoOEUFTdFffeF+rQ1S3TcSlcAMo=
Date:   Mon, 8 Nov 2021 09:10:31 +0100
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
Message-ID: <YYjbdw+QrUfvpcjx@kroah.com>
References: <20211107185435.2540185-1-megous@megous.com>
 <20211107185724.ik6wthsl3e6qlbj3@core>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211107185724.ik6wthsl3e6qlbj3@core>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2021 at 07:57:24PM +0100, Ondřej Jirman wrote:
> Hi,
> 
> On Sun, Nov 07, 2021 at 07:54:33PM +0100, megous hlavni wrote:
> > The masks are swapped (interrupts are enabled when the mask is 0).
> 
> Please ignore the 06/15 in the subject. This is just a single patch
> from my local series and I forgot to edit the subject.

But I see 2 patches sent in this series?

Can you just fix this up and resend them correctly?

thanks,

greg k-h
