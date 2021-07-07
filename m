Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA283BE4DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhGGJDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhGGJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:03:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD414C061574;
        Wed,  7 Jul 2021 02:00:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625648431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKAn8Dx3Y/L0pbsgSbA9OgZ7rDKTbASTW3EYoEIIFa4=;
        b=eVr6Wnxy0OoN8+QuLtOOjr5eycSwcNsbgtTOEt9WMEm++cvWdSqI2DomT3G7kyigmjlgrp
        py0yctsCiprDmgVh8091lkKgKuGVB/9wdWmdo2zD3T/vwgujci1sNkO3KEMdegpViu1OAg
        uL1r6xwPWLjK/95h/cowe2maqz6Lr1GaAbGfkagMl7hRKvn0f2G4LFO3zC90awe8nJ+eLJ
        lgrU/CHi92cS+/caaP9WKzFVLkFvWt/K5vyMUSwA1oJxGqH/N8FhidwHLvIZaKkVDM//Gy
        xfK8sWK/IFTL3LhEA+KvUrAckql/13hccm96ajjkxhH4O7SN6OIM7RcefdIuXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625648431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zKAn8Dx3Y/L0pbsgSbA9OgZ7rDKTbASTW3EYoEIIFa4=;
        b=vBsHwFIFbn+3aL5gtPuo/Wfkpr4xNFykm75s3sPA7dIw8WqgHFiPnM7P7zWt5AWRcUcfNv
        cad8rWx5i5MRrbBQ==
To:     Nishanth Menon <nm@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Rahul T R <r-ravikumar@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] scripts/spdxcheck.py: Lets strictly read license files in utf-8
In-Reply-To: <20210703012128.27946-1-nm@ti.com>
References: <20210703012128.27946-1-nm@ti.com>
Date:   Wed, 07 Jul 2021 11:00:31 +0200
Message-ID: <87h7h6qz0w.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth,
On Fri, Jul 02 2021 at 20:21, Nishanth Menon wrote:
> Commit bc41a7f36469 ("LICENSES: Add the CC-BY-4.0 license")
> unfortunately introduced LICENSES/dual/CC-BY-4.0 in UTF-8 Unicode text

Sigh. Why are people adding such things w/o running this script in the
first place.

> While python will barf at it with:
>
> FAIL: 'ascii' codec can't decode byte 0xe2 in position 2109: ordinal not in range(128)
> Traceback (most recent call last):
>   File "scripts/spdxcheck.py", line 244, in <module>
>     spdx = read_spdxdata(repo)
>   File "scripts/spdxcheck.py", line 47, in read_spdxdata
>     for l in open(el.path).readlines():
>   File "/usr/lib/python3.6/encodings/ascii.py", line 26, in decode
>     return codecs.ascii_decode(input, self.errors)[0]
> UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 2109: ordinal not in range(128)
>
> While it is indeed debatable if 'Licensor.' used in the license file
> needs unicode quotes, instead, let us force spdxcheck to read utf-8
> instead.

s/let us//

Ditto for the $subject. See Documentation/process/ for further enlightment.

> Reported-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

With that fixed:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
