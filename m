Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB805419029
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhI0Hqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 03:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhI0Hqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 03:46:46 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906B160F4F;
        Mon, 27 Sep 2021 07:45:08 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mUlJy-00DByP-Ir; Mon, 27 Sep 2021 08:45:06 +0100
MIME-Version: 1.0
Date:   Mon, 27 Sep 2021 08:45:06 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/2] irqchip/mchp-eic: add driver for Microchip EIC
In-Reply-To: <20210927063657.2157676-1-claudiu.beznea@microchip.com>
References: <20210927063657.2157676-1-claudiu.beznea@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <5284c2db6876e9f6f49f63f8beff766c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: claudiu.beznea@microchip.com, tglx@linutronix.de, robh+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Claudiu,

On 2021-09-27 07:36, Claudiu Beznea wrote:
> Hi,
> 
> This series adds support for Microchip External Interrupt Controller
> present on SAMA7G5. The controller supports for 2 external interrupt
> lines and is connected to GIC as follows:
> 
> pinX   +------+ EXT_IRQ0 +------+ int 153 (for pinX) +------+
> ------>|      |--------->|      |------------------->|      |
> pinY   | PIO  | EXT_IRQ1 | EIC  | int 154 (for pinY) | GIC  |
> ------>|      |--------->|      |------------------->|      |
>        +------+          +------+                    +------+
> 
> where PIO is the pin controller.
> 
> Thank you,
> Claudiu Beznea

Can you please reduce the spamming rate? 3 versions back to
back is just counter productive and actively reduces the incentive
to review the series. Please see [1] which says:

<quote>
Wait for a minimum of one week before resubmitting or pinging reviewers
</quote>

Thanks,

         M.

[1] Documentation/process/submitting-patches.rst
-- 
Jazz is not dead. It just smells funny...
