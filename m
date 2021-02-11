Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38582318A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 13:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhBKMZu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Feb 2021 07:25:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2549 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhBKMWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:22:54 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Dbwcv3sFcz67nCN;
        Thu, 11 Feb 2021 20:17:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 13:21:33 +0100
Received: from localhost (10.47.31.44) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 11 Feb
 2021 12:21:32 +0000
Date:   Thu, 11 Feb 2021 12:20:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, Dan Murphy <dmurphy@ti.com>,
        <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [RESEND PATCH v3] MAINTAINERS: add Dan Murphy as TI LP8xxx
 drivers maintainer
Message-ID: <20210211122032.00005d13@Huawei.com>
In-Reply-To: <20210211090516.gpcydiit6lmc6m5h@kozik-lap>
References: <20210210172908.336537-1-krzk@kernel.org>
        <1b31c98b-2344-c502-6071-89b9d4a886a5@ti.com>
        <20210210173632.fcbmzk4zdcwb5kps@kozik-lap>
        <20210211090327.GB4572@dell>
        <20210211090516.gpcydiit6lmc6m5h@kozik-lap>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.31.44]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 10:05:16 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Thu, Feb 11, 2021 at 09:03:27AM +0000, Lee Jones wrote:
> > On Wed, 10 Feb 2021, Krzysztof Kozlowski wrote:
> >   
> > > On Wed, Feb 10, 2021 at 11:33:49AM -0600, Dan Murphy wrote:  
> > > > Krzysztof
> > > > 
> > > > On 2/10/21 11:29 AM, Krzysztof Kozlowski wrote:  
> > > > > Milo Kim's email in TI bounces with permanent error (550: Invalid
> > > > > recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> > > > > credits and add Dan Murphy from TI to look after:
> > > > >   - TI LP855x backlight driver,
> > > > >   - TI LP8727 charger driver,
> > > > >   - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
> > > > > 
> > > > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > > > Cc: Dan Murphy <dmurphy@ti.com>  
> > > > 
> > > > Unfortunately I need to remove my ACK.  My TI email will be disabled this
> > > > Friday.
> > > > 
> > > > No replacement has been identified  
> > > 
> > > Ah, then I propose to mark entries as orphaned - without any maintainer.
> > > Other option is to remove them entirely so they will be covered by
> > > regular power supply entry.
> > > 
> > > Any preferences here?  
> > 
> > Counter-proposal: Since they are driver-level entries, just remove
> > them altogether.  They are not orphaned as they will still come under
> > the subsystem umbrella.  
> 
> I also vote for this (that was actually my v1 of this patch).
> 
> Best regards,
> Krzysztof
> 

Likewise, fine with just dropping the entries.

Jonathan
