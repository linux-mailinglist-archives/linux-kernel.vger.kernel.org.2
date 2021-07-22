Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E713D2219
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhGVJsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231609AbhGVJsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:48:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 092F06128A;
        Thu, 22 Jul 2021 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626949734;
        bh=dKkz0H90g75Jqm7Tv0Fj0nBgj32L9xL5yzrVGuWSxd0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ehlhd1I88u+UOpYo4uuAqDJZmujkb/zzPVO68lh4VsKsGbAS0GQ4bffDY+AG8w1FN
         uINgg9X0Rsdhl2h4+yj5HePRqRoB264TqfSaruZmiSobSFjJGp4yKJDNlq3p/QAKn5
         S4jscchMtclnJUaMy1PTWXVl8S3bsnHLdoeE5jLZLiCBMc44WNJOfxYJvLo+Gg4OQd
         g+3jlWjNayJINWCR10so/xuaYvomJM2mSIdsawcrv64x8LC91MYl1ohNrNvcCZBWUS
         lMcRBX8wZRdPfVe/caUtmAqM93EvkNz63XlJ3f+QPibA5XWwcTAx7s3jufOwqxkKa+
         pMd9MR3d8cmjQ==
Received: by mail-wr1-f52.google.com with SMTP id l7so5358077wrv.7;
        Thu, 22 Jul 2021 03:28:53 -0700 (PDT)
X-Gm-Message-State: AOAM53153SNi2JjWR+VIKnFtQdkm/AyknUsh8Ne/rsSMWuVUpaBscb9d
        Eek1s9igm2GwtNg60+UhQXiu9b9kayry1P5TrRo=
X-Google-Smtp-Source: ABdhPJxkSjTrQb/uN1KPB9MMMTm3daq3N1zrgRlAILlwLCIncbFfzr7m2+3Hu4Gw+BnhPDcRx+BoGjl3//ybpEvYzYw=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr49542874wrw.105.1626949732596;
 Thu, 22 Jul 2021 03:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626947324.git.viresh.kumar@linaro.org> <fced2f2b9dcf3f32f16866d7d104f46171316396.1626947324.git.viresh.kumar@linaro.org>
In-Reply-To: <fced2f2b9dcf3f32f16866d7d104f46171316396.1626947324.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 22 Jul 2021 12:28:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1jqtu1BJmnfFLEgNXsPCfiTzd0sxwJBxdgNySmETBQSg@mail.gmail.com>
Message-ID: <CAK8P3a1jqtu1BJmnfFLEgNXsPCfiTzd0sxwJBxdgNySmETBQSg@mail.gmail.com>
Subject: Re: [PATCH V2 1/5] dt-bindings: virtio: Add binding for virtio devices
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

On Thu, Jul 22, 2021 at 11:57 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Allow virtio device sub-nodes to be added to the virtio mmio or pci
> nodes. The compatible property for virtio device must be of format
> "virtio,<DID>", where DID is virtio device ID in hexadecimal format.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Looks good to me overall. One question would be for the exact format of
the 'compatible' string. After seeing this version, I would slightly prefer
"virtio,device22" over "virtio,22". I think in the previous version
we had mentioned both, but not actually decided on which one to use.

      Arnd
