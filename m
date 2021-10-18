Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF3D431F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 16:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhJROWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 10:22:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55834 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhJROWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:22:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B9F0E21A8A;
        Mon, 18 Oct 2021 14:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634566837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsBzi6/FipbnixO9Ln4BQdmP3LDK7EulRzXGYdFFDfw=;
        b=d3Owkt3EMAeSlGnoqWOra3Npjx9Z12TL/Q5MIAYqC/RG3KklZ0CvLlZsomhaM1/GHkAoXq
        JU6GayJ+K0xJXJxZqkEQ6qO0VXdOkrKbmbOE/b6HbV4DzMEfNbCrY+VvOILSvo7OzVLHmi
        K7sH+znpqu9Ff8i1Gpzp5MFJWHqZlOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634566837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsBzi6/FipbnixO9Ln4BQdmP3LDK7EulRzXGYdFFDfw=;
        b=rNpaFBqB6UabpWmgR3aJxZc6DA7txYY5Y1fFgod3eePAvBm0XCzIx4isOmZB1r14V6i87S
        DUQKRUX9U2ZMp9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A689713E81;
        Mon, 18 Oct 2021 14:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WvBsG7OCbWGKegAAMHmgww
        (envelope-from <colyli@suse.de>); Mon, 18 Oct 2021 14:20:35 +0000
Subject: Re: [PATCH] [v2] bcache: hide variable-sized types from uapi header
 check
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kmo@daterainc.com>,
        linux-kernel@vger.kernel.org
References: <20210928085554.2299495-1-arnd@kernel.org>
From:   Coly Li <colyli@suse.de>
Message-ID: <ce05e90b-f22f-bd0e-4e0f-da560bffc0c2@suse.de>
Date:   Mon, 18 Oct 2021 22:20:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928085554.2299495-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 4:55 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The headers_check helper complains about a GNU extension in
> one of the exported headers:
>
> linux/bcache.h:354:2: warning: field '' with variable sized type 'union jset::(anonymous at ./usr/include/linux/bcache.h:354:2)' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>          BKEY_PADDED(uuid_bucket);
>          ^
> linux/bcache.h:134:2: note: expanded from macro 'BKEY_PADDED'
>          union { struct bkey key; __u64 key ## _pad[BKEY_PAD]; }
>          ^
>
> Address this by enclosing the GNU extensions in an #ifdef: Since the
> header check is done with --std=c90, this shuts up the warning and makes
> it possible to include the header file C90 user space applications, but
> allows applications built with --std=gnu89 or higher to use those
> parts.
>
> Another alternative would be to exclude this header from the check,
> but the GNU extension check seems more sensible.
>
> Fixes: 81ab4190ac17 ("bcache: Pull on disk data structures out into a separate header")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

IMHO, remove bcache related header from uapi check might be better 
solution. So far only bcache-tools uses this header with its own copy, 
no application includes the header(s) so far. It makes sense to exclude 
bcache.h from upai headers check.

Thanks.

Coly Li

> ---
> v2: use __STRICT_ANSI__ check instead of __KERNEL__.
>
> I think this version is better than the first, let me know if that
> works for you.
> ---
>   include/uapi/linux/bcache.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
> index cf7399f03b71..b7901e986193 100644
> --- a/include/uapi/linux/bcache.h
> +++ b/include/uapi/linux/bcache.h
> @@ -23,9 +23,13 @@ static inline void SET_##name(type *k, __u64 v)			\
>   struct bkey {
>   	__u64	high;
>   	__u64	low;
> +#ifndef __STRICT_ANSI__
> +	/* gcc extension not meant for user space */
>   	__u64	ptr[];
> +#endif
>   };
>   
> +#ifndef __STRICT_ANSI__
>   #define KEY_FIELD(name, field, offset, size)				\
>   	BITMASK(name, struct bkey, field, offset, size)
>   
> @@ -127,6 +131,8 @@ static inline struct bkey *bkey_idx(const struct bkey *k, unsigned int nr_keys)
>   
>   	return (struct bkey *) (d + nr_keys);
>   }
> +#endif
> +
>   /* Enough for a key with 6 pointers */
>   #define BKEY_PAD		8
>   

