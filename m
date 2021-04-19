Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEA33645DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238998AbhDSOT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 10:19:58 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52119 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S232452AbhDSOTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 10:19:55 -0400
Received: (qmail 134732 invoked by uid 1000); 19 Apr 2021 10:19:21 -0400
Date:   Mon, 19 Apr 2021 10:19:21 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Chris Chiu <chris.chiu@canonical.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, m.v.b@runbox.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] USB: Don't set USB_PORT_FEAT_SUSPEND on WD19's
 Realtek Hub
Message-ID: <20210419141921.GA133494@rowland.harvard.edu>
References: <20210415114856.4555-1-chris.chiu@canonical.com>
 <YHgyP8tGNM1Wi5dJ@kroah.com>
 <CABTNMG0MuaSkWZhiTwtWjPTg5WZ-Vdt9Ju9-RzBke9JjCBJo8Q@mail.gmail.com>
 <20210415184637.GA15445@rowland.harvard.edu>
 <CABTNMG3aweq43eQcONif2_M4JF3ARmBgOKE18v7vzHvaJnjrtA@mail.gmail.com>
 <20210416153932.GD42403@rowland.harvard.edu>
 <CABTNMG25qPvVu7+EsvEgaUsU_v6jKkSKCaU5VR8CiX3oLQ4VFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABTNMG25qPvVu7+EsvEgaUsU_v6jKkSKCaU5VR8CiX3oLQ4VFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 01:11:38AM -0400, Chris Chiu wrote:
> Sorry that I didn't make myself clear. I found that if I applied RESET_RESUME
> quirk on the problematic hub, the Set-Port-Feature(suspend) timeout error
> disappeared. SInce the timeout is not happening for each suspend by default,
> I suspect maybe reset-resume take everything back to clean state for the hub
> and the Set-Port-Feature(suspend) can be taken care of w/o problems.

Okay, that's a good solution for system	suspend.

> I didn't like RESET_RESUME because runtime PM would not work on the quirked
> device.

A more interesting question is whether it will work for	devices	plugged	
into the hub.  Even though the hub won't be runtime suspended, the 
things attached	to it might be.

>  But if the Set-Port-Feature(suspend) can't be handled and
> skipped, I can't
> expect the runtime PM to work for all devices connected to the hub either.
> Is that right? If what I proposed in the patch can not get better
> result than existing
> quirk, I think using the RESET_RESUME would be a better option. Any suggestions?

Try the RESET_RESUME quirk and see how well it works with runtime 
suspend.

Alan Stern
