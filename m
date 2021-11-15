Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA2A450644
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 15:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbhKOOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 09:09:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231947AbhKOOIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:08:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 174FB61B04;
        Mon, 15 Nov 2021 14:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636985159;
        bh=rH6w2Tv5TE/ay90akvXBUGtU2n38z3jN0OwAIzjofGM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cbCDl9IgS7fVetVCq71DGnmi1vl01Tj9h0qZphVzdwi0ednsO1v93KClGcqZNpXis
         BH8J+SD/b536q27ZkMYncvOpH+1OyZo/Jb1v/FNkHfvQINkHi3Bzt0XHQ9MrI29mpH
         jScRHr2EIiCKSCj2enHXbp2XGsyBoMkugi/QbotxhXaMnzBZuLgRiiOVk9VZYOBrVK
         KQd8Ycv5NABF/hEUQC9aiGOhKLHU/7UXE8t2z/a3BQZddBJZdibUD4EuZkVD5zst10
         cRBkgJVfnMdzjtBuzxqbbwqyo0cOZpdQFr1FeT1omR6JBGM92L8iAWjhA4pEcDpHDZ
         z22+4uE7qIqgQ==
Received: by mail-ed1-f47.google.com with SMTP id w1so72597683edd.10;
        Mon, 15 Nov 2021 06:05:58 -0800 (PST)
X-Gm-Message-State: AOAM5300c80lctaDWca6pJYRrXlVrfBX1Xt3IcTJQ3kyqr+m7kzw9Ak8
        pGjWh6G3NvY9cnKYUyx6CM4V4WzP2U2koe+lbw==
X-Google-Smtp-Source: ABdhPJyhazkQsfxsx3oh3spbeLIoRA78MZ2Hqpr6bPz+xydK9rUb8/6ASL5dx892ag0WEDGSvU/3gpvHK4K/2rs6jRU=
X-Received: by 2002:a17:907:7f25:: with SMTP id qf37mr50212262ejc.147.1636985157491;
 Mon, 15 Nov 2021 06:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20211115073240.3476043-1-calvinzhang.cool@gmail.com>
In-Reply-To: <20211115073240.3476043-1-calvinzhang.cool@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 15 Nov 2021 08:05:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLtG4m6hqKc0TJs+e8ZBRZSGgOAoumnvg7u_D46i5D_AA@mail.gmail.com>
Message-ID: <CAL_JsqLtG4m6hqKc0TJs+e8ZBRZSGgOAoumnvg7u_D46i5D_AA@mail.gmail.com>
Subject: Re: [PATCH v2] of: make MAX_RESERVED_REGIONS configurable
To:     Calvin Zhang <calvinzhang.cool@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 1:33 AM Calvin Zhang <calvinzhang.cool@gmail.com> wrote:
>
> MAX_RESERVED_REGIONS has changed several times. Max reserved regions
> count grows bigger as more SOC subsystems require reserved regions.
>
> Add a Kconfig for it so that when properly configured, the static
> reserved_mem array consumes less memory on systems with few reserved
> regions.

Please read prior discussions:

https://lore.kernel.org/all/?q=of+MAX_RESERVED_REGIONS

And these 2 in particular:

https://lore.kernel.org/all/CAL_JsqJQcWsguwfehAoaRf4o-2VqXxSzKzTqg7s4+N1bp=6V5Q@mail.gmail.com/
https://lore.kernel.org/all/CAL_JsqLGvUYQmCGXLgSO+6kFj2i87dpaTbMGbyu5oMt=eeu35A@mail.gmail.com/
