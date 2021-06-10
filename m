Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E003A25E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJHzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229778AbhFJHzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:55:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1D1E6109E;
        Thu, 10 Jun 2021 07:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623311632;
        bh=QT7o7XS/J8ORfpY0OE0aSxb6FIwCHoQPz0qB6zl8pDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hP2571xsRDFkk+6vWJSZKMc9JhPpT1X46oOnEFeG+wVWbNx2b42LRqBpb1waWXERY
         TR43ciGB5QcgYE3VfbhVw1ofFlh/hVmix6RZJsNz383416KZ1KE9dS95/lOrsok1NM
         sd6qD1KLc5UK4ZRAYspSIs9guYXZ8vaI6xjR8rlb6unf3VLaEiV0A1xweqkCq7Xk90
         y6R3vnoAPZ0f47vlgb19nC/8/yW3Z+NlropyPXVEiWpuF05t7ENxqzIaRkTXPxqNwp
         2V0TeSFGff+aVLLJJmGxMOUh6IKVCA6aR8mQrJNjinqMDY+A+IQhgM8N1Vui/fsoNI
         gdEajo8l1ByAA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lrFVY-0004Lu-G2; Thu, 10 Jun 2021 09:53:45 +0200
Date:   Thu, 10 Jun 2021 09:53:44 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Fix alternate function for CP2102N
 QFN20
Message-ID: <YMHFCNbTAHxPDmqv@hovoldconsulting.com>
References: <51830b2b24118eb0f77c5c9ac64ffb2f519dbb1d.1622218300.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51830b2b24118eb0f77c5c9ac64ffb2f519dbb1d.1622218300.git.stefan@agner.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 10:39:31PM +0200, Stefan Agner wrote:
> The QFN20 part has a different GPIO/port function assignment. The
> configuration struct bit field ordered as TX/RX/RS485/WAKEUP/CLK
> which exactly matches GPIO0-3 for QFN24/28. However, QFN20 has a
> different GPIO to primary function assignment.
> 
> Special case QFN20 to follow to properly detect which GPIOs are
> available.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Tested on a custom PCB with a CP2102N QFP20 device. I noticed the bug after
> configuring GPIO.2/3 to be TX/RX LED.

Thanks for fixing this, Stefan.

Nice and clean and patch, and your findings match the datasheet ("Table
4.2. GPIO Pin Alternate Functions").

Now applied for 5.13 with a stable tag.

Johan
