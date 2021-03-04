Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB80432CD4E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 08:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbhCDHFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 02:05:02 -0500
Received: from mail-ej1-f46.google.com ([209.85.218.46]:35810 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbhCDHEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 02:04:30 -0500
Received: by mail-ej1-f46.google.com with SMTP id dx17so19702591ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 23:04:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B+ZDIEljb0IOV4sleumdsMaePhw042leZqpljifY6ps=;
        b=Y26IwcOcEpgahGuxKv22n+i03N1COy9o3dCJJEJYTxpjVybWi1AXzlBoKJdoz2Qib8
         KJG4jOqg3cx1sGL3IJ2G6ux9JLNwQfGcxKiQu7xaA5GBWu9keMjrHIOLDlu5SWyEthWt
         lM8jEUU2xynYaiCWXH31t02AYqYX5PTPoR8cS/hSbR88YeNKYNaKYWzOMWSLTD5XPPo8
         +7/Pb8O/l/Yc6ykR4z97JDE0IYBtiKnkVkzeG/N4UvJ531ruKkKdfDobjNwDxIvzHoMC
         KIoWiG+8bTAdPOrnDFNcYPKAGKQ3bdud9GDRIcyIRGElpd073c+aT32E2mss0GKb06co
         LWlg==
X-Gm-Message-State: AOAM531PT4CWOjLg16ys3WebhWlL88Su/aQVvttb9hB1BtnP6+EICG+Q
        sc9r4qx7qzVZ1Wj9Xrt4isCpsal3my0=
X-Google-Smtp-Source: ABdhPJzJPbZoXBN+LoG0ATcPM61795tMs52aK+0zmGJz4gNrXoxoOsmNWmmkQFbruzfOPoq6ZI6RnQ==
X-Received: by 2002:a17:906:8447:: with SMTP id e7mr2682823ejy.523.1614841429420;
        Wed, 03 Mar 2021 23:03:49 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id r5sm22571032ejd.113.2021.03.03.23.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 23:03:48 -0800 (PST)
Subject: Re: [V2][PATCH] vt: keyboard, fix uninitialized variables warning
To:     Li Wang <li.wang@windriver.com>, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org
References: <2973260e-2405-5a70-f9bd-398d3d45346e@windriver.com>
 <1614827448-1594-1-git-send-email-li.wang@windriver.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <32896646-67b0-2007-ee2d-85e73e43da3c@kernel.org>
Date:   Thu, 4 Mar 2021 08:03:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614827448-1594-1-git-send-email-li.wang@windriver.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 03. 21, 4:10, Li Wang wrote:
> drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
> drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    return ret;
>           ^~~
> drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    kfree(kbs);
>    ^~~~~~~~~~
> 
> Signed-off-by: Li Wang <li.wang@windriver.com>
> ---
>   drivers/tty/vt/keyboard.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 7763862..62f1ecb 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2090,6 +2090,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>   
>   		ret = 0;
>   		break;
> +	default:
> +		return -EINVAL;

I am not biased whether to add it or not, but I would return 
-ENOIOCTLCMD if we do.

>   	}
>   
>   	kfree(kbs);
> 


-- 
js
suse labs
