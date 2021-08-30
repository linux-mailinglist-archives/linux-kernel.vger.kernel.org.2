Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B089B3FBAF0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhH3R1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238125AbhH3R1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630344412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1hLSwVM1pWQzJnynIDzGoWM+Kstqw1vdKrZFQya1As=;
        b=RISqkRpv+J0Oicxt+YwZPMPer3Lw9F3eCjJS0jvFMepYzCJFsZ/m7ZNQonrI9B77I48I0d
        X+3ZSeysEtsWvjR0LQxOn4CkGAlyty79xXVMfMA2RM43r7JbCnCBfvX17G21CFvQdGCS1x
        qdOYyctNhH/yAHFMJUryJFY9oWgypW0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-114hQNOpNd2HIHCeOYqjIg-1; Mon, 30 Aug 2021 13:26:48 -0400
X-MC-Unique: 114hQNOpNd2HIHCeOYqjIg-1
Received: by mail-qk1-f200.google.com with SMTP id q13-20020a05620a038d00b003d38f784161so343138qkm.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L1hLSwVM1pWQzJnynIDzGoWM+Kstqw1vdKrZFQya1As=;
        b=QQrno+xMBA3RGYX0sdtG8iaHJMD37/U38kJ1k0g1EpljIrR/p0oOmTZ6CgZHXy+0ko
         PgWTIrL22Ks+KPBK3CsFwpFZ373UozQY/h5wGjQKp+Ph65Ef1uVFNJQkPJ4SsDU05bzP
         UybOXLBoaZ6omqjYd+YOTJNndtXXRUWQjilZsYlBjgh0eMwpp4bnsccHwtYKovJwEGPk
         j6nw9Uzasy9ST3DNm1YHNqlzBUTWB80OfKDRrwMeSijZIO+uGibiHPP0f4Y/9maz6Nzg
         4lNTD/hkTla0Pd8VpDhy9L2RRSBE52KZwwhG5GaSLkznKQnJQ+CKOOX3HLCEG4sk2FMz
         RNhw==
X-Gm-Message-State: AOAM533iq4n3pxhS733/Fx1uy+ZqV2p3JjgzXb0Wk+lJLRYXlz4260At
        66MQe/rjXhH4m3DFXTzOZhqqqr+fEjdOufRF6Ou0qtlS6LnrZe9CPR1GGgH9UHvJ3Ilfz5IDLdi
        42BCoqCIy4tON3XPVvmL8OlNrhha0pJkJ9dIXUtFc63ky4xYPSqvMZWQvhoVQDORfQDRCaH0qXT
        g=
X-Received: by 2002:a37:e20f:: with SMTP id g15mr24068196qki.450.1630344408273;
        Mon, 30 Aug 2021 10:26:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzltuKeBjrlRamAbuNM05dKynNcEyk8FEMAUbPL7cbPVdbV6COjx+HbtXm/VGmF1gCTFjuNg==
X-Received: by 2002:a37:e20f:: with SMTP id g15mr24068170qki.450.1630344407997;
        Mon, 30 Aug 2021 10:26:47 -0700 (PDT)
Received: from x1.bristot.me ([177.137.119.129])
        by smtp.gmail.com with ESMTPSA id h2sm12305440qkf.106.2021.08.30.10.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 10:26:47 -0700 (PDT)
Subject: Re: [PATCH] trace/osnoise: fix missed cpus_read_unlock()
To:     qiang.zhang@windriver.com, rostedt@goodmis.org, bristot@kernel.org,
        mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <20210829055206.137025-1-qiang.zhang@windriver.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <fb07e806-71bf-6bac-ac3c-1d99136d6f8e@redhat.com>
Date:   Mon, 30 Aug 2021 19:26:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210829055206.137025-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiang,

On 8/29/21 7:52 AM, qiang.zhang@windriver.com wrote:
> From: "Qiang.zhang" <qiang.zhang@windriver.com>
set the Subject to:

trace/osnoise: Fix missed cpus_read_unlock() in start_per_cpu_kthreads()

> 
> When start_kthread() return error, the cpus_read_unlock() need
> to be called.
> 
> Signed-off-by: Qiang.zhang <qiang.zhang@windriver.com>

Add:

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Cc: <stable@vger.kernel.org> # v5.14+

> ---
>  kernel/trace/trace_osnoise.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 65b08b8e5bf8..45d22d6f3acb 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1568,6 +1568,7 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
>  		retval = start_kthread(cpu);
>  		if (retval) {
>  			stop_per_cpu_kthreads();
> +			cpus_read_unlock();
>  			return retval;
>  		}
>  	}

Why not initialize retval = 0, and then remove the "return retval" from this if,
returning rteval at the end of the function?

-- Daniel

