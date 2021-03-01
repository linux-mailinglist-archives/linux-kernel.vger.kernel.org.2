Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC7327AA1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhCAJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233873AbhCAJWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:22:55 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 490B064D9E;
        Mon,  1 Mar 2021 09:22:15 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lGekm-00GMwV-5F; Mon, 01 Mar 2021 09:22:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Mar 2021 09:22:11 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     ito-yuichi@fujitsu.com
Cc:     'Mark Rutland' <mark.rutland@arm.com>,
        'LAK' <linux-arm-kernel@lists.infradead.org>,
        'linux-kernel' <linux-kernel@vger.kernel.org>,
        'Android Kernel Team' <kernel-team@android.com>,
        'Russell King' <linux@arm.linux.org.uk>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Will Deacon' <will@kernel.org>,
        'Valentin Schneider' <Valentin.Schneider@arm.com>
Subject: Re: [PATCH v2 0/6] arm/arm64: Allow the rescheduling IPI to bypass
 irq_enter/exit
In-Reply-To: <OSAPR01MB42277439964B9E14D3AC94F18F9A9@OSAPR01MB4227.jpnprd01.prod.outlook.com>
References: <20201124141449.572446-1-maz@kernel.org>
 <OSAPR01MB42277439964B9E14D3AC94F18F9A9@OSAPR01MB4227.jpnprd01.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f7a1cf64f8e0181a18e2b117b61622f4@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ito-yuichi@fujitsu.com, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com, linux@arm.linux.org.uk, peterz@infradead.org, catalin.marinas@arm.com, tglx@linutronix.de, will@kernel.org, Valentin.Schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-01 00:39, ito-yuichi@fujitsu.com wrote:
> Hi Marc,
> 
> I plan to add NMI patches which enables IPI_CPU_CRASH_STOP IPI as 
> pseudo-NMI[1].
> But I know need to resolve the instrumentation issues before that. I
> think need to moving arm64 entry code over to the generic entry
> code(kernel/entry/common.c) for that, is this right?
> 
> Can you tell me current status?
> Let me know if there's anything I can do to help.

Mark is working on this, I believe. I'll let him comment on the current 
state of things.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
