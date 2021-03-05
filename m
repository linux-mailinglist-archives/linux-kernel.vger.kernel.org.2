Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7232F50C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCEVCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:02:00 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36576 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhCEVBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:01:43 -0500
Received: by mail-ot1-f50.google.com with SMTP id t16so3135145ott.3;
        Fri, 05 Mar 2021 13:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCTsWhSOl0VSvNM9dJzSETj+napvS3H1QXFbSSLzpV0=;
        b=Nj1pWHd49J1Sg5sEE5xvSOM5cAF4vDA4rQbRxCR8IkzhgcvPpQwi9hUwvOI2Y7Yi+A
         Q/ShyMMwAnsIw2iS8pAkEEFPoeqqpCp1joA9STHkwjXzoIaR8N1yzspeaW956/DyuhfE
         DLspNK/GJaA1u0ucsx+UvAuQSI0tV9vFITLWPQLQyw1zFWDA8x0w8ilZ60qatrzH1RlC
         d/NkhIEARTF7ooFzuSllcuLN3PtxBrCBfn/zSzACcZ2j1c3p6NHoxsgHEQPBoAoWTcvA
         8xEXuVjzrAppqPca5lJOxVv+AKYgQMiMlKpxG55hQ5iA9GbhWdXm0fbh3fve+/1uo2Xg
         kH6Q==
X-Gm-Message-State: AOAM533en4uP1mooSBTXjgY4GSOU52bw6/vpACE5Vri/rpQuLNdCIvuf
        b2ofEYISn8YsTknCsShAIg==
X-Google-Smtp-Source: ABdhPJxZev2D1I4Q9LzV3e74lC2o5oxAXT6c99TN3OZNkH26a4it0BFlXTgREs3ZAlErkNfA0Mur3A==
X-Received: by 2002:a9d:7c3:: with SMTP id 61mr9704874oto.349.1614978102375;
        Fri, 05 Mar 2021 13:01:42 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r3sm746186oif.5.2021.03.05.13.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:01:41 -0800 (PST)
Received: (nullmailer pid 636697 invoked by uid 1000);
        Fri, 05 Mar 2021 21:01:40 -0000
Date:   Fri, 5 Mar 2021 15:01:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     mgross@linux.intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, shawnguo@kernel.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 04/34] dt-bindings: Add bindings for Keem Bay IPC
 driver
Message-ID: <20210305210140.GA622142@robh.at.kernel.org>
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-5-mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212222304.110194-5-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:22:34PM -0800, mgross@linux.intel.com wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> Add DT binding documentation for the Intel Keem Bay IPC driver, which

Bindings are for h/w blocks, not drivers. From a binding perspective, I 
don't really care what the driver architecture for some OS looks like. I 
continue to not understand what this h/w looks like. A block diagram 
would help as would understanding what blocks have multiple clients 
(mailboxes and xlink in particular).

> enables communication between the Computing Sub-System (CSS) and the
> Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
> Bay.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Mark Gross <mgross@linux.intel.com>
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Signed-off-by: Mark Gross <mgross@linux.intel.com>
> ---
>  .../bindings/soc/intel/intel,keembay-ipc.yaml | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> new file mode 100644
> index 000000000000..586fe73f4cd4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Intel Corporation
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/intel/intel,keembay-ipc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Keem Bay IPC
> +
> +maintainers:
> +  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> +
> +description:
> +  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
> +  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
> +  Keem Bay.
> +
> +properties:
> +  compatible:
> +    const: intel,keembay-ipc
> +
> +  memory-region:
> +    items:
> +      - description:
> +          Reserved memory region used by the CPU to allocate IPC packets.
> +      - description:
> +          Reserved memory region used by the VPU to allocate IPC packets.
> +
> +  mboxes:
> +    description: VPU IPC Mailbox.
> +
> +required:
> +  - compatible
> +  - memory-region
> +  - mboxes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ipc {
> +          compatible = "intel,keembay-ipc";
> +          memory-region = <&ipc_cpu_reserved>, <&ipc_vpu_reserved>;
> +          mboxes = <&vpu_ipc_mbox 0>;
> +    };
> -- 
> 2.17.1
> 
