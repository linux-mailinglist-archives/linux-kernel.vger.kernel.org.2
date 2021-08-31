Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38393FC4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbhHaJ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 05:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbhHaJ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 05:28:49 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF6C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:27:53 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id f15so33607673ybg.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 02:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvU6/kNO6BmgLZdZi9C93PdhUJWXGIVS2UePKqfl7t0=;
        b=ilcNsFxX4umMG2CqqyP97p+rY0Uq+DWK9JC4QIbNckV7q196RHIPwo/M+VeOTiy5hV
         GDIrYq1sV3k/ReEidF56v+OjGdBo5uNr5bIyoTT1mK75hyfB/e7xzosCdufIiK//dDqz
         DDkhqTbPj9HODAr08IfoDDaz2+mzfqH4plNuxIji8V1fdam3wnmO8sdYndUA9nrMSRro
         CidTQf1P0UWJzY0gHfSmYW29OPBx5tgKX752NR6G6jT9a5fiRGeLKZxA9unmYyRC0n4L
         0wiAH8/8y8RFv9slFhWIFD7NDe9DWSGQeBasmvkAUxMU0U71dTAh3GPFBev631DKy6E0
         0dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvU6/kNO6BmgLZdZi9C93PdhUJWXGIVS2UePKqfl7t0=;
        b=Q2R2EUpeJ+Y3CvpSwqbnyYaWRvB9GilROKyFsz9p6SlmmoQ7kEqjm0YqgPbZBU2YQ2
         1HV1k8pIz4RfjC2Wi+hWl27VsUtukOolBoABbbMBXsetzVoRGprH7bfXuJlpO59nhiHo
         c0fn/hqpyLojCO73hGbZ5fAOzCPqw0id3eZHXh2W/TYAVUZ4Zhx6MG6LgcQNU5ED78bf
         Ae+THj0HRFrHD/bdXwx0UGmsV0PWj0xT9IapdXlyhMcLRErr4YnpmtFW/3xf8VsDmQ2y
         BXX30dRp6TUnv/PYpwG9eQ4BfJPh3sBero2Ip0/jxT9DEY77CJIBMJV9PtpywRr0QoTE
         gAdA==
X-Gm-Message-State: AOAM533uN1xmMwi/dI8RaFjDQy1PMrNoUfkF32APqqrCFGqEpCDEO8UM
        hBWAg+rVCaHaPEovTJGVnqevRy9BVwo0EERNRqUo7A==
X-Google-Smtp-Source: ABdhPJzE9ePKcL+Dn/NnpVmOtnyvK0cq/ae0XcuYsFsBAyk6UvdthigXXv3B0IfgsGLMmGabblRTsDu031QMc+Wl+TU=
X-Received: by 2002:a05:6902:150c:: with SMTP id q12mr2006486ybu.25.1630402073108;
 Tue, 31 Aug 2021 02:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <76305b7e89006437b2a3ecf97f857231b2d4ae2a.1630391782.git.viresh.kumar@linaro.org>
In-Reply-To: <76305b7e89006437b2a3ecf97f857231b2d4ae2a.1630391782.git.viresh.kumar@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 31 Aug 2021 11:27:42 +0200
Message-ID: <CAMpxmJX-PapTN8Yt4dtCW3rimuWzAH+bXjhWP5Mf_8sJuz=PMg@mail.gmail.com>
Subject: Re: [PATCH] gpio: virtio: Add missing mailings lists in MAINTAINERS entry
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 8:39 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Add gpio and virtualization lists in the MAINTAINERS entry for Virtio
> gpio driver.
>
> Reported-by: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f632acd7d98c..da58964935d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19650,6 +19650,8 @@ F:      include/uapi/linux/virtio_fs.h
>  VIRTIO GPIO DRIVER
>  M:     Enrico Weigelt, metux IT consult <info@metux.net>
>  M:     Viresh Kumar <vireshk@kernel.org>
> +L:     linux-gpio@vger.kernel.org
> +L:     virtualization@lists.linux-foundation.org
>  S:     Maintained
>  F:     drivers/gpio/gpio-virtio.c
>  F:     include/uapi/linux/virtio_gpio.h
> --
> 2.31.1.272.g89b43f80a514
>

Applied, thanks!

Bart
