Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE93EBF67
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhHNBps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:45:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34635 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S236320AbhHNBpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:45:47 -0400
Received: (qmail 56475 invoked by uid 1000); 13 Aug 2021 21:45:18 -0400
Date:   Fri, 13 Aug 2021 21:45:18 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Maxim Devaev <mdevaev@gmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        ruslan.bilovol@gmail.com, mika.westerberg@linux.intel.com,
        maze@google.com, jj251510319013@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_hid: optional SETUP/SET_REPORT mode
Message-ID: <20210814014518.GA56183@rowland.harvard.edu>
References: <20210813114551.72898-1-mdevaev@gmail.com>
 <20210813145823.GA38198@rowland.harvard.edu>
 <20210813232212.5cba6d33@reki>
 <20210813234022.5d5644ae@reki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210813234022.5d5644ae@reki>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 11:40:22PM +0300, Maxim Devaev wrote:
> В Fri, 13 Aug 2021 23:22:12 +0300
> Maxim Devaev <mdevaev@gmail.com> пишет:
> 
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> > > In other words, a device does not need to have an interrupt-OUT 
> > > endpoint, but if it does have one then the host must use it.
> > 
> > You're right. Although the actual behavior of the hosts is not different
> > from what I wrote - they really just ignore out endpoint.
> > I will eventually fix this in the patch description.
> 
> It seems that I have confused everything even more, sorry. I will explain.
> There are three possible host behaviors:
> 
> (1) The host works with the OUT endpoint as it describes the standard
>     and transmits reports through it.
> 
> (2) The host works with IN endpoint, but refuses to transmit reports
>     via OUT endpoint at all. In the case of the keyboard, it will work,
>     but it will not receive the status of the LEDs.
> 
> (3) The host sees OUT endpoint and either refuses to use such a device at all,
>     or goes crazy in various ways.
> 
> In both cases (2) and (3), using SETUP/SET_REPORT solves the problem.
> Therefore, I offer this as an option to solve compatibility problems.
> Yes, in fact, this is not our problem, but it is impossible to fix the drivers
> of all these proprietary devices. Moreover, I have never met a keyboard
> with OUT endpoint, absolutely all of them use SETUP/SET_REPORT.

Okay.  I appreciate the more detailed explanations; thanks.  Please 
resubmit the patch with appropriate changes to the description.

Alan Stern
