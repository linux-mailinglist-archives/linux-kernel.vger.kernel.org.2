Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91546348557
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 00:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbhCXXcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbhCXXcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 19:32:11 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:32:10 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so255569otn.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VDfCQ7mDypdFgGP02/nPELkWSb7fPDTztukepFJIbL4=;
        b=R5R6IU6+nf9PEwIxttXJNeB5ZogHzhLJHJrml1vx4ANHnSTbJr5si8JL2GS5gXC9zz
         BoXA1OBshfj+mFu8DeqHG6xH2Rx9ast2qbJHxh7lo1WE71fIXVAFberGCjKcQt7nK2Bj
         EWVESIQwh4APGF8BCbhVdysdv0xPZBe29wNt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VDfCQ7mDypdFgGP02/nPELkWSb7fPDTztukepFJIbL4=;
        b=iqI9rEqBBHZTSQK81nFvUBwaE0uvoT/uFquURbW4Jn18uMHNKiaKkhGqSo2lZK5N7r
         R3VzmQU/TBcQnKmzNN9rU6pHAJgBJkXjGbP7GFrb9iWnxIVXhWZxkM2cf8FRBaaVLuni
         ycMz5nb2WsJ/Ntyns6blYXT4i6efvnJaw1fysnQNUUSFuvf03GdJai/OcgMp8WID+WIc
         E3gOyKu9NYAvlTi6ZDKj4S46owqhpHPcnJFE2t37PXHXzG9BRYbEL6fy5hMpXyMSrv0u
         P2E1auZ/Qzq1GWXDFob0ucHJuUzKrs6j18nSHFZn8pXE1iKuQAefzyKfTl1dIdJvDjoV
         K4hA==
X-Gm-Message-State: AOAM5333+FWVd674yzL6EKf9uBzei3Lq2OD1OudX0as3fJQlBAtXUMh/
        Y6hWRxNhdGYr7MPA5pi+5mGicg==
X-Google-Smtp-Source: ABdhPJxjgjkcJJR2C6hsgUV8ZIiDU3Y1ioDMXbixrlz+0Mex/FrHQE2WAD6nRDh7anrod1IfmzoKEg==
X-Received: by 2002:a05:6830:2472:: with SMTP id x50mr4972223otr.69.1616628730037;
        Wed, 24 Mar 2021 16:32:10 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v65sm732795oib.42.2021.03.24.16.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 16:32:09 -0700 (PDT)
Subject: Re: [PATCH] tools: usbip: list.h: fix kernel-doc for list_del()
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-usb@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210324000223.22043-1-rdunlap@infradead.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <0af7bfad-fff7-84be-8e7c-2ad3e93fb785@linuxfoundation.org>
Date:   Wed, 24 Mar 2021 17:32:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210324000223.22043-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 6:02 PM, Randy Dunlap wrote:
> In list.h, the kernel-doc for list_del() should be immediately
> preceding the implementation and not separated from it by
> another function implementation.
> 
> Eliminates this kernel-doc error:
> list.h:1: warning: 'list_del' not found
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Valentina Manea <valentina.manea.m@gmail.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> ---
>   tools/usb/usbip/libsrc/list.h |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> --- linux-next-20210323.orig/tools/usb/usbip/libsrc/list.h
> +++ linux-next-20210323/tools/usb/usbip/libsrc/list.h
> @@ -77,17 +77,17 @@ static inline void __list_del(struct lis
>   #define LIST_POISON1  ((void *) 0x00100100 + POISON_POINTER_DELTA)
>   #define LIST_POISON2  ((void *) 0x00200200 + POISON_POINTER_DELTA)
>   
> +static inline void __list_del_entry(struct list_head *entry)
> +{
> +	__list_del(entry->prev, entry->next);
> +}
> +
>   /**
>    * list_del - deletes entry from list.
>    * @entry: the element to delete from the list.
>    * Note: list_empty() on entry does not return true after this, the entry is
>    * in an undefined state.
>    */
> -static inline void __list_del_entry(struct list_head *entry)
> -{
> -	__list_del(entry->prev, entry->next);
> -}
> -
>   static inline void list_del(struct list_head *entry)
>   {
>   	__list_del(entry->prev, entry->next);
> 

Thank you for fixing this.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
