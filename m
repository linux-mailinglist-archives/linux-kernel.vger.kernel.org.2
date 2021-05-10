Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC33637907E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbhEJOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:20:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46547 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbhEJORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:17:50 -0400
Received: from mail-qk1-f198.google.com ([209.85.222.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lg6iC-0004R3-TU
        for linux-kernel@vger.kernel.org; Mon, 10 May 2021 14:16:44 +0000
Received: by mail-qk1-f198.google.com with SMTP id d201-20020ae9efd20000b02902e9e9d8d9dcso11725015qkg.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 07:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ukmd8wC6iLxp/7DPQoRcUbb6TtLzWN0oan/ZP7duPk4=;
        b=B4GWIJbsLF3N411r+0XjTKCxYz4R6ZnMp+CvjmBblkie6HPXsRydPYv18DhaEH3lXM
         PoipY2FDzeFJrmb20XnsOKciGicx17UiibrTLH1tNVLJiqzhxGAHI9qVZY4DawS6dHfE
         ekHa7sxGcG0YiiTqsK+JgmO3sBIuisVSoZayXivURgFRSkVvH7lahkOgVckxe1SNeQ3p
         yZLU6rbPCuLZlQTTEYZ/HMBr74Z3NuH984jOr06aIqe3qsRaWAFmthj2FtxLTlmWodif
         PCbwUByq2A25MdMo/DMirJ+UdtK99Q23GmLgfvpxmlCv3pM7vkeCqNlAg+mUGty//vTM
         4w4g==
X-Gm-Message-State: AOAM531D2uZjtZBOBPuD68/q2sjDfzPC8ib0z+PkwnJQAcXj93q+laAX
        axddHivcL3c47PUZNqel2lKEbTdUCelEaWgaGy4y/oUbHUfbaubXyBChOzKro9C98vXFUeCzq3x
        TVt9KjoI+Ux/nbCV9cSQGzfbSs+y5xAnBBEzqR1a02A==
X-Received: by 2002:ac8:c83:: with SMTP id n3mr23504101qti.236.1620656203837;
        Mon, 10 May 2021 07:16:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQeo0X1p3WiWb5qrb2jIVaXtKJGusaDV3N4JyOja6HHUNTyj9kaEL6pc4uflhq+3ssxbwb0g==
X-Received: by 2002:ac8:c83:: with SMTP id n3mr23504079qti.236.1620656203675;
        Mon, 10 May 2021 07:16:43 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.49.2])
        by smtp.gmail.com with ESMTPSA id a26sm12582883qtg.60.2021.05.10.07.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 07:16:42 -0700 (PDT)
Subject: Re: [PATCH 3/4] extcon: extcon-max77693.c: Fix potential work-queue
 cancellation race
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
References: <cover.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
 <e83fe8359b6b6dfcb0cbc18e8c3efd653971dd44.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <dadb758c-6130-d2d2-0581-23c33e699574@canonical.com>
Date:   Mon, 10 May 2021 10:16:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e83fe8359b6b6dfcb0cbc18e8c3efd653971dd44.1620633360.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 04:12, Matti Vaittinen wrote:
> The extcon IRQ schedules a work item. IRQ is requested using devm while
> WQ is cancelld at remove(). This mixing of devm and manual unwinding has
> potential case where the WQ has been emptied (.remove() was ran) but
> devm unwinding of IRQ was not yet done. It may be possible the IRQ is
> triggered at this point scheduling new work item to the already flushed
> queue.
> 
> According to the input documentation the input device allocated by
> devm_input_allocate_device() does not need to be explicitly unregistered.
> Use the new devm_work_autocancel() and remove the remove() to simplify the
> code.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Please note that the change is compile-tested only. All proper testing is
> highly appreciated.
> ---
>  drivers/extcon/extcon-max77693.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 

Seems correct:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
