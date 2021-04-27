Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476ED36C185
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 11:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhD0JRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 05:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhD0JRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:17:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1B0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:16:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id zg3so6896631ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
         :date:mime-version;
        bh=3FMaIVb8+hPFpxss5sahNQQAV4tk/aH70tObk1XSyTo=;
        b=a3DodOtE+Jfr8w0k55wnvesDq6Ad1kJ3Nzs643Zi5aUe2x8FpA9ebXVxMuScGfO6zH
         GYeU6t1jCjrbXA8o28zyp/EeHZOZfD1nk4NLlIKQTykZMO60kXnXrwbtn5x0g8Dfwf+H
         X9T2/avLw8IOqi+Cdy4XWL2TU+TlME4jcp9ae45reV1qFCZzktoyvNwCupx046zHliFG
         idbquqQLmx77XWniG/cRMPrbnF4Z6IcAazO8dWIoDFafHeORd2vEFIWK2/bGi6quKy1W
         p+uboZ5bsDCA4RxrlrPZctisMkGFBBRjScpC85KPw7locMBkZU+DXPrIMu/bZbiWuzcW
         POOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=3FMaIVb8+hPFpxss5sahNQQAV4tk/aH70tObk1XSyTo=;
        b=iEtqGxGkEIDDxD8HCy8PnIlZoNIHfLx4f6MHsOjZEx0XNBoRfdx1TY9o1Dy9jJ6DFH
         Bw9hFRl0u9fmVvLwL+tHRS69vbj+SgXsfpqeMPWJ38/ozbIAcN0WimHZGB4yTd0ng4Yk
         UkezifACkkF7RSclHYG9aR5Ju4NK0DUkm2IHSPbrziooszi4CRzaQbATdS7MVe7ltfVK
         t031NKMSYLDopHEulhyrAIrwIb+QE0mEWmeoQS5FNktIzqLd553sc9zDyml6qgO6aFb5
         AOUP0LWaQ5GqwEEqcB8hhI3fBWlxkpoelQQ/CNzjysTQSnG8/hxtFhBOei8js8nh5EJu
         1UGg==
X-Gm-Message-State: AOAM530u0+EqRwtiLH7Oq5AzkQrgxXMn9uRL5VxzC4yE38mai5VZltT1
        C3mdcgDZEufu3vtqoqZg+5ZBpA==
X-Google-Smtp-Source: ABdhPJzFQSE5nXxK1ZEsw/o7nGCfYS0VpmMvK3yFH2ZUIwIOI9kQdemuWgqMHr9W+MFNsjuyBIl/YQ==
X-Received: by 2002:a17:906:4a89:: with SMTP id x9mr22239297eju.121.1619514986710;
        Tue, 27 Apr 2021 02:16:26 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id aj8sm96757ejc.64.2021.04.27.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 02:16:26 -0700 (PDT)
References: <20210421120512.413057-1-jbrunet@baylibre.com>
 <20210421120512.413057-6-jbrunet@baylibre.com>
 <69eaa840-ed77-fc01-2925-7e5e9998e80f@linux.intel.com>
 <1j7dkon8jy.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ASoC: da7219: properly get clk from the provider
In-reply-to: <1j7dkon8jy.fsf@starbuckisacylon.baylibre.com>
Message-ID: <1jim48jdee.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 27 Apr 2021 11:16:25 +0200
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 26 Apr 2021 at 21:35, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Mon 26 Apr 2021 at 20:10, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>
>> On 4/21/21 7:05 AM, Jerome Brunet wrote:
>>> Instead of using the clk embedded in the clk_hw (which is meant to go
>>> away), a clock provider which need to interact with its own clock should
>>> request clk reference through the clock provider API.
>>> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>
>> This patch seems to introduce a regression in our modprobe/rmmod tests
>
> Really sorry about that :/
>
>>
>> https://github.com/thesofproject/linux/pull/2870
>>
>> RMMOD	snd_soc_da7219
>> rmmod: ERROR: Module snd_soc_da7219 is in use
>>
>> Reverting this patch restores the ability to remove the module.
>>
>> Wondering if devm_ increases a module/device refcount somehow?
>
> The driver is the provider and consumer, so it is consuming itself.
> This was the intent, I think the patch should be correct like
> this. Maybe I overlooked something on the clock side. I'll check.
>
> I'm not sure the problem is devm_ variant, it might be 
> clk_hw_get_clk() simpler variant which also plays with module ref counts.
>
> I don't have this particular HW to check but I'll try to replicate the
> test with a dummy module and report ASAP.
>
> Of course, I suppose the same problem applies to PATCH 1 of the series

So I can confirm that the problem is in CCF and the function
clk_hw_get_clk() which pins the clocks provider to itself.

Not that many clock providers are modules and even less are getting
removed. This is probably why this fundamental issue has not been
detected before. Thanks a lot for reporting it.

Mark, at this point I think it would be best to revert patches 1 and 5
while we work this out in CCF. The other patches are not affected.
Sorry for the mess.
