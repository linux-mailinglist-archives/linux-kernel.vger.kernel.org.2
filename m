Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391FB3E0FC1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 09:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbhHEH6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 03:58:36 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41965 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbhHEH6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 03:58:35 -0400
Received: by mail-wr1-f45.google.com with SMTP id c9so5267778wri.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 00:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SIGf0ZSasBVghsXQSCZ7mW/k5jcYYJAmZYHu4J8Tp/M=;
        b=BS7Me+8at/k0ThnN+cZdRjjn9LvQ2Hkxtl6nKas6F1QM59bfKDiT9i+oP/j4XKX+bq
         0JG4dCibXg7vV9vQpa8fAbUEHQUUbNCMFpiTthzlEzoILFN2mvsYlXYYdtTY9CeLBDnC
         P3/PePRNRBUUipEHpPxzJj9CI7gkOZMfGn0dZ/XaIqOx4tWzhznpWpM0MuCS26z3SfL3
         t56KLj7fh7uWR/FE1nHhtGRbFuA87VHpsVvkCUUzZZKjCjr3ayddDClzg4RUukz3H5KG
         C2/Cp5TT0vBr9GXhQdMnOS/J/J7CqhM72jGJfz64Joq6IBTyng3XdBJaxKqcdp41vfwn
         QViA==
X-Gm-Message-State: AOAM5311cPVh1viR3ta74q2/multbTLcx8gZGgSlU6ul/vHFWhKGUxwE
        s19jThu7pnfHcalF3kXwLDXl4CMjyCjMs19c
X-Google-Smtp-Source: ABdhPJxN/nX8OJxxlThMzUEDQ0ECk9b9U1Q3X1Uaosdqvsr7YAddOawAhmEhinTnQe8KIgacBYLFiw==
X-Received: by 2002:adf:9e01:: with SMTP id u1mr3659445wre.12.1628150300961;
        Thu, 05 Aug 2021 00:58:20 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id c204sm8170816wme.15.2021.08.05.00.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 00:58:20 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        gregkh@linuxfoundation.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org>
Date:   Thu, 5 Aug 2021 09:58:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04. 08. 21, 4:54, Xianting Tian wrote:
> @@ -933,6 +949,16 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
>   	hp->outbuf_size = outbuf_size;
>   	hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
>   
> +	/*
> +	 * hvc_con_outbuf is guaranteed to be aligned at least to the
> +	 * size(N_OUTBUF) by kmalloc().
> +	 */
> +	hp->hvc_con_outbuf = kzalloc(N_OUTBUF, GFP_KERNEL);
> +	if (!hp->hvc_con_outbuf)
> +		return ERR_PTR(-ENOMEM);

This leaks hp, right?

BTW your 2 patches are still not threaded, that is hard to follow.

> +
> +	spin_lock_init(&hp->hvc_con_lock);
> +
>   	tty_port_init(&hp->port);
>   	hp->port.ops = &hvc_port_ops;
>   

thanks,
-- 
js
suse labs
