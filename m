Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48C3B7710
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhF2RWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:22:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232573AbhF2RV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624987169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1wrhUM6aBKbr8jStY3jbGPmxOeBVQvKVaTR2f6NI98=;
        b=F0Fg1/TI+9OYnNGurHVNixTiqrvXIXSaRESm4mSaAQYBoLN7BFL0iULQe3L88W1kiPkdGh
        sZ1z7Qk/QCLx9A08k4V4UKynce5ekOw4n3yZpie/yX24oBHi7ff9AFXACGdx//rk++/pSG
        xV8Rk15CaENIQH+NMI/ahchx3Wx/ut4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-aGiBEbHdNSGTjr7rb4DptQ-1; Tue, 29 Jun 2021 13:19:27 -0400
X-MC-Unique: aGiBEbHdNSGTjr7rb4DptQ-1
Received: by mail-ej1-f70.google.com with SMTP id c2-20020a170906d182b02904bf8ceef772so2339304ejz.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 10:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X1wrhUM6aBKbr8jStY3jbGPmxOeBVQvKVaTR2f6NI98=;
        b=SHIw0TfaX49bw8FrwkA52vqiaFT5Z6QcTyvVHX/bwH91oUonNqLB5g6HuBo2Tn0yBe
         8WM85O57vovfn46+cDMdaM8blOyRZDQ6qz3newsFD8hxsaee/+aoX6kr5Ksxhoz83o3p
         1jaHHwxmiQtvDfrIpLOXjvB0XPZoulpuxmw4qRxE9ZtwmzJh0+jTLCyA9WY6soFR3/YI
         pPdb6u1JNibtA/OhwhGOvMyAgZ1trbo0xRc2pOII9Jhky7BZeqLBpOJOaaetd+Q3MA61
         vOSO0A2ELSeAYyccG22/XLbPScnTXn1kxBoSVxD1+OvvC5bOe+cgbp5rd4iS0CBVT87M
         QnGQ==
X-Gm-Message-State: AOAM5334oGPqi4WJewh3+zVN37i1avuCq79dB9q6aYlHdu7r4gNccgJc
        hXIExtkZ1JeQnRzCS1D96YRV81F92j/bKkU6PIbU9g8AoUqfLhPO/DMw19POXHv5cxiZwQ4Plrr
        ncLekRLioYZcM2zCjKLAGM87j
X-Received: by 2002:a17:906:7184:: with SMTP id h4mr31581947ejk.140.1624987166767;
        Tue, 29 Jun 2021 10:19:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+eoZdZ3FsgZ3Q8thM2CbCsmlREY7Mr+oNSU/wMxTHo0rf6tTFPuckJ0iK6XKGziTz78SCyA==
X-Received: by 2002:a17:906:7184:: with SMTP id h4mr31581926ejk.140.1624987166531;
        Tue, 29 Jun 2021 10:19:26 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id de6sm11646982edb.77.2021.06.29.10.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 10:19:26 -0700 (PDT)
Subject: Re: [PATCH][next] trace: osnoise: Fix u64 less than zero comparison
To:     Colin King <colin.king@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20210629165245.42157-1-colin.king@canonical.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <c74e711e-71c9-df9c-8406-b9e92ef12da0@redhat.com>
Date:   Tue, 29 Jun 2021 19:19:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629165245.42157-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/21 6:52 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The less than zero comparison of the u64 variable 'noise' is always
> false because the variable is unsigned. Since the time_sub macro
> can potentially return an -ve vale, make the variable a s64 to
> fix the issue.

Ops! concurrent bug fixing.

Dan Carpenter reported the same bug (and another problem), and I was working in
the patches... I saw yours after sending his ones:

https://lore.kernel.org/lkml/acd7cd6e7d56b798a298c3bc8139a390b3c4ab52.1624986368.git.bristot@redhat.com/

The patches do the same fix, but there it also:

 - Made also max_noise s64 (it is snapshot of noise).
 - Arranged the declarations in the inverted christmas tree.

> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Steven, can we merge the flags?

-- Daniel

> ---
>  kernel/trace/trace_osnoise.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index 38aa5e208ffd..02c984560ceb 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1040,11 +1040,11 @@ static void osnoise_stop_tracing(void)
>  static int run_osnoise(void)
>  {
>  	struct osnoise_variables *osn_var = this_cpu_osn_var();
> -	u64 noise = 0, sum_noise = 0, max_noise = 0;
> +	u64 sum_noise = 0, max_noise = 0;
>  	struct trace_array *tr = osnoise_trace;
>  	u64 start, sample, last_sample;
>  	u64 last_int_count, int_count;
> -	s64 total, last_total = 0;
> +	s64 noise = 0, total, last_total = 0;
>  	struct osnoise_sample s;
>  	unsigned int threshold;
>  	int hw_count = 0;
> 

