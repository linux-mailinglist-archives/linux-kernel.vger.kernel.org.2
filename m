Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4933382D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbhEQNeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:34:10 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49091 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S235266AbhEQNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:34:05 -0400
Received: (qmail 1084954 invoked by uid 1000); 17 May 2021 09:32:47 -0400
Date:   Mon, 17 May 2021 09:32:47 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Qiang Ma <maqianga@uniontech.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mouse
Message-ID: <20210517133247.GB1083813@rowland.harvard.edu>
References: <20210517060145.32359-1-maqianga@uniontech.com>
 <1327a9251c74587670970baa0f662cd61006f576.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1327a9251c74587670970baa0f662cd61006f576.camel@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 10:31:45AM +0200, Oliver Neukum wrote:
> Am Montag, den 17.05.2021, 14:01 +0800 schrieb Qiang Ma:
> > This patch enables remote wakeup by default for USB mouse
> > devices.  Mouse in general are supposed to be wakeup devices, but

I disagree with that statement.  Who decided that mice are supposed to 
be wakeup devices?

> > the correct place to enable it depends on the device's bus; no single
> > approach will work for all mouse devices.  In particular, this
> > covers only USB mouse (and then only those supporting the boot
> > protocol).
> > 
> 
> Hi,
> 
> have you tested this? In my experience the issue with mice
> is that they wake up only when you press a mouse button, not when you
> move the mouse. Do we make a promise we cannot keep here?

Even worse, if a mouse is enabled for wakeup then the system may get 
woken up at the wrong time.  The example people often use is a laptop 
with a USB mouse thrown into a backpack while it is asleep.  Something 
else inside the backpack may accidentally press against a mouse button, 
causing the system to wake up even though the user wants it to remain 
asleep.

Alan Stern
