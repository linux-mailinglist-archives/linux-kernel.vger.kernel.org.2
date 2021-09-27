Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347B84197BB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbhI0PYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:24:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58270 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbhI0PYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:24:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C92BB20159;
        Mon, 27 Sep 2021 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632756142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4iblHNSEN6nOTJcv0+SPsKJBZ5FtbT2h5gqOOcNel0=;
        b=dmykWltvhIbIbyExkYeFeiUzrmq1DkfzFC0iupBm64pkL4WF8gf3SrAJtKtH7IXqnbztuL
        ssi2QBMeZ+TsdmeTkLcme4SpEl3kIjyPQxnxzJ8lTadxk73iVDwtXNPu2vl4iVL+twTGuU
        r+F6IzGnulwYrFLlNyoS9lyr5cRiO7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632756142;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a4iblHNSEN6nOTJcv0+SPsKJBZ5FtbT2h5gqOOcNel0=;
        b=UKxKAEoG4mpXt6YVQcqQLdn403h6omq5cgMj6Ny8SSU0Z6zP9UQHAHJktxrIB4l9RdgkeQ
        z4v/VFjbv7imbODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9FD7132D4;
        Mon, 27 Sep 2021 15:22:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GIN6K6zhUWHpWAAAMHmgww
        (envelope-from <colyli@suse.de>); Mon, 27 Sep 2021 15:22:20 +0000
Subject: Re: [PATCH] [RFC] bcache: hide variable-sized types from uapi headers
To:     Arnd Bergmann <arnd@kernel.org>,
        Kent Overstreet <kmo@daterainc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
References: <20210927124331.1487876-1-arnd@kernel.org>
From:   Coly Li <colyli@suse.de>
Message-ID: <7d90109f-7e25-ae2d-0dc9-80618593a3e4@suse.de>
Date:   Mon, 27 Sep 2021 23:22:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210927124331.1487876-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/21 8:43 PM, Arnd Bergmann wrote:
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
> We could either try to shut up the warning or remove those parts from
> the user-visible section of this header. This does the second,
> under the assumption that they are not actually used.

Hi Arnd,

Yes, the variable part is necessary for bcache-tools to understand the 
on-disk format. If other program wants to understand the bcache on-disk 
format, IMHO such variable part might be necessary too.

BKEY_PADDED() is a special usage of the variable size array. In this 
case it indicates uuid_bucket is 8 x u64, and 6 x u64 space for ptr[]. 
And the bcache code make sure no more than 6 pointers are used for 
uuid_bucket.

I know BKEY_PADDED() works, but I don't know how to simply remove the 
-Wgnu-variable-sized-type-not-at-end warning.

Maybe Kent may offer some hint ?

Coly Li


>
> Fixes: 81ab4190ac17 ("bcache: Pull on disk data structures out into a separate header")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Coli, Kent: can you check to see if the hidden parts are used anywhere
> from user space, and apply the patch if not?
>
> Any other ideas for addressing this warning?
> ---
>   include/uapi/linux/bcache.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/uapi/linux/bcache.h b/include/uapi/linux/bcache.h
> index cf7399f03b71..e3e4889aa53e 100644
> --- a/include/uapi/linux/bcache.h
> +++ b/include/uapi/linux/bcache.h
> @@ -23,9 +23,13 @@ static inline void SET_##name(type *k, __u64 v)			\
>   struct bkey {
>   	__u64	high;
>   	__u64	low;
> +#ifdef __KERNEL__
> +	/* gcc extension not meant for user space */
>   	__u64	ptr[];
> +#endif
>   };
>   
> +#ifdef __KERNEL__
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

