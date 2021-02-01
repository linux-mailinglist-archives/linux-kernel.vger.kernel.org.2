Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755B230AA2A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhBAOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:46:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhBAOnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:43:42 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7ABE64E56;
        Mon,  1 Feb 2021 14:43:00 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l6aPp-00BI8c-Ro; Mon, 01 Feb 2021 14:42:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Feb 2021 14:42:57 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v1 0/2] Make fw_devlink=on more forgiving
In-Reply-To: <20210130040344.2807439-1-saravanak@google.com>
References: <20210130040344.2807439-1-saravanak@google.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <5419284dc9008907ccc36f1df5110356@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: saravanak@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, m.szyprowski@samsung.com, geert@linux-m68k.org, Tudor.Ambarus@microchip.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

Thanks for this.

On 2021-01-30 04:03, Saravana Kannan wrote:
> This patch series solves two general issues with fw_devlink=on
> 
> Patch 1/2 addresses the issue of firmware nodes that look like they'll
> have struct devices created for them, but will never actually have
> struct devices added for them. For example, DT nodes with a compatible
> property that don't have devices added for them.
> 
> Patch 2/2 address (for static kernels) the issue of optional suppliers
> that'll never have a driver registered for them. So, if the device 
> could
> have probed with fw_devlink=permissive with a static kernel, this patch
> should allow those devices to probe with a fw_devlink=on. This doesn't
> solve it for the case where modules are enabled because there's no way
> to tell if a driver will never be registered or it's just about to be
> registered. I have some other ideas for that, but it'll have to come
> later thinking about it a bit.
> 
> These two patches might remove the need for several other patches that
> went in as fixes for commit e590474768f1 ("driver core: Set
> fw_devlink=on by default"), but I think all those fixes are good
> changes. So I think we should leave those in.
> 
> Marek, Geert,
> 
> Can you try this series on a static kernel with your OF_POPULATED
> changes reverted? I just want to make sure these patches can identify
> and fix those cases.
> 
> Tudor,
> 
> You should still make the clock driver fix (because it's a bug), but I
> think this series will fix your issue too (even without the clock 
> driver
> fix). Can you please give this a shot?
> 
> Marc,
> 
> Can you try this series with the gpiolib fix reverted please? I'm 
> pretty
> sure this will fix that case.

Almost. The board boots and behaves as expected, except that a few 
devices
such as the SD card are unusable (probably because the corresponding
suppliers are still not identified as being available:

# find /sys -name waiting_for_supplier| xargs grep .| grep -v :0
/sys/devices/platform/vcc3v0-sd/waiting_for_supplier:1
/sys/devices/platform/vbus-typec/waiting_for_supplier:1
/sys/devices/platform/sdio-pwrseq/waiting_for_supplier:1
/sys/devices/platform/ir-receiver/waiting_for_supplier:1

With the GPIO patch that I reverted, no device is waiting for
a supplier.

Let me know if I can further help.

         M.
-- 
Jazz is not dead. It just smells funny...
