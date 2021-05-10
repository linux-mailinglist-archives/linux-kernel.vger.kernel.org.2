Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5B379909
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 23:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhEJVSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 17:18:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:54254 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhEJVSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 17:18:36 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4ADCD6D6;
        Mon, 10 May 2021 21:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4ADCD6D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620681449; bh=bMfhGN2Sb5awdnhBL0PMAadt6SFAO53pU1Yu0mUz7Lo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LuTteKp+df+DrnQuj+GhvAJQ78fC9PgLQx2EuY8J0l5yVpKMF1xg/BoEM6SllgbTq
         uNokbTg9glKu8ueUu5g5aG3YZFDEBOO9TyIs31XwPbE7eMG0JjH+nQVLbwlbxbdn/i
         Q0XTWLxR2B9Ba3zRIefuTrxfXzlRa0lj8V5XcSZYYjMePUprIiCRGF9aLAycuqBiR8
         vEOVgc7vd1gYBqDQu8WXApV/rqpw26+xgYpgjBFM1+eZST6P1hiLd7XLR5kp7cyrac
         LiqQx7TtYuPl32A6LFCNBBvFO+41yAWpwy/gfrUo+F4hpvV6GBQJfsWC8mbbULhHC4
         fP2+u36ka6Ymw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] Documentation: drop optional BOMs
In-Reply-To: <20210506231907.14359-1-rdunlap@infradead.org>
References: <20210506231907.14359-1-rdunlap@infradead.org>
Date:   Mon, 10 May 2021 15:17:28 -0600
Message-ID: <875yzqffvb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> A few of the Documentation .rst files begin with a Unicode
> byte order mark (BOM). The BOM may signify endianess for
> 16-bit or 32-bit encodings or indicate that the text stream
> is indeed Unicode. We don't need it for either of those uses.
> It may also interfere with (confuse) some software.
>
> Since we don't need it and its use is optional, just delete
> the uses of it in Documentation/.
>
> https://en.wikipedia.org/wiki/Byte_order_mark
>
> Fixes: 898bd37a9206 ("docs: block: convert to ReST")
> Fixes: edba5eecfd6e ("doc:it_IT: add some process/* translations")
> Fixes: 675aaf05d898 ("docs: xen-tpmfront.txt: convert it to .rstX")
> Fixes: 458f69ef3665 ("docs: timers: convert docs to ReST and rename to *.rst")
> Fixes: d80b5005c5dd ("docs: usb: convert documents to ReST")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Federico Vaga <federico.vaga@vaga.pv.it>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>  Documentation/block/data-integrity.rst                 |    2 +-
>  Documentation/process/kernel-enforcement-statement.rst |    2 +-
>  Documentation/security/tpm/xen-tpmfront.rst            |    2 +-
>  Documentation/timers/no_hz.rst                         |    2 +-
>  Documentation/usb/mtouchusb.rst                        |    2 +-
>  Documentation/usb/usb-serial.rst                       |    2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

jon
