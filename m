Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7195C453DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 02:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhKQBbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 20:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhKQBbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 20:31:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8B9C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:28:09 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z10so3061847edc.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 17:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzvlfo3mwRIjVNI3uBTsFictJR41rZxk5TeM/Ei1okM=;
        b=dY7xWxkn7EP7A0fQBKQJAS/t/i7hXMR3B340Y/elUV8VDoipVyFbxy5jMONgm4naWQ
         H8dqN6lbybISfOjw5fnLKUkLxN5/BGp6sibWyRuKLrkVn1r9GGXspRVHL8tGN/UYmwb0
         STaq9YjmufwVATs+jU7/L8dVTgNaP/Wo13DvnHmiMCvRu5VFNlootrnqj8YCfB8HZGMg
         PjxybDwrZNpkpAyCAPI9cpgCbZCvEGKnnMNuIL6qKCOP6i7dSXiUBsCtiZVtNOIEPcjD
         VVjwoLdDhIadxmgDtD8wfExhWrl2aExZok3xu0N/bFAiKC4MQxK7Uck8Ig6e+T2EnkZB
         JdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzvlfo3mwRIjVNI3uBTsFictJR41rZxk5TeM/Ei1okM=;
        b=fF1f51WYStO7s3SnKWVeVWKzmxyf7/u0XOfX6vZ4bnf82dxtueoRYppZgJzuuLsEaW
         l49l3+H9UTWSIgskc2BbVUNmvoe1WKkT3ip7OjJ//wjCgT9P6BxBbzRPps7gi0T8mNlz
         iPbpxu1kSsFqBMF7XZbz8XGa3a9QeyzXgqC9CT7hl4zJgNOyLX9AcRzCGvFnKPvh6L0e
         WzRs+ZF+2b4JUikfAvZv1ymFw0MsARHrhjC/sZEA/Rgr57O8UCECV6F3QgWbKvxw0/Bs
         acyMw7330SBzAjsps8Q5/6bEfAtitk/cW9FWnTfKejH05IsN73+ljHoj03NzC1k281jt
         AFiA==
X-Gm-Message-State: AOAM531qN3DAk3jPRW+rgEECP5hAyJBocuEUuRKfqRPp3owiWi1aYI4Y
        fvtbRyw/deSvoDk0KLQlhbRL8xd4t0dFf/e4Gx95fg==
X-Google-Smtp-Source: ABdhPJz8mPrCc7kO/eC8/+0RnyK+b3AbY3p624T+emqGvUizx5GBVl4RNjW24qFhHOr0XuvwQ4Abd5P+LJhWQMTB2t4=
X-Received: by 2002:a17:907:9487:: with SMTP id dm7mr16812462ejc.95.1637112487826;
 Tue, 16 Nov 2021 17:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20211025015156.33133-1-brad@pensando.io> <20211025015156.33133-4-brad@pensando.io>
 <YXhErvvSfKIBvHae@robh.at.kernel.org> <CAK9rFnyk=gW_ZRZUci3byu=DNwdrmKBb30HQgxK0iWJuVVPbfQ@mail.gmail.com>
In-Reply-To: <CAK9rFnyk=gW_ZRZUci3byu=DNwdrmKBb30HQgxK0iWJuVVPbfQ@mail.gmail.com>
From:   Brad Larson <brad@pensando.io>
Date:   Tue, 16 Nov 2021 17:27:57 -0800
Message-ID: <CAK9rFnzvcOmEUXYufa4R42xo+SY1Bq_Txfj=Y1QhkAVwfv-oXw@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] dt-bindings: mmc: Add Pensando Elba SoC binding
To:     Rob Herring <robh@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Nov 16, 2021 at 5:21 PM Brad Larson <brad@pensando.io> wrote:
>
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - microchip,mpfs-sd4hc

"microchip,mpfs-sd4hc" was inadvertently removed in moving to
5.16.0-rc1 and won't be in the re-spin of the patchset, its recently
added.

Also, as you mentioned the patchset should be sent against rc1

Thanks
Brad
