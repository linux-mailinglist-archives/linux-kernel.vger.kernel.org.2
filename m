Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0892B36766D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhDVAmQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Apr 2021 20:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230338AbhDVAmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:42:15 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36BF06140F;
        Thu, 22 Apr 2021 00:41:41 +0000 (UTC)
Date:   Wed, 21 Apr 2021 20:41:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] static_call: Fix unused variable warning
Message-ID: <20210421204139.669f5c22@oasis.local.home>
In-Reply-To: <20210422003334.139452-1-linux@roeck-us.net>
References: <20210422003334.139452-1-linux@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Second patch with the exact same update. Perhaps we should take one
before we get more of them ;-)

https://lore.kernel.org/lkml/20210416194300.3952208-1-cmllamas@google.com/

-- Steve


On Wed, 21 Apr 2021 17:33:34 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> If CONFIG_MODULES=n, the following build warning is reported.
> 
> kernel/static_call.c: In function ‘__static_call_update’:
> kernel/static_call.c:153:18: warning: unused variable ‘mod’
> 
> Mark the variable as __maybe_unused to fix the problem.
> 
> Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
> Reported-by: Zach Reizner <zachr@google.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  kernel/static_call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/static_call.c b/kernel/static_call.c
> index 2c5950b0b90e..8211a34251f8 100644
> --- a/kernel/static_call.c
> +++ b/kernel/static_call.c
> @@ -150,7 +150,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
>  
>  	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
>  		bool init = system_state < SYSTEM_RUNNING;
> -		struct module *mod = site_mod->mod;
> +		struct module __maybe_unused *mod = site_mod->mod;
>  
>  		if (!site_mod->sites) {
>  			/*

