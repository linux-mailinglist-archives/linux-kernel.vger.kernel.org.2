Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC3E368756
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238966AbhDVTlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236668AbhDVTll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619120466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6s69Vc1JVO1C/KitZXv6PHxtifVMVmdc7g9HprfJ1I=;
        b=cX9QNBKBz2ddEoNIIplRpZHu7kT5OHZcjRZhYrzpckmwTe/QNLpb0saUx1Gloakz89ZPhU
        1FRfCA7a7aYsAJWmcPPZasyFBHkYXwBDT0jYwQwytZPNI8kDpP6lpszhHWW5/EkbtTdhd3
        Vo8IvdNvpBi6Jx0k/f4FCTRriYZwO08=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-H_9A9vDIP5-r92gcB3cgIg-1; Thu, 22 Apr 2021 15:41:01 -0400
X-MC-Unique: H_9A9vDIP5-r92gcB3cgIg-1
Received: by mail-qv1-f70.google.com with SMTP id e20-20020ad442b40000b029019aa511c767so16651009qvr.18
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=k6s69Vc1JVO1C/KitZXv6PHxtifVMVmdc7g9HprfJ1I=;
        b=bnnNRhtxo4lp18uikDJ8RjcoYMWKz2YEp1yc0PCB1DB5YKbVZqmY0NJfJg8VDP6Pm6
         gsSKJjUqmb02i17HgdFi23je0yytEqoZxa/Fdn596SCz7I5u3mMVUqggDv+4K2+SCQZc
         dive77FwSz3gAQ2JKxUdTUUjkw95hWb5lcceAeGFzBUbOqCiIZ0MxVaAb0TAINseK+es
         5UhSN4WLSPxOzZQSg6nv6S0WUql1nCjwazJnNYAyFZvoHsvfuZY9xZ3D+vU9nOVAo4Bn
         QNY0S5ZtSRZAeZJEXdJ4guGWpyOKeIpl/dKFDvzAivpN/ntMKooQOKdB+vELtj9KHxoB
         cpKA==
X-Gm-Message-State: AOAM531OEWGmYlZQ7MEFoHJDr8uYFOBFpvHc2eJ0zlJbVAXKxCr+8bwg
        KmyX8zpX7fABi0Cx6bz5iwIEVSrBcbwtHu8XexvEza1qRC+16VfRDDMdGsfG1HZDpayZjLK2gK4
        pyYt0T7l/puECnaotnK+RZn/0
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr124883qtx.98.1619120461126;
        Thu, 22 Apr 2021 12:41:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw26o1fq4SUq8AjaV9A02QdlXMa58WsaWpt61xtbPijGtt+MgJTuq0edRMBFLJwGY3H0rmZZA==
X-Received: by 2002:a05:622a:486:: with SMTP id p6mr124872qtx.98.1619120460991;
        Thu, 22 Apr 2021 12:41:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:417f:70c0::42e6])
        by smtp.gmail.com with ESMTPSA id a63sm2838849qkf.132.2021.04.22.12.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 12:41:00 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] bits: Add tests of GENMASK
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        akpm@linux-foundation.org
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com,
        geert@linux-m68k.org, keescook@chromium.org,
        linus.walleij@linaro.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com
References: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
 <20200621054210.14804-1-rikard.falkeborn@gmail.com>
 <20200621054210.14804-2-rikard.falkeborn@gmail.com>
From:   Nico Pache <npache@redhat.com>
Message-ID: <935a7b98-ab4c-15af-3bf0-aa7c1f9de068@redhat.com>
Date:   Thu, 22 Apr 2021 15:40:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20200621054210.14804-2-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Where is TEST_GENMASK_FAILURES being defined? This fails when compiling this

test as a module.

Am I missing something here?

Cheers!

-- Nico

On 6/21/20 1:42 AM, Rikard Falkeborn wrote:
> [Snip...] 
> +#ifdef TEST_GENMASK_FAILURES
> +	/* these should fail compilation */
> +	GENMASK(0, 1);
> +	GENMASK(0, 10);
> +	GENMASK(9, 10);
> +#endif
> [Snap..] 

