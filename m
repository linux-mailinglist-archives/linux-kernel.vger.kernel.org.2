Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF8365267
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 08:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhDTGf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 02:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhDTGfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 02:35:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17179C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 23:35:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id j7so16495184pgi.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 23:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=7/qJ+cWoLN2A/P8WkshNqGRepxTOeMXYyCN2UuSNZCM=;
        b=jdj4MjgWpF34rkrJSdiyReLgxfoxC7wvQbYHqk2uCdrupaAQ5ie7nx5dLbMkD5r66M
         eTIemT1H6xc97dYEODsbf4M5W192Bxw3tO5T6GpPMKEuRlgb0bKMEdxIzjVbddIviyl1
         7BPdu0ERl5CUaQU5A2E95CN21V3Rsd98UCNF1pBLoYyZ9yluhxjc3kmwZq1P6kBtYBJp
         qFSZw8i5hvT9JVUefGGx4n5Lx2JAx7+67oP7PTEDIMDlU0G6EEHQSnpgkVQDXCYfGMUa
         /Qf895uwty2KlqrtlgB9953Z5JtVIQuj0QTQd9iDHoqexj/HtzZzPPXcZRE7il8M1U0e
         ++KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7/qJ+cWoLN2A/P8WkshNqGRepxTOeMXYyCN2UuSNZCM=;
        b=cUampJgWj1EB6peqtIR33HjgiJu27B94A5AO3CIi7DHBq4I1N4miao7C0nPNK5lw1C
         yF8ucn9QzzkCMo8QdrwODZKYhZ905cYnH8ROXqYCXsl/D/fCNmbuHCLyLZ8Fw5OcQ8Hr
         ED1POCVtzGrTlT+rFj+FCYGFwRMa/zu8W5L2rYWt1ZO1jdQMwHhUm0rugF2St+XvlU7G
         zlc98+y4kUbfOw4PCpvUdTsbZCXSA1m2SB80yJJn+qwlar4Xiugcy8nslOyXKK86Ja8f
         fJnFzOceSsJTvTMbAm6C3fJj2TWhO7eSBgichxhZOoDW/3Lue+LnudosqC5pVf5xvJfv
         U46Q==
X-Gm-Message-State: AOAM532TMtXF3gkvPcFoXYSb2l31+hfdSPRvoKyd8XvTGdHBWRQanXVQ
        zyB9zqlEtQrNo8z+3rw1FKdmTg==
X-Google-Smtp-Source: ABdhPJyB7+uL61SnopVxjLZEHqrP4CokPtaLTSzBN/xx8opJvyhg4vc8W+MeBl/M+6FrIzoA3gw83Q==
X-Received: by 2002:a62:170e:0:b029:1fa:7161:fd71 with SMTP id 14-20020a62170e0000b02901fa7161fd71mr23040906pfx.35.1618900515537;
        Mon, 19 Apr 2021 23:35:15 -0700 (PDT)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id y29sm13989232pfq.29.2021.04.19.23.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 23:35:15 -0700 (PDT)
From:   Santosh Sivaraj <santosh@fossix.org>
To:     Zou Wei <zou_wei@huawei.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, ira.weiny@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Zou Wei <zou_wei@huawei.com>
Subject: Re: [PATCH -next] tools/testing/nvdimm: Make symbol
 '__nfit_test_ioremap' static
In-Reply-To: <1617779451-81730-1-git-send-email-zou_wei@huawei.com>
References: <1617779451-81730-1-git-send-email-zou_wei@huawei.com>
Date:   Tue, 20 Apr 2021 12:05:11 +0530
Message-ID: <87h7k1zco0.fsf@fossix.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Zou,

Zou Wei <zou_wei@huawei.com> writes:

> The sparse tool complains as follows:
>
> tools/testing/nvdimm/test/iomap.c:65:14: warning:
>  symbol '__nfit_test_ioremap' was not declared. Should it be static?
>
> This symbol is not used outside of security.c, so this

s/security.c/iomap.c/

Thanks,
Santosh

> commit marks it static.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  tools/testing/nvdimm/test/iomap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
> index c62d372..ed563bd 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -62,7 +62,7 @@ struct nfit_test_resource *get_nfit_res(resource_size_t resource)
>  }
>  EXPORT_SYMBOL(get_nfit_res);
>  
> -void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
> +static void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
>  		void __iomem *(*fallback_fn)(resource_size_t, unsigned long))
>  {
>  	struct nfit_test_resource *nfit_res = get_nfit_res(offset);
> -- 
> 2.6.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
