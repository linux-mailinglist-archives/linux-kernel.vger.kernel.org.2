Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DEE3F52A0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 23:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhHWVNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 17:13:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232712AbhHWVNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:13:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE918613A8;
        Mon, 23 Aug 2021 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629753154;
        bh=FO5V+VvVNyFCl7iIUHP7YYXHV+zjbkZDH/GJy0SP/MY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QxKdriVB0R+F8JZKpRqrmIRvpaNmLjZ6pns3DFxGf+1MivtWY3/95+gGIGAik068D
         ekiRbdeWC5O6yV4R7cSwK9KJeeef+g9179ktK63zOfRGo8663N4HRCwt5nPKtF+h01
         QiPVjPebnfMiWXxdZnL8cmDdkMVxr08GJrV85u0JRLZZ4+CsIUnKqHj3aTtOJIThGs
         pPV2UTbiTH3avy+F5lJC5X9dl9v7rfxP74HO+FS5sYAMGkNq832lmz9M1/0WsPKBnY
         8igt/ggGhSS0XSJguLQx0jFiO+y2sGfYVkrZJIWA6NmrAUwy4QbccOmh/qauZIzvUk
         M5a1AwL4YhAHg==
Received: by mail-ej1-f49.google.com with SMTP id x11so39882227ejv.0;
        Mon, 23 Aug 2021 14:12:34 -0700 (PDT)
X-Gm-Message-State: AOAM530gqtdaLsD9j4kFm5yJTKBqrhgEpdcIYhgliP6gHLRdCijtkdf4
        gTSMrDi1sG5G4HGm+Rx+WZYGc01ZHn2vBFfjFA==
X-Google-Smtp-Source: ABdhPJyFFpTaNQ8lP7elawiHjryXjUyNIjLJbOKH1rXHXIM1ruMxr0K30c8RNAyuz0Af6ey+tZYmAW6/6Ul8sjBE9wU=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr37973428eje.341.1629753153543;
 Mon, 23 Aug 2021 14:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210819182544.224121-1-krzysztof.kozlowski@canonical.com>
 <20210819182544.224121-2-krzysztof.kozlowski@canonical.com> <fffdaaad-ac75-5c2f-6a31-7cdc3e57de20@roeck-us.net>
In-Reply-To: <fffdaaad-ac75-5c2f-6a31-7cdc3e57de20@roeck-us.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 23 Aug 2021 16:12:22 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+EXrMRFSwQKW2SOO2fgB48ACD6yXaujat9AbgxdG0_BA@mail.gmail.com>
Message-ID: <CAL_Jsq+EXrMRFSwQKW2SOO2fgB48ACD6yXaujat9AbgxdG0_BA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: merge max31785 into trivial devices
To:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jiri Kosina <trivial@kernel.org>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 9:23 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/19/21 11:25 AM, Krzysztof Kozlowski wrote:
> > Ther Maxim max31785 bindings are trivial, so simply merge it into
> > trivial-devices.yaml.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >   .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
>
> Not sure if that is a good idea. It would make more sense to standardize the
> properties needed by the driver/chip instead (see existing dts files in the kernel).

This device is certainly not trivial, the binding is just incomplete.

Device specific fan controller bindings are something I'm just going
to reject until someone comes up with something common.

Rob
