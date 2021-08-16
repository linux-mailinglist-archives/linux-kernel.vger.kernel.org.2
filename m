Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52963EDD27
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhHPShe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhHPShc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:37:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBC9C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:36:59 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id r9so26919483lfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b5nG1Sn4hEdSmCIfBVPgAPJIisiduFp0SMRlWQtkxmg=;
        b=Krt2XuzEx+T0LB6/+Mqg7SLTP0H1Ms829dCOLPBmV+PMoYsLuoTj4BkFpOgyLD1Cud
         rHN1gLifgizAPGHBd8TE7qFQO/K3OIdj1NfWl4BwlWApnFTf/9J36pYUdEXVjGeira4T
         CT2CcnchOItqMUDKXtLxC8QqohujzXsw2OyxtJMwLLWy0Q0S9dNKkHZOHTJAj5elcFuY
         Hq7Jk52ICxtTIMm3xp0o3CRGDH2gmRv2fMN5kjFdTaci+9Nf/haebpwlbLozd+sv1ke8
         5dJPz79F7y1SqyCj/1XkeVISdXEt06Tm9cmNM1sS61Xg2DazBPZhH+7jw4ZIrGHcpBbt
         jYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b5nG1Sn4hEdSmCIfBVPgAPJIisiduFp0SMRlWQtkxmg=;
        b=r13jrRhokeHEm/gWyYerf6tFK5Ud4dHdNKoP0x+OFOC9I2C8mRYnWEzoZFdjINGG+m
         +sE+ACX9oFRNoUxBeLjmQW0SsYJEPMO0cXPoHvmsdwZxNvhx+neFf32dwikIQXiMthI7
         /+j68WW0Kf4q05iPcquAi1Me/9HZvDD4OXiMxdGLvziYXUmE+YAb8fuz331YfIo6x7nC
         ZV3JfDee3KR4P+EmDPCohmCFTb4kyFwk0HoNWiSHdz5P4Ttz0kiXbZsXjU6qJ97gF5ua
         yRbso9PTsz2WxiBRXyq2AV7KgTuTr6FXHKCJ1Gmqm8PR3sNjNkGPEEk5Gvnyfg+WdClb
         4Arg==
X-Gm-Message-State: AOAM530KgYOjE8826AgQURZR0Vu1nVa4GPB9hwrBttZ4YiMn39zi+/P8
        q3NcB3biDpoYdGneyLVOups=
X-Google-Smtp-Source: ABdhPJwY2sNOrA2E597YG4aWdgHZYmP6uRwu780vRZDNWrG8dd9L2RvW7GPQGpmMe+aIsQYFnvUfVA==
X-Received: by 2002:a05:6512:c1f:: with SMTP id z31mr11205955lfu.373.1629139018394;
        Mon, 16 Aug 2021 11:36:58 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id b6sm2203lfv.167.2021.08.16.11.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 11:36:58 -0700 (PDT)
Subject: Re: [PATCH 0/3] ASoC: ti: Use of_device_get_match_data
To:     Aakash Hemadri <aakashhemadri123@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jawoslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>
References: <cover.1628972198.git.aakashhemadri123@gmail.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <e7a5274a-3605-9f49-e77b-51343c060b94@gmail.com>
Date:   Mon, 16 Aug 2021 21:37:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1628972198.git.aakashhemadri123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/08/2021 23:19, Aakash Hemadri wrote:
> Hi,
> 	This patch series will apply cleanly on for-next
> Prefer `of_device_get_match_data` over `of_match_device`.

All three patch is wrong.
Mark, please do not pick them up.

> Aakash Hemadri (3):
>   ASoC: ti: davinci-mcasp: Use of_device_get_match_data
>   ASoC: ti: omap-mcbsp: Use of_device_get_match_data
>   ASoC: ti: davinci-evm: Use of_device_get_match_data
> 
>  sound/soc/ti/davinci-evm.c   | 2 +-
>  sound/soc/ti/davinci-mcasp.c | 2 +-
>  sound/soc/ti/omap-mcbsp.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

-- 
Péter
