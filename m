Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4037244B206
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241134AbhKIRgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:36:05 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:44721 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbhKIRgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:36:03 -0500
Received: by mail-ed1-f45.google.com with SMTP id j21so79475724edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 09:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TvDol0kBPfNRwWgilmXm6cYollzM35nH7ADS6bmCDOM=;
        b=cgxNGc5KbR7tx74VoBR1pzNHMlvQt4JmIa3boeKoMc9fsUhRicGLvZhlnU8TYBBrYp
         oATfuZBfx0DRtH5aGCwE9iUfSKqyKijuhrhMm8M+5jJ0SEaD+sp4Q6SP1GIo6i0V7Z1K
         TDcwqi5Ga5CiWkzE2/0pHJJra1iWEqUOwDa8R8SDSm2p5vr/EMechIYBffHE8fz66NLI
         9UQLgPAKu84J3mTEuBnwbERD9ibors+igEL01vXSYFj7W48LBMGmPv7GIb61AJnZHSVM
         EWTXcU2G4EDb90kZGLLIG7EIZbSM/N4zTbmRk4qKzg/KSjOiHB6m+b3GCKX0ELmtwY12
         jivQ==
X-Gm-Message-State: AOAM530xGkQZEJRFMOaEHSQOvZTt3VmU+B0yUIm2FZTskUHsQ8z1Z8X1
        inwRMBf3HgvIFOgGqTv95ccvePVbkL8=
X-Google-Smtp-Source: ABdhPJypIaVIKUSgSQiOlr5ivJOEud4gdilaXvtsRPJMu7hwA+XMimaRZCxMy5wNyZ5sPYQPfzljAw==
X-Received: by 2002:a17:906:961a:: with SMTP id s26mr11426739ejx.494.1636479196493;
        Tue, 09 Nov 2021 09:33:16 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id c11sm4490483ede.8.2021.11.09.09.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 09:33:15 -0800 (PST)
Message-ID: <8e7d4214-01b8-d1a7-adaf-f2135cb6431a@kernel.org>
Date:   Tue, 9 Nov 2021 18:33:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] tty: n_gsm: add missing tty_kref_put
Content-Language: en-US
To:     Pavel Skripkin <paskripkin@gmail.com>, gregkh@linuxfoundation.org,
        hdanton@sina.com
Cc:     linux-kernel@vger.kernel.org
References: <20211109103930.27494-1-paskripkin@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211109103930.27494-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 11. 21, 11:39, Pavel Skripkin wrote:
> My local syzbot instance hit memory leak in gsmld_attach_gsm(). The
> reproducer injects allocation failure in tty_register_device(). After
> this error only previous tty_register_device() calls unwinded, but not
> tty_kref_get().
> 
> It leads to tty_struct leak, because ->close() won't be called in case
> of ->open() failure and nothing puts tty reference.

I don't have time to check the n_gsm case now (like: are you talking 
about tty->open/close or file_ops->open/close -- they behave 
differently), but tty definitely calls close even if open fails.

> Fixes: 0a360e8b65d6 ("tty: n_gsm: check error while registering tty devices")
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>   drivers/tty/n_gsm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 1d92d2a84889..1cc3aec17d2d 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2394,6 +2394,8 @@ static int gsmld_attach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
>   				for (i--; i >= 1; i--)
>   					tty_unregister_device(gsm_tty_driver,
>   								base + i);
> +
> +				tty_kref_put(gsm->tty);
>   				return PTR_ERR(dev);
>   			}
>   		}
> 


-- 
js
suse labs
