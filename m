Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B44C41B582
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242117AbhI1SAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241884AbhI1SAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:00:09 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55DBC061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:58:29 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so29997108otq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uR5PuPkKUKvfXK5EmQYWYaGFwQD6gS7xkf2w5Ej+K1A=;
        b=j0MstjStaBqnpbINZTrtCPXme32ur1Fotw9+yVfHNgjjVIkqcgJPE0P7zkOEbS0C5e
         4kVksbtGEi1Zxr6nimYR/l2YgpxX3XwBattDHmMW9Kuuk9tnzHmrY3qtRAgT86mvP2G5
         fdAWtTYs1Vx4rNweAdSXSW6lNJKM/x9KGDFepSqwVSxJQDGTPBNgQAs4/fMvjuD7SrjH
         ezOMpwwZjcyctLiQ7OXqX3LCpgV9tOpx3L+Z3iyt4yGBh5fM5lkfqLZ4I4hCzgxqTd7i
         HTa+fDhC6sbrC0UVlPdFrOxrWbGfdexWhohL75GSog5LegEJJIzRFphnlE2lHMCLiNim
         Vi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uR5PuPkKUKvfXK5EmQYWYaGFwQD6gS7xkf2w5Ej+K1A=;
        b=Qab3nazuBJlyIpTv6SzkbvYcZwmFbE2Pp72xvqej+FkGEXAzY+D4u0UFGHvOP1xl5r
         Qah9lp0MTEN3zO2ZXv/HveQNH/8U8v4Ur4pcQkQvuRhMrZc2M/l++/It5u0abm8K95Ij
         WfzamLdoN7Ch5YrFu3qKwUdydXhl+P0m1EjRzBnNC5xLGuSrU/njBhrWvt3axgUDGzJW
         NfC5If8FsZV4prTg5WeF320XIGVEAazsXb5M2Bn8R7RoL5g+UVqKvTtNlZRMc0v3W59+
         rI9ftn2XZGIHog13vxvmQ1xTu53AodGoWC69M7jtMAU5wGnGB+SuXf3INasYwbUmNqzG
         hKbQ==
X-Gm-Message-State: AOAM531NCa61BzpD4ibdLU9eLn07rQniqGVIB2YYFMiUXdqVmp2WB/eK
        N/vdZyTgbxKBajv2mKglrwzMb4aFb5xj/dlD
X-Google-Smtp-Source: ABdhPJyFZdU6lpvOXw+LZs11Myh1AgYn8nyQs+TzSh/UgyfeESrR431aGwkjyWoXYjjaKmU/14ehZw==
X-Received: by 2002:a9d:1913:: with SMTP id j19mr6412829ota.166.1632851909068;
        Tue, 28 Sep 2021 10:58:29 -0700 (PDT)
Received: from MacBook-Pro.hackershack.net (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id q133sm4158782oia.55.2021.09.28.10.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 10:58:28 -0700 (PDT)
Subject: Re: [PATCH] net: qrtr: combine nameservice into main module
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210928171156.6353-1-luca@z3ntu.xyz>
From:   Steev Klimaszewski <steev@kali.org>
Message-ID: <45b1b34a-b826-9516-d6da-1272e5384bd3@kali.org>
Date:   Tue, 28 Sep 2021 12:58:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928171156.6353-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/21 12:11 PM, Luca Weiss wrote:
> Previously with CONFIG_QRTR=m a separate ns.ko would be built which
> wasn't done on purpose and should be included in qrtr.ko.
>
> Rename qrtr.c to af_qrtr.c so we can build a qrtr.ko with both af_qrtr.c
> and ns.c.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  net/qrtr/Makefile              | 3 ++-
>  net/qrtr/{qrtr.c => af_qrtr.c} | 0
>  2 files changed, 2 insertions(+), 1 deletion(-)
>  rename net/qrtr/{qrtr.c => af_qrtr.c} (100%)
>
> diff --git a/net/qrtr/Makefile b/net/qrtr/Makefile
> index 1b1411d158a7..8e0605f88a73 100644
> --- a/net/qrtr/Makefile
> +++ b/net/qrtr/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_QRTR) := qrtr.o ns.o
> +obj-$(CONFIG_QRTR) += qrtr.o
> +qrtr-y	:= af_qrtr.o ns.o
>  
>  obj-$(CONFIG_QRTR_SMD) += qrtr-smd.o
>  qrtr-smd-y	:= smd.o
> diff --git a/net/qrtr/qrtr.c b/net/qrtr/af_qrtr.c
> similarity index 100%
> rename from net/qrtr/qrtr.c
> rename to net/qrtr/af_qrtr.c

Tested on the Lenovo Yoga C630

Tested-By: Steev Klimaszewski <steev@kali.org>

