Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6823428844
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhJKIFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:05:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42450 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbhJKIEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:04:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 825C520037;
        Mon, 11 Oct 2021 08:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633939362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmOre6mfDfWDB8cmxwjSAQwAP6biwZRG0HzawSv1fcU=;
        b=IOQnpZkIT0EEBVAB1vS7kfsIDPFaghimuKM1AFLX8CwYZPfdft+eWIk3pmoXkainuGa50v
        CI/DlcAS9o0KEa9ZvNzk5xtK3lelZNyoK57eSmgjDLVN2DiaefsTa6nWOwAGPFLoSGGeRu
        OI9ZJmyQ05/6tC4RFR7a5zwuLXeW6Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633939362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmOre6mfDfWDB8cmxwjSAQwAP6biwZRG0HzawSv1fcU=;
        b=5WqY8vgQQtcghINbKBKAujCUiOu5kxsnrmPp1OvOWo4x3w63I/mfR6pnnZmOcFBvk4PgI3
        KqIttjE0LQ0iUzBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5FAAC13C41;
        Mon, 11 Oct 2021 08:02:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m3qkFqLvY2GhbAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Oct 2021 08:02:42 +0000
Message-ID: <9eede0f3-cc9e-753b-16f1-0f5c3ad57794@suse.cz>
Date:   Mon, 11 Oct 2021 10:02:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Gang Li <ligang.bdlg@bytedance.com>, rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211009071243.70286-1-ligang.bdlg@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 2/2] mm: mmap_lock: use DECLARE_EVENT_CLASS and
 DEFINE_EVENT_FN
In-Reply-To: <20211009071243.70286-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/21 09:12, Gang Li wrote:
> By using DECLARE_EVENT_CLASS and TRACE_EVENT_FN, we can save a lot
> of space from duplicate code.
> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> @@ -36,11 +36,19 @@ TRACE_EVENT_FN(mmap_lock_start_locking,
>  		__entry->mm,
>  		__get_str(memcg_path),
>  		__entry->write ? "true" : "false"
> -	),
> -
> -	trace_mmap_lock_reg, trace_mmap_lock_unreg
> +	)
>  );
>  
> +#define DEFINE_MMAP_LOCK_EVENT(name)                                    \
> +	DEFINE_EVENT_FN(mmap_lock, name,                                \
> +		TP_PROTO(struct mm_struct *mm, const char *memcg_path,  \
> +			bool write),                                    \
> +		TP_ARGS(mm, memcg_path, write),                         \
> +		trace_mmap_lock_reg, trace_mmap_lock_unreg)

A question (for Steven). I've several times wondered why DEFINE_EVENT has to
pass TP_PROTO/TP_ARGS even if they are often the same. Is it not possible to
have a variant that doesn't need that, and thus also doesn't need such extra
wrapping as above?

> +
> +DEFINE_MMAP_LOCK_EVENT(mmap_lock_start_locking);
> +DEFINE_MMAP_LOCK_EVENT(mmap_lock_released);
> +
>  TRACE_EVENT_FN(mmap_lock_acquire_returned,
>  
>  	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
> @@ -73,34 +81,6 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
>  	trace_mmap_lock_reg, trace_mmap_lock_unreg
>  );
>  
> -TRACE_EVENT_FN(mmap_lock_released,
> -
> -	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
> -
> -	TP_ARGS(mm, memcg_path, write),
> -
> -	TP_STRUCT__entry(
> -		__field(struct mm_struct *, mm)
> -		__string(memcg_path, memcg_path)
> -		__field(bool, write)
> -	),
> -
> -	TP_fast_assign(
> -		__entry->mm = mm;
> -		__assign_str(memcg_path, memcg_path);
> -		__entry->write = write;
> -	),
> -
> -	TP_printk(
> -		"mm=%p memcg_path=%s write=%s",
> -		__entry->mm,
> -		__get_str(memcg_path),
> -		__entry->write ? "true" : "false"
> -	),
> -
> -	trace_mmap_lock_reg, trace_mmap_lock_unreg
> -);
> -
>  #endif /* _TRACE_MMAP_LOCK_H */
>  
>  /* This part must be outside protection */
> 

