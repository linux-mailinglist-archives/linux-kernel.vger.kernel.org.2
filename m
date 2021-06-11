Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86DA3A3CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 09:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhFKHR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 03:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFKHR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:17:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E56C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:15:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c9so4869211wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 00:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FREoGcjYmwatSSvbTS2odeRUwmu2yN1APuIOZSR0RBY=;
        b=mJUZr/QXwC6Eq9noIyQKNB3FT88clReeJxuO9wolZRA71JslpBE2MPVycE0O8C8mZR
         TkHAU8EfnyOm3PYVhkFvTL10xPUTH3/Pz6JYmAJf81qKYRIDEzzmgRiXpvMy43rC+vK1
         P4DEVHnP7urdERwxs4KNnt//I5fpG6M1u+88sR08g9ZXyidQwqmS7Ri2JfNklvGjhb2w
         HqdlNzrDK9GZ2jcPg8WPkMko0+1yQxZdhtA2B5eEysyrOv/2ELAbYMzo6/eLFPlFPK8Y
         QiIT5AphSyi13oYbU6zOkFe0U6e4NOmygyte1p7wt1F91T9XOAliVTcOHdFa3Lucdpd0
         TonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FREoGcjYmwatSSvbTS2odeRUwmu2yN1APuIOZSR0RBY=;
        b=nzAEwSpTlC2JM8QQX1X8hxxiSa6F6MLO7Vj9FmN/gr+638kPJ6uiqGmvsb8r8WNA2k
         fdn73ymsr/2ychYg5TJfJonNHFMIn9j0JwiChxXS9xPqHb7+d9WLHc89te/HWtNGcxoO
         zLYKc7Eks60aH2Vz/NCJlv+OsGYVncbvnAMb64ng1OqSv1zVm4hkK6s+zdniw6fdybc0
         Zq9OMRsvQKwlFsmh+j+flyODsYM12R5DULQNzQNyTIMAtdFi1LP8rbv8Xith6ynOxv+K
         EEoyGVZNow3rSRDt+bvdBNeHI6NxZuHNAb7bAq2SSQ4vr1Pnj69xSHD5hcs/no9icEL+
         Ywbg==
X-Gm-Message-State: AOAM53022pL1mmf2r1e8Een+k2Rot0QkBY1pAqO23cPIaAQchnZcpm8u
        NcokjbQBQdTUwRquDeyh3N+U4w==
X-Google-Smtp-Source: ABdhPJxzefSoeOyoePIG/Zey+jgTLMreoCw+p+cwYA6CvgytK8vvrimtOK18u7sAms7CvBVfDXJMrA==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr2316655wrw.57.1623395716028;
        Fri, 11 Jun 2021 00:15:16 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:bfd6:8f6:b84c:734f? ([2a01:e0a:90c:e290:bfd6:8f6:b84c:734f])
        by smtp.gmail.com with ESMTPSA id f18sm5281829wmj.13.2021.06.11.00.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 00:15:15 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: vim3: reduce cpu thermal fan trigger
 temperature
To:     Nick Xie <xieqinick@gmail.com>
Cc:     robh+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick <nick@khadas.com>, artem@khadas.com
References: <20210609012849.797576-1-xieqinick@gmail.com>
 <11da3ae4-91d4-1e51-c652-e4ad518f13bd@baylibre.com>
 <CAP4nuTVMZV7pz8NrM2MHcZzBdueRXjS+KYsU4=cQ1CB67gr_Hg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <ee3341d9-350e-a84d-6836-3401be679b2a@baylibre.com>
Date:   Fri, 11 Jun 2021 09:15:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAP4nuTVMZV7pz8NrM2MHcZzBdueRXjS+KYsU4=cQ1CB67gr_Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/06/2021 08:54, Nick Xie wrote:
> Hello Neil,
> 
> The MCU FAN won't work until the temperature reach to 80 degree centigrade,
> Do you think the temperature is too high?

I think 80 is tool high, but I fear 50 is way too low, but if you think 50 is OK after you ran some tests, just add it to the commit log and it's ok for me.

Neil

> 
> Thanks.
> 
> Neil Armstrong <narmstrong@baylibre.com <mailto:narmstrong@baylibre.com>> 于2021年6月11日周五 下午2:44写道：
> 
>     Hi Nick,
> 
>     On 09/06/2021 03:28, xieqinick@gmail.com <mailto:xieqinick@gmail.com> wrote:
>     > From: Nick Xie <nick@khadas.com <mailto:nick@khadas.com>>
>     >
>     > Reduce the MCU FAN trigger temperature from
>     > 80 degree centigrade to 50 degree centigrade.
> 
>     Can you add some more rationale to this change ?
> 
>     >
>     > Signed-off-by: Nick Xie <nick@khadas.com <mailto:nick@khadas.com>>
>     > ---
>     >  arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 2 +-
>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>     >
>     > diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
>     > index 66d67524b031..a9c34fee91f4 100644
>     > --- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
>     > +++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
>     > @@ -256,7 +256,7 @@ &cecb_AO {
>     >  &cpu_thermal {
>     >       trips {
>     >               cpu_active: cpu-active {
>     > -                     temperature = <80000>; /* millicelsius */
>     > +                     temperature = <50000>; /* millicelsius */
>     >                       hysteresis = <2000>; /* millicelsius */
>     >                       type = "active";
>     >               };
>     >
> 
>     With that:
>     Reviewed-by: Neil Armstrong <narmstrong@baylibre.com <mailto:narmstrong@baylibre.com>>
> 

