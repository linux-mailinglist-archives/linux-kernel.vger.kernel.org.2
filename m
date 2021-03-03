Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F77932BC81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349325AbhCCOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842912AbhCCKW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:27 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25681C0611C3
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 00:40:34 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ci14so21545576ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 00:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ro60MXIB3Y2Uz26MYGvRuu9lmodwDtoDimrL9uNxa78=;
        b=eM6EYOfXkk3c5KLAr9tzyvjs/l1Cj6MRuWXAUAy0Nt6trPBgRAQsK8pTL9spxtOc+q
         yv+hbStWY8XQUNeqCuWmbKOELAO1lnbUq886vGlh3p0D4BQiIFs9cvsKPrJbThNkUNzs
         rOueQBcwkXtOb3wXglTUBt0KvrnFhZLCv6F839/bvYM52rgNRLw8wKVYMQqYpoe3VFRv
         T5msOiL4LbkqOUsj8rlVi3W7xpHvgHKchfaI/YPmuDFzFPWgcU/bZXYTnD30lll24UKz
         mR6R/F0QMA46zNEOzZ6QdWugqdsUTNYk4voCGWcP3CdqZzLiU74YnepYuuzJMr1T6k50
         gccQ==
X-Gm-Message-State: AOAM533EpVdQR23oBXE24z6OIXRxG7wIY5oDK1edvEOXBj5yChg0yaMk
        Tgf3o9F8it15uB8VUrgqjxlIiOt0mCM=
X-Google-Smtp-Source: ABdhPJwpTmgQC33oE/R6n9L1uzXhUV6q3NfZffiIGESYaEVfzzFl6KnxP859D5QXy+udDANpAo8WGA==
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr786821ejd.106.1614760831434;
        Wed, 03 Mar 2021 00:40:31 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id ho19sm6311105ejc.57.2021.03.03.00.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 00:40:30 -0800 (PST)
Subject: Re: [PATCH v1 1/1] vt: keyboard, Fix typo in the doc for
 vt_get_shift_state()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20210303083229.75784-1-andriy.shevchenko@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <072d4de9-4784-a976-c622-2e43cb4e7702@kernel.org>
Date:   Wed, 3 Mar 2021 09:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210303083229.75784-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 03. 21, 9:32, Andy Shevchenko wrote:
> Kernel documentation validator is not happy:
> 
> .../keyboard.c:2195: warning: expecting prototype for vt_get_shiftstate(). Prototype was for vt_get_shift_state() instead
> 
> This is due to typo, fix it here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/vt/keyboard.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 77638629c562..5d2309742718 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2186,7 +2186,7 @@ void vt_reset_unicode(int console)
>   }
>   
>   /**
> - *	vt_get_shiftstate	-	shift bit state
> + *	vt_get_shift_state	-	shift bit state
>    *
>    *	Report the shift bits from the keyboard state. We have to export
>    *	this to support some oddities in the vt layer.
> 


-- 
js
