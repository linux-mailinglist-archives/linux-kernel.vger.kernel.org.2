Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1349238715B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 07:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbhERFjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 01:39:04 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:40668 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbhERFjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 01:39:03 -0400
Received: by mail-wr1-f47.google.com with SMTP id z17so8676838wrq.7;
        Mon, 17 May 2021 22:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qYgTEcI0p8vm+Wd+KuORzC7sfMU5u1tAKUxc2TJ7yQ4=;
        b=Hnk5e9H6PNAYhMsG08p4GBWKvbIz/9EPRrvDQYVdcGNP+EySMo7dOAbZWITh273s0J
         pmzzaPhPNq4iA7I/ovoJKeZu1QCxqN1xVsDpxhE5jCe32ojLir07Pa9JIoX696t67qAi
         QG89/tI6aAfYaOsgvJ9Z9fg0srNIOESeyrNsSpigs53+WlbYjDdXlsu8p04KRg1jAJVN
         vsquPYPHPuC0d2UFgPw2B2wIRwE7W+b6Qn4hH8/Egq8LPce4HTQqfE7VWtH62j6+q8Xi
         sWsN2aubjYyF+eatex6kkUa/pswuIO0ULgV5OjlZkaCnAyav6ywy2dsbzh0taApg3vDM
         ZpDw==
X-Gm-Message-State: AOAM5328MN90y0Mdda4rHHOQvY1y3Gl7EA7wlRsx68z2eZ+r3HHUyzyG
        AQOwE2DW8oySsT0bhsFnFueZPxaNkL0=
X-Google-Smtp-Source: ABdhPJz4X5qxJaw/KOSOFlmrtqcdtaLfeSjtFY267oOOeU1PJnTB2CHuAd5qxLAM+8jUON2HU02e4w==
X-Received: by 2002:a5d:5688:: with SMTP id f8mr4403312wrv.237.1621316263409;
        Mon, 17 May 2021 22:37:43 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id x13sm9887722wro.31.2021.05.17.22.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 22:37:42 -0700 (PDT)
Subject: Re: [RFC PATCH 1/1] MAINTAINERS: TTY LAYER: add some ./include/linux/
 header files
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210518052117.14819-1-lukas.bulwahn@gmail.com>
 <20210518052117.14819-2-lukas.bulwahn@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <69da627e-91c5-66f0-c0c9-75fbaaba6782@kernel.org>
Date:   Tue, 18 May 2021 07:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518052117.14819-2-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 05. 21, 7:21, Lukas Bulwahn wrote:
> An early prototypical automated code analysis of headers and the
> existing MAINTAINERS sections identified some header files in
> ./include/linux/ to be probably included into the TTY LAYER section.
> 
> I further checked those suggestions by this analysis and identified a
> subset of files that I am rather certain to belong to the TTY LAYER.
> 
> Add these ./include/linux/ header files to TTY LAYER in MAINTAINERS.
> 
> The patterns include/linux/tty*.h and include/linux/vt_*.h currently cover:
> 
>    include/linux/tty.h
>    include/linux/tty_driver.h
>    include/linux/tty_flip.h
>    include/linux/tty_ldisc.h
> 
>    include/linux/vt_buffer.h
>    include/linux/vt_kern.h

Yes, that looks good.

Can you extend the tool to include/uapi too?

For example this is missing too:
include/uapi/linux/tty*.h

It expands to:
include/uapi/linux/tty_flags.h
include/uapi/linux/tty.h

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210507
> 
>   MAINTAINERS | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8923f0064784..d056f777c1a5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18563,9 +18563,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
>   F:	Documentation/driver-api/serial/
>   F:	drivers/tty/
>   F:	drivers/tty/serial/serial_core.c
> +F:	include/linux/selection.h
>   F:	include/linux/serial.h
>   F:	include/linux/serial_core.h
> -F:	include/linux/tty.h
> +F:	include/linux/sysrq.h
> +F:	include/linux/tty*.h
> +F:	include/linux/vt.h
> +F:	include/linux/vt_*.h
>   F:	include/uapi/linux/serial.h
>   F:	include/uapi/linux/serial_core.h
>   F:	include/uapi/linux/tty.h
> 

thanks,
-- 
js
suse labs
