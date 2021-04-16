Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9643361C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbhDPIqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237554AbhDPIqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:46:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1383D611AB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618562747;
        bh=hCKXjUHUPAyf45wnAsMpCP6D5beOeU9GECgSJ/13C7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=htdCqZ6wfjndMFgb8WAew3IkIluieTP4Q/9P4rXkM85GUltahHXOct+oC94HZNm31
         bwkNPuqbtPtzjcJLb3JwI3IBRjSL1ngxafBLGGJjmcl+RaQpv8MqbIQUC7MPfBefjl
         CKuNYgfcZoo1pQiTbMWFMugJQ+JS5WlGUA81oqfvbZjVjaoldv7t+lO6x5/eXVO9t+
         YVtTgY3dMhl5QLTY2a7BreAtgOOFQ49YhI54zt6kDwlUGlx09spL2bVUShjZjSw9u5
         g4kYi5wwhJ8kSIw7xVGKhIkXJ7t8Y1QPz7g9MjM9FCc68rzdl+JxONB0gc7K3TWAcZ
         xwoyR96bpsQhA==
Received: by mail-ej1-f54.google.com with SMTP id sd23so32336944ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 01:45:46 -0700 (PDT)
X-Gm-Message-State: AOAM531xp7pSf02q2a9/e/Oq43J0OnCb30WEeExukc3CZ1LaV8TnznHF
        II5q7B8viNpppmomD30doayDhxfchfu8t0vKhLk=
X-Google-Smtp-Source: ABdhPJyUdDY1GQvKomVNa7nqkZMOnakaL2C4Hh3p9QW9Gq2XkHNgYsyN8U6zoFkRAmMIZocoiOhmenRVIl6j9BDV+Uw=
X-Received: by 2002:a17:906:ece1:: with SMTP id qt1mr7479973ejb.385.1618562745621;
 Fri, 16 Apr 2021 01:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210416034712.7891-1-zhuguangqing83@gmail.com>
In-Reply-To: <20210416034712.7891-1-zhuguangqing83@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 16 Apr 2021 10:45:33 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe+eK-2cZ2h-WUUrfPwkXrHGopaEmx0Kwjsa4Nqq0DyeA@mail.gmail.com>
Message-ID: <CAJKOXPe+eK-2cZ2h-WUUrfPwkXrHGopaEmx0Kwjsa4Nqq0DyeA@mail.gmail.com>
Subject: Re: [PATCH] regulator: mt6360: Fix missing IRQF_ONESHOT as only
 threaded handler
To:     zhuguangqing83@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 at 06:30, <zhuguangqing83@gmail.com> wrote:
>
> From: Guangqing Zhu <zhuguangqing83@gmail.com>
>
> Coccinelle noticed:
> drivers/regulator/mt6360-regulator.c:386:8-33: ERROR: Threaded IRQ with no
> primary handler requested without IRQF_ONESHOT

This should be tested. There are several patches like this all over
the tree so it looks like "let's fix everything from Coccinelle"
because you ignored at least in some of the cases that the handler is
not the primary one. I am not saying that the change is bad, but
rather it looks automated.

Best regards,
Krzysztof
