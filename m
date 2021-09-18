Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61B4108B5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 23:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbhIRV2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 17:28:19 -0400
Received: from srv4.3e8.eu ([193.25.101.238]:36426 "EHLO srv4.3e8.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232932AbhIRV2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 17:28:18 -0400
Received: from [IPv6:2003:c6:cf12:5a0:9abc:9583:6f0a:c734] (p200300c6cf1205a09abc95836f0ac734.dip0.t-ipconnect.de [IPv6:2003:c6:cf12:5a0:9abc:9583:6f0a:c734])
        (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits))
        (No client certificate requested)
        by srv4.3e8.eu (Postfix) with ESMTPSA id DC4E4600A9;
        Sat, 18 Sep 2021 23:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu;
        s=mail20170724; t=1632000412;
        bh=C/aPzaf95uZFHaGAuqSsJ/yKi15mexvt0yMVqlpMCc0=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=aCEWlS9GqO3Zjs5Zm5GbmIGyRXk7bGcFFftlUj+/z2+r7HjfpzrEPg5W3m9O6CI85
         +runf7LnW9zphnEsEY2JfxEee0aPeTTP9eWnI/4zAwGD9kN57g2MoCO0KqaCCfyNH0
         byL6Brvzge3wRPTXeQ0rG9asWgzstoEnsoWujlDWpGV1uZvP37HwCvRf2/zLN7WM5g
         hqjrB1QaTQjb9WZ9oq20EpPYOsfioXCkTknQ86+6yTxpWB8cYg5hfxoE7iutoWkBcD
         EiyRl/0QK/mfa+tzqvoeJimTFxLrVc6gvoLVxR6ahJQyaBFTA/a09/HTEqZh+e5x65
         MF8kl5lbz3WmA==
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Daniel Kestrel <kestrelseventyfour@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210808072643.GA5084@ubuntu>
 <51f2ebf4-6df1-eba5-99f1-1ec88e475d20@3e8.eu> <20210917190154.76203a9a@xps13>
 <e9dd0653-139f-749b-c088-e756ee2d2132@3e8.eu> <20210917213246.319e60cb@xps13>
From:   Jan Hoffmann <jan@3e8.eu>
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <14eb0cb7-b0af-87bf-b9a5-3e35eeb43f54@3e8.eu>
Date:   Sat, 18 Sep 2021 23:26:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917213246.319e60cb@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

> Yes this was my understanding, that only software ECC engine was
> supported. The mainline driver shows absolutely no signs of hardware
> ECC engine support.
> 
> Perhaps however you mean that on-die ECC engine are not supported
> anymore because of the engine_type being set in attach_chip()?

Yes, this is exactly the issue.

> If yes then indeed there is something to do, perhaps checking if an
> engine has been already set is enough? You can try something like:
> 
> if (engine_type == unknown)
> 	engine_type = soft;

Checking for NAND_ECC_ENGINE_TYPE_INVALID doesn't work, as the engine
type is already set to NAND_ECC_ENGINE_TYPE_ON_HOST by rawnand_dt_init.
The code there seems to expect that chip->ecc.engine_type contains the
default value, which is no longer the case after commit 525914b5bd8
("mtd: rawnand: xway: Move the ECC initialization to ->attach_chip()").

The following in attach_chip works:

if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST)
	chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;

However, this will also silently use the software ECC engine if anyone
actually configures the on-host hardware ECC engine in the device tree
(which is of course unsupported for xway).

Thanks,
Jan
