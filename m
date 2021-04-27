Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E2136C8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbhD0Pq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:46:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:37450 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234932AbhD0Pq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:46:29 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ABBC52C1;
        Tue, 27 Apr 2021 15:45:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ABBC52C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1619538345; bh=o2gGn+4BnvtLdCze9lDxV+rfDGVuo34dWsbyZeiw5mk=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=AwFAjlPU4C/LrqrYnz99l2l54L6esGX1hE3y0WqjhyRtujIV2AY/acA2pjYnDg2xg
         hDF5B9SefMkTEOe0dldxbILZfpVoE1rxsHa8CNxuyYBtd67GpSQ1Ej/T+i6v+ob/IS
         tLzoTxCpSzBBV2VifBZ9TTK0w+vDXpo1ImrZyHHsIQY7EBYkVpj5eBsGHAsOC92TtH
         Ckx2vHP49qNtKOYMU4zwFAwRiz7DDj9voNXtlCgN+tKu/zzae6dUfPU6UfLQQSUhHz
         t50WFgfW1HZ43xCTlSQ0Z2yqvY0tjOOzWxYw9+aAPtV5HQxUeBr2abgvCGWnTO4XuL
         RErcunzh+WSZw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <bilbao@vt.edu>, tglx@linutronix.de,
        mingo@redhat.com, peterz@infradead.org, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixed typo in Documentation/x86/x86_64/5level-paging.rst
In-Reply-To: <CACbHsvSta2hogK0E4AKCxsUF3bFrdQTAA-mp2MvO6Q7+rQuKCg@mail.gmail.com>
References: <CACbHsvSta2hogK0E4AKCxsUF3bFrdQTAA-mp2MvO6Q7+rQuKCg@mail.gmail.com>
Date:   Tue, 27 Apr 2021 09:45:45 -0600
Message-ID: <871raveno6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <bilbao@vt.edu> writes:

> Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
> ---
>  Documentation/x86/x86_64/5level-paging.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/x86/x86_64/5level-paging.rst
> b/Documentation/x86/x86_64/5level-paging.rst
> index 44856417e6a5..b792bbdc0b01 100644
> --- a/Documentation/x86/x86_64/5level-paging.rst
> +++ b/Documentation/x86/x86_64/5level-paging.rst
> @@ -6,9 +6,9 @@
>
>  Overview
>  ========
> -Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
> +Original x86-64 was limited by 4-level paging to 256 TiB of virtual address
>  space and 64 TiB of physical address space. We are already bumping into
> -this limit: some vendors offers servers with 64 TiB of memory today.
> +this limit: some vendors offer servers with 64 TiB of memory today.

So this seems like a good change, but I need to make a couple of
requests:

 - Please include a changelog, even with relatively simple patches like
   this.

 - Patches should be sent as plain text, inline in the mail - not as
   attachments and *certainly* not as HTML.  Have a look at
   Documentation/process/email-clients.rst if you need some guidance on
   configuring your email setup.

Thanks,

jon
