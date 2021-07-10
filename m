Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B683C341B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhGJKYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 06:24:52 -0400
Received: from aposti.net ([89.234.176.197]:57962 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230443AbhGJKYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 06:24:51 -0400
Date:   Sat, 10 Jul 2021 11:21:56 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Innolux EJ030NA
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Message-Id: <K4Y0WQ.MLS1MDCVFJWL3@crapouillou.net>
In-Reply-To: <YOlvev0nvXVYU01y@ravnborg.org>
References: <20210625121045.81711-1-paul@crapouillou.net>
        <YOk60yTP9L1gT3+W@ravnborg.org> <HBW0WQ.NHPOJDIT9XWR1@crapouillou.net>
        <YOlvev0nvXVYU01y@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

>>  I am not sure; the doc states that this (additionalProperties: 
>> false) "can't
>>  be used in case where another schema is referenced", which is the 
>> case here,
>>  as we include "panel-common.yaml".
> 
> This DT schema already list all relevant properties like:
> 
> 	backlight: true
> 
> So "additionalProperties: false" tells that no other properties are
> allowed other than the listed properties.
> 
> To my best understanding unevaluatedProperties: false is less strict 
> and
> should be used if one does not list all possilbe properties.
> This could be the case for a panel haging below a SPI controller as in
> this case. So in other words giving this some extra thought I think
> unevaluatedProperties: false is OK here.

A panel below a SPI controller would have all its SPI-specific 
properties covered by spi-controller.yaml, I believe? So maybe 
"additionalProperties: false" would work?

In any case, if I use "additionalProperties: false", "make 
dt_binding_check" complains that my example's "spi-max-frequency" 
property is not covered. So maybe you are right.

> So my r-b is ok if you keep it as it.
> 
> PS. Where do you guys hang out with the downfall of freenode - 
> somewhere
> on oftc?

We moved to #opendingux on Libera.

Cheers,
-Paul


