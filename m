Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE0C3FA7B3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 23:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhH1VxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 17:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhH1VxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:53:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C0C061756;
        Sat, 28 Aug 2021 14:52:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id z4so16234161wrr.6;
        Sat, 28 Aug 2021 14:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JJCwgQFjCSJNhbTyoyaxjPlruVTGCzjmC4R3DiQ5BA0=;
        b=RRYevVMMofQgeIqhjO427n9IVgzgU6jB5x0ymhNUBsjC3MqI9F25aT6v6f6wYPxMwn
         UONG/GQ/LEX8xMkWmgUYQnnJNPz6RGll0l5BBqYFAy4rH8z706Sdr8RC2SvJ6RD+QIoY
         R+g4lNxxVIGvDLA2akTAB7wHhJGA3JOj+eN1luc3xY9bEXbBwz4Rk1FMqtptx1K77wXK
         9y7PE4WGAJhiAuWCHg32eAlsHhn9Vv5mt6IyGXwUFnv4li0odNHkIJTHXmezSfRzm8n9
         JR59dlhXEg28e3pkdTTb+Mw3T6dcqpy+beDxkwhQi0eZBcSyM7cgO16qhuUr+KaT0q7K
         MGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JJCwgQFjCSJNhbTyoyaxjPlruVTGCzjmC4R3DiQ5BA0=;
        b=eW9Co5f+GzkyncJYk0oxDfK9/bWpBwW+TmG9J/P2nifBGRev9kGEnvopB9sRHNRhpE
         /YgTfETG3XJgz+wO2ZTjTetOIzgbDSUXGps71S2A2wTj+Hs3AZEMrz4hDNqbJzPLPIVN
         NUgb2wLrxMCMNPrdlvSrpf4cZlfJ2Rxfiim7OYtjeRngdGnbxvmcG+BU5WgbK13CNMyn
         cXjalTn1RyGXQSbm3ZdOYByWdp3iOBN8ThsHnLyEmjHimbtr2MGzI72kJGk81GmDLaBv
         B/2fi/rec1tcFXmKvfKGIjjFwwRDtS5obWK/qGyeM70inJpPlWSAnB+LGQBbRJYZjyvg
         DS6g==
X-Gm-Message-State: AOAM533ow6i+w03d1qI8EVn1gtDJfbUEVVjnscaNuJsxGxX0GWTTBHfk
        p0AzSxoDt+SNv2ANNYzHntJIUUQB15oW2g==
X-Google-Smtp-Source: ABdhPJxS2krldZzW91UNrktjT9dt9csrMj7vrwJj9ZG2j2ImbKBwRAi+pO0391xB7Gxb3Yzp7V76zQ==
X-Received: by 2002:adf:9f47:: with SMTP id f7mr10292147wrg.401.1630187551980;
        Sat, 28 Aug 2021 14:52:31 -0700 (PDT)
Received: from localhost.localdomain (haganm.plus.com. [212.159.108.31])
        by smtp.gmail.com with ESMTPSA id n3sm10046215wmi.0.2021.08.28.14.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 14:52:31 -0700 (PDT)
Subject: Re: [PATCH 3/5] ARM: dts: NSP: Fix MDIO mux node names
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210828112704.2283805-1-mnhagan88@gmail.com>
 <20210828112704.2283805-3-mnhagan88@gmail.com> <YSptPF8MKNahkMbm@lunn.ch>
From:   Matthew Hagan <mnhagan88@gmail.com>
Message-ID: <858a86de-c06e-0221-64ea-bb1790db398a@gmail.com>
Date:   Sat, 28 Aug 2021 22:52:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSptPF8MKNahkMbm@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2021 18:07, Andrew Lunn wrote:

> On Sat, Aug 28, 2021 at 11:27:01AM +0000, Matthew Hagan wrote:
>> This patch fixes the following message by adding "mdio-mux" compatible:
>> compatible: ['mdio-mux-mmioreg'] is too short
>  
> Err, what? This sounds like a workaround for a tool problem, not a
> real fix. 
>
> What is actually wrong with:
>
> compatible = "mdio-mux-mmioreg";

Yes this does work fine either with or without "mdio-mux". The changes
have been made to correspond with those submitted by Rafal Milecki for
the BCM5301X platform[1] and to conform with
Documentation/devicetree/bindings/net/mdio-mux-mmioreg.yaml
which does state both as required items (and hence not a tool problem).

[1] https://lore.kernel.org/linux-arm-kernel/20210822191256.3715003-1-f.fainelli@gmail.com/T/

>
> 	   Andrew
>
Matthew

