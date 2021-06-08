Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753BE39EEC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFHGcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHGcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:32:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F40C061574;
        Mon,  7 Jun 2021 23:30:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso1578247pjb.5;
        Mon, 07 Jun 2021 23:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2jz5hlCuaBdqSYbaiyDCQ/DcKvk6V8GBLrVQOXLIjcQ=;
        b=vX2t7Y+5YFGEE7c/dpT+UQzs3WMByV6Owq5mGVsFrw9aL+BVKG0LbQFMmgyYaxcL4O
         eJnyFYoR5lrPVgwNF5KP9pEUVZXxtQJcWaoT2WKR4K8baeFSkL5gI+RAyyvOn+AIQYAq
         ehJu7731gAHEWEOeoZ0z2mUHAkd5hjAbSaX5AuKyJKmsYP4espq8iifNEUO0OmbwX+LC
         /DZO3O3pzktZkDSLTtTrSpYUYY1Kcz/dKjqrxb6xA7AORpZPVItqZRkb5dEWH3Nd6MnS
         1DPGbnbQnSpT3M7cL7+ui8uUlAZkFwOumi+imG26VJm9wzPWKeAa0ZVEurDzQsX1q4M9
         NKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2jz5hlCuaBdqSYbaiyDCQ/DcKvk6V8GBLrVQOXLIjcQ=;
        b=jTHznlYXOLhmTT/4yACypazpWYIK9WWikjGFWiDpS40TY3YUAIL0domAg3cGrJ9065
         FWnmg3toyOY8MMbJgqO1LKNQkTaQA4mzMrYNh4GxxbYatItd0zXVlyQ7Hj1v1m+vSLjP
         fDK7Nc7+KyLE6qLxVDf2T2nxndRrmpre4/yRkhEJNvzde6PCKofm9GZXYbECDjlDLCtA
         7X9Ct28ifAjZKJnwm33rt7Bq3KQxvhmhM9mvPTwHEfBuC5q9HuvtC7q6cpf0bR8qfWsE
         EoLnImZZ8nQJk1gAiCnSgcZdoZ7cStQLvgDWzK/PEQ5pPeyCIw+prekpSVxzN8nBnkmG
         b1Kw==
X-Gm-Message-State: AOAM531nzrbI+BatSuA9pvPio+rwSqx3p1NNE5l+tReyFmeXcOEwokx/
        8DNIhanxDlMyL8dRsJEWzc8FIVpAN2UoJKtG
X-Google-Smtp-Source: ABdhPJw67EVP9ys8Hb89y8ambGHuL+RyJ1rSk5qpSld8QJ40kAtBzJSSR1jZAgzlEfbQ4KcPth2E8g==
X-Received: by 2002:a17:902:c412:b029:112:7897:dd21 with SMTP id k18-20020a170902c412b02901127897dd21mr8710104plk.70.1623133843356;
        Mon, 07 Jun 2021 23:30:43 -0700 (PDT)
Received: from [10.104.8.180] ([119.28.155.243])
        by smtp.gmail.com with ESMTPSA id r16sm10257444pfq.140.2021.06.07.23.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 23:30:42 -0700 (PDT)
Subject: Re: [PATCH v2] docs/zh_CN: add a translation for index
To:     Hu Haowen <src.res@email.cn>, bobwxc@email.cn, alexs@kernel.org,
        corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210608035323.63728-1-src.res@email.cn>
From:   Alex Shi <seakeel@gmail.com>
Message-ID: <9dcbf22d-f415-db19-da45-421d19c2f757@gmail.com>
Date:   Tue, 8 Jun 2021 14:30:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210608035323.63728-1-src.res@email.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/21 11:53 AM, Hu Haowen wrote:
> The original file has added a former intro in commit b51208d41c6a4e7fc2f0
> ("docs: Tweak the top-level Sphinx page") and hence update the Chinese
> version for it.
> 
> Signed-off-by: Hu Haowen <src.res@email.cn>
> ---
>  Documentation/translations/zh_CN/index.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index 1f953d3439a5..cb8595c0364c 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -17,6 +17,13 @@
>     **翻译计划:**
>     内核中文文档欢迎任何翻译投稿，特别是关于内核用户和管理员指南部分。
>  
> +这是中文内核文档树的顶级目录。内核文档，就像内核本身一样，在很大程度上是一
> +项正在进行的工作；当我们努力将许多分散的文件整合成一个连贯的整体时尤其如此。
> +另外，随时欢迎您对内核文档进行改进；如果您想提供帮助，请加入vger.kernel.org

for Chinese doc, we just encourage for polish and translation, contents
change should go to English first.

> +上的linux-doc邮件列表。
> +
> +.. include:: ./disclaimer-zh_CN.rst

don't include this file, 2 of index are different. and not a exact copy.

> +
>  许可证文档
>  ----------
>  
> 
