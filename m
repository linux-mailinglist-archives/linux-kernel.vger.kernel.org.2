Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8742E3DE02D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 21:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhHBTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 15:41:03 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:43787 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhHBTlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 15:41:00 -0400
Received: by mail-il1-f181.google.com with SMTP id x7so14169411ilh.10;
        Mon, 02 Aug 2021 12:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FJh25K50xXyjKPR6I/ZvrZUKOP39Op3Mf/ZgMwF4m0c=;
        b=D0GscuhHgu1AqkJR+Q2K3mbNINlAsnE4umSDKAR9RivpwpNHj8kCX16LS0tNF6DThw
         3GSdwtCCpKbY+SdaQeaDBmUzrDNJatXV/iwin//1r9tB93JSfOTzd1aO5/bJTNLEkiFB
         KCLnwEY9imzX4CWQsX98ZPhOPyrPbbDoNbqrvUoWyZTl7P6sMvH9dWUkLETogAncOpNx
         A3363qdvZNb1nWWuwyJyr+fThNErBENvPQTyNCxBfoio6sDUwfKa++abwADr5qX/FPhQ
         32a0/Pwo8wK2rl4ZxirMH8VL924RQctr7AMv3ezFRMZIU5wkI0/lgPj5nrqhu5ZbG8Ei
         BhOA==
X-Gm-Message-State: AOAM530Om0jc8haSPml1Kgf6PC+yB/r6qqN5L2aAmsGvaRqimBFdsFwx
        Pt09kl4Qd7chjrIfmHLwPg==
X-Google-Smtp-Source: ABdhPJwvggXn5Z7YudjXgOND2Yw8VhbJaXRXS3FG2BPqNK8V+7I6XJDO/pfIwMzl2HHkidmpbOccyA==
X-Received: by 2002:a92:d790:: with SMTP id d16mr589527iln.185.1627933250278;
        Mon, 02 Aug 2021 12:40:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 125sm8031665iow.9.2021.08.02.12.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 12:40:49 -0700 (PDT)
Received: (nullmailer pid 1475877 invoked by uid 1000);
        Mon, 02 Aug 2021 19:40:48 -0000
Date:   Mon, 2 Aug 2021 13:40:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        virtualization@lists.linux-foundation.org,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>,
        Jason Wang <jasowang@redhat.com>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jie Deng <jie.deng@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V4 1/5] dt-bindings: virtio: Add binding for virtio
 devices
Message-ID: <YQhKP3CvvVR5VmIA@robh.at.kernel.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <d8319fd18df7086b12cdcc23193c313893aa071a.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8319fd18df7086b12cdcc23193c313893aa071a.1627362340.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 10:53:48 +0530, Viresh Kumar wrote:
> Allow virtio device sub-nodes to be added to the virtio mmio or pci
> nodes. The compatible property for virtio device must be of the format
> "virtio,device<ID>", where ID is virtio device ID in hexadecimal format.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/virtio/mmio.yaml      |  3 +-
>  .../bindings/virtio/virtio-device.yaml        | 41 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
