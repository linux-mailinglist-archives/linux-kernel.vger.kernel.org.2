Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978AA35B144
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 05:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhDKDVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 23:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234950AbhDKDVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 23:21:44 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3403C06138B;
        Sat, 10 Apr 2021 20:21:28 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q10so6766130pgj.2;
        Sat, 10 Apr 2021 20:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qlSJc4t6k90L7rQgXSXEIV+HoVoS9K7iCRrH/b5iwoc=;
        b=kQOKCmXxKQW40XZNABhPOEFiB9swRFOF1apgrL3GdicdZPT7ZUsh9L2b26Aqtd1CR9
         6doqqA0afq4I2dZattSVzVYR7JgfGQv6ulGYxqYKVVDqOw0L5hzLMqi7sbxbW5bVmqCl
         A3OSM44MEN39B0ihmy5nfs60pxI64cqIUAeI0tYC/b7zdzPP1YxzBmVojhraKaCHorW6
         SlyFDkIZB4ptDv1jAIWTlwsyjhFAls9+bv8pZA314nyK9uLHRl5vRBdU1BgR7hrmpGTb
         gKz17uX5KM/NjPe8bon2t3e+P0VSP5gmbp4X9oE6JG3mJX/kHkJtb//ijHnD7nT2bFFj
         Nu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlSJc4t6k90L7rQgXSXEIV+HoVoS9K7iCRrH/b5iwoc=;
        b=aH5+Ox34ne7BBqczrIrL0FiuLtJQNFZWLWD2kuWIN0GHKxCSpFoOhIU40VbLcDpbRf
         hcU3GtvB+/aUP9G2xTiFp4IyFFZhqP7+6obkkdiaAUkOG5MkcZdMqe8LAZqkT7epbsEO
         LBQmZzYOIzKUcWDdWaPEfF4ScywjelsPfLFuDwOMC3Gq/jcIYhxa6ZXvvbrstdlalaIH
         f4gAG6pIuoE5D2/EGudrDF/pTzWa0Q4iCYAuVH8BgxVSrxRedCSWztH/apptABYnsugV
         shDoN7VuxqZ32N9AT3N7OI0Vk+1WuPs65HF8vo3DFA+hOpUxQC+RJnvevjz2nMempbVJ
         zjtQ==
X-Gm-Message-State: AOAM533VWlPekgm2Zo4REg9wal1v8KdRKbLZKWVVxIcRv+7H/GiMakrU
        mR5qRHZZr7EvB/8/WYx72ro=
X-Google-Smtp-Source: ABdhPJy5kyvV279co0pNS7BO6amqd9zlv1DLLe/ioBFUSVUwvKOFTiapaYad9fnr9QKhGU7Ks6kMRA==
X-Received: by 2002:a63:cb44:: with SMTP id m4mr20435373pgi.4.1618111287958;
        Sat, 10 Apr 2021 20:21:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a9b4:ff60:6655:5c5f])
        by smtp.gmail.com with ESMTPSA id t184sm6768597pgt.32.2021.04.10.20.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 20:21:27 -0700 (PDT)
Date:   Sat, 10 Apr 2021 20:21:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 4/6] devres: handle zero size in devm_kmalloc()
Message-ID: <CAKdAkRRRyC3x39CDRq_3ur1=MWuUug6ov-NWmSBc3h+XyRcsgQ@mail.gmail.com>
References: <20200629065008.27620-1-brgl@bgdev.pl>
 <20200629065008.27620-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629065008.27620-5-brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Mon, Jun 29, 2020 at 1:56 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Make devm_kmalloc() behave similarly to non-managed kmalloc(): return
> ZERO_SIZE_PTR when requested size is 0. Update devm_kfree() to handle
> this case.

This is wrong if you consider devm_krealloc API that you added. The
premise of devm_krealloc() is that it does not disturb devres "stack",
however in this case there is no entry in the stack. Consider:

	ptr = devm_kzalloc(dev, 0, GFP_KERNEL);
	...
	more devm API calls
	...

	/* This allocation will be on top of devm stack, not bottom ! */
	ptr = devm_krealloc(dev, ptr, 16, GFP_KERNEL);

And also:

	ptr = devm_kzalloc(dev, 16, GFP_KERNEL);
	...
	more devm API calls
	...
	/* Here we lose out position */
	ptr = devm_krealloc(dev, ptr, 0, GFP_KERNEL);
	...
	/* and now our memory allocation will be released first */
	ptr = devm_krealloc(dev, ptr, 16, GFP_KERNEL);


IMO special-casing 0-size allocations for managed memory allocations
should not be done.

Thanks.

-- 
Dmitry
