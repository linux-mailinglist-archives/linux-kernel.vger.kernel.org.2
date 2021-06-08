Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CD239FCA8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhFHQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhFHQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:40:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0216C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 09:38:33 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p13-20020a05600c358db029019f44afc845so2308933wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 09:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5MiCsohSNbpQZL8LRnsIqyOkEhi0sWxny4ybtnjXo/E=;
        b=j8B7zQBgKLIQyikIY1/IF32okfKCFjEQds5pepMlL5rcW2XnrTauKFiBbDlL5FwPXM
         bQRHrWvRjH51ABQ25SXfD0Gg0MGtGjAQ1G4bHDhhIlrsDxLlEw3NzzWehetg9vHRN/AV
         DHigod3Pta56OQ6/AbI/Y/8EJAu6u1SaBhOekvAUwjIa5SlsWU9aE7/QqoaRXwtAzbOx
         P5DGITV/6utrwIpHBM7y0nC2il2hn9tNu7fQAJw4JaxAZLM6sI9xMX8DOLVXklASexlo
         R0e3yEEj2aYjDPXkINe3UEDLHsvy+QhBnKdgxJHlwzZnxzItq3cQ25jXAlfjKPqQB5pz
         nGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5MiCsohSNbpQZL8LRnsIqyOkEhi0sWxny4ybtnjXo/E=;
        b=Z+7N7EDcsqZun2A/JUEHCp6n8GT+pKQuJ62y4+4T1IgThejlSy+x9Py0+qw0g1rdkH
         mZHjMte8hIWAeUZfoXzTfhzFWqJSSpVVHIEjtHd+6JqQ61W2bV3+48CyqoKkrT5RpyXO
         e1AG2yMDWnEEEzsj7TUB9PeBF9nGczjwEJAboa1+Zc587i9X3bl22GPxaXSZqATR5qaQ
         RPOx89XOqxjX/a90wMSi6ZeLkiAkGUuamzFSd/wwAZktyrymi1745HB+X7ju6+ilYXzb
         1SynEkZAPHjh/77N9596P+L21y2gldK1ek5Wmlk6bLD3D+chJB8ZP1S3DjcM8/iqBKAt
         Cb4g==
X-Gm-Message-State: AOAM533ijMQmEsYanvQscMUAGzzwQWSO6Hxim8gZBPIWGfFQysE+X0O3
        eK2GkQfxuPncy9en811q+CpMAjkUz36kBDIs
X-Google-Smtp-Source: ABdhPJw08Bscg886RgtJ5ecEZCdZhnXdY9Z/AxEb4VZaj+H+QJBzHoV/oO8BmNN7T9SaGmZrlPizuA==
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr23433400wmn.132.1623170312142;
        Tue, 08 Jun 2021 09:38:32 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:d35c:a474:f6ef:ed8b? ([2a01:e0a:90c:e290:d35c:a474:f6ef:ed8b])
        by smtp.gmail.com with ESMTPSA id a1sm23275526wrg.92.2021.06.08.09.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 09:38:31 -0700 (PDT)
Subject: Re: [PATCH RESEND] arm64: meson: select COMMON_CLK
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20210429083823.59546-1-jbrunet@baylibre.com>
 <162008674673.40672.14279142646066453043.b4-ty@baylibre.com>
 <CAMuHMdVhrMNzuXkD9BQxPaiwS41bsOyJU_kwGYwk5ftto-AGBQ@mail.gmail.com>
 <1jczsw1fnj.fsf@starbuckisacylon.baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <7e70f485-1114-223a-e7cc-386795049e4c@baylibre.com>
Date:   Tue, 8 Jun 2021 18:38:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1jczsw1fnj.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/06/2021 18:32, Jerome Brunet wrote:
> 
> On Tue 08 Jun 2021 at 11:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
>> Hi Jerome,
>>
>> On Tue, May 4, 2021 at 2:06 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>> On Thu, 29 Apr 2021 10:38:23 +0200, Jerome Brunet wrote:
>>>> This fix the recent removal of clock drivers selection.
>>>> While it is not necessary to select the clock drivers themselves, we need
>>>> to select a proper implementation of the clock API, which for the meson, is
>>>> CCF
>>>
>>> Applied, thanks!
>>>
>>> [1/1] arm64: meson: select COMMON_CLK
>>>       commit: aea7a80ad5effd48f44a7a08c3903168be038a43
>>>
>>> Best regards,
>>> --
>>> Kevin Hilman <khilman@baylibre.com>
>>
>> Why is this needed, and why would this make any difference?
>> COMMON_CLK is always enabled on arm64, as the main ARM64 symbol in
>> arch/arm64/Kconfig selects it.
> 
> Ah indeed. Shortly after commit ba66a25536dd was merged I remember I had
> problem with COMMON_CLK (or any other clock implementation) being
> selected. TBH, I don't remember it exactly ...
> 
> For sure this was a mistake.
> Neil, can you still drop it and do you need a revert ?
I can't drop it, it has already been merged.

Please send a revert and I'll push it for 5.14-rc fixes.

Neil

> 
>>
>> Gr{oetje,eeting}s,
>>
>>                         Geert
> 

