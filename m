Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0973B9049
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 12:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhGAKFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 06:05:15 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51021 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbhGAKFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 06:05:14 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A15C42224E;
        Thu,  1 Jul 2021 12:02:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625133763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7fswWsAdWP8NO1tagWuHhgH26LxBv6WQkfSB6mnL3W0=;
        b=HkZixNnZCm6DHD3JEs/RExo3oEr7zRrqkoS3wbZW8DfG4z57UIQ+4eFWgnSYmg/yCs/4G1
        P+d0nuYFTvUpk8rQWQViMXPEQtwgw79yBuR5Uj6rovbkTKX7A5KNNEFEQ9W4sgl12/D7Wg
        AJYWwzMo8bNOzNMl5kQleKUTzXA7Apc=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 01 Jul 2021 12:02:42 +0200
From:   Michael Walle <michael@walle.cc>
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mtd: spi-nor: Add some M45PEx ids
In-Reply-To: <20210630182059.29699-1-hongweiz@ami.com>
References: <20210629150846.21547-1-hongweiz@ami.com>
 <20210630182059.29699-1-hongweiz@ami.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <ea2db205a600f66ed3ec7224723a3e82@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hongwei,

Am 2021-06-30 20:20, schrieb Hongwei Zhang:
>> Am 2021-06-29 17:08, schrieb Hongwei Zhang:
>>> Add some Micron M45PEx flash memeories into the IDs table.
>> 
>> Did you test all these flashes?
>> 
> No, the patch was added in porting drivers related to AST2600 EVB.

Please note, that all flashes which are added must be tested.

>>> Fixes: dd1e9367157f900616f (ARM: dts: everest: Add phase corrections
>>> for
>>> eMMC)
>> 
>> Bogus Fixes tag. First, I cannot find this commit id, which tree is
>> that? Secondly, adding new flash ids don't fix anything, esp not
>> something related to eMMC.
>> 
> Sorry for the confusion, I thought Fixes tag could be also used for 
> referencing
> the revision base for the patch to aplly on.
> I used dev-5.10 branch from https://github.com/openbmc/linux.git , 
> should I
> use a different repository?

AFAIK commits in fixes tags must be relative to Linus Torvalds' tree
(or a subtree must not rebase, like the networking trees, which means
they will end up in Torvalds' tree).

Anyway, this is not a fix and therefore there must be no Fixes: tag.

-michael
