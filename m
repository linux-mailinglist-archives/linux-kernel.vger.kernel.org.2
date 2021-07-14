Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04CF3C9249
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhGNUnt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jul 2021 16:43:49 -0400
Received: from aposti.net ([89.234.176.197]:42742 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhGNUnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:43:49 -0400
Date:   Wed, 14 Jul 2021 21:40:46 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Innolux EJ030NA
To:     Rob Herring <robh@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Message-Id: <YF59WQ.VTZ17PPSJ9I02@crapouillou.net>
In-Reply-To: <20210714203013.GA3287208@robh.at.kernel.org>
References: <20210625121045.81711-1-paul@crapouillou.net>
        <YOk60yTP9L1gT3+W@ravnborg.org> <HBW0WQ.NHPOJDIT9XWR1@crapouillou.net>
        <YOlvev0nvXVYU01y@ravnborg.org> <K4Y0WQ.MLS1MDCVFJWL3@crapouillou.net>
        <20210714203013.GA3287208@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le mer., juil. 14 2021 at 14:30:13 -0600, Rob Herring <robh@kernel.org> 
a écrit :
> On Sat, Jul 10, 2021 at 11:21:56AM +0100, Paul Cercueil wrote:
>> 
>>  [...]
>> 
>>  > >  I am not sure; the doc states that this (additionalProperties:
>>  > > false) "can't
>>  > >  be used in case where another schema is referenced", which is 
>> the
>>  > > case here,
>>  > >  as we include "panel-common.yaml".
>>  >
>>  > This DT schema already list all relevant properties like:
>>  >
>>  > 	backlight: true
>>  >
>>  > So "additionalProperties: false" tells that no other properties 
>> are
>>  > allowed other than the listed properties.
>>  >
>>  > To my best understanding unevaluatedProperties: false is less 
>> strict and
>>  > should be used if one does not list all possilbe properties.
> 
> Right. There's some value of listing which common properties you are
> using as well.
> 
>>  > This could be the case for a panel haging below a SPI controller 
>> as in
>>  > this case. So in other words giving this some extra thought I 
>> think
>>  > unevaluatedProperties: false is OK here.
>> 
>>  A panel below a SPI controller would have all its SPI-specific 
>> properties
>>  covered by spi-controller.yaml, I believe? So maybe 
>> "additionalProperties:
>>  false" would work?
> 
> No. Because spi-controller.yaml is evaluated on the SPI host node and
> this one is evaluated on the SPI slave. There's some work to address
> this, but it means every SPI slave will have to reference a SPI device
> schema. The bigger issue here is SPI controller specific device
> properties. So for this case, we'll have to use unevaluatedProperties.

Thank you for the clarification.

Cheers,
-Paul


>> 
>>  In any case, if I use "additionalProperties: false", "make 
>> dt_binding_check"
>>  complains that my example's "spi-max-frequency" property is not 
>> covered. So
>>  maybe you are right.
>> 
>>  > So my r-b is ok if you keep it as it.
>>  >
>>  > PS. Where do you guys hang out with the downfall of freenode - 
>> somewhere
>>  > on oftc?
>> 
>>  We moved to #opendingux on Libera.
>> 
>>  Cheers,
>>  -Paul
>> 
>> 
>> 


