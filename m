Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473A140FEC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240818AbhIQRrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhIQRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:47:01 -0400
X-Greylist: delayed 79625 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Sep 2021 10:45:38 PDT
Received: from srv4.3e8.eu (srv4.3e8.eu [IPv6:2001:67c:12a0:200::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71EDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:45:38 -0700 (PDT)
Received: from [IPv6:2003:c6:cf12:5a0:9abc:9583:6f0a:c734] (p200300c6cf1205a09abc95836f0ac734.dip0.t-ipconnect.de [IPv6:2003:c6:cf12:5a0:9abc:9583:6f0a:c734])
        (using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits))
        (No client certificate requested)
        by srv4.3e8.eu (Postfix) with ESMTPSA id 1085B600AA;
        Fri, 17 Sep 2021 19:45:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3e8.eu;
        s=mail20170724; t=1631900736;
        bh=ktVsCO/bA+2oA7yI6QdsCnVtNDARkq+bYABQf34Yf5w=;
        h=To:Cc:References:From:Subject:Date:In-Reply-To:From;
        b=waEfshOiUYtzIx19kj860fpjfQLq/lwaNwD7rYmnSJRsFZ60Lkd5z/jwJ3VQK3ypd
         djTVDAPOk2M05vZvHpLcbHOMWeI0gSDEaE0UmBRlXo/QdCTcftAkOyjyUZBmbIiWqk
         Vgs/PTKpKsJLplyZqAgTpK9PyxNb+VkxkuFBtOBJKULRH5+1v4g6K07xRhcBwz0gJ4
         FsAuqQs81aaBO5ae8qhY6QHtgeIK5ymCEeOePBPWCnMW8oNM54hE9YWsKTOCtwWb3O
         ip+dHUQAyACxfJ1630UDOvBwlSEp2WIGP/ZBWiHlCycrI/kCUNkYeX07roKvoXKCLl
         cBW5i0ssPRBKA==
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Daniel Kestrel <kestrelseventyfour@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210808072643.GA5084@ubuntu>
 <51f2ebf4-6df1-eba5-99f1-1ec88e475d20@3e8.eu> <20210917190154.76203a9a@xps13>
From:   Jan Hoffmann <jan@3e8.eu>
Subject: Re: [PATCH v2] mtd: rawnand: xway: No hardcoded ECC engine, use
 device tree setting
Message-ID: <e9dd0653-139f-749b-c088-e756ee2d2132@3e8.eu>
Date:   Fri, 17 Sep 2021 19:45:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917190154.76203a9a@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

> I am not sure to understand your message as answer to this thread.
> There are two problems here:
> 1/ The DT values not being taken into account

This is the issue I'm referring to.

> 1/ Has already been fixed (at least that is what I think)

This is not fixed in kernel 5.10. And unless I am missing something
there also doesn't seem be a fix in more recent kernels.

I am aware of commit 33d974e76e21 ("mtd: rawnand: xway: Do not force a
particular software ECC engine"), but that only fixes the ECC
algorithm. The ECC engine type is still hard-coded in xway_attach_chip.

Thanks,
Jan
