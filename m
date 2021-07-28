Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693133D9938
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhG1XFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 19:05:36 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44030 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhG1XFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:05:36 -0400
Received: by mail-pl1-f176.google.com with SMTP id d17so4570020plh.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 16:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U60c5xJDYPZl1wcbWJicdtU4pVfb4y+5hbaJlciBxO0=;
        b=fhFiwRcf90rX44t+Or8vWIAEa20pBf6zOYYngGrr+TYruiL342sk3hYXj4fUGnAxV8
         KlrrwssPGuLp1e/vxg8ay/XoHhkyFlOSyAExelgbWH7aFy3BdlTZDEBHcUu1KxQNVPpA
         s22AsdB/Ksh2wv1rT8w80EA3KGV3d5YrX7Y5OubyPN9HaZDvpjWPD0UE4o117AQPyVar
         Qy6z7YYCJw21BpPVgfrkNyBnLgvU+jgrUP4MJ9J3opClL+h8HdQ255qZfBJSM5aR5zBg
         /9BP6vfzr1ziUczqjCcz1vLCOxWZWW3mxg5MzE9mFXBeej8k9DhsN6eVpC2gV8HfRjAJ
         40Eg==
X-Gm-Message-State: AOAM531hw2H4ldrWLejsdALykiNGN1kby7ohc0UtyYYSXdDxBsmNxVUI
        vWKlH8sZOAD5SelcXI5n2t0=
X-Google-Smtp-Source: ABdhPJxdnHUasAmL1QGuk9MHFZNu2rA69L2MOlpnCxPeJVaY6dKEsoNsSVFv7DDUKuMe0CiO2PwfAw==
X-Received: by 2002:a17:902:c20d:b029:12b:565f:691e with SMTP id 13-20020a170902c20db029012b565f691emr1904987pll.75.1627513532653;
        Wed, 28 Jul 2021 16:05:32 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:3328:5f8d:f6e2:85ea])
        by smtp.gmail.com with ESMTPSA id 37sm1061037pgt.28.2021.07.28.16.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 16:05:32 -0700 (PDT)
Subject: Re: [PATCH] fault-inject: Declare the second argument of
 setup_fault_attr() const
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210708183427.22842-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9afbc59c-f745-03c1-c74d-264a7180ec87@acm.org>
Date:   Wed, 28 Jul 2021 16:05:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210708183427.22842-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/21 11:34 AM, Bart Van Assche wrote:
> This patch makes it possible to pass a const char * argument to
> setup_fault_attr() without having to cast away constness.
> 
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   include/linux/fault-inject.h | 2 +-
>   lib/fault-inject.c           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
> index e525f6957c49..afc649f0102b 100644
> --- a/include/linux/fault-inject.h
> +++ b/include/linux/fault-inject.h
> @@ -42,7 +42,7 @@ struct fault_attr {
>   	}
>   
>   #define DECLARE_FAULT_ATTR(name) struct fault_attr name = FAULT_ATTR_INITIALIZER
> -int setup_fault_attr(struct fault_attr *attr, char *str);
> +int setup_fault_attr(struct fault_attr *attr, const char *str);
>   bool should_fail(struct fault_attr *attr, ssize_t size);
>   
>   #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> diff --git a/lib/fault-inject.c b/lib/fault-inject.c
> index ce12621b4275..45520151b32d 100644
> --- a/lib/fault-inject.c
> +++ b/lib/fault-inject.c
> @@ -15,7 +15,7 @@
>    * setup_fault_attr() is a helper function for various __setup handlers, so it
>    * returns 0 on error, because that is what __setup handlers do.
>    */
> -int setup_fault_attr(struct fault_attr *attr, char *str)
> +int setup_fault_attr(struct fault_attr *attr, const char *str)
>   {
>   	unsigned long probability;
>   	unsigned long interval;

Hi Akinobu,

Did I send this patch to the right person?

Thanks,

Bart.
