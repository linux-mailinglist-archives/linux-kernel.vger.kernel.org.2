Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF83FD62D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 11:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbhIAJIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 05:08:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57120 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239862AbhIAJIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 05:08:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE290202A3;
        Wed,  1 Sep 2021 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630487257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3jeCbfsUFcHiHKv3bA+MeCKvFKq2zsYwKYFQ0RSEWc=;
        b=LteYd9tBQXEEtiYmRamrsRzXsxjk4Vsh/7J2d0zl2ORjaIunNKsSOFLceM2zfp6nnoJMZM
        dDl29fP4Yd80K7AKv+xhpXPu4qJsLqcOOXlSB7Pr85ltnE/IIsXMERRY0rqd+x3KSKgNH7
        zPTFXBiLlFD/Q5UE1CZb2QSPIXoM36M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630487257;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3jeCbfsUFcHiHKv3bA+MeCKvFKq2zsYwKYFQ0RSEWc=;
        b=78P8IW8OTZR4dAREobDMk3MfpLxLVNXiC2Gru0i8OFNeN3OOThY07xHRG8tVXuHqxCj5F4
        IDovntQgOskonJCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id ADD2713A41;
        Wed,  1 Sep 2021 09:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EskUKdlCL2FoFQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 01 Sep 2021 09:07:37 +0000
Message-ID: <f425e27a-8f4a-7687-589e-b726085c5c7a@suse.cz>
Date:   Wed, 1 Sep 2021 11:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, geert@linux-m68k.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>
References: <20210901051914.971603-1-imran.f.khan@oracle.com>
 <20210901051914.971603-3-imran.f.khan@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH 2/2] lib, stackdepot: Add helper to print stack
 entries.
In-Reply-To: <20210901051914.971603-3-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/21 07:19, Imran Khan wrote:
> To print a stack entries, users of stackdepot, first
> use stack_depot_fetch to get a list of stack entries
> and then use stack_trace_print to print this list.
> Provide a helper in stackdepot to print stack entries
> based on stackdepot handle.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>

You should convert existing users together with the patch that introduces
the helper. I think print_stack() in mm/kasan/report.c, and
__dump_page_owner() could use this.

> ---
>  lib/stackdepot.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

It's missing a declaration in include/linux/stackdepot.h
Perhaps it could be all be a static inline there anyway.

> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 1d42ef9ef766..eab4476b060b 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -214,6 +214,23 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
>  	return NULL;
>  }
>  
> +/**
> + * stack_depot_print - print stack entries from a depot
> + *
> + * @handle:		Stack depot handle which was returned from
> + *			stack_depot_save().
> + *
> + */
> +void stack_depot_print(depot_stack_handle_t stack)
> +{
> +	unsigned long *entries;
> +	unsigned int nr_entries;
> +
> +	nr_entries = stack_depot_fetch(stack, &entries);
> +	stack_trace_print(entries, nr_entries, 0);
> +}
> +EXPORT_SYMBOL_GPL(stack_depot_print);
> +
>  /**
>   * stack_depot_fetch - Fetch stack entries from a depot
>   *
> 

