Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7571A44F14C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 05:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbhKME7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 23:59:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40374 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhKME7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 23:59:40 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AD4ueDC043668;
        Fri, 12 Nov 2021 22:56:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1636779400;
        bh=QKiYW89hLwTm0nhytVf0QCQIVJ2BC8AJGIi0hCu/PFk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EKvpZabT7OygZTzRwVu8MO9vIluz38jQaCaZilTCt1aeXqD+w51K6Zf46ugFTtQdy
         hCOox/WFEMzz5oioxuNxiDTJjeOmlHOaYUQwRhDTBykiTbITilMght1LjPKq9eaIO9
         PISfgy2VPZpr58kDqzIeJwvDA5JcKvUUhwYPTEEo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AD4udJY030201
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Nov 2021 22:56:40 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 12
 Nov 2021 22:56:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 12 Nov 2021 22:56:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AD4ud78086423;
        Fri, 12 Nov 2021 22:56:39 -0600
Date:   Fri, 12 Nov 2021 22:56:39 -0600
From:   Nishanth Menon <nm@ti.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: k3-j721e: correct cache-sets info
Message-ID: <20211113045639.pao2sz2refr5sq43@crushing>
References: <20211112063155.3485777-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211112063155.3485777-1-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:31-20211112, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>

Minor comment (should be easy to fix when picking up the patch), lest I
forget-> $subject: arm64: dts: ti: to maintain consistency

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
