Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC154191E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 11:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhI0J6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 05:58:31 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39834
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233717AbhI0J62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 05:58:28 -0400
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8B47A4079E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632736610;
        bh=8izaMMzdZFyOj97+0PH0WvhjiKv4VMQW7lnH7kNs5mE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=P8IksPXWNPx7+KgWU7P8ObsC8raaz6/3+4uTi8oVC8IblUuB5FBJIiNisQMpmj52U
         6Ei6HGl46pIwyZJP15h68wiW/oUq1bn44dyNFBcYv/9vBogR54cHHX6D8enECxPytF
         Q84ORN7L0tf10h1SqrALz1aSuDAW+FP9065O18pKofMCRo0Y7ILeGVfT/QCUYa3Bjz
         vacyRBvZASZNPrIJPf7+aHHYtC0j7JciotFu4KXvHzXT5vyVc5VE4oITFQT45ozL4j
         PfkCO2CIh260950rzHyE92rx9YVP+cYTgodl0O6AvPXbFFqfLAua7h7Gv6FjTBA1ql
         a2Yu9QFEqjnxQ==
Received: by mail-lf1-f69.google.com with SMTP id d16-20020a056512369000b003fca9e038ddso14162613lfs.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 02:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8izaMMzdZFyOj97+0PH0WvhjiKv4VMQW7lnH7kNs5mE=;
        b=aBV3NngAyQ/CPi4EQpMIfWL8Xa+sKPxisg6dll3RQD1UV41y0sVRze/+Iut7R0wN5+
         v6/ObskG2y4Ag/GXiQkFul0S55/0pnik6eankAKYsq7zEr0hxqzNsgNVKTZEXuV8FKbO
         +C38/ZXgLOH6LJo+M09/G2iQ55VUkDTl7sgU+ikuShCdevSv7RNcdA+xZDjseSm2JbSp
         oJFVBLP7ajb7eUYouiCacSk/3eG4l7ta6YMlvITTXUwUkJMg6ohDJsLhTzMM6I+Gn/dW
         gAhYzMn3N45HPHPehi3sKPNth0mH8TR5/IiiLQ/Muv7VWo1LIa+vfawCIedVQCvogt6O
         Ix1g==
X-Gm-Message-State: AOAM532GnDx4K2OcHaYTCWVglBrNB+AGTyyNwVzJabXyW2xw2NCA8R6x
        o1LIrqLbMpw540ufGPx3u7qZj7xpdE0LZILxJ5Asgt3vEfG180B9WT1ZpJoGfm4LZ34bGriPDqY
        oo0MulAOOsCkmPlia8jvfskQEaXfzGgpNz9NhYOgC2A==
X-Received: by 2002:a05:651c:21b:: with SMTP id y27mr27717121ljn.489.1632736609659;
        Mon, 27 Sep 2021 02:56:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsalFADlVVVTu6/XTNSAKB3HNcwAnUH9lAMPjtuA1GXtlKiHFEQOe/tRpUNI0FkSI2EPyMRA==
X-Received: by 2002:a05:651c:21b:: with SMTP id y27mr27717103ljn.489.1632736609508;
        Mon, 27 Sep 2021 02:56:49 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a7sm1078846ljp.21.2021.09.27.02.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 02:56:49 -0700 (PDT)
Subject: Re: [PATCH] ASoC: samsung: add missing "fallthrough;"
To:     Arnd Bergmann <arnd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210927095449.1070639-1-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <bb24d3b0-aa8f-3649-1837-3b8f43ef7e0f@canonical.com>
Date:   Mon, 27 Sep 2021 11:56:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927095449.1070639-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2021 11:54, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With gcc, we get a warning in this file:
> 
> In file included from include/linux/io.h:13,
>                  from sound/soc/samsung/s3c-i2s-v2.c:16:
> sound/soc/samsung/s3c-i2s-v2.c: In function 's3c2412_i2s_trigger':
> arch/arm/include/asm/io.h:92:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
>  #define __raw_writel __raw_writel
>                       ^
> arch/arm/include/asm/io.h:299:29: note: in expansion of macro '__raw_writel'
>  #define writel_relaxed(v,c) __raw_writel((__force u32) cpu_to_le32(v),c)
>                              ^~~~~~~~~~~~
> arch/arm/include/asm/io.h:307:36: note: in expansion of macro 'writel_relaxed'
>  #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
>                                     ^~~~~~~~~~~~~~
> sound/soc/samsung/s3c-i2s-v2.c:398:3: note: in expansion of macro 'writel'
>    writel(0x0, i2s->regs + S3C2412_IISFIC);
>    ^~~~~~
> sound/soc/samsung/s3c-i2s-v2.c:400:2: note: here
>   case SNDRV_PCM_TRIGGER_RESUME:
>   ^~~~
> 
> From all I can tell, this was indeed meant to fall through, so
> add "fallthrough;" statement to avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/soc/samsung/s3c-i2s-v2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
