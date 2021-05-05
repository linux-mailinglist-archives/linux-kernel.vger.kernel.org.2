Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6937493F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhEEUVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhEEUVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:21:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECE1C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 13:20:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id di13so3533158edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Mv4wqHc8zTw/J8WtIF1x0mpLNs4iPzNxbH+cO+sYFs=;
        b=QVkG18XIZWHqKQDqA7yUYVW6tTYJeP+JLLxSFkbOFOBrMzSlSDtSuiUB/idxxSsy/d
         6AHzXAJG8ZA/nyWc0f8u/Ego5Cn0CpZp84CUujXe/8DzVsoSaRFPGxfT8ieRULbpcaSH
         q7XSTMnYMxVakMs9RxjwTKBHBvMvcrUvQKHTyTU/U5TaH/9u22iQgG7TmqbG2QYkOaqO
         YREjms4RvTEnAW2ICYz/yxOBjTEEa4bwdfVSFv8As/+ghmnCNz3wQaazD0sRLD2njHdf
         bZ8qP9usa9gfkmBEKNM+Tc+n40mpTfyKA2RfIpMJuHCSLO451ScGMRJHSFGsqJwj2BlQ
         7CTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Mv4wqHc8zTw/J8WtIF1x0mpLNs4iPzNxbH+cO+sYFs=;
        b=WlczQG0N9wlYAs2WF5eqUeAcER2tjt7eCcvgfX39gbbnTSKBYrXXrsx+r7D+7fO/A2
         rZI9zrJrKTpO+s3/V1PbmaUVu6nok0jragouGXERNvB7LHw4ok+LNbm5HNN59o2He+oP
         rZgLatCCqFG3rbarTjueUau47yEcE0oDbLXcnnZzeYEOAGRdQmOFRr2Qh7Sfb+802eyu
         VOSVfFyAQAl87sYD67YkUrvXtDbdXmxGEV7oHuE9TYZX7A4dvvLD+UTLoVcrRH82zGDU
         9w+3KO6ST89ANhH7ydlWt0WBz3qd1wDo5qRUCLVE061nA/DgyeKttb07MGHmpiAUjp6o
         RmXA==
X-Gm-Message-State: AOAM5319g37GL319r1HkNycculDdGD21l/cn1Z4xEKi/aYx1o88Mh0zN
        7cJ01w+Cw3O2AwH/JrRrPq/Pj/HMl/mJM5JwVLQ=
X-Google-Smtp-Source: ABdhPJzZB98VEZ4g43Z5H3Hj4W7dWbziHf1Urvr12LVTjBku1fi3a9KlpuWAISYjSXM9GqQLaXXa2X380+YlZCqK2Fs=
X-Received: by 2002:a05:6402:3109:: with SMTP id dc9mr881064edb.13.1620246037148;
 Wed, 05 May 2021 13:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210505073248.3816183-1-narmstrong@baylibre.com> <20210505073248.3816183-4-narmstrong@baylibre.com>
In-Reply-To: <20210505073248.3816183-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 5 May 2021 22:20:26 +0200
Message-ID: <CAFBinCBa=rHQ+Sho2Lq0cA0dYnhKX4ZJaQUqBcaiOxNzD+bFiA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, May 5, 2021 at 9:32 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Banana Pi BPI-M5 is a credit card format SBC with the following features:
> - Amlogic S905X3 quad core Cortex-A55
> - Mali-G31 GPU
> - 4GB LPDDR4
> - 16GB eMMC flash
> - 4 USB 3.0
> - 1 GbE ethernet
> - HDMI output
> - 2x LEDS
> - SDCard
> - 2.5mm Jack with Stereo Audio + CVBS
> - Infrared Received
> - ADC Button
> - GPIO Button
> - 40 pins header + 3pins debug header
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
one nit-pick below, but still this gets my:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +       /*
> +        * WARNING: The USB Hub on the BPI-M54 needs a reset signal
s/BPI-M5/BPI-M54/
I am hoping that Kevin can fix this while applying


Best regards,
Martin
