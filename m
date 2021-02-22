Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DA8321364
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBVJsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230169AbhBVJrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:47:49 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910C564E2F;
        Mon, 22 Feb 2021 09:47:08 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lE7o2-00FI1i-EN; Mon, 22 Feb 2021 09:47:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 22 Feb 2021 09:47:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Ajay Patil <pajay@qti.qualcomm.com>, kernel-team@android.com,
        Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v7 23/23] [DO NOT MERGE] arm64: Cope with CPUs stuck in
 VHE mode
In-Reply-To: <YDN6BtDhzmF5OtBO@latitude>
References: <20210208095732.3267263-1-maz@kernel.org>
 <20210208095732.3267263-24-maz@kernel.org> <YDN6BtDhzmF5OtBO@latitude>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <4d4e9a5cff65dbd8861f829089f570e5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: j.ne@posteo.net, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, psodagud@codeaurora.org, sramana@codeaurora.org, catalin.marinas@arm.com, marcan@marcan.st, pajay@qti.qualcomm.com, kernel-team@android.com, will@kernel.org, ardb@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 2021-02-22 09:35, Jonathan Neuschäfer wrote:
> Hi,
> 
> On Mon, Feb 08, 2021 at 09:57:32AM +0000, Marc Zyngier wrote:
>> It seems that the CPU known as Apple M1 has the terrible habit
>> of being stuck with HCR_EL2.E2H==1, in violation of the architecture.
> 
> Minor nitpick from the sideline: The M1 SoC has two kinds of CPU in it
> (Icestorm and Firestorm), which makes "CPU known as Apple M1" a bit
> imprecise.

Fair enough. How about something along the lines of:
"At least some of the CPUs integrated in the Apple M1 SoC have
  the terrible habit..."

> In practicality it seems unlikely though, that Icestorm and Firestorm
> act differently with regards to the code in this patch.

This is my hunch as well. And if they did, it shouldn't be a big deal:
the "architecture compliant" CPUs would simply transition via EL1
as expected, and join their buggy friends running at EL2 slightly later.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
