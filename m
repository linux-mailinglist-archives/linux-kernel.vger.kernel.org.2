Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E23B36E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhFXTZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:25:30 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:42756 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhFXTZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:25:21 -0400
Received: by mail-il1-f169.google.com with SMTP id h3so7437485ilc.9;
        Thu, 24 Jun 2021 12:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FObiRZ7IWgSRqkULNo4SwrdAdxQlc/wqkjjpbgOxgV4=;
        b=NkMBl3D2x4QEMa33fDwRZUTC4Znp+tI2XvCn/pTRKwomjZhcWjT75d52b5XzNthI0G
         J8f5WNMxky3vK1Y924NR7uAJHfZRUoN72GvDpau3weUXeve6BcOeXSAkMQFGCFdeKhNW
         mDdQvvLNTeqzMo7FIIZ/PDuOMJswT1tSHBhNdc9lHCR10LxEz/+9aoWi8kXbKShHb2yz
         DBlGliQU1uyAND7/N/a40abjtA9kkT1ccVQS3hTUdZqiKmH37X51I5RAagbyJaA8fmfV
         vYPMN5Sx89/kwQhbXkKrHccKLF05aqc2SjQ71ShGEjryFSPlV8DQxvjQfthPhrOs5BaT
         J9jA==
X-Gm-Message-State: AOAM530809/77uf2N7f32fXkBHS7/lStwzWwt0jNSltoiFWn1UmPR4Fe
        KBmHIq8l4fm/yizzy0M2YA==
X-Google-Smtp-Source: ABdhPJzEjFxbj1rCOIu3LTYs/mTe8TlXtzHhyiSc9VVWPhi8Wdd79t+9mOKtZpPlJtZ1v+UpfuzJOg==
X-Received: by 2002:a05:6e02:190a:: with SMTP id w10mr4930148ilu.238.1624562581835;
        Thu, 24 Jun 2021 12:23:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c10sm55041ild.72.2021.06.24.12.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:23:00 -0700 (PDT)
Received: (nullmailer pid 1842131 invoked by uid 1000);
        Thu, 24 Jun 2021 19:22:55 -0000
Date:   Thu, 24 Jun 2021 13:22:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     jean-philippe@linaro.org, Rob Herring <robh+dt@kernel.org>,
        vincent.guittot@linaro.org, alex.bennee@linaro.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        igor.skalkin@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com,
        linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        peter.hilber@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com,
        anton.yakovlev@opensynergy.com, souvik.chakravarty@arm.com,
        mikhail.golubev@opensynergy.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        james.quinlan@broadcom.com, etienne.carriere@linaro.org
Subject: Re: [PATCH v4 13/16] dt-bindings: arm: Add virtio transport for SCMI
Message-ID: <20210624192255.GA1842097@robh.at.kernel.org>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-14-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611165937.701-14-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 17:59:34 +0100, Cristian Marussi wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> Document the properties for arm,scmi-virtio compatible nodes.
> The backing virtio SCMI device is described in patch [1].
> 
> While doing that, make shmem property required only for pre-existing
> mailbox and smc transports, since virtio-scmi does not need it.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202102/msg00018.html
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: devicetree@vger.kernel.org
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> [ Peter: Adapted patch for submission to upstream. ]
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> [ Cristian: converted to yaml format, moved shmen required property. ]
> Co-developed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> V4
> - convertd to YAML
> - make shmem required only for pre-existing mailbox and smc transport
> - updated VirtIO specification patch message reference
> - dropped virtio-mmio SCMI device example since really not pertinent to
>   virtio-scmi dt bindings transport: it is not even referenced in SCMI
>   virtio DT node since they are enumerated by VirtIO subsystem and there
>   could be PCI based SCMI devices anyway.
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
