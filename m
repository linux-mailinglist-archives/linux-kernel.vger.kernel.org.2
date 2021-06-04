Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF339B6E5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhFDKWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:22:19 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41902 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhFDKWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:22:16 -0400
Received: by mail-wr1-f46.google.com with SMTP id h8so8725499wrz.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ziavbqWUEKiMtC7t1VjCERXgHXd+SAZbkk0wx19OWY=;
        b=AUmYpKUCqqVGkR1DU1J3h/uIiApIX+1iARiLeBsd7QAn0XFvm+gZT5xc9DaSZtULIm
         u0BXLbssp0yBgyf+pnDOSb/t1la/zL9BcIfdvHtDV0E42STBiWAJLS9nKeIqzhG58WtH
         RroFtgfVVxMLRxKH0IIAp+ongjmY4cgmnFE1aA3VFBiIv0JuJm7TnA9T058UNO0Y0dsL
         nHSDWD47A8DLryT97t6IdgiiA35M0jZCUU5Hwa3ru/jHoPnpDe7CBpXVr9AH0AFq4Ur+
         t5ClveGnOhzNasKZdH89SEOcUfoKZJEkA+F7dKRcZPIkEvkRHHShh8b5kBESyzhJpzOn
         hTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4ziavbqWUEKiMtC7t1VjCERXgHXd+SAZbkk0wx19OWY=;
        b=lLxhcAm5I73itqUIZJza+gaxGAV6yHpa4Suzj4koV1pJQW1Aw0buxzxyGXBvYbI5Og
         B+vFtPZD6Wkqh02gPcQCRncE+0X7Htf2eQGUy01WmWND68zHELQjYHEgB3A82o/PZVuW
         Dbq0lQSOJkiQxETgKLqwDK/4ZEIiLSpo9g+ws9VHFEiDEGY8+1/n3pEW+Fyb9rlyWg4M
         2slHz1AOnndEC2X3XMkXnBkakBigCu4+EZh9X1dNqwlpiVnLof/3sIlXKWaCgfPvCuaM
         BiLENZwSdYEUZwIVEiWV6hNCUyBChXo1PXNii92n8EOkAVXEPLBE3H7n0ZBTuQUoftlX
         414A==
X-Gm-Message-State: AOAM533edIDIEIcEfd4M6m/satXm4EtsnMTKzijN6nhvFPos71SRP3CA
        0URR0c6AZy3FL4wGdqbxhjvLOwt53cb/hoaO
X-Google-Smtp-Source: ABdhPJyZPtI4shQfAGMbh/07M+zranWNJi/sP7idE2MNMX+O8VKGf4UxO2fV62ARG2iaDO6Lb+0Gig==
X-Received: by 2002:a5d:5251:: with SMTP id k17mr3105093wrc.153.1622801970016;
        Fri, 04 Jun 2021 03:19:30 -0700 (PDT)
Received: from [10.1.3.29] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q5sm6228890wrm.15.2021.06.04.03.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 03:19:29 -0700 (PDT)
Subject: Re: [PATCH 3/6] arm64: dts: meson-sm1-odroid-c4: fix hub_5v regulator
 gpio
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com
References: <20210601090140.261768-1-narmstrong@baylibre.com>
 <20210601090140.261768-4-narmstrong@baylibre.com>
 <CAFBinCB+SyCmxrjJLcuy=mLsChPZ9i_1TsaWkL3kuhPO1wGwWw@mail.gmail.com>
 <802340ba-edd1-d148-4c6b-e2eae9c2a096@baylibre.com>
 <CAFBinCAVeEVWVmpn11RWxuvYBpAVUj37R=U7ykv+YPUNYYTLMA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <353cb179-1ff6-9586-f6e8-e692b11d1e12@baylibre.com>
Date:   Fri, 4 Jun 2021 12:19:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCAVeEVWVmpn11RWxuvYBpAVUj37R=U7ykv+YPUNYYTLMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2021 12:13, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Fri, Jun 4, 2021 at 11:43 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> So I'll add:
>> +&vcc_5v {
>> +       gpio = <&gpio GPIOH_8 GPIO_OPEN_DRAIN>;
>> +       enable-active-high;
>> +};
>>
>> in odroid.dtsi instead in this patch.
> that sounds good to me
> 
>> Not sure what to do about the regulator-hub_5v.
> maybe dropping this regulator overall? we're using gpio-hogs elsewhere
> for the USB hub's reset line
> or dropping the gpio-hog and keeping this regulator to manage GPIOH_4

I'll drop it completely, it makes no sense to have a regulator for a HUB reset anyway.

Neil

> 
> 
> Best regards,
> Martin
> 

