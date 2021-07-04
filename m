Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D483BAAF6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 04:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGDC5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 22:57:02 -0400
Received: from [43.250.32.171] ([43.250.32.171]:11779 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S229529AbhGDC5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 22:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=XSfasOGrPR+I0jNlTRv4lNuiHSKY6pf0joyDX
        n4UDSk=; b=HcA39Ds4s6tuSs3aa5UmkeA16dGQ40gtFQmrgtsdbm+jBdN64MqlQ
        13/RBJe32JYf9V7W53PGCl5UMbls8QQawsJHolpn98pZG1ZNsqxJyPLFwxe9Tx0G
        SveEx7LWiVjlVrhweJkPHyPrz1DJjC3NKR6v3sQlUwyT0ZuS/V27C0=
Received: from [0.0.0.0] (unknown [39.144.6.102])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgBnAzfPIuFgRjw1AA--.9206S3;
        Sun, 04 Jul 2021 10:54:11 +0800 (CST)
Subject: Re: [PATCH] docs/zh_CN: Remove the Microsoft rhetoric
To:     Hu Jialun <hujialun@comp.nus.edu.sg>,
        =?UTF-8?B?5byg5LmQIFpoYW5nIExl?= <r0bertz@gentoo.org>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Wei Ming Chen <jj251510319013@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210703164834.460447-1-hujialun@comp.nus.edu.sg>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <1503da9f-23e2-d1c1-8b7b-f5cd4d273f1f@email.cn>
Date:   Sun, 4 Jul 2021 10:54:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210703164834.460447-1-hujialun@comp.nus.edu.sg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: LCKnCgBnAzfPIuFgRjw1AA--.9206S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1fXr17Zr1kJry7JFW7XFb_yoW5Jry3pF
        1DKr1xAa1xCwn5Cr4xuw48urZ5Wan7GFZxGF15G3yrWrnxAa1ktFWDKrs0va4fXry0vay5
        ZF4jkr9ru3WavFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1U
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr2
        1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWxJr1UJwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IUUOzVUUUUUU==
X-Originating-IP: [39.144.6.102]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/4 上午12:48, Hu Jialun 写道:
> Update Chinese translation on par with original English coding-style.rst
> Related commit b7592e5b82db19b72a34b471f3296ad3f651c8b9
>
> Signed-off-by: Hu Jialun <hujialun@comp.nus.edu.sg>
> ---
> This is more of a crude first attempt to begin getting accustomed to
> mailing list conventions of open-source communities.
> While efforts have been made to conform to the patch submission
> conventions, there is still inevitably certain omissions.
> Any corrections and suggestions would be greatly appreciated! :)


Dear Hu Jialun,

Welcome to linux-doc mailing list. We are always welcoming new contributors
who come up with corrections and suggestions to our documentation work.
Looking forward to your future constructions to the Linux kernel community.

By the way, congratulations for your first contribution to the Linux
documentation. Your patch is pretty, so don't worry about any issues.
All you're supposed to do is to wait for Corbet to have a check and apply
it.

Reviewed-by: Hu Haowen <src.res@email.cn>

Thx,
Hu Haowen


>  Documentation/translations/zh_CN/process/coding-style.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
> index b8c484a84d10..638d714bec83 100644
> --- a/Documentation/translations/zh_CN/process/coding-style.rst
> +++ b/Documentation/translations/zh_CN/process/coding-style.rst
> @@ -268,8 +268,7 @@ C 程序员不使用类似 ThisVariableIsATemporaryCounter 这样华丽的名字
>  ``count_active_users()`` 或者类似的名字，你不应该叫它 ``cntuser()`` 。
>  
>  在函数名中包含函数类型 (所谓的匈牙利命名法) 是脑子出了问题——编译器知道那些类
> -型而且能够检查那些类型，这样做只能把程序员弄糊涂了。难怪微软总是制造出有问题
> -的程序。
> +型而且能够检查那些类型，这样做只能把程序员弄糊涂了。
>  
>  本地变量名应该简短，而且能够表达相关的含义。如果你有一些随机的整数型的循环计
>  数器，它应该被称为 ``i`` 。叫它 ``loop_counter`` 并无益处，如果它没有被误解的

