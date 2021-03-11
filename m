Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74571337B77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhCKR5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:57:38 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50336 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCKR5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:57:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12BHuxlk042621;
        Thu, 11 Mar 2021 11:56:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615485419;
        bh=q08sJDe3heSV4QnUx6HBERqRFXasPw62PnUGroZLHvQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EZ2htw8QV3Zy0M40FE+VW7TS8Ir0UPukIu0zvt8R36esfrQiA8LsmEk8SMdvSseOW
         s4ng9ZYR+Zo7Iq8tT+epEjwiEb2G3F//7E6jmcnGkI/wOmrf5FNGVCuUiIixUva+3c
         QWZrmNwtrLNVDGBUBwWYD2ZXG2oW8n7RM7TFOV5E=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12BHuxsx110234
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Mar 2021 11:56:59 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 11
 Mar 2021 11:56:58 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 11 Mar 2021 11:56:58 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12BHuw1U018537;
        Thu, 11 Mar 2021 11:56:58 -0600
Date:   Thu, 11 Mar 2021 11:56:58 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: Add support for Siemens IOT2050
 boards
Message-ID: <20210311175658.agmnphz2pjydwnc5@annex>
References: <cover.1615369068.git.jan.kiszka@siemens.com>
 <9bff40f434e5298890e5d139cc36cc46a0ca2d76.1615369068.git.jan.kiszka@siemens.com>
 <20210311131754.i5ewls6hgeitcgre@astonish>
 <8d076ff1-cdac-941f-e796-a2e6dba792ab@siemens.com>
 <20210311140056.fzvke3rrg6c2uuoa@uncouth>
 <519ae6b7-35db-1fdd-de1e-e0155e0ca82a@siemens.com>
 <20210311142151.5o54k7kmrnatufcw@target>
 <f8c6f598-cb9c-ecd5-0b01-09f171ce7c26@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8c6f598-cb9c-ecd5-0b01-09f171ce7c26@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:36-20210311, Jan Kiszka wrote:
> On 11.03.21 15:21, Nishanth Menon wrote:
> > On 15:14-20210311, Jan Kiszka wrote:
> > 
> > [...]
> > 
> >>>
> >>> See [1] compare the compatibles against
> >>> Documentation/devicetree/bindings -> I think you should describe what
> >>> your hardware really is though.
> >>
> >> This SPI bus is routed to an Arduino connector. By default, userspace
> >> (e.g. mraa) takes ownership and adds the desired logic for what is being
> >> connected. We have no idea what shield or other extension the user adds,
> >> though.
> > 
> > overlays look like the right approach for variable systems like these.
> > It is not exactly plug and play.. but it does provide a level of
> > flexibility that is helpful.
> 
> Yes, that's for extensions which have kernel drivers. The default model
> here is userspace, though. Will add as a separate patch to our queue for
> now.

My colleagues did some checkups and pulled up a few thread on spidev
of potential interests..

See:
https://patchwork.kernel.org/project/spi-devel-general/patch/1427499742-26916-1-git-send-email-broonie@kernel.org/
https://yurovsky.github.io/2016/10/07/spidev-linux-devices.html
etc...

I'd split the spidev node alone as an addendum indicate the checkpatch
warning, describe the details and loop in spidev list, Mark, et.al. to
discuss the direction. I am hoping we can get this resolved or get a
direction for .13-rc1

But that said, I see some examples such as 
for i in `git grep ".compatible" drivers/spi/spidev.c|grep =|cut -d '=' -f2|cut -d ' ' -f2`; do git grep $i Documentation/devicetree/bindings/; done

Documentation/devicetree/bindings/spi/spi-mux.yaml:                compatible = "lineartechnology,ltc2488";
Documentation/devicetree/bindings/misc/ge-achc.txt:- compatible : Should be "ge,achc"
Documentation/devicetree/bindings/misc/ge-achc.txt:     compatible = "ge,achc";
Documentation/devicetree/bindings/misc/lwn-bk4.txt:- compatible : Should be "lwn,bk4"
Documentation/devicetree/bindings/misc/lwn-bk4.txt:     compatible = "lwn,bk4";

So, the shield could be hosting one of those say
 ge,achc or maybe lwn,bk4 ?- will probably be good to document the
dts is for such a configuration, though it is possible that such a
configuration might work for others?

I agree with Mark that "dt should indicate specific hardware" and we
should constraint the definition in such a scope?

[...]

> > 
> >> Are we talking about spidev here? Then let's drop that node, but I do
> >> need to know how to describe spidev properly
> > 
> > yes - the spidev is my problem. can you drop the node and repost? i cant
> > locally modify and hope it works.
> > 
> 
> Done.

Thanks, I will try and pick up the v5 later today - need to redo my
sanity checkups.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
