Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70E031F730
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhBSKPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:15:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSKN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:13:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62EAC64EC7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 10:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613729568;
        bh=+rkOr32K/R3lXUFpe+EpMk0yx1sEZxKpjKiwALuXsgw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZWJi7OW80q1YL8rNR1033cdfsrMo0OsIANnug5s//t51KcjGrQmzcfrI9sRrlp8Uh
         Y0AjdB80r5RArApIzjJ2rS3+8RTmMr5yAghM2E7hzfCQTA8RZ8Frb9WbmQpQ2T4PD1
         sjwurbFkGKV8g43dAMV8KbAuOSFquDWI7+jKqpW9G1fDui48yJ4IIh5Io6s+LCbsZO
         XU2wDF3gZauiaUoH8yH0iOU6EqTZuSlWKxwidZjFRHdKJpwZcUrLlyRY311Q+RI+Gy
         IvQK28+JKR68Rn/Nwyq/lPZUT2ZC8aTZD52DWsVhnk70M7SneOmK9o0ZbQNQQMUeOW
         HnxtdwnhAj4SA==
Received: by mail-ot1-f41.google.com with SMTP id b16so4646982otq.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:12:48 -0800 (PST)
X-Gm-Message-State: AOAM532WLeAJQKISPS6DmKh+jM+uSOL5SWleKOM6PJP5zpupM+jFfQv4
        ptaGSVcticpm3CoHjzhTqjDw3i1W71W/Il7tx+E=
X-Google-Smtp-Source: ABdhPJxEECxvQi17Bs5FnBGof9CZxwJRFU+K1xpawbOCCMHcTPM2DYPgqifINaU54Ao9+aDUW+PB72OjcjRQGARCuTM=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr6161708oti.210.1613729567654;
 Fri, 19 Feb 2021 02:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20210219084509.48269-1-jasowang@redhat.com>
In-Reply-To: <20210219084509.48269-1-jasowang@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 19 Feb 2021 11:12:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wJDAA9X6se4EvSpoQTWyxdyeVt+8vfCCbTpe+Zqixew@mail.gmail.com>
Message-ID: <CAK8P3a3wJDAA9X6se4EvSpoQTWyxdyeVt+8vfCCbTpe+Zqixew@mail.gmail.com>
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 9:45 AM Jason Wang <jasowang@redhat.com> wrote:
>
> We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
> lot of confusion. E.g it may break various default configs which want
> virtio devices.
>
> So this patch fixes this by hide the prompot and document the
> dependency.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Note that this effectively makes VIRTIO_PCI_MODERN and VIRTIO_PCI
synonyms, so git goes back to not being able to have VIRTIO_PCI_MODERN
by itself, but it seems that this is ok because the legacy part was already
split out.

        Arnd
