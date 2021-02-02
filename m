Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F730C944
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 19:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbhBBSO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 13:14:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238298AbhBBSML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612289445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NF1HLRWXYuenoK18bwRhukljyPKdg9K5mCLeCWBVL+Q=;
        b=Lk2zrgPyA4rQhf7ZE5QWSgjsKCnKB46/Ggecf0bW0Xvre6mTfNrZKNW7RMYdu+hxP5hAQi
        5sl9bXp6EVHg1/+0jhAIAd5/8SUOag38+hE6hBP4JQfgXauDuUavo/0eAvhDhKFgHdmnGG
        PTbmXAiSNGmD5Yjjy9a2xZZETXvFk0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-6GlwiiBvNyG6VLBZaVSUBw-1; Tue, 02 Feb 2021 13:10:41 -0500
X-MC-Unique: 6GlwiiBvNyG6VLBZaVSUBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0470803F43;
        Tue,  2 Feb 2021 18:10:39 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E5DA50EDE;
        Tue,  2 Feb 2021 18:10:36 +0000 (UTC)
Date:   Tue, 2 Feb 2021 13:10:35 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov <dbaryshkov@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dm crypt: replaced #if defined with IS_ENABLED
Message-ID: <20210202181035.GA14886@redhat.com>
References: <20210122084321.24012-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122084321.24012-1-a.fatoum@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22 2021 at  3:43am -0500,
Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:

> IS_ENABLED(CONFIG_ENCRYPTED_KEYS) is true whether the option is built-in
> or a module, so use it instead of #if defined checking for each
> separately.
> 
> The other #if was to avoid a static function defined, but unused
> warning. As we now always build the callsite when the function
> is defined, we can remove that first #if guard.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>
> ---
>  drivers/md/dm-crypt.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 8c874710f0bc..7eeb9248eda5 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -2436,7 +2436,6 @@ static int set_key_user(struct crypt_config *cc, struct key *key)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
>  static int set_key_encrypted(struct crypt_config *cc, struct key *key)
>  {
>  	const struct encrypted_key_payload *ekp;
> @@ -2452,7 +2451,6 @@ static int set_key_encrypted(struct crypt_config *cc, struct key *key)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_ENCRYPTED_KEYS */
>  
>  static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string)
>  {
> @@ -2482,11 +2480,10 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
>  	} else if (!strncmp(key_string, "user:", key_desc - key_string + 1)) {
>  		type = &key_type_user;
>  		set_key = set_key_user;
> -#if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
> -	} else if (!strncmp(key_string, "encrypted:", key_desc - key_string + 1)) {
> +	} else if (IS_ENABLED(CONFIG_ENCRYPTED_KEYS) &&
> +		   !strncmp(key_string, "encrypted:", key_desc - key_string + 1)) {
>  		type = &key_type_encrypted;
>  		set_key = set_key_encrypted;
> -#endif
>  	} else {
>  		return -EINVAL;
>  	}
> -- 
> 2.30.0
> 

I could be mistaken but the point of the previous way used to enable
this code was to not compile the code at all.  How you have it, the
branch just isn't taken but the compiled code is left to bloat dm-crypt.

Why not leave this as is and follow same pattern in your next patch?

Mike

