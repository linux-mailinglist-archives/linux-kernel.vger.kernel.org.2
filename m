Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB724023DC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhIGHKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbhIGHKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:10:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD15C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 00:09:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i28so1625943wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 00:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LIu3oOHWEmY3wQIAxqSNQIyaCKUxHsLssdTO6YON+08=;
        b=o/qBi4CH3HaRDR5bQWk1T7vSl1D/KMMjoEVRUtpQEYYYNtJoWsbsgVbv2hp3WxnoFC
         P1wqlO3zjnNVTmKXxBIS5CDmj25jPudO6R05EAS9k00Stq0pybfYUpIGNJtT3Ti9bqDX
         1/htb7JsW3Q1ddjf+Q/f494NOpHdO5Xjkukv/ADAAcRVSKSwbwR/Mfn5/49IHjuMMv9z
         tMM8YHFh8MLMrUoGMUGxc5usuvrIPaarFEkukcszcpR9WvX7NMBIoCOd7pOfiNNCtT/u
         Fe5/raK3tiuWJaCKFpwnAuzXXFNTqKkKkrqncMriKGWI0LYkhYcHbfje3BMPz4dK6lm6
         0tUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LIu3oOHWEmY3wQIAxqSNQIyaCKUxHsLssdTO6YON+08=;
        b=gtlmvn6q1eY977UlinPwSw/0I+FiDNnYVLJKYzwn9LiVh1nxHN5gslRSpf7tJCF8fM
         19J9W3UbJTtX+aYkOo/JeqPC6EFn7jci9f5XvR3c1rbkmACkDGl30j0BgLyfkP1seEvN
         NQVqCoVosuCEYAld+a/m/XNtRmQPuNs9D/QscPx2MQU/1j08HUhkmhOchinbcDpkqyYp
         7GxZ0nkZJBvnqN8EexCUbpZvqa1IVQGczqbFktSmnKk3jVgX4OMc7zdCWiOEmDFERSOx
         mVrR/JLWJkKzQErTJyJPf84bwqvlSvYdsZiF8OD50UbQuAf62XorXFwOfZ/6Bi+3Fkik
         bACQ==
X-Gm-Message-State: AOAM531lPxH1dWh+xO8TfNAVR4J1yz09qdYkL+2BrZ1KoVrOabQTnssE
        C/CS0SIQLfF1d0F4An0Ih7LQvXNRyI1RjcnK
X-Google-Smtp-Source: ABdhPJxBBb07iGeSfx+y8zGr1Fv3QEHQnM3o0CVUlxPEOvrWTeUEtyfU2Wnr0KYAvyj9J61Gqx8QYw==
X-Received: by 2002:adf:c7d1:: with SMTP id y17mr2514305wrg.214.1630998548660;
        Tue, 07 Sep 2021 00:09:08 -0700 (PDT)
Received: from ?IPv6:2001:861:44c0:66c0:48a5:8e41:47ff:c025? ([2001:861:44c0:66c0:48a5:8e41:47ff:c025])
        by smtp.gmail.com with ESMTPSA id l21sm1462479wmh.31.2021.09.07.00.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 00:09:08 -0700 (PDT)
Subject: Re: [PATCH v3 4/4] arm64: dts: meson-axg: add support for JetHub D1
To:     Vyacheslav <adeep@lexina.in>, Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210904142745.183875-1-adeep@lexina.in>
 <20210904142745.183875-5-adeep@lexina.in>
 <77699dc0-88d5-3462-15fe-eb376c862d30@baylibre.com>
 <c6430622-5857-877c-6293-fc101500a6e6@lexina.in>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <83730df2-5104-bfff-949e-4499e0c2612a@baylibre.com>
Date:   Tue, 7 Sep 2021 09:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c6430622-5857-877c-6293-fc101500a6e6@lexina.in>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/09/2021 17:07, Vyacheslav wrote:
> 06.09.2021 15:26, Neil Armstrong пишет:
>> On 04/09/2021 16:27, Vyacheslav Bocharov wrote:
>>> JetHome Jethub D1 (http://jethome.ru/jethub-d1) is a home automation
>>> controller with the following features:
>>>
>>> +
>>> +&spicc1 {
>>> +	status = "okay";
>>> +};
>> Why enabling it without pinctrl properties ?
> 
> spiccwas planned for use during the development of the device, but in fact it is not currently used. Pins exist on expand pad.
> 
> Its better to add pinctrl as below or leave spicc1 disabled?

As you want, if the HW is present and functional, usually it's enabled in the DT.

Neil

> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
> index bc10f3357c09..ecffc90d9884 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dts
> @@ -313,6 +313,8 @@ &usb {
>  
>  &spicc1 {
>         status = "okay";
> +       pinctrl-0 = <&spi1_x_pins>, <&spi1_ss0_x_pins>;
> +       pinctrl-names = "default";
>  };
>  
>  &gpio {
> 
> 
> --
> 
> Vyacheslav
> 

