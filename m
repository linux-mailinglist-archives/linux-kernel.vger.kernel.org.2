Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFAD31DFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhBQUDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:03:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233730AbhBQUDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:03:07 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B451064E62;
        Wed, 17 Feb 2021 20:02:26 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lCT1k-00EeXg-KE; Wed, 17 Feb 2021 20:02:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Feb 2021 20:02:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
In-Reply-To: <20210217195717.13727-1-michael@walle.cc>
References: <YCvYV53ZdzQSWY6w@kroah.com>
 <20210217195717.13727-1-michael@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <4e4d0479b935e60a53f75ef534086476@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: michael@walle.cc, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-17 19:57, Michael Walle wrote:
> Hi Greg,
> 
>> There's no need to keep around a dentry pointer to a simple file that
>> debugfs itself can look up when we need to remove it from the system.
>> So simplify the code by deleting the variable and cleaning up the 
>> logic
>> around the debugfs file.
> 
> This will generate the following oops on my board (arm64,
> freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts). In debugfs_lookup()
> debugfs_mount is NULL.

That's odd. I gave it a go yesterday, and nothing blew up.
Which makes me wonder whether I had the debug stuff enabled
the first place...

I've dropped the patch from -next for now until I figure it out
(probably tomorrow).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
