Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8CE428389
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 22:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhJJUeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 16:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58380 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229679AbhJJUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 16:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633897938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A2WM23iKfyJKBW5KrpSSOzCQTAjIwd99n6oiaQ5fc7c=;
        b=FO8b/dwDrIyIJ87PhbhlNpQMJVPltxwrWtVBog+sVn0vZEpRehw1FOaEv+rw3sL9MKV0Op
        kavakeip+JcFVjnBmlC4BrgbtP8MfPUG3vF5y+KFYGN1eYhz0ROMCLWNBUDnyL4UckEcuv
        j5qe8HmNdw1Tw3WIBQfEqFKDD4ntF1E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-Wmt5NUUoP1ygNRO9LJaNMA-1; Sun, 10 Oct 2021 16:32:17 -0400
X-MC-Unique: Wmt5NUUoP1ygNRO9LJaNMA-1
Received: by mail-ed1-f71.google.com with SMTP id h19-20020aa7de13000000b003db6ad5245bso5293751edv.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 13:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A2WM23iKfyJKBW5KrpSSOzCQTAjIwd99n6oiaQ5fc7c=;
        b=zKw1lY+0zgPK+9UJqUXxsq3mH6U0XomzvI1sfSYV5B7ils1UbA8BaKeOhk88XxPiX8
         c5WvOFn4ayt4B1MO/o4AYSLl1Ypc0V3t46kPMWBLX8xs0Oo8ih/Jr6QQG2Fd+U7Dwj7S
         LFavLiy93p2KRF6x6j4oYOr/ppbo5gwlVpr6IAmZkn2zQDpScZhCjrLXiYv/yhC00XwE
         BuCi9NX/8JI0uxjeEPOR6TDQ8JwJs7ouHYajUmywAHCUtfjwgrdk2ptORFlA1WxFwrnC
         EcY4euTGcbyQzyl0q+WLSwSJ1MlRxxRQ9ll+Cpy0vvoJuDTja8xknroIOG/XmDzHJ/2R
         y/vQ==
X-Gm-Message-State: AOAM533UE/waiGtuaRxg7Yu/cD0068EAl4Dt3bFvcqr8XKv3c7QW2OUE
        IS91zoXEwCSiihzgJTSzWr4gSzNII0pQmT+8XUaqkK3uT7YfSwowhg6KndtGS/qxVYcpS66RudR
        EdjVxrk6vH4H5ZVqQTZeI/hFD
X-Received: by 2002:a50:cc03:: with SMTP id m3mr35811807edi.278.1633897936552;
        Sun, 10 Oct 2021 13:32:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxL7oBHZT4EcrkFGCpdMbmkraoKZo9lhc/TO0YYTZ4dl04QSDgY9HzrEdv4Q8hLpZ5R3ywDkA==
X-Received: by 2002:a50:cc03:: with SMTP id m3mr35811794edi.278.1633897936456;
        Sun, 10 Oct 2021 13:32:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bj21sm2491946ejb.42.2021.10.10.13.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 13:32:16 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] ASoC: Intel: bytcr_rt5651: few cleanups
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20211007170250.27997-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0a74d8d1-2f36-18dc-56a3-4e5033dcab85@redhat.com>
Date:   Sun, 10 Oct 2021 22:32:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211007170250.27997-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/21 7:02 PM, Andy Shevchenko wrote:
> The small set of cleanups against bytcr_rt5651 board file.
> 
> In v2:
> - added commit message to patch 2 (Joe, Pierre)
> - added cover letter (Pierre)
> - added Hans to Cc list (Hans)
> 
> Andy Shevchenko (4):
>   ASoC: Intel: bytcr_rt5651: Get platform data via dev_get_platdata()
>   ASoC: Intel: bytcr_rt5651: Use temporary variable for struct device
>   ASoC: Intel: bytcr_rt5651: use devm_clk_get_optional() for mclk
>   ASoC: Intel: bytcr_rt5651: Utilize dev_err_probe() to avoid log
>     saturation

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

