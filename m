Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251CA32607E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhBZJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:50:32 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:42775 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhBZJtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:49:46 -0500
Received: by mail-ej1-f47.google.com with SMTP id a22so13738461ejv.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qz7iF8KIepOE4aCxzuQPw/BTEyuyc4LjaMrR27h9584=;
        b=sn0jUN5rgOydijiWmV3xW/uL07ZhnJWtQ9rTgtnDinXOyJX8nyFTIZrWyBM8FOIeFE
         rNG1eGq86is9NMgqgwZeCKlY/UqSvTNnN1GodI6ZwlU3O9CZ8s7dFL+UHniqzI/hyHUP
         397AKofvy1aeh6wcmolDFmIe5B+ZSWmcJ0fZ/EK/uGnVDYC2RiyB87ofgZzulhMjWnu1
         tWJSE0+ywPJHIj3qO4W3ZvEd5DHgN5glI2gji32zSQPflQUU0pgjjxyak5n+2e8ougwB
         rwrbqb42h4M7BQYd3pfvPXCEZRsAkre//p865XaVFKboxzTPOwc/9kEHMXGX2GUSqUJz
         R6Rg==
X-Gm-Message-State: AOAM531zzURWaQEU6aR+1LAUXgTDUv98asVYJAMKXCZHSNRG7daI2HtV
        qc2NL+UF/2Dk9EN7MZqGMorNHLzNWS1VSA==
X-Google-Smtp-Source: ABdhPJxa+ePfa8Re0o7FPIUeXTV3zNbjJ6/8zuXMfuHUQc76/Zay34GMNYowsatoX+YD24AqPO+Hiw==
X-Received: by 2002:a17:906:1b0e:: with SMTP id o14mr2419608ejg.541.1614332943754;
        Fri, 26 Feb 2021 01:49:03 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id ke18sm2145756ejc.117.2021.02.26.01.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 01:49:03 -0800 (PST)
Subject: Re: [PATCH 17/20] vt: Manual replacement of the deprecated strlcpy()
 with return values
To:     Romain Perier <romain.perier@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20210222151231.22572-1-romain.perier@gmail.com>
 <20210222151231.22572-18-romain.perier@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <a9f26339-c366-40c4-1cd6-c7ae1838e2b6@kernel.org>
Date:   Fri, 26 Feb 2021 10:49:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222151231.22572-18-romain.perier@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 21, 16:12, Romain Perier wrote:
> The strlcpy() reads the entire source buffer first, it is dangerous if
> the source buffer lenght is unbounded or possibility non NULL-terminated.

"length" and it's NUL, not NULL in this case.

> It can lead to linear read overflows, crashes, etc...
> 
> As recommended in the deprecated interfaces [1], it should be replaced
> by strscpy.
> 
> This commit replaces all calls to strlcpy that handle the return values

s/that/which/ ?
"handles"
"value"

> by the corresponding strscpy calls with new handling of the return
> values (as it is quite different between the two functions).

Sorry, I have hard times understand the whole sentence. Could you 
rephrase a bit?

> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>   drivers/tty/vt/keyboard.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 77638629c562..5e20c6c307e0 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2067,9 +2067,12 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>   			return -ENOMEM;
>   
>   		spin_lock_irqsave(&func_buf_lock, flags);
> -		len = strlcpy(kbs, func_table[kb_func] ? : "", len);
> +		len = strscpy(kbs, func_table[kb_func] ? : "", len);

func_table[kb_func] is NUL-terminated and kbs is of length len anyway, 
so this is only cosmetical.

>   		spin_unlock_irqrestore(&func_buf_lock, flags);
>   
> +		if (len == -E2BIG)
> +			return -E2BIG;
> +

This can never happen, right?

>   		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
>   			-EFAULT : 0;
>   
> 

thanks,
-- 
js
