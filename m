Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE03D65C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbhGZQsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237987AbhGZQsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 12:48:14 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCEFC01B079
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:22:13 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso10623441otb.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rJgYrAAFtcjBWZ81nVHlsdXlwxX21/6y1tWdyXf43yY=;
        b=QuIqSpzgb0vHUIcN2FS3CWw8Pj8HBS/O/RJRt0NraNHThfiVHyjfMdc+mbWg+5YGPY
         f4Za/DglVuVtA/V9iCRWzrbZ+q3YfZBTmUbkE4uqoAHyPL5051Mws6bLqmh/SrhkepsL
         PdiFI2yzMHOUiX+lEjlI6UXVW9WdAuT4GeQ/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rJgYrAAFtcjBWZ81nVHlsdXlwxX21/6y1tWdyXf43yY=;
        b=BtVdvDhGWVub+0jjV/uPzIRehhZ9MMytYdOCvGxtblhf8klniNJlxJAUPD11/WZBxC
         by2Sw2FllGcgJnGZqEyzKKXmYaIFKv3fWWPM0grnLkgj1YN8I2AclPAeGkousUqsDpzc
         rgCFLRERFtnIiKafGfcNsk2oYjL6iZnXqIRKAUR/3Z/dzDBsgj2J5ZNFAQy1zUkjiLrv
         O395tO643bXMaL5PC3XpZKbwixjn1+x48jjFQFpSxAd3xpTJemFJ+PRIDb8sP601F7B9
         GavTilg8QSq6pY8wKGfEW7QVnqYousAnGiPyPBy5A5Xyc2bAlWNRJUw7g/rDRYlpZzZG
         LZOw==
X-Gm-Message-State: AOAM531zmaGtRkID5K6/MK9YHQ7WbdbRI2Sk+WD/hnV56V12+1g6AqbP
        oDXWtUBSgNUFKjPRKhZVIguwVg==
X-Google-Smtp-Source: ABdhPJwbVpoSNaPiCc+cCdG2ojeVa5dFPoNsJOdXoQoFoj4N8ynAHJCZmIp5ct9xYan/saIwxwpeJQ==
X-Received: by 2002:a05:6830:15d1:: with SMTP id j17mr12744998otr.292.1627320133142;
        Mon, 26 Jul 2021 10:22:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c21sm91818oiw.16.2021.07.26.10.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 10:22:12 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] firmware_loader: fix use-after-free in
 firmware_fallback_sysfs
To:     Anirudh Rayabharam <mail@anirudhrb.com>, mcgrof@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+de271708674e2093097b@syzkaller.appspotmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210724121134.6364-1-mail@anirudhrb.com>
 <20210724121134.6364-3-mail@anirudhrb.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2f6f4318-8640-7b22-5492-e74f2af9ba38@linuxfoundation.org>
Date:   Mon, 26 Jul 2021 11:22:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210724121134.6364-3-mail@anirudhrb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/21 6:11 AM, Anirudh Rayabharam wrote:
> This use-after-free happens when a fw_priv object has been freed but
> hasn't been removed from the pending list (pending_fw_head). The next
> time fw_load_sysfs_fallback tries to insert into the list, it ends up
> accessing the pending_list member of the previoiusly freed fw_priv.
> 
> The root cause here is that all code paths that abort the fw load
> don't delete it from the pending list. For example:
> 
> 	_request_firmware()
> 	  -> fw_abort_batch_reqs()
> 	      -> fw_state_aborted()
> 
> To fix this, delete the fw_priv from the list in __fw_set_state() if
> the new state is DONE or ABORTED. This way, all aborts will remove
> the fw_priv from the list. Accordingly, remove calls to list_del_init
> that were being made before calling fw_state_(aborted|done).
> 
> Also, in fw_load_sysfs_fallback, don't add the fw_priv to the pending
> list if it is already aborted. Instead, just jump out and return early.
> 
> Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")
> Reported-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> Tested-by: syzbot+de271708674e2093097b@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>   drivers/base/firmware_loader/fallback.c | 10 +++++++---
>   drivers/base/firmware_loader/firmware.h |  6 +++++-
>   drivers/base/firmware_loader/main.c     |  2 ++
>   3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 1a48be0a030e..5d9f372fc9e7 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -91,10 +91,9 @@ static void __fw_load_abort(struct fw_priv *fw_priv)
>   	 * There is a small window in which user can write to 'loading'
>   	 * between loading done and disappearance of 'loading'
>   	 */

Update the comment to "between loading done/abort"

Rest looks good to me.

> -	if (fw_sysfs_done(fw_priv))
> +	if (fw_state_is_aborted(fw_priv) || fw_sysfs_done(fw_priv))
>   		return;
>   
> -	list_del_init(&fw_priv->pending_list);
>   	fw_state_aborted(fw_priv);
>   }
>   
> @@ -280,7 +279,6 @@ static ssize_t firmware_loading_store(struct device *dev,
>   			 * Same logic as fw_load_abort, only the DONE bit
>   			 * is ignored and we set ABORT only on failure.
>   			 */
> -			list_del_init(&fw_priv->pending_list);
>   			if (rc) {
>   				fw_state_aborted(fw_priv);
>   				written = rc;
> @@ -513,6 +511,11 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>   	}
>   
>   	mutex_lock(&fw_lock);
> +	if (fw_state_is_aborted(fw_priv)) {
> +		mutex_unlock(&fw_lock);
> +		retval = -EINTR;
> +		goto out;
> +	}
>   	list_add(&fw_priv->pending_list, &pending_fw_head);
>   	mutex_unlock(&fw_lock);
>   
> @@ -538,6 +541,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
>   	} else if (fw_priv->is_paged_buf && !fw_priv->data)
>   		retval = -ENOMEM;
>   
> +out:
>   	device_del(f_dev);
>   err_put_dev:
>   	put_device(f_dev);
> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> index 63bd29fdcb9c..36bdb413c998 100644
> --- a/drivers/base/firmware_loader/firmware.h
> +++ b/drivers/base/firmware_loader/firmware.h
> @@ -117,8 +117,12 @@ static inline void __fw_state_set(struct fw_priv *fw_priv,
>   
>   	WRITE_ONCE(fw_st->status, status);
>   
> -	if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED)
> +	if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED) {
> +#ifdef CONFIG_FW_LOADER_USER_HELPER

Might be helpful to add a comment that this covers all abort/done
paths

> +		list_del_init(&fw_priv->pending_list);
> +#endif
>   		complete_all(&fw_st->completion);
> +	}
>   }
>   
>   static inline void fw_state_aborted(struct fw_priv *fw_priv)
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 4fdb8219cd08..68c549d71230 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -783,8 +783,10 @@ static void fw_abort_batch_reqs(struct firmware *fw)
>   		return;
>   
>   	fw_priv = fw->priv;
> +	mutex_lock(&fw_lock);
>   	if (!fw_state_is_aborted(fw_priv))
>   		fw_state_aborted(fw_priv);
> +	mutex_unlock(&fw_lock);
>   }
>   
>   /* called from request_firmware() and request_firmware_work_func() */
> 

thanks,
-- Shuah
