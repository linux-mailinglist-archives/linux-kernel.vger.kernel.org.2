Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14023C7FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbhGNIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhGNIXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:23:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D2AC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:20:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id qb4so1942109ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F8Io+rg1Po7RKIeX6xd4nWzyFfLG9bRShMsVJw7hf0Q=;
        b=BqDNNSk7ZSAQK4poF+WsKbLWA5YzfU2H6DRP7g8AhtSDx5oKXqIwkX0gVqTCYATcr6
         KdZNQhf6s/NGfcPR7o2nXA1mgBXVkIW0M/UZ3+t8xQbVX48lyvKTcbI5hpf3lcsDlluq
         ws/Jpup4YIz+yoWrpKldXbBmt9Su6Kr7udKSTTIXkAVmGiqUXOxIKBMuExp8lx/W+Dma
         Zmc60wFDKsTgka2ASyEWGzS2eqPr6GKDIYk5gBnrU3AGYkFP/JXIz/A83L1wX+N/Ty1e
         QESK19pnJYhm5QTym0rIpglmWTStHqJFnCF0KheLKuNv1HUlqrZZlyxwYvjuO9TBlI26
         a5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F8Io+rg1Po7RKIeX6xd4nWzyFfLG9bRShMsVJw7hf0Q=;
        b=f6qdYvGO0Y4LB7udnMFduwVT2LY0WbjggxrPgwoKM51ZIWjcKvI4ehhJGS1UCXeIHS
         atbuTBEm5n31ndQTF5mwVMAE1erTQT633R76vhffSIdqtwTwbVfpZy473hf20baESkJw
         L3FCQzMzST74KHuUkyhYUDJwD31Fcz5UyqNGFk4EJ+ieiE9dQVI2X7ibj884/6jfHx5t
         DyTlWFTtx0KcfUHzoymEaZLII7zzSOIfKglD9nqp1BgPUxMIEG5IM0ekjLak0T7ENKsx
         w8eQMuz+Q639lKCJlDaiAHt3DV58ZNSf6zB1o/TgdiX3Y+1QEWHHSWD+2D5jZtwFUGwa
         MDFA==
X-Gm-Message-State: AOAM531eeD3B13BCDIcqzs+Xm5spIkrcRG9N68XkQeTcDZk4x50RcLkc
        EAEzko9KGaVqgYKuenizXvw3ag==
X-Google-Smtp-Source: ABdhPJzyuroGTikKGPkfvMs8+Wj2CvFr44B6AtpScg3Pu1k9Wf/sWWAM9fXM7DM7RVR/SHddJJE5BQ==
X-Received: by 2002:a17:906:24c3:: with SMTP id f3mr11047240ejb.145.1626250841411;
        Wed, 14 Jul 2021 01:20:41 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id s5sm602820edi.93.2021.07.14.01.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 01:20:40 -0700 (PDT)
Date:   Wed, 14 Jul 2021 10:20:21 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <YO6eRXz/J1tPOi0P@myrica>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7>
 <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 10:34:03PM +0200, Arnd Bergmann wrote:
> > > Is it going to be a problem if two devices in kernel use the same
> > > of_node ?
> >
> > There shouldn't be. We have nodes be multiple providers (e.g clocks
> > and resets) already.
> 
> I think this would be a little different, but it can still work. There is in
> fact already some precedent of doing this, with Jean-Philippe's virtio-iommu
> binding, which is documented in both
> 
> Documentation/devicetree/bindings/virtio/iommu.txt
> Documentation/devicetree/bindings/virtio/mmio.txt
> 
> Unfortunately, those are still slightly different from where I think we should
> be going here, but it's probably close enough to fit into the general
> system.
> 
> What we have with virtio-iommu is two special hacks:
>  - on virtio-mmio, a node with 'compatible="virtio,mmio"' may optionally
>    have an '#iommu-cells=<1>', in which case we assume it's an iommu.
>  - for virtio-pci, the node has the standard PCI 'reg' property but a special
>    'compatible="virtio,pci-iommu"' property that I think is different from any
>    other PCI node.

Yes in retrospect I don't think the compatible property on the PCI
endpoint node is necessary nor useful, we could deprecate it. The OS gets
the IOMMU topology information early from 'iommus', 'iommu-map' and
'#iommu-cells' properties, which is the only reason we need this PCI
endpoint explicitly described in DT. The rest is discovered while probing
just like virtio-mmio.

Thanks,
Jean
