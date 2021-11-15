Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23C450A48
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 17:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhKOQ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 11:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhKOQ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 11:58:40 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D8BC061714
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:55:44 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id w22so22379283ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZ7NYt0W413AD7cV4RQDPmgYwsGcXKqpIAx5+YC6+Bo=;
        b=XsnQEFUknE61g50ai18W9TgJ92Cg0GKsw7/0yRbT5zg9e0A0FIC9p0J7wEr6WsX57Z
         veF10fQeNCSVRbgxVjX+tOdfVRGtvIhM4jgBRHh8cRd1dLfmVlCAIPEtoArcQoH5nn5L
         NxQ51PkeKFKDH+37zbAWK8JAGzRZWib1RaFNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZ7NYt0W413AD7cV4RQDPmgYwsGcXKqpIAx5+YC6+Bo=;
        b=is1/zF6TTt2ecdym2MyrE5GWoQn6EEkXEjAabOFwrw3VMKiDj/zJ1nVNDkyPWYAv41
         cX69cPSahdVTmoM6VSIoDox4dXSdjn/J2upjvctXEjIgue/SuDXEEsVcR1k/u1hcVLlf
         nX0OzKv502uksG9dY16bd1xm6JDisWNtcweQQ5ylFuEU/4+/TfXZ3lwWjhzz8Kpka7oZ
         dphbA2HFLmgpkHAwxwlPbwzWTVHmoBQEK04dDhvVGyYWowdTR2VeWWDq9SX8YxKQKAx/
         Y+lOsbzW4v6mcc+mR2hCNS+lrEREQQq6BJXIxdvZb2u1T1cs7LMgnL5SLWu6+MtMow+G
         FTcQ==
X-Gm-Message-State: AOAM533OYrNCrv++I4RljkTbefQjnoAs9EZeIYcidfBRrt9zmlchGd9i
        mu/Wt3bYZWn4h+dlQ4a/JVX507ydyChYqQ==
X-Google-Smtp-Source: ABdhPJz+FAuOeHBBEZFTQ9sAjoP7x0APkU7OHiGjRXI134a3A81YO8OdRyO9NnpjDKfk17FuG2AKvg==
X-Received: by 2002:a5e:d80a:: with SMTP id l10mr197979iok.182.1636995343219;
        Mon, 15 Nov 2021 08:55:43 -0800 (PST)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id e17sm10331902iow.18.2021.11.15.08.55.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 08:55:43 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id s15so17377682ild.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:55:42 -0800 (PST)
X-Received: by 2002:a05:6e02:1aa2:: with SMTP id l2mr227461ilv.114.1636995342360;
 Mon, 15 Nov 2021 08:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20211115154201.46579-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211115154201.46579-1-andriy.shevchenko@linux.intel.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 15 Nov 2021 08:55:06 -0800
X-Gmail-Original-Message-ID: <CAE=gft5CXQaC3M-LoWtY_TEnBEdK-kR9uH_Zqp1y6EDWyXdaYg@mail.gmail.com>
Message-ID: <CAE=gft5CXQaC3M-LoWtY_TEnBEdK-kR9uH_Zqp1y6EDWyXdaYg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] i2c: mux: gpio: Replace custom acpi_get_local_address()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 7:42 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Recently ACPI gained the acpi_get_local_address() API which may be used
> instead of home grown i2c_mux_gpio_get_acpi_adr().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
