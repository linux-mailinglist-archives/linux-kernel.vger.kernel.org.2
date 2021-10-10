Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0A428388
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 22:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhJJUds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 16:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230364AbhJJUds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 16:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633897908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qM1+noO5f6Akmfg35oCrKfVl0X/R5UrRZVOAH+twLU=;
        b=Nz2isOhHcK1qP8knVqiVKcPDH8xKzC8ktuDK5bqQcg3NRaRFAMTmJ491p2kSwlBNQKz9Xu
        ks0xEtOjEp4mtqfBhE2Qfb1FNR8tj0YZMtMpLOWftHne+WOdYNGOeNHPOC/4myBhuTQ06A
        dUyNGleF4IidSjj4PMIZQtlepViP5E0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-McIpeXZhO56gBn5DCwOhew-1; Sun, 10 Oct 2021 16:31:47 -0400
X-MC-Unique: McIpeXZhO56gBn5DCwOhew-1
Received: by mail-ed1-f70.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso13886969edf.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 13:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2qM1+noO5f6Akmfg35oCrKfVl0X/R5UrRZVOAH+twLU=;
        b=u792HmyQ952HeCKGdpVrNgoei02QVg6Ps/xBIkIOdAtOni08VlfsVBJRJPlo+11+gv
         /7ePPJTas7R1z+Y1LhDQgkUxR0b/XUuXnABxjKCpnVG3uHtdBYzbggMKQSHPeijceJHE
         YBZjPLiJFK8iBDxsgi+0UfsIfxF01ExWmkW4nkEEMX+mmdOqERs6GnlbeNBPuqmG+/63
         r6k9Wm5y+I3qZyqp7QeWg49KVrF8nloYG39i6NGHWs26GXNCwIr+b7Lt8X1sNkGKME3k
         npu3f6fBq1dYqwuBio50cW0b43DrCTj5KdYMDuwMvd5yzNLXsNes+jZDyH8ghHodNwgY
         2egQ==
X-Gm-Message-State: AOAM531K1PvtMn9N4ZlnVYhZBZyNOnfxcqPOjTArvqZ4fwlgoR2l+ThA
        /1m/8CrIhN+XLnLyKnayNU18wHLMk21FTfL0PEk4dwAkGs+wZ9XRXu+jR7hQUScgzEn1I0OuoWG
        nFSc7wuzLbRpuUx3JnKay7co7
X-Received: by 2002:a17:906:3402:: with SMTP id c2mr20436907ejb.271.1633897906092;
        Sun, 10 Oct 2021 13:31:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsTCCJeD2sHdcAkCoRgmD8hDM8YIZg1nI86MOfu7KCKbmw811KDl5Bmy5Uquq3ELP7Z4sudA==
X-Received: by 2002:a17:906:3402:: with SMTP id c2mr20436898ejb.271.1633897905961;
        Sun, 10 Oct 2021 13:31:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p23sm3087111edw.94.2021.10.10.13.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 13:31:45 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] ASoC: Intel: bytcr_rt5640: few cleanups
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20211007165715.27463-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3219a8c9-a9c8-25a9-95df-9aa5dbdf6815@redhat.com>
Date:   Sun, 10 Oct 2021 22:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211007165715.27463-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/21 6:57 PM, Andy Shevchenko wrote:
> The small set of cleanups against bytcr_rt5640 board file.
> 
> In v2:
> - added commit message to patch 2 (Joe, Pierre)
> - added cover letter (Pierre)
> - added Hans to Cc list (Hans)
> 
> Andy Shevchenko (4):
>   ASoC: Intel: bytcr_rt5640: Get platform data via dev_get_platdata()
>   ASoC: Intel: bytcr_rt5640: Use temporary variable for struct device
>   ASoC: Intel: bytcr_rt5640: use devm_clk_get_optional() for mclk
>   ASoC: Intel: bytcr_rt5640: Utilize dev_err_probe() to avoid log
>     saturation

Thanks, the entire series good to me, this one I've also
given a quick test-spin, so:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

For the series.

Regards,

Hans


