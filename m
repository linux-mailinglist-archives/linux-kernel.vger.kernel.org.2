Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEDF4500EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhKOJQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:16:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42390 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhKOJPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:15:43 -0500
Received: from zn.tnic (p200300ec2f0b5600b1b3fd86d7b0312f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5600:b1b3:fd86:d7b0:312f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED5FF1EC0464;
        Mon, 15 Nov 2021 10:12:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636967562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XN6oLtdPBzmygW4sNSSf+9ArzNWshVKV7dEjstnhqeA=;
        b=khiPzV1+qid4jBC5ijoFK90YXRltVQXhunk3NE2tHLr4bI9d8r9cPuJgFZil0FcgK84Ydg
        MGR0YnfF+MEJuQRSmEew0BTtLTiI8AHG1b12SkrBg4x9x2vIGKGQLqXzz5nzErcj4N4FXb
        bMdqgoCFKKsFUqsWDJtCwPqMtCD8TwM=
Date:   Mon, 15 Nov 2021 10:12:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] x86/cpu: Remove "noclflush"
Message-ID: <YZIkhnqSq9SgL7k6@zn.tnic>
References: <20211112103246.7555-1-bp@alien8.de>
 <20211112103246.7555-7-bp@alien8.de>
 <CAJhGHyCm2O6uj29cAQNfaHX3Wq2NyO+s4=nQAS+3PadDqhiZtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJhGHyCm2O6uj29cAQNfaHX3Wq2NyO+s4=nQAS+3PadDqhiZtw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 05:03:29PM +0800, Lai Jiangshan wrote:
> The patch is definitely good for me, but I have no idea what
> "BUGS=" relates to here.
> (In the commit 191679fdfa63 ("x86: add noclflush option"))
> 
> In Documentation/admin-guide/kernel-parameters.rst:
> BUGS=   Relates to possible processor bugs on the said processor.

Probably some CLFLUSH-related erratum from more than 10 years ago.
Probably not relevant anymore - otherwise we would have heard about it.

> For patch 3,4,5, they can have my reviewed-by:
> 
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
