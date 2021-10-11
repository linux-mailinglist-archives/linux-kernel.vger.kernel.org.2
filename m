Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B842428829
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhJKH4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:56:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58618 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbhJKH42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:56:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C29522022;
        Mon, 11 Oct 2021 07:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633938868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52hF6Ny0CXxEn0NCyAW/H2iOq3Poe78PpEbjrpmjd3c=;
        b=sUhHN4dKXjYdNjbOdhE5s5Vo9E7Fq5EsbBjrBp8j2JjdrSgHaIDNikKNnlHsciX7oaHego
        8IvW7v55/PbjbzXczyEuSS+3fetCWQ5CLht5K+jgJEiM7DT2ew46/T+01yzRBLcTh0yX33
        y9Azt9A8z84DeAoEXnIjWd5x9sXYshg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633938868;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52hF6Ny0CXxEn0NCyAW/H2iOq3Poe78PpEbjrpmjd3c=;
        b=CGR/RSvYtu/OcuO7/SSyFakWO5C8xVH7JQX+aROb2h4wNp5yG75Rz1BjoIXgiB7W/2CnmS
        ARXBIqHM+Qn3klCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E148213B9C;
        Mon, 11 Oct 2021 07:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yDNKNrPtY2GuaAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Oct 2021 07:54:27 +0000
Message-ID: <ffc6b1ef-02a8-83f0-b2e0-c03b6a1a4e0c@suse.cz>
Date:   Mon, 11 Oct 2021 09:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] mm: mmap_lock: remove redundant "\n" in TP_printk
Content-Language: en-US
To:     Gang Li <ligang.bdlg@bytedance.com>, rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211009071105.69544-1-ligang.bdlg@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211009071105.69544-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/21 09:11, Gang Li wrote:
> Ftrace core will add "\n" automatically on print. "\n" in TP_printk
> will create blank line, so remove it.
> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/trace/events/mmap_lock.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
> index 0abff67b96f0..5f980c92e3e9 100644
> --- a/include/trace/events/mmap_lock.h
> +++ b/include/trace/events/mmap_lock.h
> @@ -32,7 +32,7 @@ TRACE_EVENT_FN(mmap_lock_start_locking,
>  	),
>  
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s\n",
> +		"mm=%p memcg_path=%s write=%s",
>  		__entry->mm,
>  		__get_str(memcg_path),
>  		__entry->write ? "true" : "false"
> @@ -63,7 +63,7 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
>  	),
>  
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s success=%s\n",
> +		"mm=%p memcg_path=%s write=%s success=%s",
>  		__entry->mm,
>  		__get_str(memcg_path),
>  		__entry->write ? "true" : "false",
> @@ -92,7 +92,7 @@ TRACE_EVENT_FN(mmap_lock_released,
>  	),
>  
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s\n",
> +		"mm=%p memcg_path=%s write=%s",
>  		__entry->mm,
>  		__get_str(memcg_path),
>  		__entry->write ? "true" : "false"
> 

