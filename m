Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278A03D39EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhGWLXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 07:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhGWLXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:23:50 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B75FC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 05:04:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GWSfR5Vqtz9sXM;
        Fri, 23 Jul 2021 22:04:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1627041861;
        bh=WEE70A1SmlcnlIsv9nVnRGPp1lz7FMXEUMxrnsgf+IU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VunPNjPI5UTxmlZmtF6HnK+D0Dif1lwUaNWcXlVbCnOy3zlfgpBXZRcdGvCjeSpTD
         9GtJzMFZAjmswf1Hvf+Shhuu3DtNGBXMNTQoMka2kFXjYcF/zGbOVaCZOBpwbNaHMV
         epX/8JSDuS2F3jGKGPdB1wvzULNj0TkI4wo+Z5qZ8TF2KuuqLjMk0XTObjG1udah19
         U1CpdO9KIVSiwPBast1gIEWa3fuADmNkO9j6lepWMRmuG+MHxyeWmwMTljc1HY+qcN
         iPuTprU1H6rO2uX1bsNbdVNf6qs+BaSKB5njML9F9aEsaaPNMQrnX9vJgFwZ5rtJUH
         0p1oAfMTFZbgA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Paul Mackerras <paulus@samba.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] Revert "mm/pgtable: add stubs for
 {pmd/pub}_{set/clear}_huge"
In-Reply-To: <162686329170.980657.905966885675716231.b4-ty@kernel.org>
References: <20210720202627.Horde.vlszNhxkKrLIg0-3Sn2ucw5@messagerie.c-s.fr>
 <87r1fs1762.fsf@mpe.ellerman.id.au>
 <162686329170.980657.905966885675716231.b4-ty@kernel.org>
Date:   Fri, 23 Jul 2021 22:04:10 +1000
Message-ID: <87o8at1bk5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> writes:
> On Wed, 21 Jul 2021 17:02:13 +1000, Michael Ellerman wrote:
>> This reverts commit c742199a014de23ee92055c2473d91fe5561ffdf.
>> 
>> c742199a014d ("mm/pgtable: add stubs for {pmd/pub}_{set/clear}_huge")
>> breaks arm64 in at least two ways for configurations where PUD or PMD
>> folding occur:
>> 
>>   1. We no longer install huge-vmap mappings and silently fall back to
>>      page-granular entries, despite being able to install block entries
>>      at what is effectively the PGD level.
>> 
>> [...]
>
> Thank you Michael! I owe you a beer next time I see you, if we don't go
> extinct before then.

No worries, thanks to Christophe for identifying the solution while on
vacation!

Beers seem a long way off, but hopefully one day :)

cheers
