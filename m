Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A6D40EB04
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234265AbhIPTsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:48:12 -0400
Received: from srv4.3e8.eu ([193.25.101.238]:34172 "EHLO srv4.3e8.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhIPTsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:48:11 -0400
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Sep 2021 15:48:11 EDT
Received: from [IPv6:2003:c6:cf12:5a0:9abc:9583:6f0a:c734] (p200300c6cf1205a09abc95836f0ac734.dip0.t-ipconnect.de [IPv6:2003:c6:cf12:5a0:9abc:9583:6f0a:c734])
        (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits))
        (No client certificate requested)
        by srv4.3e8.eu (Postfix) with ESMTPSA id 55F66600A9;
        Thu, 16 Sep 2021 21:38:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu;
        s=mail20170724; t=1631821108;
        bh=a33GpWWnFT3v41eI/sIwgek55Y5I8bXRNKTeri1tpmE=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=pi9e29V+QW+sGLIt+qY+Buh/nSOq+Iz9Nx2eZ08Wi/YBSgkw9NqITMl8jZFRIDnJ3
         +HtfAbhOxK6IAwBTdl1Xa9gO/Zdp6pmJsurSjkbMgOuSiXMUF6mvwj1Ukc7CuNMBSV
         AHuo3JJsjqygK5LwgTmljN0GRnGk1YuHXOnvNgQBSHEmv8ziKqxgi5pOcYnLAyvruh
         KY5cAEmY9o2a+duv70z0Lcs+jIijTM8PoUem8+hF8z5SMYjBTMQQEuffPp5xRNytID
         +G0czFuVrEOpHGf5W2Kp5ps6UDG0wMxCiejUqa2bCjr9iQ0J9WAUjGB3rc10CMb4ik
         PSD4LQukH/vYg==
To:     Daniel Kestrel <kestrelseventyfour@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210808072643.GA5084@ubuntu>
From:   Jan Hoffmann <jan@3e8.eu>
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <51f2ebf4-6df1-eba5-99f1-1ec88e475d20@3e8.eu>
Date:   Thu, 16 Sep 2021 21:38:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210808072643.GA5084@ubuntu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Configuration of the ECC engine type using device tree has actually
worked before. I am using OpenWrt on a Fritzbox 7362 SL, which has a
Micron 29F1G08ABADA flash chip. The bootloader of the device uses on-die
ECC, so that has to be used for Linux as well. It is configured in DTS
using "nand-ecc-mode = "on-die";". This worked fine with kernel 5.4.
However, after switching to kernel 5.10 it is ignored and software ECC
is used instead.

If I understand this correctly, the situation is as follows:

Originally, xway-nand did set defaults for ECC mode and algorithm, but
different values could be configured using device tree.

Commit d7157ff49a5b ("mtd: rawnand: Use the ECC framework user input
parsing bits") broke these default values, as the ECC algorithm is now
unconditionally set from the user configuration in rawnand_dt_init.
Previously, the default value was only overwritten if the device tree
actually contained a value.

This is fixed in d525914b5bd8 ("mtd: rawnand: xway: Move the ECC
initialization to ->attach_chip()"). However, this makes it impossible
to configure the ECC engine type in the device tree, as it is now
overwritten by the default value in xway_attach_chip.

I am not sure if this patch is the best approach for fixing this, as it
would again cause breakage for anyone who relies on the existing
default value. And this kind of breakage seems to have been the reason
for moving the default values to attach_chip in the first place (see
https://lore.kernel.org/lkml/20201105084939.72ea6bfd@xps13/ ).

As similar changes were applied to other NAND drivers, the same issue
probably also exists there. Maybe it makes sense to add a proper fix
for all of them?

Thanks,
Jan
