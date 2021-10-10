Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BA4428387
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 22:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhJJUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 16:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34790 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231136AbhJJUdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 16:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633897878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29N8iJHpqEFBydQ2HyKe6nNjBksnkXsyb45rpziiGjY=;
        b=C5J/2kzWSxjh0ei5PH/xhwb/WBcbfMAgRBFAGPgHZIGEFkKwLhg6QJ1US4EDmZPCbLJh5e
        7frrU5H23du0Osx5w32xDJCN/0T/QLrvXU6KZMSlFqPE6Q81p69834gz0YscELwKG1m4E0
        t4CbMdxtt7eX3tKUhtql7taiTN3MYOo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-qIC5m5JTNMiecOI_qw0sjA-1; Sun, 10 Oct 2021 16:31:17 -0400
X-MC-Unique: qIC5m5JTNMiecOI_qw0sjA-1
Received: by mail-ed1-f71.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso13935532edx.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 13:31:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=29N8iJHpqEFBydQ2HyKe6nNjBksnkXsyb45rpziiGjY=;
        b=o3TYWFE32RSPC+L7cvBw4CULN1tElN7ja0QtppdH7mXJzrnih/dGT25HvK5bky5Nxb
         mIQlQhH1W3WV+2BL7/in152ugqA/yyvI/rRpwSODL79Rjbh1rlHAJ5jVFe42drWqIrLH
         2nHLG6U+M6LhvmXwfwcayyS/OLtrQ4A5F6B70slz/IqsWq1mhMhn2McHTYmH8WweHvHo
         +90i0K+ZvKPBwtZuBlDicX7Y0Idrh9ha04Z6n/ESdgvyHSfeGMvi3E3asWwzxXAQRSIO
         gN5ARXfpxyR3mzCsTMbtgDM+0rbgUl28IIFt/skUvi22dNBO9Mhr0XC8TeUcidSgYRWJ
         2O0A==
X-Gm-Message-State: AOAM532Sm7HUSF98ci3xwEsOe9yqpAT5uCdrnNHEurQjaJr5ajyfZRb6
        xRbPvNUImvk4q4r1uAKW3kmgSYELB7yw7Ys7sJGBLJyZub0wiYwFTz+LyNNENqmHmsn5IUS2bok
        UQljAh20sTr8gMZJODIfXHczX
X-Received: by 2002:a05:6402:268c:: with SMTP id w12mr34274685edd.376.1633897876330;
        Sun, 10 Oct 2021 13:31:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSECQrx1JCOn54lLBMRIQZgcaKJygbpxJ623VAkSBF5wUhroWcQi2nR6YXENQmfu4UFK2vBw==
X-Received: by 2002:a05:6402:268c:: with SMTP id w12mr34274664edd.376.1633897876184;
        Sun, 10 Oct 2021 13:31:16 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id v15sm2093119edi.89.2021.10.10.13.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 13:31:15 -0700 (PDT)
Subject: Re: [PATCH v4 0/4] ASoC: Intel: bytcht_es8316: few cleanups
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20211007164523.27094-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9206ba12-c69f-c638-31ed-9f15ca0e6587@redhat.com>
Date:   Sun, 10 Oct 2021 22:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211007164523.27094-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/21 6:45 PM, Andy Shevchenko wrote:
> The small set of cleanups against bytcht_es8316 board file.
> 
> In v4:
> - fixed Pierre's email (Pierre)
> - added Hans to the Cc list
> 
> In v3:
> - actually added a Pierre's tag (Mark)
> 
> In v2:
> - added tag (Pierre)
> - added commit message to the patch 2 (Joe)
> 
> Andy Shevchenko (4):
>   ASoC: Intel: bytcht_es8316: Get platform data via dev_get_platdata()
>   ASoC: Intel: bytcht_es8316: Use temporary variable for struct device
>   ASoC: Intel: bytcht_es8316: Switch to use gpiod_get_optional()
>   ASoC: Intel: bytcht_es8316: Utilize dev_err_probe() to avoid log
>     saturation

Thanks, the entire series good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

For the series.

Regards,

Hans

