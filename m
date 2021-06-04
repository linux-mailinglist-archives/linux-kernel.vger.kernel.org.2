Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA539B2E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 08:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFDGvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 02:51:22 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:42721 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhFDGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 02:51:20 -0400
Received: by mail-pf1-f171.google.com with SMTP id s14so5872070pfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 23:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=BQWvJC5s5eM3wv6CMNUuU7NegMGtDLO5XucsEYO9Poc=;
        b=wUjAz0Q7vy0RdQQLDhtuh4NJFgjqB8kcFTgPBUeN6naahgiK8ldHsJxJEXNF/gIiLQ
         rJKa15pQLHfKHYwiPtW0BbpQefZ9Vm5fJRp4eMQ1mInOpN1ErBJ6orJv9iPKukDqGatn
         X/wvgvCBmmqxXh5hPM57uka+4yWDv7UMyn36k4Kjx2b5OwCIJGxbFvMTNGMqIpSKq7JZ
         xZF52mjhKEfmNoTTiNlS8nJJ82gxw0lFNMTUtObXCJOa4dm2I1323IkRGMmDEVsqSJyL
         YFfSlTG8/mm7Miy36u/2wTqL0zuHqhTbK+5zzD6Llw61d3FqKLjME2bVVB+b4TUy/X0Z
         BoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BQWvJC5s5eM3wv6CMNUuU7NegMGtDLO5XucsEYO9Poc=;
        b=dmCLRpLAqW37EZnVWLZaK4Pq2gxVOxNvYl1193J2WSYsRcddp/TJ/y+K5ALJS3fu84
         CPZUCOzeO0/x92sMkXxuF/MgLy/QubVCNOre5EbDVMFzoJiQC0YWbn402hn17tvmKOKY
         MeSHKoEb3EhavJAKt9K7s00kNZDP/kXc3Gidoc8R0Y1CpKay6AryKxLF4qhJIU6kz3tU
         ve2nFzfOkkjplEy+rkwz/tpGSeUM8p7z1Qk9lonciRJpNY99YCWg73n38kYH2/BjfdER
         MLDRagibSpgrXe4jxdvVZE+Mb6PYAH4hert5uC8XnqeVTb/uTEipDRWigInZ1o8ruZ7M
         I5Lw==
X-Gm-Message-State: AOAM531EE+5I2s/fDEGeeG6mFRHDbEMdYn53J6vEFGaMYSdOP7T+s/J6
        xAJ9vnLo5/phF9JWNUbpgjbIVg==
X-Google-Smtp-Source: ABdhPJx2UDloTP4aiPcPj38DSXAFTgLGFtShKK7vZ5nAtthJEC3mYqSS/8DwRVJOSkvzLdJ0gOJrqg==
X-Received: by 2002:a65:6884:: with SMTP id e4mr3422366pgt.71.1622789314969;
        Thu, 03 Jun 2021 23:48:34 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id m14sm947785pff.17.2021.06.03.23.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 23:48:34 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Wu Bo <wubo40@huawei.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, bp@suse.de, rafael.j.wysocki@intel.com,
        mpe@ellerman.id.au, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com, wubo40@huawei.com
Subject: Re: [PATCH] tools/testing/nvdimm: use vzalloc() instead of
 vmalloc()/memset(0)
In-Reply-To: <1622425715-146012-1-git-send-email-wubo40@huawei.com>
References: <1622425715-146012-1-git-send-email-wubo40@huawei.com>
Date:   Fri, 04 Jun 2021 12:18:32 +0530
Message-ID: <87tumem8fz.fsf@desktop.fossix.local.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Bo <wubo40@huawei.com> writes:

> Use vzalloc() instead of vmalloc() and memset(0) to simpify
> the code.
>
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  tools/testing/nvdimm/test/nfit.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

LGTM,

Reviewed-by: Santosh S <santosh@fossix.org>

>
> diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
> index 54f367cbadae..258bba22780b 100644
> --- a/tools/testing/nvdimm/test/nfit.c
> +++ b/tools/testing/nvdimm/test/nfit.c
> @@ -1625,7 +1625,6 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
>  	if (rc)
>  		goto err;
>  	INIT_LIST_HEAD(&nfit_res->list);
> -	memset(buf, 0, size);
>  	nfit_res->dev = dev;
>  	nfit_res->buf = buf;
>  	nfit_res->res.start = *dma;
> @@ -1652,7 +1651,7 @@ static void *test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma)
>  	struct genpool_data_align data = {
>  		.align = SZ_128M,
>  	};
> -	void *buf = vmalloc(size);
> +	void *buf = vzalloc(size);
>  
>  	if (size >= DIMM_SIZE)
>  		*dma = gen_pool_alloc_algo(nfit_pool, size,
> -- 
> 2.30.0
