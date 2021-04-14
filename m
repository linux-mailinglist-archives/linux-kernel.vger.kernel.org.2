Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD235EB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 05:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbhDNDPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 23:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhDNDPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:15:31 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56717C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:15:11 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso16186479otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lWYNYk08w1Eqo11tDp7n2MyKlkaxOTUBjMHwWUDYMiU=;
        b=ybKZcbBXlGb+zPieCVgdhs+W/ZIPuFZYgO8jLu3+uu1SfGWdYkNWTsFu1VO/NYYxS9
         VbKwCQ+hU6lCZjSOadkGrJnKZMspdWwEBZ/43/6v96dCeDGj4AjR/IBMP/+w7E5B45ok
         c3gVEVde/kscNze+iLaD1trJsjYmS4cP3mpScrOHJA5gf4NqwGrykbXMuJ7bhbATI8P2
         u2VPWENfRe5Tex1PCFlypJEjC99+DgIJwlZ1VArVTnnv2fD7CMPzJFunxJaCBmqjZCFI
         Rlgl4NmRWrdaySA/H8jmUN7pKPjpIvXS9anTPVLXuDy1U2LPuXGpkA1Ci//u/e2iISPS
         8ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lWYNYk08w1Eqo11tDp7n2MyKlkaxOTUBjMHwWUDYMiU=;
        b=tIq8gGfWWMkcHIZYf4GNe+AAmT4aE/s89RjTAiDIWcyGwgDo0dodiwXL5ZfEHcOoZC
         uYRmEyka6dJ4p7qDD454aixekwhnjmlail3b7uDyyDgFCciVHtvKm3GL4Vrfp8dYD4Ua
         UB6Hy3cYxmrAO+kse+HqEMPqWUomPtOs+BqzhJpd8hxmxKB4LPKy1U14hH92Dia4MWjB
         yEtfzw+ITlufYvS7NTrTPSG8EDXfy2oAufrLjmxpaJqK7mCzdRF/JfcmWuvkGjShRWAd
         X+anqSpRfwuW5hkG8zAcMScvC2MGr6TOhGJ3ulTDAwJUOB6jK/e7MUAegpFBtwFAzp4c
         44TQ==
X-Gm-Message-State: AOAM531EIw/l8xWQ3ps28GyqfqqVb1UtPb8YzNB5+yLfYV8pJJ+0By/+
        A1OBqyWQ9oqbgFg38r6DavKcpQ==
X-Google-Smtp-Source: ABdhPJzhuNpR60s28axQk88bCxDheLszIz7pnVj9A1oBNW6bNwfBRdsDc84DwlQ3JCGuQJQ9Kowyvg==
X-Received: by 2002:a05:6830:3115:: with SMTP id b21mr30438984ots.318.1618370110582;
        Tue, 13 Apr 2021 20:15:10 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm3872026otj.50.2021.04.13.20.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 20:15:10 -0700 (PDT)
Date:   Tue, 13 Apr 2021 22:15:08 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Nikita Travkin <nikitos.tr@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm
 Memshare service
Message-ID: <20210414031508.GZ1538589@yoga>
References: <20210319172321.22248-1-nikitos.tr@gmail.com>
 <20210319172321.22248-2-nikitos.tr@gmail.com>
 <20210330144048.GA264685@robh.at.kernel.org>
 <bf20ff4b-1765-2bc8-d0de-bea675a1d090@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf20ff4b-1765-2bc8-d0de-bea675a1d090@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10 Apr 03:05 CDT 2021, Nikita Travkin wrote:

> Hi, sorry for a late reply but I couldn't answer earlier.
> 
> 30.03.2021 19:40, Rob Herring ??????????:
> > On Fri, Mar 19, 2021 at 10:23:20PM +0500, nikitos.tr@gmail.com wrote:
> >> From: Nikita Travkin <nikitos.tr@gmail.com>
> >>
> >> Add DT bindings for memshare: QMI service that allocates
> >> memory per remote processor request.
> >>
> >> Signed-off-by: Nikita Travkin <nikitos.tr@gmail.com>
> >> ---
> >>  .../bindings/soc/qcom/qcom,memshare.yaml      | 109 ++++++++++++++++++
> >>  include/dt-bindings/soc/qcom,memshare.h       |  10 ++
> >>  2 files changed, 119 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,memshare.yaml
> >>  create mode 100644 include/dt-bindings/soc/qcom,memshare.h
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,memshare.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,memshare.yaml
> >> new file mode 100644
> >> index 000000000000..ebdf128b066c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,memshare.yaml
> >> @@ -0,0 +1,109 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,memshare.yaml#"
> >> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> >> +
> >> +title: Qualcomm QMI Shared Memory Service
> > How many shared memory interfaces does Qcom have...
> >
> >> +
> >> +description: |
> >> +  This driver provides a QMI service that allows remote processors (like modem)
> >> +  to request additional memory. It is used for applications like GPS in modem.
> > If the memory region is defined in reserved-memory, how are you 
> > allocating additional memory? 
> 
> Initially remoteproc is loaded into it's own reserved-memory region
> but qcom decided that they sometimes need more memory than that.
> Memshare driver in msm8916 downstream tree seem to blindly allocate
> DMA region for every request that it gets. Additionally for those
> clients described in the DT, they do the DMA allocation on boot
> time and never free the region. They call it "guaranteed" allocation.
> 
> On msm8916 only one "guaranteed" client seem to be used so I decided
> to implement it with reserved-memory node. On newer platforms they
> seem to have more clients but I think that the driver can be easily
> extended to support dynamic allocation if someone really needs it.
> 

