Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DBF3A2080
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhFIXJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:09:32 -0400
Received: from netrider.rowland.org ([192.131.102.5]:49757 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229507AbhFIXJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:09:31 -0400
Received: (qmail 1862035 invoked by uid 1000); 9 Jun 2021 19:07:35 -0400
Date:   Wed, 9 Jun 2021 19:07:35 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        cristian.birsan@microchip.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Message-ID: <20210609230735.GA1861855@rowland.harvard.edu>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609121027.70951-1-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 03:10:27PM +0300, Claudiu Beznea wrote:
> On SAMA7G5 suspending ports will cut the access to OHCI registers and
> any subsequent access to them will lead to CPU being blocked trying to
> access that memory. Same thing happens on resume: if OHCI memory is
> accessed before resuming ports the CPU will block on that access. The
> OCHI memory is accessed on suspend/resume though
> ohci_suspend()/ohci_resume().

That sounds very strange.  Suppose one of the ports is suspended, so access to the 
OHCI registers is blocked.  Then how can you resume the port?  Don't you have to 
access the OHCI registers in order to tell the controller to do the port resume?

What happens when there's more than one port, and one of them is suspended while 
the other one is still running?  How can you communicate with the active port if 
access to the OHCI registers is blocked?

Alan Stern
