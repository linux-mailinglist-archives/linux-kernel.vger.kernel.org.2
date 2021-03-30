Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76634E4BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhC3Jtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhC3JtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:49:24 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C23C061574;
        Tue, 30 Mar 2021 02:49:24 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1CEA02222E;
        Tue, 30 Mar 2021 11:49:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1617097759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nm5DXEo0jkIlCPceI4kZgChSiL9E0F8HDcjVbx5UvYY=;
        b=Ra+2dv0u2o5h2cqYRwv6VLqxp430olUEJyjPjzHPuGNstjQcuBt8/d7v0wAxC0OHuum+nV
        V/pqGCbzDbS5KHPNacWlp77/hsY5cLWpviDJym3h+/th8HzUdnZBT61LrXH3TACQRlYI1t
        zuxb6kYN8752fIdk0ZiapELTTbaQnd8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 30 Mar 2021 11:49:16 +0200
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [RFC PATCH 0/4] mtd: core: OTP nvmem provider support
In-Reply-To: <ace5b308-d6ea-b301-0d2e-29f95b91fe8b@linaro.org>
References: <20210322181949.2805-1-michael@walle.cc>
 <ace5b308-d6ea-b301-0d2e-29f95b91fe8b@linaro.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <e4d6721e8500c85883b0af7ccc96fce6@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

Am 2021-03-30 11:42, schrieb Srinivas Kandagatla:
> On 22/03/2021 18:19, Michael Walle wrote:
>> The goal is to fetch a (base) MAC address from the OTP region of a SPI 
>> NOR
>> flash.
>> 
>> This is the first part, where I try to add the nvmem provider support 
>> to
>> the MTD core.
>> 
>> I'm not sure about the device tree bindings. Consider the following 
>> two
>> variants:
>> 
>> (1)
>>      flash@0 {
>>          ..
>> 
>>          otp {
>>              compatible = "mtd-user-otp";
>>              #address-cells = <1>;
>>              #size-cells = <1>;
>> 
>>              serial-number@0 {
>>                  reg = <0x0 0x8>;
>>              };
>>          };
>>      };
>> 
>> (2)
>>      flash@0 {
>>          ..
>> 
>>          otp {
>>              compatible = "mtd-user-otp";
>>              #address-cells = <1>;
>>              #size-cells = <1>;
>> 
>> 			some-useful-name {
>>                  compatible = "nvmem-cells";
>> 
>>                  serial-number@0 {
>>                      reg = <0x0 0x8>;
>>                  };
>> 			};
>>          };
>>      };
>> 
>> Both bindings use a subnode "opt[-N]". We cannot have the nvmem cells 
>> as
>> children to the flash node because of the legacy partition binding.
>> 
>> (1) seems to be the form which is used almost everywhere in the 
>> kernel.
>> That is, the nvmem cells are just children of the parent node.
>> 
>> (2) seem to be more natural, because there might also be other 
>> properties
>> inside the otp subnode and might be more future-proof.
>> 
>> At the moment this patch implements (1).
>> 
> 
> 
> Have you looked at this series[1], are you both trying to do the same 
> thing?

Yes, I've seen these, but they are for MTD partitions. OTP regions are 
not
MTD partitions (and cannot be mapped to them).

-michael

> 
> [1] 
> https://lore.kernel.org/linux-mtd/20210312062830.20548-2-ansuelsmth@gmail.com/T/
> 
> --srini
> 
> 
>> Michael Walle (4):
>>    nvmem: core: allow specifying of_node
>>    dt-bindings: mtd: add YAML schema for the generic MTD bindings
>>    dt-bindings: mtd: add OTP bindings
>>    mtd: core: add OTP nvmem provider support
>> 
>>   .../devicetree/bindings/mtd/common.txt        |  16 +-
>>   .../devicetree/bindings/mtd/mtd.yaml          | 110 +++++++++++++
>>   drivers/mtd/mtdcore.c                         | 149 
>> ++++++++++++++++++
>>   drivers/nvmem/core.c                          |   4 +-
>>   include/linux/mtd/mtd.h                       |   2 +
>>   include/linux/nvmem-provider.h                |   2 +
>>   6 files changed, 267 insertions(+), 16 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/mtd.yaml
>> 
