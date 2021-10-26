Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E878343AB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 07:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhJZFNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 01:13:21 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42734 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhJZFNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 01:13:20 -0400
Received: by mail-wr1-f48.google.com with SMTP id v17so15532382wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 22:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=P3Zc6yeCZnILUVTPl/gZcYbGqf9vc97cwBNzsoT0q3g=;
        b=30B5uFW3LEKKoRDZ+JxbNxI+am8eOrKyYXeolKCIf/kxdfiy0jNyb+6UTOGlBQUhQf
         hJGWYmUAggclaHa/eqPdc2O4r3hRWlg0isRQ/pb69pCnTqYPpbUHsn1mhsCmRZDNCerc
         JjtdSQqozjLtSP5FTW+FcRSluztpTtw+4jGqmtwnzI9nJg/iCc2UnBrwWeMRdShjqUlG
         dUdqzB+bt547rulpmWkVQQPnTakMdgumalgeIwWjxnRks34DOrp2up0pDdGuX6e3GTDr
         UEltcbC7c+Lt8Rg1DGgze9Ukh7t67R3a47UUkinqGVG1MQySQeOcNGQvVTpdMyDZvO9C
         iYvQ==
X-Gm-Message-State: AOAM532Lg4hDFC6hkfuamFIOplsoDhpdbI8SINwQAAA3lu0RCrKabhqj
        m6vKdk//k2GzKx55RVNaKc0=
X-Google-Smtp-Source: ABdhPJx6PQGIVmdcNUmalhy4yPmH8boj2Cllr+IVnA7VjjuLDIUjtctTj8Wo0XiYE0gbxFgNFMuSzQ==
X-Received: by 2002:a5d:6c65:: with SMTP id r5mr28856932wrz.26.1635225055992;
        Mon, 25 Oct 2021 22:10:55 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id n11sm8532947wrs.14.2021.10.25.22.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 22:10:55 -0700 (PDT)
Message-ID: <208f7a41-a9fa-630c-cb44-c37c503f3a72@kernel.org>
Date:   Tue, 26 Oct 2021 07:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v11 2/3] tty: hvc: pass DMA capable memory to put_chars()
Content-Language: en-US
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        gregkh@linuxfoundation.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com
Cc:     shile.zhang@linux.alibaba.com, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
 <20211015024658.1353987-3-xianting.tian@linux.alibaba.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20211015024658.1353987-3-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 10. 21, 4:46, Xianting Tian wrote:
> @@ -151,9 +142,11 @@ static uint32_t vtermnos[MAX_NR_HVC_CONSOLES] =
>   static void hvc_console_print(struct console *co, const char *b,
>   			      unsigned count)
>   {
> -	char c[N_OUTBUF] __ALIGNED__;
> +	char *c;
>   	unsigned i = 0, n = 0;
>   	int r, donecr = 0, index = co->index;
> +	unsigned long flags;
> +	struct hvc_struct *hp;
>   
>   	/* Console access attempt outside of acceptable console range. */
>   	if (index >= MAX_NR_HVC_CONSOLES)
> @@ -163,6 +156,13 @@ static void hvc_console_print(struct console *co, const char *b,
>   	if (vtermnos[index] == -1)
>   		return;
>   
> +	hp = cons_hvcs[index];
> +	if (!hp)
> +		return;

You effectively make the console unusable until someone calls 
hvc_alloc() for this device, correct? This doesn't look right. Neither 
you describe this change of behaviour in the commit log.

regards,
-- 
js
suse labs
