Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE633D3748
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbhGWIUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 04:20:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234661AbhGWITa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:19:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EC0E60ED4;
        Fri, 23 Jul 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627030802;
        bh=i/SLSdoPGycqqQzXxoO/uSPvWizS46ohQxaCWaQwtHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U0NUWUCOKObXBlEcVLjvSg4l1ZOBFoYdqsuXa52obSdyAeWw1aYS0Qw5SpWHPMUwy
         nfkQ1BOQoasUsOiAwwRl1ruvIvwjNt+SF27To/+2qtKmUcESB1cW5cTUFjpyivckMk
         LbTy8mGifkRGCqkXEk6nGUNSFFDw4DuscDQfS8Ptl9XJJpiTHB4D/k+i0G2N7rnUEO
         LRMlDDPZS3cPmyA2mfwLU9GqTaeTGxJIqfRk28DTN1nrzNCvYAUczymrnZN+LykFLN
         BmsBCYEkWa3vNg8lnjsVOWQphkR6XT/Z024uQBrqEPw6dN+NRkKGdrEMNHBbIosq97
         YeM6WlaA3athA==
Received: by mail-wm1-f47.google.com with SMTP id a80-20020a1c98530000b0290245467f26a4so1214022wme.0;
        Fri, 23 Jul 2021 02:00:02 -0700 (PDT)
X-Gm-Message-State: AOAM532/TKjVQRAJbbivmkjARcdy27TYA9UqOMaHztjADvcWPuF8sFw3
        qjd1JqxpFOdk45ufcV7tqVcP2p5Df1+k2RHw2mg=
X-Google-Smtp-Source: ABdhPJwHPwcqUC1aYRuD0bi0jvic8ZST223S6CxliTeuDhn6Fo1iTMXFZnRu1HfyRZ/V3/3KSfYKv3UzRtGaneZPeZo=
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr13005903wmh.120.1627030800777;
 Fri, 23 Jul 2021 02:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <026ad5f274d64d46590623f9f3a04b8abfbe62d7.1626947324.git.viresh.kumar@linaro.org>
 <3606cdcc637682a3eb401d617e6e247431b78ec6.1627019436.git.viresh.kumar@linaro.org>
In-Reply-To: <3606cdcc637682a3eb401d617e6e247431b78ec6.1627019436.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 23 Jul 2021 10:59:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3-CesWmHMRst1_XP=CECAr19mT40ZiuK5ruEcW_qa24Q@mail.gmail.com>
Message-ID: <CAK8P3a3-CesWmHMRst1_XP=CECAr19mT40ZiuK5ruEcW_qa24Q@mail.gmail.com>
Subject: Re: [PATCH V2.1 5/5] virtio: Bind virtio device to device-tree node
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

On Fri, Jul 23, 2021 at 8:12 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Bind the virtio devices with their of_node. This will help users of the
> virtio devices to mention their dependencies on the device in the DT
> itself. Like GPIO pin users can use the phandle of the device node, or
> the node may contain more subnodes to add i2c or spi eeproms and other
> users.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
