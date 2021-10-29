Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDFE43FBFD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhJ2MHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:07:19 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7821 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhJ2MHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635509089; x=1667045089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rLhxBIcFSdOiKZQUIOx/5AlyAZ5laI3Gc0J2/okOBqc=;
  b=XwRA0bgFkk8UXwtqlpx7QmKKyN/zyagM+kaqP0aLQzSc4JAHQeYO4c80
   XvZkVO2b/HlFIUyYcrrg5lWZChqdsFV/Q33YlVb1gzqna5rtxGpVLAp2t
   4AteFeisaItJWZiNmhuGfeEqTCp2+qsbMx4MdZO9JHaG1ozqe/vzWFyYj
   QCj8VOhe7g59kvAX7jpOX1J5i1K0TaZzxEvCWhjL790jxOKOr4EZXi9Js
   qPiqppOLuemEY7VlI/BcKvrjhl8RQZApfAGdQqnR9oUJ3uk3rAy1QaGEE
   sctoOSZLlvMLIHeJAHggs6nuL5O4y5PuYBEqZICiZN0tKyR/JkW9K0SGZ
   A==;
IronPort-SDR: TMnM0lPzY3HH4TBwEEepbdRw93UljuFTHZf4Aulz1yV0BZBP+S8296Keezbh8vAFl7FZAby7nI
 S5aQw8OkNWh/eG3T3yVQMvFLiT+IPIVcH/MQEy5/wNXcNT0A6D6nCRX5dpd2a7Mb1sjxgNz+ob
 wZBMdapUqFgQyP5cbLTf4O8Tqv1RdpKcZIn2ShQqwUO/nVSz/AbUvejxaW0Uxf0xO3O6UArr4V
 HG0wQiELInhuCQ2GNi1C+8PgB7u+pHKpr7yMs8TqrGAqAARQgF47d/DxVO4lXngQs56A3jw/At
 m8q+pW7gxWtn4KzbSm37D9r+
X-IronPort-AV: E=Sophos;i="5.87,192,1631602800"; 
   d="scan'208";a="150025505"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Oct 2021 05:04:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Oct 2021 05:04:48 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 29 Oct 2021 05:04:48 -0700
Date:   Fri, 29 Oct 2021 14:06:31 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: clock: lan966x: Extend for clock
 gate support
Message-ID: <20211029120631.a7p6d6hurefz4emt@soft-dev3-1.localhost>
References: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
 <20211019084449.1411060-2-horatiu.vultur@microchip.com>
 <YXjCufT1WyLEriY2@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <YXjCufT1WyLEriY2@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/26/2021 22:08, Rob Herring wrote:

Hi Rob,

> 
> On Tue, Oct 19, 2021 at 10:44:47AM +0200, Horatiu Vultur wrote:
> > It is required to add a new resource to be able to access the clock gate
> > registers. Now that we have 2 resources, add also reg-names property to
> > make more clear.
> 
> It is an ABI breakage to require 2 reg entries. If that's okay for this
> binding, you need to explain why. The binding requiring 2 so that DT
> files get updated, but the driver allowing for 1 is okay.

I will make the resource optional not to break any ABI.

> 
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> > ---
> >  .../bindings/clock/microchip,lan966x-gck.yaml       | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> > index fca83bd68e26..047c77e049f1 100644
> > --- a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> > +++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> > @@ -19,7 +19,14 @@ properties:
> >      const: microchip,lan966x-gck
> >
> >    reg:
> > -    maxItems: 1
> > +    items:
> > +      - description: core registers
> > +      - description: gate registers
> > +
> > +  reg-names:
> > +    items:
> > +      - const: core
> > +      - const: gate
> >
> >    clocks:
> >      items:
> > @@ -39,6 +46,7 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > +  - reg-names
> >    - clocks
> >    - clock-names
> >    - '#clock-cells'
> > @@ -52,6 +60,7 @@ examples:
> >          #clock-cells = <1>;
> >          clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
> >          clock-names = "cpu", "ddr", "sys";
> > -        reg = <0xe00c00a8 0x38>;
> > +        reg = <0xe00c00a8 0x38>, <0xe00c02cc 0x4>;
> > +        reg-names = "core", "gate";
> >      };
> >  ...
> > --
> > 2.33.0
> >
> >

-- 
/Horatiu
