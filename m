Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0E83CFCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 16:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbhGTONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:13:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45480 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbhGTN71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:59:27 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16KEdx0k026826;
        Tue, 20 Jul 2021 09:39:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626791999;
        bh=i3NPMi50XC/qqwmVNCcZfA3t4NBmpTGhaYXkRuvsQ/8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XuXP+64foJoUCQ8dw4uYnUGI67zar/QPuyLrTu7QZ3CHJK6Zsd9KAUznebozZYUqk
         hqpMw05rbGTvX1J75Uzmq2QNDSD2Ka1/YQx90C8IawozGB3ww17oZLGpv9Qrk3+miq
         Wp3yH7koCqYfrr+Pjjgl5aAnBcrwBBzrVAkJnkVs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16KEdxYl115748
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Jul 2021 09:39:59 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 20
 Jul 2021 09:39:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 20 Jul 2021 09:39:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16KEdxNj117037;
        Tue, 20 Jul 2021 09:39:59 -0500
Date:   Tue, 20 Jul 2021 09:39:59 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Marc Kleine-Budde <mkl@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/6] arm64: dts: ti: k3-am65-mcu: Add Support for MCAN
Message-ID: <20210720143959.6zmfo6pmrkpzkpse@repaint>
References: <20210720141642.24999-1-a-govindraju@ti.com>
 <20210720141642.24999-2-a-govindraju@ti.com>
 <20210720142047.mfqssyj4lwh3yi2k@pengutronix.de>
 <f3560ac8-8ffe-87d6-a21f-87f6251f1750@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f3560ac8-8ffe-87d6-a21f-87f6251f1750@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20:00-20210720, Aswath Govindraju wrote:
> Hi Marc,
> 
> On 20/07/21 7:50 pm, Marc Kleine-Budde wrote:
> > On 20.07.2021 19:46:37, Aswath Govindraju wrote:
> >> From: Faiz Abbas <faiz_abbas@ti.com>
> >>
> >> Add Support for two MCAN controllers present on the am65x SOC. Both support
> >> classic CAN messages as well as CAN-FD.
> > 
> > Thanks for the patch!
> > 
> > Why don't you disable the CAN cores by default in the dtsi?
> 
> As far as I know, in the dtsi file we mention all the subsystems or
> periherals present in the SoC and in the specific board dts file we
> enable or disable the DT nodes depending on whether the  pins are
> brought out.


There is a long history on this. You should be able to look the
discussion up in lore archives. The nutshell is the dtsi files should
maintain DT standard which is "default, status if not explicitly
provided is enabled" and the board dts files will explicitly disable
OR reserve the nodes that are not pinned out / used / reserved (due to
firmware usage) etc. There is the entire string parsing, size arguments
that run around this topic, but, anyways.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
