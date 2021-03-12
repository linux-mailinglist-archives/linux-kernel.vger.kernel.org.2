Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6673B338A99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhCLKwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbhCLKwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:52:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2A4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:52:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so11948403wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5vl4TnJGbtOwZE1EsiegxeOEN6L8oOxqwuScwUDj6dw=;
        b=fdpaSkr1MOEWfiUyvbv5xMFNqGFf4I2dukUFszolGvjm1yJErXnQTeE9yRZWU0O7uN
         mihLs85hFyE+nAdkRPBCowkTb5sEyeJRfTSCmblsUcuF+wgKF2jg4CCmAdl/Ya/MyXqE
         i2YJfKCHU1fwmgFf4Smz6EsKyMQSqV0J5VzLJYzbOMSjANWOHa5lpS2q76ul/z4cNnZA
         YAdw70p2z9K4+GnaSyNkXRtxrKvsGaDjeDUbrDmU/C1s7tMJgYGCPTXFwavPfdWbPVsg
         HXzZKM9KB/4pVB1DFfxgAc6n2+yCrLxNEST6GXBOmLxCDbT2dSypZoW1pRMOwG/zu6ve
         194w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5vl4TnJGbtOwZE1EsiegxeOEN6L8oOxqwuScwUDj6dw=;
        b=Whv0W0M2kYFFzz/P+oDMYGQzRYTBrjs05zbF6mfRqp6fM6P5mTYAzNQrndQtrcYluy
         HbRUY/ZzEVEMFkjalqcJUV34R55juqyWjOLQIcWPBTpo5Kkxx/ps8WwhySdgTmxow+l+
         FyXldd+4FZMX+7fn3B75SgmSKsk4IcGQr9G/uXgs5pikHVbbrOKuvYKafUy1M3mFo6Zg
         W60nPsq+9y5c5Z8BpkeDAQ0M5Na5Zt1CuUtigL/mtYxM7mTXsQIWcAHZBI9cutqybGUq
         0m+48B/qiWXStxIujqPHXyBzuUFK6mIThmDy0jCumqt23ws2kvFE5CgQy/JC1S3iWk/S
         VcQA==
X-Gm-Message-State: AOAM531nX9i1aQFo8MhKLahGz7XxZU1oek0Td5azbAA57M9RnEclgEwZ
        BmKgnGbD/dwFoBCMeky1GoNfNA==
X-Google-Smtp-Source: ABdhPJxy/RG5RLN5uL47bfpYouV02imhS7sb6oHrolh4iMAPNn5VNyvy2A/C9N1x+WhCFKpcRrErMQ==
X-Received: by 2002:a05:600c:214d:: with SMTP id v13mr12602188wml.162.1615546340506;
        Fri, 12 Mar 2021 02:52:20 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:d5de:d45f:f79c:cb62])
        by smtp.gmail.com with ESMTPSA id n186sm1707383wmn.22.2021.03.12.02.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:52:19 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:52:14 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] kasan: docs: update shadow memory section
Message-ID: <YEtH3oADQeTx1+bK@elver.google.com>
References: <f6efb2f36fc1f40eb22df027e6bc956cac71745e.1615498565.git.andreyknvl@google.com>
 <6cb4988a241f086be7e7df3eea79416a53377ade.1615498565.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb4988a241f086be7e7df3eea79416a53377ade.1615498565.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:37PM +0100, Andrey Konovalov wrote:
[...]
> -The kernel maps memory in a number of different parts of the address
> -space. This poses something of a problem for KASAN, which requires
> -that all addresses accessed by instrumented code have a valid shadow
> -region.
> -
> -The range of kernel virtual addresses is large: there is not enough
> -real memory to support a real shadow region for every address that
> -could be accessed by the kernel.
> +The kernel maps memory in several different parts of the address space.
> +The range of kernel virtual addresses is large: there is not enough real
> +memory to support a real shadow region for every address that could be
> +accessed by the kernel. Therefore, KASAN only maps real shadow for certain
> +parts of the address space.
>  
>  By default
>  ~~~~~~~~~~

While we're here, can we change this "By default" heading which seems
wrong -- the paragraph starts with "By default, ..." as well.

Perhaps "Default Behaviour"?
