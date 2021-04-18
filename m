Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947F236377B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhDRUQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 16:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDRUQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 16:16:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3696CC06174A;
        Sun, 18 Apr 2021 13:16:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g5so43011754ejx.0;
        Sun, 18 Apr 2021 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNuUdltEGVx+LNO7Cjlx/rXKrfa7ugDPwassLJV+nSs=;
        b=mqPm+w7JmVVzXfnrSms0ASX1jFQJYUm3p1sJbaCl3/uMEbArElAa/R8U9HVvFxQ0hz
         pNliHaRGcBWhgHcNb4xSxzoLx5IHVf3ke0tTMUbYVp/pQN06syEUmeZPHaGAwanbPYz/
         5hfKXtZhctLLIwv8WazMfyxG5k6P12959FpVJuFy98OX0dNx1vwp1E6rNPos3PicqmBm
         9SEMFMjIAhNzyG8ReegFzJpbPEzrinE59CfhKV2IDdIj3ujfOPSyLUTsNVTQMT01GSd4
         T9tNmIdRTOMcB9DgbcbReGxNawcUc3bU5NotsUpebZ8zruG28KZF694GOt0eA1JFn/Zm
         oCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNuUdltEGVx+LNO7Cjlx/rXKrfa7ugDPwassLJV+nSs=;
        b=ZtO4DlpCa+hobLRNh9O+cNbLBqN1eYK6EXK1BX1nsqsAclMJLdXKwmBWZU/EauzQ6x
         b9p8qpoqEh6dqzi+M59/rnYh0Ku938fMKMCsFtPhcHebf5H8s9GPhXp9Ptf8cwD9d4fu
         hBcAcZCEzrvpw0uvckL1gJ3oB0ER7Pfovg3mGfgzrMBnZPg2tWqgpS5gM+DqpjSW3KsF
         YVJRuZokknsZitXKaFFMx5vYgXQn9sU7EBRY+UdJr7ZZxdH80WvC+oAYIJCajETrJt4Y
         xfrFai+ii6JymRAK/S9HT1nmT+ilgksaQohlX9p4mpL95apW625KfaWlQD0Pqzv3cr6h
         mb7g==
X-Gm-Message-State: AOAM531HPJoInwt/i80dWnoLlcTnuxPnIJ8ewYjVmoiTj6un6MVU4qWG
        GAM+xBwYwse1i2fVSV8DtQuIRTPhwxxaaqrIlu0=
X-Google-Smtp-Source: ABdhPJyhQS7ewMgAuX/LkyOxZdJtKiVze0rTgdP222AQTI32WgZhH+58iLsPWoHbamLBE9hqYjmeo3DutxyH8F6btks=
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9mr18688147ejh.172.1618776962793;
 Sun, 18 Apr 2021 13:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210407042609.9736-1-christianshewitt@gmail.com> <20210407042609.9736-3-christianshewitt@gmail.com>
In-Reply-To: <20210407042609.9736-3-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 18 Apr 2021 22:15:51 +0200
Message-ID: <CAFBinCAL1zpcNm5VdbwpwZM1DPvfhnx0+npZvs8Hi5DOLz+7kA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: meson: add saradc node to ODROID N2/N2+
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hyeonki Hong <hhk7734@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 6:27 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> From: Hyeonki Hong <hhk7734@gmail.com>
>
> Add the meson saradc node to the ODROID N2/N2+ common dtsi.
>
> Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
