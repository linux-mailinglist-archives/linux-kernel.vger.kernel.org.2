Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD5B31E847
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhBRJii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:38:38 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:54585 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhBRI2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:28:00 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A1D1C22237;
        Thu, 18 Feb 2021 09:27:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1613636829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6ZbUUwv9T7NP9ffAh1wNte4LqGASIxmIr4F8GWCA7w=;
        b=SXPm7qt685w7wZcv9GHdYeUZVNCIGcKmLTmjWiieUAe5ZW22euByvWUvNL7RsFL8hceqSu
        A+rwyr6S4oFB+nulbsn4hnV/VcFKHtfZLi7KvSg5/nY/gwXmM1EqOzG7Q01FUe/mO1ksyh
        3ZDexrFxjuXJHX3/ZRQP5s64rBezfsk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Feb 2021 09:27:09 +0100
From:   Michael Walle <michael@walle.cc>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
In-Reply-To: <YC4X4iLMCK3tNVsF@kroah.com>
References: <YCvYV53ZdzQSWY6w@kroah.com>
 <20210217195717.13727-1-michael@walle.cc>
 <4e4d0479b935e60a53f75ef534086476@kernel.org>
 <5c527bfb6f3dfe31b5c25f29418306c6@walle.cc> <87czwys6s1.wl-maz@kernel.org>
 <YC4X4iLMCK3tNVsF@kroah.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <8b4de9eae773a43b38f42c8ab6d9d23c@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-02-18 08:31, schrieb Greg KH:
> On Wed, Feb 17, 2021 at 09:50:38PM +0000, Marc Zyngier wrote:
>> On Wed, 17 Feb 2021 20:10:50 +0000,
>> Michael Walle <michael@walle.cc> wrote:
>> >
>> > Am 2021-02-17 21:02, schrieb Marc Zyngier:
>> > > On 2021-02-17 19:57, Michael Walle wrote:
>> > >> Hi Greg,
>> > >>
>> > >>> There's no need to keep around a dentry pointer to a simple file that
>> > >>> debugfs itself can look up when we need to remove it from the system.
>> > >>> So simplify the code by deleting the variable and cleaning up the
>> > >>> logic
>> > >>> around the debugfs file.
>> > >>
>> > >> This will generate the following oops on my board (arm64,
>> > >> freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts). In debugfs_lookup()
>> > >> debugfs_mount is NULL.
>> > >
>> > > That's odd. I gave it a go yesterday, and nothing blew up.
>> > > Which makes me wonder whether I had the debug stuff enabled
>> > > the first place...
>> > >
>> > > I've dropped the patch from -next for now until I figure it out
>> > > (probably tomorrow).
>> >
>> > Mh, maybe its my .config, I've attached it. I also noticed that
>> > the board boots just fine in our kernel-ci [1].
>> 
>> I reproduced here. I had disabled GENERIC_IRQ_DEBUGFS for obscure
>> reasons, and it caught fire as I re-enabled it.
>> 
>> Adding this fixes it for me:
>> 
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index 367ff1c35f75..d8a14cf1a7b6 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -1904,7 +1904,8 @@ static void debugfs_add_domain_dir(struct 
>> irq_domain *d)
>> 
>>  static void debugfs_remove_domain_dir(struct irq_domain *d)
>>  {
>> -	debugfs_remove(debugfs_lookup(d->name, domain_dir));
>> +	if (domain_dir)
>> +		debugfs_remove(debugfs_lookup(d->name, domain_dir));
>>  }
>> 
>>  void __init irq_domain_debugfs_init(struct dentry *root)
>> 
>> 
>> Could you please check whether it works for you?
> 
> Can you try this debugfs core change instead?  Callers to debugfs 
> should
> not have to do the above type of checking as debugfs should be much 
> more
> robust than that.
> 
> thanks,
> 
> greg k-h
> 
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 2fcf66473436..5aa798f52b6e 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -297,7 +297,7 @@ struct dentry *debugfs_lookup(const char *name,
> struct dentry *parent)
>  {
>  	struct dentry *dentry;
> 
> -	if (IS_ERR(parent))
> +	if (IS_ERR_OR_NULL(name) || IS_ERR(parent))
>  		return NULL;
> 
>  	if (!parent)

This doesn't work. name is not NULL when it is called.

What has to happen before debugfs_lookup() can be called? Looks like
someone has to initialize the static debugfs_mount, first.

-michael
