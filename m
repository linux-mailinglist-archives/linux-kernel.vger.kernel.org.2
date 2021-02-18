Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C8431EA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 13:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhBRMvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 07:51:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232366AbhBRLF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:05:56 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D4D964E15;
        Thu, 18 Feb 2021 10:39:41 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lCgih-00EkDd-Em; Thu, 18 Feb 2021 10:39:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Feb 2021 10:39:39 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
In-Reply-To: <YC41eWXKjE77zIBo@kroah.com>
References: <20210217195717.13727-1-michael@walle.cc>
 <4e4d0479b935e60a53f75ef534086476@kernel.org>
 <5c527bfb6f3dfe31b5c25f29418306c6@walle.cc> <87czwys6s1.wl-maz@kernel.org>
 <YC4X4iLMCK3tNVsF@kroah.com> <8b4de9eae773a43b38f42c8ab6d9d23c@walle.cc>
 <YC4nhoc9F59/1drh@kroah.com> <b5739c15db3d009556abcf9704984dab@kernel.org>
 <YC4rKOBRuzqfvdHI@kroah.com> <87eehdpx05.wl-maz@kernel.org>
 <YC41eWXKjE77zIBo@kroah.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <aada952a251b192acbdc163fc35dbd05@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, michael@walle.cc, linux-kernel@vger.kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-18 09:38, Greg KH wrote:
> On Thu, Feb 18, 2021 at 09:04:42AM +0000, Marc Zyngier wrote:
>> On Thu, 18 Feb 2021 08:54:00 +0000,
>> Greg KH <gregkh@linuxfoundation.org> wrote:
>> 
>> [...]
>> 
>> > > > Wow, wait, you are removing a debugfs file _before_ debugfs is even
>> > > > initialized?  Didn't expect that, ok, let me go try this again...
>> > >
>> > > Yeah, that's a poor man's rename (file being deleted and re-created).
>> >
>> > True, but that's not happening here, right?  Some driver is being
>> > initialized and creates a debugfs file, and then decides to unload so it
>> > removes the debugfs file?
>> 
>> No, that's not what is happening.
>> 
>> The irqchip driver starts, creates an irqdomain. File gets created, at
>> least in theory (it fails because debugfs isn't ready, but that's not
>> the issue).
>> 
>> It then changes an attribute to the domain (the so-called bus_token),
>> which gets reflected in the domain name to avoid aliasing.
>> Delete/create follows.
>> 
>> > Why was it trying to create the file in the first place if it didn't
>> > properly bind to the hardware?
>> 
>> See above. We encode properties of the domain in the filename, and
>> reflect the change of these properties as they happen.
> 
> Ah, ok, you really are doing delete/re-create.  Crazy.  And amazing it
> was working previously without the checks I just added...
> 
> Funny that you all never were even noticing that the debugfs files are
> not present in the system because they are tryign to be created before
> debugfs is present?  Is that an issue or has no one complained?

See how irq_debugfs_init() is called in the middle of the boot sequence,
and retroactively populates all the debugfs files what we missed during
the early boot.

So we're not missing anything in the end, it's just delayed.

> Anyway, I'll go turn this into a real patch and get it into 5.12-rc1 so
> that the irqdomain patch I sent you will not blow anything up.  Feel
> free to also queue it up in your tree if you want to as well.

Thanks for that.

         M.
-- 
Jazz is not dead. It just smells funny...
