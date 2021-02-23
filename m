Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFDD3226D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 09:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhBWIGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 03:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232128AbhBWIGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 03:06:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9D1E64E3F
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 08:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614067524;
        bh=DEfLwojdN2tmIGnM/YjvaE+dYcaDTBiA3iiough4Sp4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uX2oKxWViV2GbLq5Xisdw64JCWv/alzilFlenPunOnKDk6csIyZuFiBe6bHD/cMyA
         dRsKSjTFg4o2WAbXZiuwy3hOcTSi51prww1DzxGCQeI0Wj1/3elj/+CdlbhFMLLe7S
         omdpoeD6g9GIPd4SGletS4Zb9pOfdvHPSKlaIXQaxeCJA0LlL8pGHck5GhU9YDHjbK
         1+WBrt+4kZ8ZKUo5uIG6Pw2cmEWcpmtBiGIOHXCKI54z4aCkCBLrTLmEHpe/6MU1YZ
         NfBXml7Sqp2XHati67K3uybi+8UnkJEindi4QqR04bV85RWSWHF3OoxXoLjIxwvoGD
         a9YE4y5s3h0/g==
Received: by mail-ot1-f48.google.com with SMTP id 105so8317411otd.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 00:05:24 -0800 (PST)
X-Gm-Message-State: AOAM533lkriF4dz+IdET+A6WlHSrjTjHso79IAmN+UOBntZ2GOS28l83
        +HhoVMmpQlta4nRdzPinFa0S2PbDbDAXXG0Vn+E=
X-Google-Smtp-Source: ABdhPJw2rmp4NmE3d/5BbJg6XYhZOdAaovkMFXMuk9tRuR4CWUOfEG2mGikmKxxiUAho94+3Lt7V+0SrpmwECWz7Hgc=
X-Received: by 2002:a9d:6b8b:: with SMTP id b11mr721484otq.210.1614067522018;
 Tue, 23 Feb 2021 00:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20210223061905.422659-1-jasowang@redhat.com> <20210223061905.422659-2-jasowang@redhat.com>
In-Reply-To: <20210223061905.422659-2-jasowang@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 23 Feb 2021 09:05:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1b+76bdHFnFEM7bUrfqkasGziR7cLkgRa5jUOaL1FZgw@mail.gmail.com>
Message-ID: <CAK8P3a1b+76bdHFnFEM7bUrfqkasGziR7cLkgRa5jUOaL1FZgw@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        shahafs@mellanox.com, sgarzare@redhat.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 7:19 AM Jason Wang <jasowang@redhat.com> wrote:
>
> We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
> lot of confusion. E.g it may break various default configs which want
> virtio devices.
>
> So this patch fixes this by hiding the prompot and documenting the
> dependency. While at it, rename the module to VIRTIO_PCI_LIB.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Guenter Roeck <linux@roeck-us.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>
