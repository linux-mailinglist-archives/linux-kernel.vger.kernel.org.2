Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282883EC709
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 05:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhHODuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 23:50:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39421 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233848AbhHODuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 23:50:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GnNbN0DtRz9sT6;
        Sun, 15 Aug 2021 13:49:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1628999392;
        bh=oksZwUuazJvyP/mu5YVIEDEnHdB0QX1GEAxzy9oOoGw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cW3zYHgZtt0iJ99/blGwvB5OhuCh9dutsTRQ8lskJyJ52uy8dvnIyedD4mt3Zhmky
         E9ZteJ17gTt+F0m1KRUWAs7Kw8tUMmlWlEIr/WKT0dNcDDZmSY7Uu7Br4MVm/hb1Gk
         Dz9s61tiVVeGeyOoZSW5MxBI7DVbKUKRQ1EWoRGGdQ40pyw/Z6xmZ3EKNbwKLWJ5a+
         qYIIRIwEe0TeQVaBCaiz8rjbi9+dvD6HXSdAl3l0CLLRgNV5CIGu445K5Y036EEZNo
         cvmReB7AxleDZePojBwV/pYS+lT6kXmRQ+qqebpo4YbbP3nGxHl4RHyAYK+ANCraFB
         0UcW4tbWKwLTg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/bug: Provide better flexibility to
 WARN_ON/__WARN_FLAGS() with asm goto
In-Reply-To: <389962b1b702e3c78d169e59bcfac56282889173.1618331882.git.christophe.leroy@csgroup.eu>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
 <389962b1b702e3c78d169e59bcfac56282889173.1618331882.git.christophe.leroy@csgroup.eu>
Date:   Sun, 15 Aug 2021 13:49:50 +1000
Message-ID: <87wnonl63l.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 24725e50c7b4..34745f239208 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -926,7 +926,7 @@ static void check_section(const char *modname, struct elf_info *elf,
>  		".kprobes.text", ".cpuidle.text", ".noinstr.text"
>  #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
>  		".fixup", ".entry.text", ".exception.text", ".text.*", \
> -		".coldtext"
> +		".coldtext .softirqentry.text"

This wasn't working, I updated it to:

               ".coldtext", ".softirqentry.text"

Which works.

cheers
