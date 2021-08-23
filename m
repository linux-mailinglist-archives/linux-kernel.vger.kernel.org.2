Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CBE3F52B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 23:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhHWVUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 17:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232724AbhHWVUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:20:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 253C2613D5;
        Mon, 23 Aug 2021 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629753600;
        bh=2OGkwzJxQay8Lrkj6GAAwN64s4e0d3mH+a/eXPiSdIo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=REAzUuz8JUQv76UNOUUdxBzoQiHtLjpr+QP7bb+GoUhwblAIE21Lizevfzrr3i9++
         iBnsIkC14x34wt3NErXeHFx8+1J1lbafVlCLBL1QY44yaXIhCkcLWdt4nQeeWBhSvN
         WMDKNzCzwH91AqKSywwijGIUCw69PEk9856PjgV2rBC0PQNyLcU0+1PM43yk09gBfe
         d2dNFKhhpLNR0sqhMl22dGT9DRzqBaHbGiwJ9ZS1gz+dQZnLAqByYyJuiJM5BtUiAQ
         7ENtmso2Q3WsbSb5ydlmsXrmcQtPgLIzWggwI9gDZQKA1VaFBd8sNHh0NGRGYrKTbB
         Pt1ojrqSlKQ7w==
Received: by mail-ed1-f47.google.com with SMTP id i6so28311296edu.1;
        Mon, 23 Aug 2021 14:20:00 -0700 (PDT)
X-Gm-Message-State: AOAM531UVMGjY7URxhpXIpHTMrypfshNAij2eyM664McPRj/8TlEZtGw
        oaxdRU9EhPRZoaJ+dhM3Tk1pGgPRR6TsOIglaQ==
X-Google-Smtp-Source: ABdhPJy4qwuP7eNEgB8CJGomnX/HXxW3WFg0te7Ac41HlE2QIYEXWyJAKf8Zc93OtPb+2pnel9vzNAwYWqhXnj8+YJ8=
X-Received: by 2002:aa7:d1d3:: with SMTP id g19mr2747076edp.373.1629753598411;
 Mon, 23 Aug 2021 14:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210819182544.224121-1-krzysztof.kozlowski@canonical.com> <441b28c9-a997-7143-825f-f272e399d60f@roeck-us.net>
In-Reply-To: <441b28c9-a997-7143-825f-f272e399d60f@roeck-us.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 23 Aug 2021 16:19:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKJgvK8g+zbzLCBxnKbgAioBcdHWNAvqe4Z9BzkNMwPpA@mail.gmail.com>
Message-ID: <CAL_JsqKJgvK8g+zbzLCBxnKbgAioBcdHWNAvqe4Z9BzkNMwPpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: merge max1619 into trivial devices
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jiri Kosina <trivial@kernel.org>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 9:26 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/19/21 11:25 AM, Krzysztof Kozlowski wrote:
> > Ther Maxim max1619 bindings are trivial, so simply merge it into
> > trivial-devices.yaml.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> Do we have a general guideline on how to handle such trivial bindings ?

Not really. I debate (with myself) just getting rid of it as I suspect
lots of bindings are just incomplete. Like should supplies be
required? But it's convenient to have and not duplicate a bunch of
boilerplate.

> I normally leave it up to the driver author to decide one way or another.

Me too.

This one looks simple enough to be in trivial-devices, so I'll take
having a schema over not.

Rob
