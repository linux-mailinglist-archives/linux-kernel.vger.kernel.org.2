Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4515A3DF4DC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 20:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbhHCSk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbhHCSk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:40:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D89C061757;
        Tue,  3 Aug 2021 11:40:13 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qk33so37780499ejc.12;
        Tue, 03 Aug 2021 11:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fNMGun6SQ8nSYdEPy7DaDO9KQJS0mMRcRHdAkGT9rf8=;
        b=GclFGnuJ7cDuD4jUtlGwrm5/gX3W8RQXGTIJnUnNaYZd23lltKgk8pLDnSp26WZjrd
         JgdMTfRdh1VU4iSE8umDSwXENTY/62ui+3Q7AdYHRwxs0d9ZEhcLdaz6LoI79w+tzZ7T
         ttdJXGpVWT5fuwFgULe/1Xo+05brSc2UclYuYe9obupJgFiAMy9OmEPoywfletyi4Dm9
         qMUud/plearhNnTyFr5z4sWUi3P9cWe+p48oLvU9vkz+8IiUON38TKQTYhqniFDiMP8H
         B9YhP7RS60ROKuzzIusPVtEckjn0DQyf1jlCplJuHlVFt0q1Fefi6rsLHnF7UYTyxJvC
         vmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fNMGun6SQ8nSYdEPy7DaDO9KQJS0mMRcRHdAkGT9rf8=;
        b=mphhYEY+QWNLgpqaAt/npVevF+zvG2fkWu4XKxtFfAvIyycB/JwV0+1BhDN8OniBrB
         1C2/aakWZxm5jEy3Q1P/69aCCViBMxfA0TGSpQxLJezmky6itXOzRwlg4C21cTcZCUTe
         4IUO+Doy17gBsGq/2/KLYhAenUBTBDX2v0HGLNR2UfOQ7078iTEjgrdpajPA+5J2dAsz
         QrQ3TVbfeYfkcSaXRtDi7AsGR48C4Ki2qs+2R24lBl8wV7sI4lx5G4lNF6/JRpVCuNj9
         mh9KuVW4twfiCEPHQyL1Jno/J6vvaaS56r4GklLo5tA7PoeZ7T8gZcehWHhJNodw3BDB
         oszw==
X-Gm-Message-State: AOAM532J1M62Zan6riJuJleqiJCQUTxgx+ccPXplDJj0nKnRfRMOeHwE
        nbnaQxIk61aUhNXucj3JZTM=
X-Google-Smtp-Source: ABdhPJzLs6aqqBhWr8P9X5oqgwyPBr/qsI3k1NEFOThGxEcXZZ2LprWA7Nvjo2FSySAffDSka7uwZw==
X-Received: by 2002:a17:906:d54c:: with SMTP id cr12mr22222691ejc.227.1628016012465;
        Tue, 03 Aug 2021 11:40:12 -0700 (PDT)
Received: from [10.18.0.36] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id i11sm8475735edu.97.2021.08.03.11.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 11:40:12 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] platform/surface: aggregator: Ouse y instead of
 objs in Makefile
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
References: <20210803175000.72880-1-andriy.shevchenko@linux.intel.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <d8d1837a-583b-3926-5057-755acc84a5c9@gmail.com>
Date:   Tue, 3 Aug 2021 20:40:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803175000.72880-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 7:50 PM, Andy Shevchenko wrote:
> The 'objs' is for user space tools, for the kernel modules
> we should use 'y'.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you! I was previously not aware of that distinction. Two small
notes:

  - There is a typo in the subject line.
  - With that change, the ifeq could be placed in-line (see note below).

All in all looks good to me (assuming the typo gets fixed).

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/aggregator/Makefile | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/surface/aggregator/Makefile b/drivers/platform/surface/aggregator/Makefile
> index c8498c41e758..ce548dba1d4b 100644
> --- a/drivers/platform/surface/aggregator/Makefile
> +++ b/drivers/platform/surface/aggregator/Makefile
> @@ -6,12 +6,12 @@ CFLAGS_core.o = -I$(src)
>   
>   obj-$(CONFIG_SURFACE_AGGREGATOR) += surface_aggregator.o
>   
> -surface_aggregator-objs := core.o
> -surface_aggregator-objs += ssh_parser.o
> -surface_aggregator-objs += ssh_packet_layer.o
> -surface_aggregator-objs += ssh_request_layer.o
> -surface_aggregator-objs += controller.o
> +surface_aggregator-y := core.o
> +surface_aggregator-y += ssh_parser.o
> +surface_aggregator-y += ssh_packet_layer.o
> +surface_aggregator-y += ssh_request_layer.o
> +surface_aggregator-y += controller.o
>   
>   ifeq ($(CONFIG_SURFACE_AGGREGATOR_BUS),y)
> -surface_aggregator-objs += bus.o
> +surface_aggregator-y += bus.o
>   endif

I believe it should now be possible to write this as

     surface_aggregator-$(CONFIG_SURFACE_AGGREGATOR_BUS) += bus.o

which might be a bit cleaner. Don't have much of a preference though so
I'd also be fine with keeping the ifeq.

Regards,
Max
