Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D4F30C7F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhBBRhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:37:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237505AbhBBRee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:34:34 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5093D64ECE;
        Tue,  2 Feb 2021 17:33:55 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l6zYn-00BZHW-3j; Tue, 02 Feb 2021 17:33:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Feb 2021 17:33:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Crispin <john@phrozen.org>
Cc:     Bert Vermeulen <bert@biot.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] irqchip: Add support for Realtek RTL838x/RTL839x
 IRQ controller
In-Reply-To: <44d6de52-5422-1138-cb00-21320668eb29@phrozen.org>
References: <20210104131755.2979203-1-bert@biot.com>
 <20210104131755.2979203-3-bert@biot.com>
 <44d6de52-5422-1138-cb00-21320668eb29@phrozen.org>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <db9b3d9c6f886428763c8c21fe26f172@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john@phrozen.org, bert@biot.com, tglx@linutronix.de, robh+dt@kernel.org, mail@birger-koblitz.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

On 2021-02-02 15:33, John Crispin wrote:
> On 04.01.21 14:17, Bert Vermeulen wrote:
>> This is a standard IRQ driver with only status and mask registers.
>> 
>> The mapping from SoC interrupts (18-31) to MIPS core interrupts is
>> done via an interrupt-map in device tree.
>> 
>> Signed-off-by: Bert Vermeulen <bert@biot.com>
> Signed-off-by: John Crispin <john@phrozen.org>

There is already a v4 on the list[1], so you may want to comment on that 
one.

It would also help if you'd give a reason for your SoB to be added.
Or did you mean to Ack the patch?

Thanks,

         M.

[1] https://lore.kernel.ortg/r/20210122204224.509124-1-bert@biot.com
-- 
Jazz is not dead. It just smells funny...
