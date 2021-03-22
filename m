Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5499C344CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 18:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhCVRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhCVRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:05:16 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A97C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:05:11 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x27so9001038qvd.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edxiajj3pRs/T67JjKnnNu8jS6uH/jxSLcgetS/152k=;
        b=lmUJKKcr5fwHsvwxbmTJiLXqr3KMnghgEokc5CtfneaAi4MoijJYSE3OCkVWnCgFqe
         u7EDtki7hnxQsBdjx96G9NCYraX+R5cL/jIGYPr9oXPPXR3djdJA6BhAPfcM3ymATyLx
         NxlwTpErCk2IWszGDaspRUYC00EIJX5VvwIFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edxiajj3pRs/T67JjKnnNu8jS6uH/jxSLcgetS/152k=;
        b=CQVm8yAIlIcgGLa/pjB2BGjbvt9c/itv6+mszrgj1/rfmqOnS2ij3P6JYaGB5rjEa7
         1kt+5FHf5361gXnIntvSEE4+oY6AdCLQVmdfIonSvVlD4WhIKkNEH56XjK4e2BYZijWU
         qjhvjY2O6JGIaSMNc242ZzkU0J8Zo7AK7/9QMgcvp3ecHf+ygEYmJwvk0tvK+FFzXoUs
         F2jQZcyaQlE0bGmfXe9POFoEbcmsSj1ZrU6uG+QYXfZa+JgI2WJlEZYG8lQRrPQXLDpM
         PbJODTq1nfDSnXUN8r5GIjDOcj9BdXFxVPMO6Cq7ULVSXuODqfjxAp19DQSGE2Z7CodT
         Lmaw==
X-Gm-Message-State: AOAM531m6/k6OMpAELYEz7JJTU+Tyniq6ywojcs4WDEAw2zUxtMVg9H3
        k3GrkDcP42/MNico8Pa/Lcd+PMJ4NqqTuA==
X-Google-Smtp-Source: ABdhPJyW74Y+74Go7XDos3K9adFTTAZE04qmftJTAW9yaVBwxnaKFZASARNBSUO/ZKPlI5A3NThL+Q==
X-Received: by 2002:a05:6214:326:: with SMTP id j6mr577173qvu.13.1616432710425;
        Mon, 22 Mar 2021 10:05:10 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id q125sm11313555qkf.68.2021.03.22.10.05.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 10:05:09 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id m3so7345791ybt.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 10:05:09 -0700 (PDT)
X-Received: by 2002:a25:3741:: with SMTP id e62mr583491yba.343.1616432709363;
 Mon, 22 Mar 2021 10:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210322164308.827846-1-arnd@kernel.org>
In-Reply-To: <20210322164308.827846-1-arnd@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Mar 2021 10:04:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WY6yxx+vkH+UU4VYei29xBftdnyRBE1OpEELmJ-kLfFg@mail.gmail.com>
Message-ID: <CAD=FV=WY6yxx+vkH+UU4VYei29xBftdnyRBE1OpEELmJ-kLfFg@mail.gmail.com>
Subject: Re: [PATCH] kgdb: fix gcc-11 warning on indentation
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 22, 2021 at 9:43 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> -#define v1printk(a...) do { \
> -       if (verbose) \
> -               printk(KERN_INFO a); \
> -       } while (0)
> -#define v2printk(a...) do { \
> -       if (verbose > 1) \
> -               printk(KERN_INFO a); \
> -               touch_nmi_watchdog();   \
> -       } while (0)
> -#define eprintk(a...) do { \
> -               printk(KERN_ERR a); \
> -               WARN_ON(1); \
> -       } while (0)
> +#define v1printk(a...) do {            \

nit: In addition to the indentation change you're also lining up the
backslashes. Is that just personal preference, or is there some
official recommendation in the kernel? I don't really have a strong
opinion either way (IMO each style has its advantages).


> +       if (verbose)                    \
> +               printk(KERN_INFO a);    \
> +} while (0)
> +#define v2printk(a...) do {            \
> +       if (verbose > 1)                \
> +               printk(KERN_INFO a);    \
> +       touch_nmi_watchdog();           \

This touch_nmi_watchdog() is pretty wonky. I guess maybe the
assumption is that the "verbose level 2" prints are so chatty that the
printing might prevent us from touching the NMI watchdog in the way
that we normally do and thus we need an extra one here?

...but, in that case, I think the old code was _wrong_ and that the
intention was that the touch_nmi_watchdog() should only be if "verose
> 1" as the indentation implied. There doesn't feel like a reason to
touch the watchdog if we're not doing anything slow.

-Doug
