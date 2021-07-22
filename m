Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF8A3D263D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhGVOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 10:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232403AbhGVOLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 10:11:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87DC661287;
        Thu, 22 Jul 2021 14:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626965545;
        bh=Z200EX+5HDJ6PjQgqSVr7z0wv8JhNwb0KyOjUzzQn8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XUezO4uAl16RGId9rEQC8Fi0hkMsAxUIUa2TP6UMMVVw6tjA3txe4PDeyJNXMDM22
         4jpDuAZle5+8Uug6u0nrpjqvTEWSe2YjkKhErgVWV7h4kFgCLdP5bkXKwScIpTRJWo
         y9AAON/q4DipNmkB8F10UxbAhn6dV6kXqHNOazwKLZ4xUjqQ3bVe/wwvwdzkjnwcGi
         NLdV8iEJaV6vKpWQxcrp5YvCTzIVsv+ziU9HGJEyxE6sHclDeTuQZ9EJmTjPpAmE+T
         Br7h2IY1LRYryDejXf2CaskgupfLaWHeDr60b96ytg/wet+fusBL8oJOLliwBgDn+7
         yGI/X+7ASJt1Q==
Received: by mail-wr1-f48.google.com with SMTP id k4so6253274wrc.8;
        Thu, 22 Jul 2021 07:52:25 -0700 (PDT)
X-Gm-Message-State: AOAM5314/fdiunylhbMG/4QvE8p46kL/spKZ+c3InD5WeCryfkBW6OTR
        cHMOxRKnEK/VVWrNRSsk/FVNWeJ82ZHmICpPVaE=
X-Google-Smtp-Source: ABdhPJznWXbF03Iq8bIl0uOktaOeMXJCwujQZBTwdO+wrMACSquTC8MCA1kkExxv3em/0QSfRmKwfRgikaSRFqDr6nE=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr330808wrw.105.1626965544187;
 Thu, 22 Jul 2021 07:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626947324.git.viresh.kumar@linaro.org> <026ad5f274d64d46590623f9f3a04b8abfbe62d7.1626947324.git.viresh.kumar@linaro.org>
In-Reply-To: <026ad5f274d64d46590623f9f3a04b8abfbe62d7.1626947324.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 22 Jul 2021 16:52:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0iQ5dt_38Y9j6XCoj=n7YA+cPz7i6mjP24k9WY7QL+oA@mail.gmail.com>
Message-ID: <CAK8P3a0iQ5dt_38Y9j6XCoj=n7YA+cPz7i6mjP24k9WY7QL+oA@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] virtio: Bind virtio device to device-tree node
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> +/* Virtio device compatibles and IDs */
> +static const struct of_device_id of_virtio_devices[] = {
> +       { .compatible = "virtio,22", .data = (void *)VIRTIO_ID_I2C_ADAPTER },
> +       { .compatible = "virtio,29", .data = (void *)VIRTIO_ID_GPIO },
> +       { }
> +};
> +
> +static int virtio_device_of_init(struct virtio_device *dev)
> +{
> +       struct device_node *np, *pnode = dev->dev.parent->of_node;
> +       const struct of_device_id *match;
> +       int ret, count;
> +
> +       if (!pnode)
> +               return 0;
> +
> +       count = of_get_available_child_count(pnode);
> +       if (!count)
> +               return 0;
> +
> +       /* There can be only 1 child node */
> +       if (WARN_ON(count > 1))
> +               return -EINVAL;
> +
> +       np = of_get_next_available_child(pnode, NULL);
> +       if (WARN_ON(!np))
> +               return -ENODEV;
> +
> +       match = of_match_node(of_virtio_devices, np);
> +       if (!match) {
> +               ret = -ENODEV;
> +               goto out;
> +       }

I think it would be better not to have to enumerate the of_virtio_devices[]
strings, but instead use of_device_is_compatible() to match against
"virtio,%d". Otherwise we end up modifying this function for every
virtio driver that needs a binding.

       Arnd
