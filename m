Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DF43D0A61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhGUHcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235501AbhGUH1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:27:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00614611C1;
        Wed, 21 Jul 2021 08:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626854900;
        bh=CB9OUKQMrgSdC8Z5AXE2cn/p4yiYpa0gBjoMEuRqffc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HiVrrtmvAiAuohqI2l7Tn7FJm4vcjxmuZ9X1+qQ7/6e6AzQx7qWZ2T2/KOrrBA0hw
         B8Frfv+LuZV9yKlnGt7Zi4/NKFMygi+tLMglSFIxDxUZsDXKZ3leqrClzgLXJ33gTk
         h7qS4utfoZnMpmlT7gA9VtK1+anrQc3NPbjPAgUU=
Date:   Wed, 21 Jul 2021 10:08:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     stern@rowland.harvard.edu, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        cristian.birsan@microchip.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ohci-at91: suspend/resume ports after/before
 OHCI accesses
Message-ID: <YPfV8gCx1SVTedxd@kroah.com>
References: <20210609121027.70951-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609121027.70951-1-claudiu.beznea@microchip.com>
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
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
> 
> The patch was tested on SAMA7G5, SAMA5D2 and SAM9X60.

This does not apply to 5.14-rc2, can you please rebase and resend?

thanks,

greg k-h
