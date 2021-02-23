Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC8E322E03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhBWPwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbhBWPv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:51:28 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0702C06178B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:50:47 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id o3so8322207oic.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=23xyttMgUTUc74O8PSZq50RUnpnu4HEpSjkkgbeXd50=;
        b=bWUUd7DRJ8fxiVDrm/GbzrK0jpBnaJpLAtCLK9iG3/HaqQJokjax0+3WT+am9QiZO/
         g5ks13ahhiLhszxDWHhPnIybHmixq98QENtwdhuU3eyktbjdG07uYNZK4XQxTdKTnlha
         GLAE4nSk/+jVaOrO7Kr67vFh3v2Izhnw8v2jWqY1pmra+HMMqYMTF+7uOpQvDuxYTw8z
         Ebj5uAHeP886aLV711ncIe0L+3N/ideu1m5BqR7l0hQfNSIzf2iGL4jQWv/c9qbmgRRO
         3GSECONOt3uriBqOprSCId+ynebzD/ODb6KxRzt6P9AGQ4e1UgibMcAEkILVwQbMkC32
         jKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=23xyttMgUTUc74O8PSZq50RUnpnu4HEpSjkkgbeXd50=;
        b=TJK2dYqs70xLG6nyP1EKnGOxkffOQDHWU089/0TmjJX/E6uU+n0TtVp57HX2D7htMM
         PZqYsXKZOV5xEO0TOH62lxVbC3h9FdHqUTtK1azAJbTshEIzguH40j/LOrrI+rcJ5L/F
         UB0Nva9Kg69y901UhQ4fZmdf9cKFqL1xDWqwEtL4l4LLATMDHSSvr8iJ6J6YK8OfSVu7
         zzN2YZwbi+SMy9ZWnu80Ff0k3vbcm16a5vMEKt2nGQ7uz5hIXaYkz46LUzycux1ViuFI
         pRUAXZs8iQh2yyyuMsUyZ5fMaTna+9zxrn4GY1mF765fWLHqV8c79W/JTG3z4TlXoMG2
         oY3g==
X-Gm-Message-State: AOAM531IL1MoPoiy7a9MnStinC+0tKXTXxzAiIdlMFMnMKwKu76FTQ8Z
        tOA4x7l4L6A8jCJ+l8KcPZUnXnX4HrZo1NJbJkxe0oAuxV4=
X-Google-Smtp-Source: ABdhPJwmLfj4P+YB6TA3SbUyXZUMALrC8Q5ZBxxZShUXhi/jO2OYGG1maell7wrySj7E7LUovTo2SSHWlKKikjQ3y6w=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr19426724oiw.161.1614095447221;
 Tue, 23 Feb 2021 07:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20210223061905.422659-1-jasowang@redhat.com> <20210223061905.422659-2-jasowang@redhat.com>
 <533886b3-9979-7a51-5b44-eeefad242cdf@roeck-us.net>
In-Reply-To: <533886b3-9979-7a51-5b44-eeefad242cdf@roeck-us.net>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Tue, 23 Feb 2021 09:50:35 -0600
Message-ID: <CAEUSe7-g=O_=G1fzjLwjQH1taj0YZYKt=874mUxcM-qGv51+9g@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
To:     Guenter Roeck <linux@roeck-us.net>,
        Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>, shahafs@mellanox.com,
        sgarzare@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

If I may add to the nit-picking...

On Tue, 23 Feb 2021 at 09:23, Guenter Roeck <linux@roeck-us.net> wrote:
> On 2/22/21 10:19 PM, Jason Wang wrote:
> > We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
> > lot of confusion. E.g it may break various default configs which want
> > virtio devices.
> >
> > So this patch fixes this by hiding the prompot and documenting the

*prompt

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
