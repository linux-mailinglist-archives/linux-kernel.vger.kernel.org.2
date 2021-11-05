Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA384446078
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhKEIQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:16:55 -0400
Received: from elvis.franken.de ([193.175.24.41]:33295 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231403AbhKEIQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:16:53 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1miuMT-0006S3-00; Fri, 05 Nov 2021 09:14:09 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7FDC5C292A; Fri,  5 Nov 2021 09:13:51 +0100 (CET)
Date:   Fri, 5 Nov 2021 09:13:51 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] bus: brcmstb_gisb: Allow building as module
Message-ID: <20211105081351.GA6380@alpha.franken.de>
References: <20210924191035.1032106-1-f.fainelli@gmail.com>
 <20211105025155.GA2922689@roeck-us.net>
 <9318932a-9b00-62be-eeb9-ca755a05c841@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9318932a-9b00-62be-eeb9-ca755a05c841@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 07:56:12PM -0700, Florian Fainelli wrote:
> 
> 
> On 11/4/2021 7:51 PM, Guenter Roeck wrote:
> > On Fri, Sep 24, 2021 at 12:10:34PM -0700, Florian Fainelli wrote:
> > > Allow building the Broadcom STB GISB arbiter driver as a module, however
> > > similar to interrupt controller drivers, don't allow its unbind/removal
> > > since it is not quite prepared for that and we want it to catch bus
> > > errors all the time.
> > > 
> > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > 
> > Hmm, did you actually test that ?
> 
> Great way to introduce someone to a problem, really.
> 
> > 
> > Building mips:allmodconfig ... failed
> > --------------
> > Error log:
> > <stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
> > ERROR: modpost: "board_be_handler" [drivers/bus/brcmstb_gisb.ko] undefined!
> 
> I did not indeed test a modular build for MIPS and had not anticipated it to
> fail. Thomas, do you have any objections exporting board_be_handler to
> modules or would you rather not do it and force the driver to be boolean for
> MIPS?

I'd prefer to not export it, so making the driver non-modular for MIPS
would be a solution. If there is a need to set the bus error handling
I'd like to see a function setting and that function could be exported.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
