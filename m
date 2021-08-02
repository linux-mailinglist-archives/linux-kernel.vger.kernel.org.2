Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9413F3DDA98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbhHBOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:16:28 -0400
Received: from m32-153.88.com ([43.250.32.153]:15169 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238227AbhHBOLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=zQWRDMlxuYvEy8QnJiiJAjAsoNI8QnuO+SUDC
        +yR8Ps=; b=GtE0fjNKzS3uUlP2Jee8Wv2tbMe6vfyWehh/ALOw7jEVtqjDH5dzC
        I0BXm7MfadlYHo0GhPviYRaKzBEFGBsUse7ZFHgLpl74tVv9EPXJyaDTzBMmDszh
        vmNDwOEwf9T9KZRdYAa1BCOp+wYOFaVCCH0G8pSpk7bpiqX0YUhlq0=
Received: from [0.0.0.0] (unknown [113.251.11.248])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCXFqft_AdhsMYXAA--.3575S3;
        Mon, 02 Aug 2021 22:10:53 +0800 (CST)
Subject: Re: [PATCH v3 9/9] docs: pdfdocs: Enable language-specific font
 choice of zh_TW translations
To:     Akira Yokosawa <akiyks@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Wu X.C." <bobwxc@email.cn>, SeongJae Park <sj38.park@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <eb8184ab-cfab-680b-f180-1157a7f709b3@gmail.com>
 <48810e08-595f-fb87-603f-fa642823b84c@gmail.com>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <e9130727-ad59-f147-f41a-9b3acc96d47e@email.cn>
Date:   Mon, 2 Aug 2021 22:10:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <48810e08-595f-fb87-603f-fa642823b84c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgCXFqft_AdhsMYXAA--.3575S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw4kJr4Uury5tFW7WF15Arb_yoWDJFbEya
        1kXF4vv3W7Ar1IgFWrJr1kXF1FvF4rGr10yr15trZ5Za13Aws7Ar1DW3s5Za45WFsrurs8
        C3Z5Xw18ZrnxXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUboAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
        II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7
        xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84AC
        jcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F4
        0EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1UJr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67
        vIY487MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
        C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
        JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
        WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x0Jj-VyxUUUUU=
X-Originating-IP: [113.251.11.248]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/2 下午6:00, Akira Yokosawa 写道:
> The "TC" variant is supposed to be the choice for traditional
> Chinese documents.
>
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Hu Haowen <src.res@email.cn>


Well done!

Reviewed-by: Hu Haowen <src.res@email.cn>
Tested-by: Hu Haowen <src.res@email.cn>

Cheers,
Hu Haowen


> ---
>  Documentation/translations/zh_TW/index.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
> index 76981b2111f6..c02c4b5281e6 100644
> --- a/Documentation/translations/zh_TW/index.rst
> +++ b/Documentation/translations/zh_TW/index.rst
> @@ -5,6 +5,7 @@
>  	\renewcommand\thesection*
>  	\renewcommand\thesubsection*
>  	\kerneldocCJKon
> +	\kerneldocBeginTC
>  
>  .. _linux_doc_zh_tw:
>  
> @@ -162,3 +163,6 @@ TODOList:
>  
>  * :ref:`genindex`
>  
> +.. raw:: latex
> +
> +	\kerneldocEndTC

