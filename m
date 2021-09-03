Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C471400658
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 22:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350037AbhICULw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 16:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbhICULv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 16:11:51 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5EC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 13:10:51 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 6so565326oiy.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 13:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3m9UVTKaP/6MZzcOogo7hIJQvVYSfkAKBC56K4U8VTM=;
        b=GrdpQ6Wm8xj/RMTJ6mQl2OTOpaU2meTOouAFtAc60sqfJi69iOsDcTZAQzG3AuHEqw
         9k91954F9HddOaLDgTqo4qqgaHXs3T96lYO7HmUIijzX9o2sYpxxqExrK2DmZqvka3sk
         SYZO2pJqhBeZwFKPj8EsFq+hLXHcKcAQI/tFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3m9UVTKaP/6MZzcOogo7hIJQvVYSfkAKBC56K4U8VTM=;
        b=ZXkzFhDM6lBzpD8AT02APHSvb9Y4WZRZeuVAr2LukTYS7/c75wxD3ebJ6/myOyKF6G
         Zz/RorCRfT8HU/2OehmYDX3xDqRHmU7/zidCYAqBxQ8wgwgBHN3gWD74WS4kZEsZZwHb
         PrJwMPvIF080P3Py+LUB3YERVdxLQc6P4FghnUcO1Fs/6hpf2OIt0we0hNg3CVrbsu1L
         hKGirtuhh8YWuO3zTUxr44cTbg4NR1GBPpuShb6LZnoQTKOwGtAgElUXTX2F77wZpcB+
         ZJ1Cj4Jm6wUpYZDHrmgsv+9ph45Z3Jqo/XlXCJVQwmGBezCkNjZk+0fkxllOXXxb30fB
         e6yA==
X-Gm-Message-State: AOAM532T/eJ5AYS+Suf2tQjhT2d+w6U0/qNZGmcd400/0CieRcj9lLls
        2D3M0apM/t6q27ciuv6WQzxXQv65Wtw+Jw==
X-Google-Smtp-Source: ABdhPJxZgmnGBuWUrzorD0W+IAA6aMIILSp5zHLJ0fngve1Dn55CZb5uptcvcWBgmf3FaByRCEuolg==
X-Received: by 2002:aca:6041:: with SMTP id u62mr447325oib.82.1630699849879;
        Fri, 03 Sep 2021 13:10:49 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id q13sm76700ota.17.2021.09.03.13.10.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 13:10:49 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id bi4so558027oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 13:10:48 -0700 (PDT)
X-Received: by 2002:aca:4557:: with SMTP id s84mr414577oia.77.1630699848430;
 Fri, 03 Sep 2021 13:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
 <20210901150840.GF5976@sirena.org.uk> <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
 <20210902170613.GG11164@sirena.org.uk> <CA+ASDXPJO=F+fa2zE4LDdRzMjgiugJfuzZKnZ-pndagVtw++Ug@mail.gmail.com>
 <20210903111023.GE4932@sirena.org.uk> <CA+ASDXM7GrbahVyneW=TwHi9Uu7sF+7GcC=U0866_m=GXnFmtQ@mail.gmail.com>
 <20210903175414.GO4932@sirena.org.uk>
In-Reply-To: <20210903175414.GO4932@sirena.org.uk>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 3 Sep 2021 13:10:37 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPQMxCoWzFXEGqi6M0NPPhOXzE=ODMqvoKYq7XDdHCP8Q@mail.gmail.com>
Message-ID: <CA+ASDXPQMxCoWzFXEGqi6M0NPPhOXzE=ODMqvoKYq7XDdHCP8Q@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: resolve supply voltage deferral silently
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 10:54 AM Mark Brown <broonie@kernel.org> wrote:
> I've queued it for v5.16, I'm likely to move it to v5.15 - it's just
> warnings on a very small subset of systems but OTOH it's pretty safe.

Thanks! I'm OK with either. It's not a critical issue (log spam), but
in a way it's a small regression.

Brian
