Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293A030917F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 03:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhA3CRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 21:17:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:12827 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232821AbhA3CJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 21:09:25 -0500
IronPort-SDR: /cF0H4Z0MlrNtwdv2I+aa0+jpWA1i5Eoq6qnDKT7BCQx7/SUqwsBo+TK1saInZNbmbXrYkrudV
 9XIsET9DEnpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="167605832"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="167605832"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:02:46 -0800
IronPort-SDR: m/mcp0N18j5yhMSa+q+nLGaZ/bnCFViXiFmTxASqO5WF15v/IwH9bV5BEq3NzLSlO+Ve85RJuy
 c7txI1PY8vmQ==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="365581015"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:02:45 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 20F016365;
        Fri, 29 Jan 2021 18:02:45 -0800 (PST)
Date:   Fri, 29 Jan 2021 18:02:45 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mgross@linux.intel.com, jassisinghbrar@gmail.com,
        palmerdabbelt@google.com, dragan.cvetic@xilinx.com,
        devicetree@vger.kernel.org, arnd@arndb.de,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        gregkh@linuxfoundation.org, markgross@kernel.org, corbet@lwn.net,
        damien.lemoal@wdc.com, Paul Murphy <paul.j.murphy@intel.com>,
        bp@suse.de, peng.fan@nxp.com, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/34] dt-bindings: Add bindings for Keem Bay VPU IPC
 driver
Message-ID: <20210130020245.GA63583@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210126054036.61587-1-mgross@linux.intel.com>
 <20210126054036.61587-7-mgross@linux.intel.com>
 <1611756011.180359.1429680.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611756011.180359.1429680.nullmailer@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 08:00:11AM -0600, Rob Herring wrote:
> On Mon, 25 Jan 2021 21:40:08 -0800, mgross@linux.intel.com wrote:
> > From: Paul Murphy <paul.j.murphy@intel.com>
> > 
> > Add DT bindings documentation for the Keem Bay VPU IPC driver.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Mark Gross <mgross@linux.intel.com>
> > Signed-off-by: Paul Murphy <paul.j.murphy@intel.com>
> > Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > ---
> >  .../soc/intel/intel,keembay-vpu-ipc.yaml      | 153 ++++++++++++++++++
> >  1 file changed, 153 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> 
> dtschema/dtc warnings/errors:
fixed.


> 
> See https://patchwork.ozlabs.org/patch/1432168
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
