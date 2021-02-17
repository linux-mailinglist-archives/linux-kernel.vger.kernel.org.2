Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A531E1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 23:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhBQWWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 17:22:08 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:47717 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhBQWWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 17:22:05 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 696282223B;
        Wed, 17 Feb 2021 23:21:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1613600482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUhr1niuS+nIf8yyOL3EK0hH/D5TYRo+abH0t2xXTCg=;
        b=Z+aWOd5SyJshtj3KOxhVN3QTMOCFnaIjPZsRz6IXVijR+Wboe3FSEz9txVrorlpNUaZ5uO
        H2s7WjBtpcg/dtAfEWpcCx4RkR/hTCru5aZq0X8ygEe5o8DzKR81p+rfNj1RxL3t//ehSb
        1/NBURT9R3xZQukqT6/9NDnp+1J/ML4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Feb 2021 23:21:22 +0100
From:   Michael Walle <michael@walle.cc>
To:     Marc Zyngier <maz@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
In-Reply-To: <87czwys6s1.wl-maz@kernel.org>
References: <YCvYV53ZdzQSWY6w@kroah.com>
 <20210217195717.13727-1-michael@walle.cc>
 <4e4d0479b935e60a53f75ef534086476@kernel.org>
 <5c527bfb6f3dfe31b5c25f29418306c6@walle.cc> <87czwys6s1.wl-maz@kernel.org>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <9da32aa719280d2056a84b784d43976e@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-02-17 22:50, schrieb Marc Zyngier:
> On Wed, 17 Feb 2021 20:10:50 +0000,
> Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2021-02-17 21:02, schrieb Marc Zyngier:
>> > On 2021-02-17 19:57, Michael Walle wrote:
>> >> Hi Greg,
>> >>
>> >>> There's no need to keep around a dentry pointer to a simple file that
>> >>> debugfs itself can look up when we need to remove it from the system.
>> >>> So simplify the code by deleting the variable and cleaning up the
>> >>> logic
>> >>> around the debugfs file.
>> >>
>> >> This will generate the following oops on my board (arm64,
>> >> freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts). In debugfs_lookup()
>> >> debugfs_mount is NULL.
>> >
>> > That's odd. I gave it a go yesterday, and nothing blew up.
>> > Which makes me wonder whether I had the debug stuff enabled
>> > the first place...
>> >
>> > I've dropped the patch from -next for now until I figure it out
>> > (probably tomorrow).
>> 
>> Mh, maybe its my .config, I've attached it. I also noticed that
>> the board boots just fine in our kernel-ci [1].
> 
> I reproduced here. I had disabled GENERIC_IRQ_DEBUGFS for obscure
> reasons, and it caught fire as I re-enabled it.
> 
> Adding this fixes it for me:
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 367ff1c35f75..d8a14cf1a7b6 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1904,7 +1904,8 @@ static void debugfs_add_domain_dir(struct 
> irq_domain *d)
> 
>  static void debugfs_remove_domain_dir(struct irq_domain *d)
>  {
> -	debugfs_remove(debugfs_lookup(d->name, domain_dir));
> +	if (domain_dir)
> +		debugfs_remove(debugfs_lookup(d->name, domain_dir));
>  }
> 
>  void __init irq_domain_debugfs_init(struct dentry *root)
> 
> 
> Could you please check whether it works for you?

Works for me, too. Thanks.

-michael
