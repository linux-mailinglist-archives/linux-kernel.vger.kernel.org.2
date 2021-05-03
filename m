Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FFA3722D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 00:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhECWBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 18:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECWBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 18:01:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4AC061573
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ql7b19WsqWoCC0uuC3YoVxZWS2TTjZSu47kv+OuwI8c=; b=IruHIceDH7OVzFpSMH4VTGjYOn
        JRIgsWzpTOrdilWc8p4qvl6wE9X7GmXJyEGgY3PycMqNUvn2nf6yyHdXrlk2g8qosyZOdcp+bcGCR
        7QRWQw03LwhQ20nalMEUkg8yD96zX1TKMIVhmhHhxsmf0D4jJqVuKtxHyvRzFAUtVhr0a4xK4h7eM
        gBdfgnBysFrJUwBpR+KxSzJqRpSfNNdS7Gw6D+TwS+kBwJRnw4y2WShsCMXfnuAgSn/bt2vevarrI
        lwZtLHNZa9JLUnuEYthWlTbJgPqFiS1AQGbx7UBo0GxfHB5gxbVUcNdCcoErQTIh9hq1opb/P0u3o
        Vfm7xcrA==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldgbG-00Fgg5-RZ; Mon, 03 May 2021 22:00:10 +0000
Subject: Re: [PATCH] init: Print out unknown kernel parameters
To:     Andrew Halaney <ahalaney@redhat.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@suse.de>
References: <20210503213400.27360-1-ahalaney@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dfc44b3f-a810-cfbe-f13f-39548ab3fb08@infradead.org>
Date:   Mon, 3 May 2021 14:59:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210503213400.27360-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 5/3/21 2:34 PM, Andrew Halaney wrote:
> It is easy to foobar setting a kernel parameter on the command line
> without realizing it, there's not much output that you can use to
> assess what the kernel did with that parameter by default.
> 
> Make it a little more explicit which parameters on the command line
> _looked_ like a valid parameter for the kernel, but did not match
> anything and ultimately got tossed to init. This is very similar to the
> unknown parameter message received when loading a module.
> 
> This assumes the parameters are processed in a normal fashion, some
> parameters (dyndbg= for example) don't register their
> parameter with the rest of the kernel's parameters, and therefore
> always show up in this list (and are also given to init - like the
> rest of this list).

As you say, unknown parameters are just given to init -- they are not
errors.

However, if someone is experiencing a problem, can't they just boot
with the addition of "debug" to the kernel command line and then they
can see what arguments and environment are being passed to the init
process?  E.g.:

[    9.453693] Run /sbin/init as init process
[    9.456886]   with arguments:
[    9.460014]     /sbin/init
[    9.463121]     showopts
[    9.466157]     fb=font:VGA8x8
[    9.469172]   with environment:
[    9.472146]     HOME=/
[    9.475152]     TERM=linux
[    9.478103]     BOOT_IMAGE=/boot/bzImage-next0409
[    9.481057]     resume=/dev/sda7
[    9.484006]     splash=native
[    9.495272]     v1de0=vesafb


Can you show an example of what this code prints?

thanks.

> Another example is BOOT_IMAGE= is highlighted as an offender, which it
> technically is, but is passed by LILO and GRUB so most systems will see
> that complaint.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> 
> Hello,
> 
> This idea was suggested by rostedt and bpetkov, not sure what they'll
> think of the implementation :P Please let me know if you've got
> suggestions (or hate the idea in general).
> 
> Piggybacking on unknown_bootoption()'s assessment of the
> parameters made this pretty straight forward, but I'm a bit unhappy with
> dyndbg and BOOT_IMAGE showing up. I didn't want to make an exception for
> them, so I left it as is and decided that their oddities ought to be
> shown in the output still. The format of the output is borrowed from the
> dynamic debug statements for printing init's env/argv lines.
> 
> Due to the BOOT_IMAGE bit I didn't actually ever get to exercise the
> early return (limited on my test systems right now) but I think I got
> that statement correct.
> 
> Thanks,
> Andrew
> 
>  init/main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/init/main.c b/init/main.c
> index dd11bfd10ead..cd313f1bc7b0 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -872,6 +872,20 @@ void __init __weak arch_call_rest_init(void)
>  	rest_init();
>  }
>  
> +void print_unknown_bootoptions(void)
> +{
> +	const char *const *p;
> +
> +	if (panic_later || (!argv_init[1] && !envp_init[2]))
> +		return;
> +
> +	pr_notice("Unknown command line parameters:\n");
> +	for (p = &argv_init[1]; *p; p++)
> +		pr_notice("    %s\n", *p);
> +	for (p = &envp_init[2]; *p; p++)
> +		pr_notice("    %s\n", *p);
> +}
> +
>  asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  {
>  	char *command_line;
> @@ -913,6 +927,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  				  static_command_line, __start___param,
>  				  __stop___param - __start___param,
>  				  -1, -1, NULL, &unknown_bootoption);
> +	print_unknown_bootoptions();
>  	if (!IS_ERR_OR_NULL(after_dashes))
>  		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
>  			   NULL, set_init_arg);
> 


-- 
~Randy

