Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFF130C75B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbhBBRSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:18:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41332 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237331AbhBBRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:15:38 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 112HDqOb004710;
        Tue, 2 Feb 2021 11:13:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612286032;
        bh=0GZnBlsOkIAfjlHvw1T+IMeqbm+/Fp8bDPjTo2hjuDs=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Ra8W66MYl0TlPXojJYJRm1TR63LmE1LYpFMwPYm6xPmVYP3hTyuBLH4kw90SkTlrY
         hbr+pxs2hVaL0BogygW6yDCvwzO2EVM3nwTn/xP/ax6A9ChE4e/v4o6dxQXCgpx7pF
         2nTxPK/JDg0GjH1Y44XcBrRNIlH/o333VnXMdezg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 112HDqBx120507
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Feb 2021 11:13:52 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 2 Feb
 2021 11:13:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 2 Feb 2021 11:13:51 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 112HDp2N007407;
        Tue, 2 Feb 2021 11:13:51 -0600
Date:   Tue, 2 Feb 2021 11:13:51 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     <arm@kernel.org>, <soc@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL 1/2] MAINTAINERS: Update to TI maintainer for v5.12
Message-ID: <20210202171351.qhnzxvakptfbyocv@coach>
References: <20210130131411.afna4wj72r7xscqn@skinny>
 <161228438414.1848830.8600684869682893491.b4-ty@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <161228438414.1848830.8600684869682893491.b4-ty@arndb.de>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:47-20210202, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On Sat, 30 Jan 2021 07:14:11 -0600, Nishanth Menon wrote:
> > Please pull the following MAINTAINERS file update for v5.12 cycle. Made
> > sense to send via ARM path since the main PR path was for TI platforms.
> 
> This seems more appropriate to have in v5.11, I tend to fast-track
> maintainer address changes as bug-fixes so future emails reach the
> correct address.

Ouch, my bad. Thanks for the headsup, will keep this in mind if
(hopefully not), we need to do this in the future.

> 
> > The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
> > 
> >   Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
> > 
> > are available in the Git repository at:
> > 
> > [...]
> 
> Merged into arm/fixes, thanks!
> 
> merge commit: 6102f9e700bb3fee2f37756514885e7b14a70ef6

Thanks.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
