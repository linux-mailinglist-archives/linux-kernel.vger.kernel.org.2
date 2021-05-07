Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05C6376B0B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhEGUIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEGUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:08:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C58C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 13:07:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b21so1565986pft.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrDqJx93OwdWCfFkXfyEoTQC8negd4/G/SopvOQHRnA=;
        b=Ljvql2B1pthM67CXVupOIxAd4PFlEjAG7Pu1s/nfesxhIUrpDmA9WLsAC/Y3bUo89g
         L/ffu8tDadfJ+pxidn0DVYDIwFBhXtSReZRTWroN+u3PhkNwNVTXhAH3sTK0Vm+2a0cy
         W5eEohTjs00P6IN84pcyoz+qPDTHRCv0pINXFVh6whjkUtKZBscI/ZFkKDBIFWPJ704G
         WT+6V90c0iJ5r4KzivNgjybA6tuK2SztLgLIufQhkGbJAOucXLb2x/7GEEPhPXiryx8P
         cSOx8FmuoQ8Unp9GRkbXh/ngSaNhviDcjeY2MP/OUTHI7Lp6FVj5aIKS0AxY5L54uUk5
         VNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrDqJx93OwdWCfFkXfyEoTQC8negd4/G/SopvOQHRnA=;
        b=pXFwK8buRQNn4eIyBipK1M5HW3KmwOgkNr52bLg3bOb39dpJOyULlrRh6LZuDHRM/m
         Il6Dg4CPVJeyPS1LPRYZXsTp8YM/q1DAu9/Sxmmh3Y65Vi3HflE1rfmsGA4srR2rqRdF
         3SqOkjpB1JbMl447+l8d6mnnWUKVQ7IuDXW1vHqBJVuPVciy6q9wFm/Yy8bi+lcRUeck
         sc9mHpPL8+Tumfr6AAlM9h622pX2ELbv55bLY+/zMpq/cRG0n6DQ7xzScs9+CA2G/wmj
         dt2dI+TtUQfkPqabpNki6wM7sDSFl9jvvK+Spp2ISgOKe6/4m21PeotuQzjdPpCZEk/v
         0Orw==
X-Gm-Message-State: AOAM53327MeVFT+aIHdhA1Wwkz/Cf/vt5t2UByu9y96A2zZgaHeqmM36
        zH8/SlL6OHNMKwVhNnTIDE1GNSQC8JzJk90bPa/dXg==
X-Google-Smtp-Source: ABdhPJzT1xB3lzIA3Cm3XMfODY+rxABey2UGk2x5NFeuPpU8S2XsIfS2S3qp0oopN7quK7JnoLOGgAhPmWRj87DEBTA=
X-Received: by 2002:a63:cc11:: with SMTP id x17mr11654985pgf.159.1620418060779;
 Fri, 07 May 2021 13:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210507050908.1008686-1-davidgow@google.com> <20210507050908.1008686-2-davidgow@google.com>
In-Reply-To: <20210507050908.1008686-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 7 May 2021 13:07:29 -0700
Message-ID: <CAFd5g47NR_OKQfxDxc_PnXKCbkKNUeUH49Q6k6m=70C4uhQ0xQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: Assign strings to 'const char*' in STREQ assertions
To:     David Gow <davidgow@google.com>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 10:09 PM David Gow <davidgow@google.com> wrote:
>
> Currently, the KUNIT_EXPECT_STREQ() and related macros assign both
> string arguments to variables of their own type (via typeof()). This
> seems to be to prevent the macro argument from being evaluated multiple
> times.
>
> However, yhis doesn't work if one of these is a fixed-length character
> array, rather than a character pointer, as (for example) char[16] will
> always allocate a new string.
>
> By always using 'const char*' (the type strcmp expects), we're always
> just taking a pointer to the string, which works even with character
> arrays.
>
> Signed-off-by: David Gow <davidgow@google.com>

Aside from the nit that Daniel pointed out, this looks good to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
