Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178B033189F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 21:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhCHUbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 15:31:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:8496 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhCHUbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 15:31:22 -0500
IronPort-SDR: u3TtpV4ZS6tmSsy8615/wrAogWoEoOO5FJv73sXuKxtKb7Ku0K/g4E0QPRBTdkGSYRnY759exg
 qLyhtpqcCXzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="184738983"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="184738983"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 12:31:21 -0800
IronPort-SDR: 6DD67P3qdHW1Jh8D1KN5wLd2C9MpjLjWb7jiU5Jwf7cgIDHPW0Z3ovMMRFNovCbXbV+QYNqus2
 VJh9BUjVBysQ==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="369533241"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 12:31:19 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id AA0456365;
        Mon,  8 Mar 2021 12:31:19 -0800 (PST)
Date:   Mon, 8 Mar 2021 12:31:19 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, shawnguo@kernel.org, jassisinghbrar@gmail.com,
        linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 19/34] xlink-core: Add xlink core device tree bindings
Message-ID: <20210308203119.GB138795@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-20-mgross@linux.intel.com>
 <20210305210300.GB622142@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305210300.GB622142@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 03:03:00PM -0600, Rob Herring wrote:
> On Fri, Feb 12, 2021 at 02:22:49PM -0800, mgross@linux.intel.com wrote:
> > From: Seamus Kelly <seamus.kelly@intel.com>
> > 
> > Add device tree bindings for keembay-xlink.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
> > ---
> >  .../bindings/misc/intel,keembay-xlink.yaml    | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> > new file mode 100644
> > index 000000000000..5ac2e7fa5b5e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
> > @@ -0,0 +1,29 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (c) Intel Corporation. All rights reserved.
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/misc/intel,keembay-xlink.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Intel Keem Bay xlink
> > +
> > +maintainers:
> > +  - Seamus Kelly <seamus.kelly@intel.com>
> > +
> > +description: |
> > +  The Keem Bay xlink driver enables the communication/control sub-system
> > +  for internal and external communications to the Intel Keem Bay SoC.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: intel,keembay-xlink
> > +
> > +additionalProperties: False
> > +
> > +examples:
> > +  - |
> > +    xlink {
> > +        compatible = "intel,keembay-xlink";
> 
> A node with only a compatible is almost always abusing DT just to 
> instantiate your driver.

Is it normal to make drivers that want to abuse DT in this way platform
devices?

Any advice would be welcome and helful.

thanks!

--mark
