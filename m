Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7223D709C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhG0Hvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235621AbhG0Hvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:51:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF4DA6120A;
        Tue, 27 Jul 2021 07:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627372309;
        bh=N2yhUHFzYph7KZ5wl9QL58WERXQF7RT+if1eOPzjX8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UGIe+h6fnmh2uZqvtrMR7Qh4prgksTBZhP/PNQ9qxzGHPAqA4MecvUFqy46CGg8KI
         eHi+v5XfX5Zseib4SKydxd979SP8iEZkLCbVSDScrvvCL5RwCOIrz3n9xtp3slge92
         krGLxbxrG8GzEL4ozbFiXEJpJZP2hihFj7unOIT5Seuq6Y1GiY8r9UJWi4TbDGYvZ1
         6qXSVfjL1SLzUaUNggKYjOHeEWahI6KvYCOKJaHv66+V1qur+JCN/IvySRLEBf4T7r
         HNtuj6qs4sMHUWzfLw1XQCIeyTndBtAG+AOGLugYUPXi9OAUwblykaSfv0m0Zoun0A
         8a+v/DaJuIRyQ==
Received: by mail-wr1-f54.google.com with SMTP id l18so6352665wrv.5;
        Tue, 27 Jul 2021 00:51:49 -0700 (PDT)
X-Gm-Message-State: AOAM533KeErdCuhD2PX7p9GYyVUMbNe6uxT2VgoldQy5ZxOlX/DgoQjP
        oyi0SPVVAy6mJrfl/vaQu47weyRexwNcOhUmAv4=
X-Google-Smtp-Source: ABdhPJzkrTpoW9lwm549EDKKK2/4LDrs+jDmhB7qtu0+t4r2k9JLz61Q10pGG6nnTX4k+EReornpLTFGprOjpOJmKHM=
X-Received: by 2002:adf:f446:: with SMTP id f6mr10414343wrp.361.1627372308302;
 Tue, 27 Jul 2021 00:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627362340.git.viresh.kumar@linaro.org> <d8319fd18df7086b12cdcc23193c313893aa071a.1627362340.git.viresh.kumar@linaro.org>
In-Reply-To: <d8319fd18df7086b12cdcc23193c313893aa071a.1627362340.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Jul 2021 09:51:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Y_c1ECp-bFyvkyoDAbivWLvgXDL+gyfJxsWo213Nu1A@mail.gmail.com>
Message-ID: <CAK8P3a0Y_c1ECp-bFyvkyoDAbivWLvgXDL+gyfJxsWo213Nu1A@mail.gmail.com>
Subject: Re: [PATCH V4 1/5] dt-bindings: virtio: Add binding for virtio devices
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

On Tue, Jul 27, 2021 at 7:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Allow virtio device sub-nodes to be added to the virtio mmio or pci
> nodes. The compatible property for virtio device must be of the format
> "virtio,device<ID>", where ID is virtio device ID in hexadecimal format.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
