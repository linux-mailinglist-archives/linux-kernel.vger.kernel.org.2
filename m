Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF134048C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhCRLYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229929AbhCRLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616066674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4iXOrVyMySTuoCrUgKSxCYUTZzujXDxpyIVUUHHpo6E=;
        b=amgAlwV3egMY0QbY70LT7E7kUukiiGJ6ed+0NOSo6BA6l7yTnxvQLgZ3qdcAF/alpunYP0
        tMuM9wJS0PX2RHWUPX3KEelIsLm3N6JBsd/ZThb2u76jSsPfh4pBvnfWgvayBHwXgbQgxY
        KL3OzlD3TbU5A0Vebf3tuhG4Awl6/QA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-KywU5bkaMJC4sTY-sctybw-1; Thu, 18 Mar 2021 07:24:30 -0400
X-MC-Unique: KywU5bkaMJC4sTY-sctybw-1
Received: by mail-ed1-f71.google.com with SMTP id bm8so7867533edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 04:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4iXOrVyMySTuoCrUgKSxCYUTZzujXDxpyIVUUHHpo6E=;
        b=Z9hA1wTIXef1QRp7CkTyXIR6IWba3AM9cQMfAUD1ngzE/GSSBKX21xmQAbfPGNG6DL
         MEqNdOM7LEsu4QnBsTpl2mvrrOmrRkxHfAJopXi0E1PrkKvrOsBhD7+3CWBN+CiA0m3J
         izN/5lcLuQZqmpm7BISGp9A0siI0yf7Q80lqj9jM4OlPU46OX0IRNQZoaHigxkGjz4/8
         NoCDJ0oQ+znXfi4uyIZPc3+xwEYn9O76z3OQBZMLq4dmfiRhIYilD77e1PObTv32pV1p
         wUSu9vpOAcRTT3f5mmruIC11r7VebBFXdfT/5eWeNKmg56bpaJw15EndDhGOhFyNbmu/
         fu/Q==
X-Gm-Message-State: AOAM531eiWOYRwTtTrwsrKRwhUj+Zz1wosD4ycUJWynhTI/C+JgBOzsk
        pKjkxTym+Rk8EAFNiJfnKfhD+bosUkoCiumJNSgbR+jQbOa2IwDY1K6p2g/4xdVaOlb8DRKS/NV
        uXSityTzQak2wDjBWzF4AASfq
X-Received: by 2002:aa7:df86:: with SMTP id b6mr3017834edy.294.1616066669350;
        Thu, 18 Mar 2021 04:24:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHuwfa/RMwxwdlj/Z414K7wfajD1biUO6xL/R+rKEsNZIXRlnhQS1xRR229+DDRcUCHGhNEg==
X-Received: by 2002:aa7:df86:: with SMTP id b6mr3017814edy.294.1616066669163;
        Thu, 18 Mar 2021 04:24:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r17sm1765538edm.89.2021.03.18.04.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 04:24:28 -0700 (PDT)
Subject: Re: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
To:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
References: <20210307151807.35201-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <433cda84-2d61-ccb4-155a-5f8fa1021c90@redhat.com>
Date:   Thu, 18 Mar 2021 12:24:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210307151807.35201-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 3/7/21 4:17 PM, Hans de Goede wrote:
> Hi All,
> 
> Here is v4 of my series to rework the arizona codec jack-detect support
> to use the snd_soc_jack helpers instead of direct extcon reporting.
> 
> As discussed before here is a resend rebased on 5.12-rc2, making sure that
> all patches this depends on are in place.
> 
> Lee, can you pick-up patches 1-6 through the MFD tree and then send a
> pull-req to Mark so that Mark can merge the Asoc parts throught the ASoC
> tree ?
> 
> Patches 2-6 touch drivers/extcon, these all have an Ack from Chanwoo Choi
> for merging these through the MFD tree.

Lee, is there a specific reason why these have not been merged yet,
or did you just not get around to these yet ?

As I already mentioned Chanwoo Choi already gave an ack for merging
the extcon patches through MFD, so AFAICT eveything is ready to merge
1-6 through the MFD tree, and then have Mark merge an ib from the
MFD tree and merge the rest.

Regards,

Hans



> 
> Here is some more generic info on this series from the previous
> cover-letter:
> 
> This is done by reworking the extcon driver into an arizona-jackdet
> library and then modifying the codec drivers to use that directly,
> replacing the old separate extcon child-devices and extcon-driver.
> 
> This brings the arizona-codec jack-detect handling inline with how
> all other ASoC codec driver do this. This was developed and tested on
> a Lenovo Yoga Tablet 1051L with a WM5102 codec.
> 
> This was also tested by Charles Keepax, one of the Cirrus Codec folks.
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (13):
>   mfd: arizona: Drop arizona-extcon cells
>   extcon: arizona: Fix some issues when HPDET IRQ fires after the jack
>     has been unplugged
>   extcon: arizona: Fix various races on driver unbind
>   extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol")
>     call
>   extcon: arizona: Always use pm_runtime_get_sync() when we need the
>     device to be awake
>   ASoC/extcon: arizona: Move arizona jack code to
>     sound/soc/codecs/arizona-jack.c
>   ASoC: arizona-jack: Move jack-detect variables to struct arizona_priv
>   ASoC: arizona-jack: Use arizona->dev for runtime-pm
>   ASoC: arizona-jack: convert into a helper library for codec drivers
>   ASoC: arizona-jack: Use snd_soc_jack to report jack events
>   ASoC: arizona-jack: Cleanup logging
>   ASoC: arizona: Make the wm5102, wm5110, wm8997 and wm8998 drivers use
>     the new jack library
>   ASoC: Intel: bytcr_wm5102: Add jack detect support
> 
>  MAINTAINERS                                   |   3 +-
>  drivers/extcon/Kconfig                        |   8 -
>  drivers/extcon/Makefile                       |   1 -
>  drivers/mfd/arizona-core.c                    |  20 -
>  sound/soc/codecs/Makefile                     |   2 +-
>  .../soc/codecs/arizona-jack.c                 | 577 +++++++-----------
>  sound/soc/codecs/arizona.h                    |  44 ++
>  sound/soc/codecs/wm5102.c                     |  12 +-
>  sound/soc/codecs/wm5110.c                     |  12 +-
>  sound/soc/codecs/wm8997.c                     |  14 +-
>  sound/soc/codecs/wm8998.c                     |   9 +
>  sound/soc/intel/boards/bytcr_wm5102.c         |  28 +-
>  12 files changed, 325 insertions(+), 405 deletions(-)
>  rename drivers/extcon/extcon-arizona.c => sound/soc/codecs/arizona-jack.c (76%)
> 

