Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910FE365EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhDTRfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:35:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232913AbhDTRfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:35:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA7F6613C4;
        Tue, 20 Apr 2021 17:35:01 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lYuH5-008Xpj-OZ; Tue, 20 Apr 2021 18:34:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Apr 2021 18:34:59 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: Add support for IDT 79rc3243x interrupt
 controller
In-Reply-To: <20210420123441.24179-1-tsbogend@alpha.franken.de>
References: <20210420123441.24179-1-tsbogend@alpha.franken.de>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <a8ca9b028f454ec6deca6387742c2713@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tsbogend@alpha.franken.de, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-20 13:34, Thomas Bogendoerfer wrote:
> IDT 79rc3243x SoCs have rather simple interrupt controllers connected
> to the MIPS CPU interrupt lines. Each of them has room for up to
> 32 interrupts.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Is there a DT binding for this irqchip? The code looks fine, but
it'd be good if the binding was merged at the same time as the driver.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
