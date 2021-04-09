Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15735A4FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhDIRz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:55:26 -0400
Received: from mailout08.rmx.de ([94.199.90.85]:54109 "EHLO mailout08.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDIRzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:55:24 -0400
X-Greylist: delayed 1998 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 13:55:23 EDT
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout08.rmx.de (Postfix) with ESMTPS id 4FH4gM0ScjzMsfQ;
        Fri,  9 Apr 2021 19:21:51 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4FH4gK18Kdz2xCK;
        Fri,  9 Apr 2021 19:21:49 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.55.67) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 9 Apr
 2021 19:21:48 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jiri Prchal <jiri.prchal@aksignal.cz>
Subject: Re: [PATCH 0/3] nvmem: eeprom: add support for FRAM
Date:   Fri, 9 Apr 2021 19:21:47 +0200
Message-ID: <4311739.LvFx2qVVIh@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20210409154720.130902-1-jiri.prchal@aksignal.cz>
References: <20210409154720.130902-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.55.67]
X-RMX-ID: 20210409-192149-YcHNxFStkyvC-0@out01.hq
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

I have two Fujitsu different FRAMs running with the stock at25 driver. I set
the page size equal to the device size (as FRAMs have no pages).  

Are you able to run your FRAM with the unmodified driver?

I assume that getting the device geometry from the chip is vendor specific (in
contrast to flash devices which have standard commands for this).  I suppose
that there is no much value getting vendor specific information from a chip. If
the drivers knows the vendor, it should also know the chip (e.g. from the dt).

regards
Christian

On Friday, 9 April 2021, 17:47:17 CEST, Jiri Prchal wrote:
> Adds sopport for Cypress FRAMs.
> 
> Jiri Prchal (3):
>   nvmem: eeprom: at25: add support for FRAM
>   nvmem: eeprom: at25: add support for FRAM
>   nvmem: eeprom: add documentation for FRAM
> 
>  .../devicetree/bindings/eeprom/at25.yaml      |  12 +-
>  drivers/misc/eeprom/Kconfig                   |   5 +-
>  drivers/misc/eeprom/at25.c                    | 151 ++++++++++++++----
>  drivers/nvmem/core.c                          |   4 +
>  include/linux/nvmem-provider.h                |   1 +
>  5 files changed, 139 insertions(+), 34 deletions(-)
> 
> 




