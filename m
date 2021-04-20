Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93257365BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbhDTPE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:04:29 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51107 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhDTPE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:04:27 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2FD2322249;
        Tue, 20 Apr 2021 17:03:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1618931032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ra38DMf98MFYu630YGYd6KiMOT196r9TyH0tZwWwqFg=;
        b=AzWNOeIq0/cAZAVzRIWlHSxBbInCZvUBSeR80v5Wz8oGB0ZSQ5fLA9QjD+Z8/CNaHti8Uh
        kRW/TNIwOjaDOL87DNWg5cwET5kGzQciflRY2u+CrgWUecEyNWu9wGzivs3k0hjavpDHBM
        qXQsqW2Kj+x0Z4CK3g+d2cWcI4+sYJ0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Apr 2021 17:03:52 +0200
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/5] mtd: core: OTP nvmem provider support
In-Reply-To: <20210420140801.GA3240688@robh.at.kernel.org>
References: <20210416114928.27758-1-michael@walle.cc>
 <20210416184423.GA3715339@robh.at.kernel.org>
 <9f33229a8fe83b49210289fc93a8554e@walle.cc>
 <20210420140801.GA3240688@robh.at.kernel.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <755f8f930844cbef2b32f81bf6585c31@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Am 2021-04-20 16:08, schrieb Rob Herring:
> On Fri, Apr 16, 2021 at 09:26:03PM +0200, Michael Walle wrote:
>> Am 2021-04-16 20:44, schrieb Rob Herring:
>> > On Fri, Apr 16, 2021 at 01:49:23PM +0200, Michael Walle wrote:
>> > > The goal is to fetch a (base) MAC address from the OTP region of a
>> > > SPI NOR
>> > > flash.
>> > >
>> > > This is the first part, where I try to add the nvmem provider
>> > > support to
>> > > the MTD core.
>> > >
>> > > I'm not sure about the device tree bindings. Consider the following
>> > > two
>> > > variants:
>> > >
>> > > (1)
>> > >     flash@0 {
>> > >         ..
>> > >
>> > >         otp {
>> > >             compatible = "mtd-user-otp";
>> >
>> > mtd is a linuxism. Why not just 'nvmem-cells' here or as a fallback if
>> > we come up with a better name?
>> 
>> There are two different compatibles: "mtd-user-otp" and 
>> "mtd-factory-otp"
>> to differentiate what kind of OTP should be used (and both are 
>> possible
>> at the same time). Thus nvmem-cells alone won't be enough. We could 
>> drop
>> the "mtd-" prefix though.
>> 
>> Is there a benefit of having the following?
>>   compatible = "user-otp", "nvmem-cells";
> 
> Yes. I assume 'user-otp' tells you something about the region and
> 'nvmem-cells' tells you that there are child nodes of nvmem data. Of
> course 'user-otp' could imply 'nvmem-cells' as you did. I'm fine with
> either way.

Ah, if I use both compatibles, then the
Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
schema kicks in, which mandates 'compatible = "nvmem-cells";' and I
get the following errors:

   CHECK   Documentation/devicetree/bindings/mtd/mtd.example.dt.yaml
/home/mwalle/repos/b-linux-arm64/Documentation/devicetree/bindings/mtd/mtd.example.dt.yaml: 
otp-1: compatible:0: 'nvmem-cells' was expected
	From schema: 
/home/mwalle/repos/linux-mw/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
/home/mwalle/repos/b-linux-arm64/Documentation/devicetree/bindings/mtd/mtd.example.dt.yaml: 
otp-1: compatible: ['factory-otp', 'nvmem-cells'] is too long
	From schema: 
/home/mwalle/repos/linux-mw/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
/home/mwalle/repos/b-linux-arm64/Documentation/devicetree/bindings/mtd/mtd.example.dt.yaml: 
otp-1: compatible: Additional items are not allowed ('nvmem-cells' was 
unexpected)
	From schema: 
/home/mwalle/repos/linux-mw/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml

Is there a way around that?

-michael
