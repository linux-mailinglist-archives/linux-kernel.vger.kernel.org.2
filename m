Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699694032BD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 04:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347328AbhIHCsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 22:48:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51498 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345390AbhIHCsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:48:37 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1882lPdn101267;
        Tue, 7 Sep 2021 21:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1631069245;
        bh=7EcX9InYVySA5sqeGbQN5WvTqoO1xNHAkEBhg6Y4sPo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=d22YljuuiTS6zq9m+voo1+geE45mybBysnsHAH4kV8fZkhQx7i5zc0maOrPVUmD4T
         A814xiSGsnzgeF+rXy9YROBn6dzI0Y7nVg4GJHr/ucibcVsnNiaDbd2q3oYmGBz9Wn
         VNLbkyqJazGRgv9eq4350dmRwle8QzUxYRVwzw6o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1882lOfO090825
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Sep 2021 21:47:24 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 7
 Sep 2021 21:47:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 7 Sep 2021 21:47:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1882lOoE069693;
        Tue, 7 Sep 2021 21:47:24 -0500
Date:   Tue, 7 Sep 2021 21:47:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: iot2050: Flip mmc device ordering on
 Advanced devices
Message-ID: <20210908024724.v76ff5xjlqaddww6@attendant>
References: <8e2e435ef67868cb98382b44c51ddb5c8d045d66.1631024536.git.jan.kiszka@siemens.com>
 <20210907151301.7fqwmc7hmcyhhybv@carve>
 <35e0cadf-526c-6402-fb8e-8cdb8b7a0bfe@siemens.com>
 <20210907152746.fbddtkktvx6hb5ti@cattishly>
 <c63a5ac2-77ca-e54c-183c-b3274a9698db@siemens.com>
 <20210907153547.53cc2zx23rx72kqf@thyself>
 <482dddc1-b1f8-15db-a0c5-0d6def5d859f@ti.com>
 <20210907165316.4s3jrouctcpc3kvo@pessimism>
 <d69acf3d-e0c4-ef7b-be23-0d98dd6b05aa@ti.com>
 <4cb6e76e-479f-5e06-778a-4788be53afb9@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4cb6e76e-479f-5e06-778a-4788be53afb9@siemens.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:28-20210907, Jan Kiszka wrote:
[...]

> > Yes, I am suggesting a flip in the order and this order can be applied
> > across all the K3 SoC's
> > 
> 
> I'm not sure what you are suggesting. I've sent v2 already which moves
> aliasing to SoC level, and I would push that to U-Boot as well if
> acceptable. If not, we will keep this in our board DTs.
> 

responded in context of v2:
https://lore.kernel.org/all/20210908024442.jskmqqye432p4nmt@gatherer/
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
