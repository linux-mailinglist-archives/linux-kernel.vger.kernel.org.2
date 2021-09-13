Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BFA409A46
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbhIMREZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbhIMREY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:04:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A08C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:03:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x7so9438666pfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=frWu/JoUaXMXlQeR23mYrB0fgcNWVG++fwwYDmdHa4w=;
        b=jH+jgXCDCf41ZSHz9662zsAbn9A1ikMEcI08nO1dpYSf5byrUCpY/RJc1zQ2VRnhP0
         KLfxCdTPr7HxtncsTRM8KQ3naXZQLEE5k+Y7KmzUQgvOuKzeOX835vyyN0C5P7WGyw2i
         /locR0780r8b+j5rC7AFi5z8A2GBqBjc68SHIiJb/+llBMWWfqhRY0wT7jY9yj7F/lwP
         weWo8pkeuspx6heUbeD/lKGAyoei41eziWUMagCF07noCIqpoUuggGHXgoQUKeOTh7wz
         NqATfzOjxmiFREK1+Egn1haEztdY1paD4feosxruwJ6dS2JKQLt9mgN/qWrqzia/aZ0b
         FTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=frWu/JoUaXMXlQeR23mYrB0fgcNWVG++fwwYDmdHa4w=;
        b=3443JVdKCTHZc3D1uvX/aqf22vineKnrDkQl32z8DbrFRvsBTpfeAQA29igjOJJdLl
         byzFPOn70V+SR6HHaQBKhV5YV94hMYGyOh5HQlUShxBzgYHIynrEqZcb/vxVXmAnV1/P
         BVBYscEtoVjNeyIqVgzc4mcliAUtvkjemdTkXsi4dhlYCCk9kAH9wBS7aOg9rvMG8EFe
         Mci69JnPOuGpubVMZNJ+ZC0aMX3UJPaO5JpgKlaJ9sBCaYjqVGJLqKsVTeU5vAyJOVjV
         CNCCKBnHx9f8Z+JipnOUThj0Gj0SvS2Ecrg8MmSf2KikYPjG57bsW0ZIod0vvpW2cmyp
         TA6w==
X-Gm-Message-State: AOAM533Vyt+4HdVt3y8gQs13ER7tMcZW3tYW3WA0S50xmMEl8ZUP65tw
        h43wuL0ftfOv/gM5DUFF8bgm6ONe7OM=
X-Google-Smtp-Source: ABdhPJzoGTMD2m4u5bIjm2nE49ZiivfXqDpDL9bxyCZL+CR5IQWney1Q8cfjdX/g016Djkr0j5UTAA==
X-Received: by 2002:a63:9a19:: with SMTP id o25mr12129014pge.61.1631552587899;
        Mon, 13 Sep 2021 10:03:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q5sm4512106pjd.30.2021.09.13.10.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 10:03:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 07:03:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>
Subject: Re: [PATCH v2 6/6] workqueue, kasan: avoid alloc_pages() when
 recording stack
Message-ID: <YT+EStsWldSp76HX@slm.duckdns.org>
References: <20210913112609.2651084-1-elver@google.com>
 <20210913112609.2651084-7-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913112609.2651084-7-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:26:09PM +0200, Marco Elver wrote:
> While there is an increased risk of failing to insert the stack trace,
> this is typically unlikely, especially if the same insertion had already
> succeeded previously (stack depot hit). For frequent calls from the same
> location, it therefore becomes extremely unlikely that
> kasan_record_aux_stack_noalloc() fails.
> 
> Link: https://lkml.kernel.org/r/20210902200134.25603-1-skhan@linuxfoundation.org
> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Marco Elver <elver@google.com>
> Tested-by: Shuah Khan <skhan@linuxfoundation.org>
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route with the rest of series or if you want me to take
these through the wq tree, please let me know.

Thanks.

-- 
tejun
