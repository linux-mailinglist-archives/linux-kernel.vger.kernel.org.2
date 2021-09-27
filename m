Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ABE41A029
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhI0UeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbhI0Ud6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:33:58 -0400
Received: from srv4.3e8.eu (srv4.3e8.eu [IPv6:2001:67c:12a0:200::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7849C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:32:19 -0700 (PDT)
Received: from [IPV6:2003:c6:cf12:5a0:9abc:9583:6f0a:c734] (p200300c6cf1205a09abc95836f0ac734.dip0.t-ipconnect.de [IPv6:2003:c6:cf12:5a0:9abc:9583:6f0a:c734])
        (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits))
        (No client certificate requested)
        by srv4.3e8.eu (Postfix) with ESMTPSA id 34CCF60073;
        Mon, 27 Sep 2021 22:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu;
        s=mail20170724; t=1632774736;
        bh=UzG2e21h9wHznK4ErSzXQr3B2Z0rBnjaGgUtVaw7338=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=wU3KMRARhKVLBtIJU4/O9B7QdFn9o+V/TbdXoH6HKqlpB8A7v0uGolJQcluqOqyIr
         z2UMKp0xJOarvo6AOjb/a2knT0x1C91cCKYvW/cQZkJLYT+mUVn/xBN/qaDf3VyjkO
         Ay7kkur+Zdm9Cp6hY+wvGSp1DRez2bq9FR74fJNff1+Oaw8afNGwwBnSTHlM3ogj7Z
         hbrN9DEqKcoY0HD1lt4bE+gY5dn4UnSUy2IKBGoFYh2HeIzhajPIv0R95etcZvABTz
         Ne41Nya86NSATxV75/dmbfEjxvdNiVGzh0b7Cih8Ypu/czqbdiLp7vJrXlIpQu1ZWR
         V5PS3hv+vb4NQ==
Message-ID: <f800c48f-8e4a-ecdc-3198-c52be0425823@3e8.eu>
Date:   Mon, 27 Sep 2021 22:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Daniel Kestrel <kestrelseventyfour@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210808072643.GA5084@ubuntu>
 <51f2ebf4-6df1-eba5-99f1-1ec88e475d20@3e8.eu> <20210917190154.76203a9a@xps13>
 <e9dd0653-139f-749b-c088-e756ee2d2132@3e8.eu> <20210917213246.319e60cb@xps13>
 <14eb0cb7-b0af-87bf-b9a5-3e35eeb43f54@3e8.eu> <20210927183150.4be87140@xps13>
From:   Jan Hoffmann <jan@3e8.eu>
In-Reply-To: <20210927183150.4be87140@xps13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

> So what I propose is:
> - in the driver probe: set the default to software ECC
> - in the attach() hook: drop the line setting the engine_type to SOFT.
> 
> Please check the below diff and tell me if it works for you. I'll then
> propose a wider series fixing the other drivers as well.

I can confirm that your patch fixes the issue.

I tested using kernel 5.10 on a Fritzbox 7362 SL (with on-die ECC
configured via device tree which was broken before). I also checked on
a Fritzbox 7412 (this device uses software ECC). Both are working with
this patch.

Thanks,
Jan
