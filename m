Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83E3C5FF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhGLQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:01:46 -0400
Received: from ms.lwn.net ([45.79.88.28]:42284 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhGLQBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:01:45 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 10B0736E;
        Mon, 12 Jul 2021 15:58:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 10B0736E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626105536; bh=Qb3OXo7qhoaP3C4INVLiWv6MZA+pYBII5/GUopy3zWs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Aae8KS5Z6cOukMDwLjn9CLgDbWIL2ZDm2u898yF8m+4X/Zj9AT3uOZ1aWUmQYk7vF
         LqJ9yD4YN3DIOaVpzWoiRhahezYUlmkGyH1rYeI+nk6Cm6Ec4ybFN2hqyH1IQ1wKCn
         Sv57PGROrEU/LjRiUO7APcayTASSPIULykk1lqv/WSvXUbZCG/6yF58XylEnbXqD0V
         u0foO8nM+J2/plsjJ80i6W94l2VUm2SKTqLEMVdyhC+gp+WiM/9LCuRH144pWaR04Q
         BViKBkvSsLId6otZGTIepkG3AZ6YfXYubuBM15YibFAY9hkfzQlnj+5Mpj/lB+QK/S
         DujrTKjPfSQcQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Nishanth Menon <nm@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "Ravikumar, Rahul" <r-ravikumar@ti.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-spdx <linux-spdx@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] scripts/spdxcheck.py: Strictly read license files in
 utf-8
In-Reply-To: <20210707204840.30891-1-nm@ti.com>
References: <20210707204840.30891-1-nm@ti.com>
Date:   Mon, 12 Jul 2021 09:58:55 -0600
Message-ID: <87y2abr0ao.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> Commit bc41a7f36469 ("LICENSES: Add the CC-BY-4.0 license")
> unfortunately introduced LICENSES/dual/CC-BY-4.0 in UTF-8 Unicode text
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
> needs unicode quotes, instead, force spdxcheck to read utf-8.
>
> Reported-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

I've applied this, thanks.

jon
