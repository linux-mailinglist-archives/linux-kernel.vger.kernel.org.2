Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE9540AA12
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhINJCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:02:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59466 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhINJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:02:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4A8B3220BA;
        Tue, 14 Sep 2021 09:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seidAS9JqA/z63Wo4YmSLROfSZAIjV9xwK5/H5h3XO0=;
        b=FklnkAPc3JkEAYVv/RIpkBnRLQVba4+tUcdADN0lLmtBRt5DKRq1XyfZU4jgyAOCY496YF
        xFZs6I8D1dssf3ML5OjXj/ZQZ11q1RwzOAX+VP6QuFwmhe75GbnxzaFY2l6aALSR4lf4st
        /ztumWb5/EmxAJilFBtBORCHEhEYw+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610065;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=seidAS9JqA/z63Wo4YmSLROfSZAIjV9xwK5/H5h3XO0=;
        b=QR9YQCggbndcJ9s78TDmJ0RYLmLergoY7ylXCnDIWUjqT1XR33obJgputPPSa3/dJCm00/
        N9mtARIO1anBYxAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 181EE13D3F;
        Tue, 14 Sep 2021 09:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IPopBdFkQGGFNAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Sep 2021 09:01:05 +0000
Message-ID: <ef0aa660-0cb6-dc21-f2ce-368b34f8af3d@suse.cz>
Date:   Tue, 14 Sep 2021 11:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH v2 2/2] lib, stackdepot: Add helper to print stack
 entries.
Content-Language: en-US
To:     Imran Khan <imran.f.khan@oracle.com>, geert@linux-m68k.org,
        akpm@linux-foundation.org, ryabinin.a.a@gmail.com,
        glider@google.com, andreyknvl@gmail.com, dvyukov@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210902000154.1096484-1-imran.f.khan@oracle.com>
 <20210902000154.1096484-3-imran.f.khan@oracle.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210902000154.1096484-3-imran.f.khan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 02:01, Imran Khan wrote:
> To print a stack entries, users of stackdepot, first
> use stack_depot_fetch to get a list of stack entries
> and then use stack_trace_print to print this list.
> Provide a helper in stackdepot to print stack entries
> based on stackdepot handle.
> Also change above mentioned users to use this helper.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/stackdepot.h |  2 ++
>  lib/stackdepot.c           | 17 +++++++++++++++++
>  mm/kasan/report.c          | 15 +++------------
>  mm/page_owner.c            | 13 ++++---------
>  4 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 6bb4bc1a5f54..d77a30543dd4 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -19,6 +19,8 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
>  unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>  			       unsigned long **entries);
>  
> +void stack_depot_print(depot_stack_handle_t stack);
> +
>  unsigned int filter_irq_stacks(unsigned long *entries, unsigned int nr_entries);
>  
>  #ifdef CONFIG_STACKDEPOT
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 67439c082490..873aeb152f52 100644
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

Maybe this should also skip stack_trace_print when nr_entries is 0, to avoid
the warning. While the callers added by this patch check handle != 0, future
ones might not.