Is the "guaranteed" memory required to come from the reserved-memory
part of memory, or could it simply be allocated on demand as well (or
preallocated, but at a dynamic address)?

If these allocations always came from a reserved-memory region, then
adding a "qcom,memshare" compatible to the reserved-memory node itself
seems like a reasonable approach. But if dma_alloc is sufficient, and
there's cases where there's no "guaranteed" region, perhaps we should
just describe this as part of the remoteproc node (i.e. essentially
flipping the node/subnode in your current binding).


E.g. can we get away with simply adding an optional qcom,memshare-node
to the remoteproc binding and when that's present we make the Qualcomm
remoteproc drivers spawn the memshare handler and listen for requests
from that node?

> I tried to explain that in the cover letter but I think I made some
> mistake as I don't see it in the Patchwork.
> 
> >> +
> >> +maintainers:
> >> +  - Nikita Travkin <nikitos.tr@gmail.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: qcom,memshare
> >> +
> >> +  qcom,legacy-client:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> +    description: Phandle to a memshare client node used for legacy requests.
> >> +
> >> +  "#address-cells":
> >> +    const: 1
> >> +
> >> +  "#size-cells":
> >> +    const: 0
> >> +
> >> +patternProperties:
> >> +  "^.*@[0-9]+$":
> >> +    type: object
> >> +
> >> +    properties:
> >> +      reg:
> >> +        description: Proc-ID for clients in this node.
> > What's Proc-ID?
> 
> The requests from the remote nodes contain client-id and proc-id
> that are supposed to differentiate the clients. It's possible to
> find the values in downstream DT or by observing what messages
> are received by the memshare service (I left dev_dbg logging in
> the driver for that reason)
> 
> I think I should reword it to make this more apparent, maybe
> "Proc-ID that clients in this node send."?
> 

If this is a constant for each remote and we make this a child thing of
remoteproc perhaps encode the number in the remoteproc nodes?

(We still need something in DT to state that we want a memshare for
a given platform/remoteproc)

> >
> >> +
> >> +      qcom,qrtr-node:
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        description: Node from which the requests are expected.
> >> +
> >> +      "#address-cells":
> >> +        const: 1
> >> +
> >> +      "#size-cells":
> >> +        const: 0
> >> +
> >> +    patternProperties:
> >> +      "^.*@[0-9]+$":
> >> +        type: object
> >> +
> >> +        properties:
> >> +          reg:
> >> +            description: ID of this client.
> > How does one determine the ID?
> 
> As with proc-id, maybe reword to "ID that this client sends."?
> 
> I will change those in v2, I still expect comments on the driver
> itself, so I'll wait for that before submitting it with just a
> couple lines changed.
> 
> >
> >> +
> >> +          memory-region:
> >> +            $ref: /schemas/types.yaml#/definitions/phandle
> >> +            description: |
> >> +              Reserved memory region that should be used for allocation.
> >> +
> >> +        required:
> >> +          - reg
> >> +
> >> +    required:
> >> +      - reg
> >> +      - qcom,qrtr-node
> >> +
> >> +required:
> >> +  - compatible
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/soc/qcom,memshare.h>
> >> +
> >> +    reserved-memory {
> >> +
> >> +      #address-cells = <2>;
> >> +      #size-cells = <2>;
> >> +
> >> +      gps_mem: gps@93c00000 {
> >> +        reg = <0x0 0x93c00000 0x0 0x200000>;
> >> +        no-map;
> > We support 'compatible' in reserved-memory nodes, can you simplify the 
> > binding and put everything in here?
> 
> If I understand this correctly, each reserved-memory node will
> then load a new instance of memshare. Since the driver registers a
> QMI service that handles multiple clients, there should be only one
> instance.

This you could work around in the driver implementation, to refcount a
single implementation shared among all the instances.

> Additionally, as I mentioned earlier, some clients may not
> need reserved-memory at all
> 

This on the other hand, makes me feel like we shouldn't go that route.

Regards,
Bjorn

> >> +      };
> >> +    };
> >> +
> >> +    memshare {
> >> +      compatible = "qcom,memshare";
> >> +      qcom,legacy-client = <&memshare_gps>;
> >> +
> >> +      #address-cells = <1>;
> >> +      #size-cells = <0>;
> >> +
> >> +      mpss@0 {
> >> +        reg = <MEMSHARE_PROC_MPSS_V01>;
> >> +        qcom,qrtr-node = <0>;
> >> +
> >> +        #address-cells = <1>;
> >> +        #size-cells = <0>;
> >> +
> >> +        memshare_gps: gps@0 {
> >> +          reg = <0>;
> >> +          memory-region = <&gps_mem>;
> >> +        };
> >> +      };
> >> +    };
> >> +
> >> +...
> >> diff --git a/include/dt-bindings/soc/qcom,memshare.h b/include/dt-bindings/soc/qcom,memshare.h
> >> new file mode 100644
> >> index 000000000000..4cef1ef75d09
> >> --- /dev/null
> >> +++ b/include/dt-bindings/soc/qcom,memshare.h
> >> @@ -0,0 +1,10 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +
> >> +#ifndef __DT_QCOM_MEMSHARE_H__
> >> +#define __DT_QCOM_MEMSHARE_H__
> >> +
> >> +#define MEMSHARE_PROC_MPSS_V01 0
> >> +#define MEMSHARE_PROC_ADSP_V01 1
> >> +#define MEMSHARE_PROC_WCNSS_V01 2
> >> +
> >> +#endif /* __DT_QCOM_MEMSHARE_H__ */
> >> -- 
> >> 2.27.0
> >>
> 
