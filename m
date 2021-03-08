Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48533331854
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhCHUUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:20:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:27580 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhCHUUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:20:09 -0500
IronPort-SDR: SrujMP6x7kuOTwTvpAKuAt9rOAip9kmz/kCqc5MLd5wLamLSVn9fej00oJ7zX8thPX9ivPnwL3
 lgCa8WEgWdzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="185713798"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="185713798"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 12:20:09 -0800
IronPort-SDR: Jx4SpPoXYyH0UBNvH9d/29Q1bE9+Tc5qZqB8UtL+uAwKeyu3P0gYs9q0f3x5hiqylNuAnHXiY7
 nm3NC7Jg3sig==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="430496246"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 12:20:08 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id AC8E86365;
        Mon,  8 Mar 2021 12:20:08 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:20:08 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, shawnguo@kernel.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 04/34] dt-bindings: Add bindings for Keem Bay IPC
 driver
Message-ID: <20210308202008.GA138795@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-5-mgross@linux.intel.com>
 <20210305210140.GA622142@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305210140.GA622142@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 03:01:40PM -0600, Rob Herring wrote:
> On Fri, Feb 12, 2021 at 02:22:34PM -0800, mgross@linux.intel.com wrote:
> > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > 
> > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> 
> Bindings are for h/w blocks, not drivers. From a binding perspective, I 
> don't really care what the driver architecture for some OS looks like. I 
> continue to not understand what this h/w looks like. A block diagram 
> would help as would understanding what blocks have multiple clients 
> (mailboxes and xlink in particular).
I'm working to gather this info.

thanks!

--mark

> 
> > enables communication between the Computing Sub-System (CSS) and the
> > Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
> > Bay.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > Signed-off-by: Mark Gross <mgross@linux.intel.com>
> > ---
> >  .../bindings/soc/intel/intel,keembay-ipc.yaml | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> > new file mode 100644
> > index 000000000000..586fe73f4cd4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2020 Intel Corporation
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/soc/intel/intel,keembay-ipc.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Keem Bay IPC
> > +
> > +maintainers:
> > +  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > +
> > +description:
> > +  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
> > +  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
> > +  Keem Bay.
> > +
> > +properties:
> > +  compatible:
> > +    const: intel,keembay-ipc
> > +
> > +  memory-region:
> > +    items:
> > +      - description:
> > +          Reserved memory region used by the CPU to allocate IPC packets.
> > +      - description:
> > +          Reserved memory region used by the VPU to allocate IPC packets.
> > +
> > +  mboxes:
> > +    description: VPU IPC Mailbox.
> > +
> > +required:
> > +  - compatible
> > +  - memory-region
> > +  - mboxes
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ipc {
> > +          compatible = "intel,keembay-ipc";
> > +          memory-region = <&ipc_cpu_reserved>, <&ipc_vpu_reserved>;
> > +          mboxes = <&vpu_ipc_mbox 0>;
> > +    };
> > -- 
> > 2.17.1
> > 
