Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A96C35B8B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 04:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhDLCnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 22:43:00 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:53785 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhDLCm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 22:42:59 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id AD5774DC;
        Sun, 11 Apr 2021 19:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1618195362;
        bh=2JSiMj2lTtmX/cUYNHcQfWGUlLOWOoaYmlbsGHi9kio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pj17EJIJVgdcFiOCc3Sp5k+Ahwe2EdYCOMrNIkcBILxo9psf3hCrccvT9SMGg01VH
         HuSkUSpuQaQCc85/EC1LmH/OEuwkcoDCRqG9EYUJRGYv9QG+8O6kzFbVqCZgZ9ZA32
         enjwhxM73UTmJ+0J96VAy9QZoMEhfN4R7652iOlo=
Date:   Sun, 11 Apr 2021 21:42:39 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
Message-ID: <YHOznzolgu+j9Ruh@hatter.bewilderbeest.net>
References: <20210401044232.9637-1-zev@bewilderbeest.net>
 <84202973-1a94-4630-beeb-f33d044a0364@www.fastmail.com>
 <CACPK8XcfuEyqGmO72taXFPARxwzLyct5__0C0CF-nyEf6Yubnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACPK8XcfuEyqGmO72taXFPARxwzLyct5__0C0CF-nyEf6Yubnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 09:20:59PM CDT, Joel Stanley wrote:
>On Mon, 12 Apr 2021 at 02:16, Andrew Jeffery <andrew@aj.id.au> wrote:
>> On Thu, 1 Apr 2021, at 15:12, Zev Weiss wrote:
>
>> > +&vuart {
>> > +     status = "okay";
>> > +     aspeed,sirq-active-high;
>>
>> This should probably go away, but otherwise,
>
>Zev, this has already been merged (both to mainline for v5.13 and in
>openbmc), so any fixups need to come as patches on top of the existing
>code.
>

Got it, thanks -- I figured I'd wait until the DT-properties patches got 
approved & merged (I'll be sending v6 of that shortly) and then send an 
incremental update for the e3c246d4i dts to match the final form of 
those.


Zev

