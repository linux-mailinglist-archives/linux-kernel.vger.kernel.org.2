Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313E83F0136
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 12:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhHRKFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 06:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234317AbhHRKE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 06:04:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D16EF6109E;
        Wed, 18 Aug 2021 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629281062;
        bh=R9THNafsQYxOtTzoJp4an+Oz+xi/hoKlYEp8lGHOa5M=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Wc1JA9Zrijwgh+6GF1RIzHax4WJL7k6gCqk9QbMYKaDx1j4dTTqKf1cIKWthewr2t
         dNbVyWE9YrWtYlkX1xD4kMI3OLRBjthnA/bie6raPQc+JEUK+tNd6sDWz2BeD0iEu9
         lPmSOznBSGhlCIRjT1rrsYl22O001BzQdEWKUE7pe6nG3sq5/Q/yofA0mts3ikrNGy
         jBH1dQh4CxhvhpoOaSkdcqC1HZ/JGPoxD6Wh+bCRsI6FFUyLadLmtMX625zWhjuC/A
         xC0gSVJD1nq8j2PpOiaGu4rGqKGzmNhW5E9n9AccpMlKeIzfMBEQ5CedHqTIKP0YDc
         bAV3HGABBrCGQ==
References: <CAKXUXMwgWfX8+OvY0aCwRNukencwJERAZzU7p4eOLXQ2zv6rAg@mail.gmail.com>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Felipe Balbi <balbi@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Manish Narani <manish.narani@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dependency of USB_DWC3_XILINX on ARCH_VERSAL
Date:   Wed, 18 Aug 2021 13:02:19 +0300
In-reply-to: <CAKXUXMwgWfX8+OvY0aCwRNukencwJERAZzU7p4eOLXQ2zv6rAg@mail.gmail.com>
Message-ID: <87pmubf4rh.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lukas,

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
> Commit 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
> adds the config USB_DWC3_XILINX, which depends on the config
> ARCH_VERSAL. However, the config ARCH_VERSAL is not defined in the
> current mainline kernel repository.
>
> Will a definition of ARCH_VERSAL follow eventually (soon?) for
> mainline, is there just a further out-of-tree development for which
> the dependency is useful or is this just a mistake and can be
> corrected?

IMHO, we should have COMPILE_TEST added. Something like this:

modified   drivers/usb/dwc3/Kconfig
@@ -151,7 +151,7 @@ config USB_DWC3_IMX8MP
 
 config USB_DWC3_XILINX
 	tristate "Xilinx Platforms"
-	depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
+	depends on (ARCH_ZYNQMP || ARCH_VERSAL || COMPILE_TEST) && OF
 	default USB_DWC3
 	help
 	  Support Xilinx SoCs with DesignWare Core USB3 IP.

Care to test, please

-- 
balbi
