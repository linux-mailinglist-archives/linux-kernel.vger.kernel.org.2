Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505B940EAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhIPTfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:35:54 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:35684
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233137AbhIPTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:35:52 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2F2A63F324
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631820871;
        bh=mgBzE1LccxDYj5lbzdu52/SrN6CKyxSxvBGDAYwYTWI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=WYa3jIdFfHHDaIqWoxrhoIi2nB6gb6Ba3h/z1corXHEKrd2Mx6KByS6i+/1WtQbSm
         HqyT50xrwmQ686OhP9EtL433gv0aO7G0rN+ILwtS69cuyqqr/UREz6UbD2ZC2bTZZ7
         qo9Xa07m2aLYIOcVf7JOj5usjxKGmUwyWcGLFrzufmrHLl6afuxI9esPQCjin6uvlo
         8Ubsq0aWc8HCOO5OfKuMqV0IgpcjO+HHZYN3abG8CbBQPOuDvFN+83LuzDNzGR33aX
         gRSwjHJsIQ1NImQQ+2e4t9uBR/t+3KfxCCsLvW1AF7cALwOX6zKMzyLy7sSDiePG3L
         fSFVZW+rjPfug==
Received: by mail-wr1-f71.google.com with SMTP id j1-20020adff541000000b001593715d384so2824612wrp.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mgBzE1LccxDYj5lbzdu52/SrN6CKyxSxvBGDAYwYTWI=;
        b=y5Oa7jqbP5pBpMTsVJAuO4Yzi/NDYKF1eS/rn3uUk739pvnjqSMZLBmizepfeBOTG2
         hn/hxdL4gSAGYIrfOqSwrjqtF3F/yCRP/82kne+cymh5BvpURapDN6KM9EMtkLxDdlmp
         /olgcNIlKh3lF/5zdAahKryeNfwSUX5UIebtJRKZPazQtW26dcSC5L+qlgd8c0wVbXw+
         TVhDn0xTelSMUucDG4FSvwOX06qIbWdZ2leADlWKFtW0Wnj0hr6GyIHa9HWUJ4abRtFb
         t6PJSEdH/YzT0SaYBJD1fOwL7p9Fi5k6wjXuGtC6BFIx2W7qhRzSRi2NsLnlJhs9df4M
         YZWg==
X-Gm-Message-State: AOAM530f2Qc3BJDqj7eXuGlGmV8fWT4G0IkRvuUW0G5855y4VvKjO3fN
        Qd0IWKdtc8qa7z6CWMYG34U1iuaWCPEeBZ7HfHpbnZ0NB3VuAtsFCStpeUdqB5HoI/sRl5+SsQE
        80sFI3te0JkGn+EFJUu4JiuGYbl+gdTjOLiM4waXl4w==
X-Received: by 2002:adf:c7d1:: with SMTP id y17mr7857893wrg.214.1631820869952;
        Thu, 16 Sep 2021 12:34:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf+0GFj++u7lbh268H6UF7ugAOIgIOijp92MKCOwUmdhzxURij/a+4xLLMmGgonQR4a46H6w==
X-Received: by 2002:adf:c7d1:: with SMTP id y17mr7857885wrg.214.1631820869817;
        Thu, 16 Sep 2021 12:34:29 -0700 (PDT)
Received: from [192.168.2.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l19sm4284252wrc.16.2021.09.16.12.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 12:34:28 -0700 (PDT)
Subject: Re: [PATCH] Input: ads7846 - Make use of the helper function
 dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210916153104.13727-1-caihuoqing@baidu.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <922265b2-bed7-8daa-3132-8cfc3b5e50fd@canonical.com>
Date:   Thu, 16 Sep 2021 21:34:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916153104.13727-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2021 17:31, Cai Huoqing wrote:
> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/input/touchscreen/ads7846.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

You sent 32 independent patches. Do you expect us to copy-paste similar
feedback on each of them? This would not make any sense. Please organize
all your submissions in a series with:

  git format-patch -32
  git send-email ..... 00*

The patches you sent were already sent before:
https://lore.kernel.org/lkml/20200827185829.30096-1-krzk@kernel.org/

Best regards,
Krzysztof
