Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1A3D9DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhG2G7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:59:07 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:46502
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234079AbhG2G7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:59:06 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id C55203F22A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627541940;
        bh=wgSGi39fr5nLY0RGz51HyBillidzyYTFsor+uOU3rSk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=B/hQJAf2mdTJds0dgKGzQG2+m65UmXITt7xJdH6d0fB1O4oBam9Rf2devuyyRdjjs
         chWuZWGhyE/PAdKfZjFMrQSTCXUPaJPviidPuzLLoC1yfTL4Hn750K5VtHLdPnwd2s
         uF3eSLScOie+MqXwvAVYP6itjbBtbS2vFScc5kn875ZfUWSUNz12MCrEkj0ECa3MhF
         NyvhI3MPO1oXlN/3mYEkgQ147xalw2ru9LTVDbSiZqrbViANJO94u+qrKFr2QkKHsH
         SyLiF3JWx9pQq6859zZ94e6NZhFHICHKqlgUjtdd6Rgz+DtMFPL9rToZUs7PfoXZXh
         J6VrWOgiLimOQ==
Received: by mail-ed1-f69.google.com with SMTP id b88-20020a509f610000b02903ab1f22e1dcso2464697edf.23
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 23:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wgSGi39fr5nLY0RGz51HyBillidzyYTFsor+uOU3rSk=;
        b=qTpq2w/k6eQmZqZCJrnFrlVxJP6j3XypDd3hwqltjdR9rGwwbT2Z9vrnmaXmvsnB/f
         F+rYpBAgULGQXV6C5yI/DyglRrvsSa20tveQ5TSUMnyySU5qldmcdiRDCB01W9cujEko
         lw64VTZLLmS+1kb4zy2n5kMv9dk+RnzJlUmSs1xbZzNHzrtqK9NhJ0HI5Pna8PBkCzOt
         pExQmRrkpsFvZ91QuwRc8K+vGYawP+CfdyMR+5i6X7kVDkLTQm0IRjc1UhiYuD4IBpL0
         9SOOejql8SKU/cuZ0R12taytWGDfMgcHM/KPNe2CHYIoTqTrxvPQVxgDoicTaC+qT/jk
         DOag==
X-Gm-Message-State: AOAM533BsHOlPuZ+DQBsqnBXs07duvXzi3ZrOb+JG7LBlJ5t/fAWFKBJ
        hnX3YtsbC3BhTkkHCsnKIM0Tx/LdrRzM/LQcAhh9gOpZ3ohg+x+a/e8UWeEj9od0Em5VbDZNX30
        085TSb6cxXr+T4T6Ip0C07rgIyzbJAphw5NHZBHsFJQ==
X-Received: by 2002:a05:6402:289b:: with SMTP id eg27mr4469626edb.90.1627541936312;
        Wed, 28 Jul 2021 23:58:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoaHmIDscS1JudoyHTTam6xSzSzbWI306CXe2m56uOvV912dNGIdzbln0GsnAeansSxYhDsg==
X-Received: by 2002:a05:6402:289b:: with SMTP id eg27mr4469618edb.90.1627541936176;
        Wed, 28 Jul 2021 23:58:56 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id e7sm627732ejt.80.2021.07.28.23.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 23:58:55 -0700 (PDT)
Subject: Re: [PATCH] ASoC: samsung: Constify static snd_soc_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20210728172548.234943-1-rikard.falkeborn@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <f78b45f1-11e8-e1c3-3095-aca32de9fad1@canonical.com>
Date:   Thu, 29 Jul 2021 08:58:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728172548.234943-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2021 19:25, Rikard Falkeborn wrote:
> These are only assigned to the ops field in the snd_soc_dai_link struct
> which is a pointer to const struct snd_soc_ops. Make them const to allow
> the compiler to put them in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  sound/soc/samsung/aries_wm8994.c   | 2 +-
>  sound/soc/samsung/arndale.c        | 4 ++--
>  sound/soc/samsung/h1940_uda1380.c  | 2 +-
>  sound/soc/samsung/littlemill.c     | 2 +-
>  sound/soc/samsung/midas_wm1811.c   | 2 +-
>  sound/soc/samsung/neo1973_wm8753.c | 4 ++--
>  sound/soc/samsung/rx1950_uda1380.c | 2 +-
>  sound/soc/samsung/smartq_wm8987.c  | 2 +-
>  sound/soc/samsung/smdk_wm8580.c    | 2 +-
>  sound/soc/samsung/smdk_wm8994.c    | 2 +-
>  sound/soc/samsung/smdk_wm8994pcm.c | 2 +-
>  sound/soc/samsung/tm2_wm5110.c     | 6 +++---
>  sound/soc/samsung/tobermory.c      | 2 +-
>  13 files changed, 17 insertions(+), 17 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
