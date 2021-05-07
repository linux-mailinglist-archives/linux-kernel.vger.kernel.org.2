Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF9376024
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhEGGPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhEGGPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:15:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A2EF613D8;
        Fri,  7 May 2021 06:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620368053;
        bh=gFnV/k+UdXYwSVrHSx0FiiV2r8txNvYrizze1uQC+Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HznYzawYDbRu67ZBVjXY2BSF3Ix/xPt5uEoSgKnrtwiwnolY8Ixh0a2rO17EPIbHN
         FfIhDzeAkeKy8igheLUV9f0yki8Bw4I4HG8WXZf97vRD/nyUCII0cbbdCkIq+K2Usm
         J+VIg3O31kA8h0L5FT3xy8CuLwoRLHeN4MHdHI3A=
Date:   Fri, 7 May 2021 08:14:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] Documentation: drop optional BOMs
Message-ID: <YJTastLTzwVJOPNk@kroah.com>
References: <20210506231907.14359-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506231907.14359-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 04:19:07PM -0700, Randy Dunlap wrote:
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

That's crazy, nice catch!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> 
> --- linux-next-20210506.orig/Documentation/block/data-integrity.rst
> +++ linux-next-20210506/Documentation/block/data-integrity.rst
> @@ -1,4 +1,4 @@
> -﻿==============
> +==============
>  Data Integrity
>  ==============
>  
> --- linux-next-20210506.orig/Documentation/process/kernel-enforcement-statement.rst
> +++ linux-next-20210506/Documentation/process/kernel-enforcement-statement.rst
> @@ -1,4 +1,4 @@
> -﻿.. _process_statement_kernel:
> +.. _process_statement_kernel:
>  
>  Linux Kernel Enforcement Statement
>  ----------------------------------
> --- linux-next-20210506.orig/Documentation/timers/no_hz.rst
> +++ linux-next-20210506/Documentation/timers/no_hz.rst
> @@ -1,4 +1,4 @@
> -﻿======================================
> +======================================
>  NO_HZ: Reducing Scheduling-Clock Ticks
>  ======================================
>  
> --- linux-next-20210506.orig/Documentation/usb/mtouchusb.rst
> +++ linux-next-20210506/Documentation/usb/mtouchusb.rst
> @@ -1,4 +1,4 @@
> -﻿================
> +================
>  mtouchusb driver
>  ================
>  
> --- linux-next-20210506.orig/Documentation/usb/usb-serial.rst
> +++ linux-next-20210506/Documentation/usb/usb-serial.rst
> @@ -1,4 +1,4 @@
> -﻿==========
> +==========
>  USB serial
>  ==========
>  
> --- linux-next-20210506.orig/Documentation/security/tpm/xen-tpmfront.rst
> +++ linux-next-20210506/Documentation/security/tpm/xen-tpmfront.rst
> @@ -1,4 +1,4 @@
> -﻿=============================
> +=============================
>  Virtual TPM interface for Xen
>  =============================
>  
