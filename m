Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE8745EF84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349993AbhKZOFB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Nov 2021 09:05:01 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:38625 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhKZOC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:02:59 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHo6Y-1mnqcB3y5e-00Etq5 for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021
 14:59:45 +0100
Received: by mail-wm1-f54.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso10784532wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 05:59:45 -0800 (PST)
X-Gm-Message-State: AOAM532Iv3npJZbxk5x0tZJNA4IQOmCGlCIetSORSkHDlzfWVKsXsVov
        OdcTf7bsfiGm8l1GS6wEEdTIhJ+qlNAmuSK/j0I=
X-Google-Smtp-Source: ABdhPJwLo2gvIaV7a7BIVtCOjM0MfS2JQcBHF9YHLbK8BZai46KYcznJM7hhcadb89FUv1DDYSJlNeq22biIjPHaGvA=
X-Received: by 2002:a05:600c:6d2:: with SMTP id b18mr15934623wmn.98.1637935185632;
 Fri, 26 Nov 2021 05:59:45 -0800 (PST)
MIME-Version: 1.0
References: <20211125154406.470082-1-anders.roxell@linaro.org> <6b1e51a8-2f4d-2024-df90-a35c926d7a30@csgroup.eu>
In-Reply-To: <6b1e51a8-2f4d-2024-df90-a35c926d7a30@csgroup.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Nov 2021 14:59:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0n_n+PnfYmAdS9923yheLqYXRp8=65hKf9abLCRAX8ig@mail.gmail.com>
Message-ID: <CAK8P3a0n_n+PnfYmAdS9923yheLqYXRp8=65hKf9abLCRAX8ig@mail.gmail.com>
Subject: Re: [PATCH] powerpc: mm: radix_tlb: rearrange the if-else block
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:hGSB75CjeR/oKAfwRFTXVfARdCQowz6zWpjPFSzGnacBIA8CG2m
 U/3X1XKwVqGa1UJhPFfF4cCLynul7HFJpTQJ+HtfDl3OOujRF7045SLhpwg9iZF6ah01bGy
 TEruEfIgQPAy3bKhANxvMNGYyWwEvnAbKG8mXPe2+YXmOVKjx3DgITUK7Y02ipUfwU7n2TH
 xD/lzz9/F5YgLJ+SJ/5HA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQuRoF2Ic54=:4E90zqvQst62E9q90dwFS0
 wKzn7y8xwWiEE1YsPelPw4bJrW/grOjpmQzYK25BmxYt6JNs+0KOkWmoR0zOasVf46HGmRiVo
 PD2hulRc0obALv05rzz8AUCc6mf9LVuPXChqTXcRO15RkvViMH5SoCDhvhpuQMdk8FffhC7ES
 wL3qNKdNyx0t6XRTvWNCY3ItzNDzm2ZdrYo0YHHH0HBmpgwCeyLI1vSldWpehGOPZA48cFRDK
 OuPIIDf+OAHjlL8lcK39paiSi0PvxM22euMd5veETJpHO1NgK41EpQCgpo+tEEK7PWQLeABNq
 Gl0o//U2G0qV5bNhw7FN5j8G5oCNWoY3wlZzGchebl8tx6ePaIR3jAtTW28Sx4IiMEjnGbFAY
 aFzLok0AJ7jju7aAbigdX+pdC59qxWFrjCTKh8kwxqswykckRkvcyx2L2+RVjR7H0UNF3VwRD
 Uc6WLrEcgUDIgRelVNKEISWiEYiqOzzwKT6GnznMC+DDrzLSRCY7wDQ4nFw9+NebqDzh2osNX
 x2rzXWCK+4ULK+EqWlJISC0zxL9hakmKyp2tVPb7IiTk1Nb9aEXRA3c+j0npZHy29UTSOfoW0
 iHiKlOnWKUHrgvveQEoz1kwoIXF3pkKr+IKU6rG69Jq+4ksWOym6yfzlSDwYSCEBRXVhWXqdD
 cJaBkAqj6oSncFDawolhnRDsWJeCy5EIZE9nbPeZ8fM46CZ2gFA6NuHm3sb8F1llCPKo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 2:43 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 25/11/2021 à 16:44, Anders Roxell a écrit :
> Can't you fix CLANG instead :) ?
>
> Or just add an else to the IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) that
> sets hstart and hend to 0 ?

That doesn't sound any less risky than duplicating the code, it can lead to
incorrect changes just as easily if a patch ends up actually flushing at the
wrong address, and the compiler fails to complain because of the bogus
initialization.

> Or just put hstart and hend calculation outside the IS_ENABLED() ? After
> all GCC should drop the calculation when not used.

I like this one. I'm still unsure how clang can get so confused about whether
the variables are initialized or not, usually it handles this much better than
gcc. My best guess is that one of the memory clobbers makes it conclude
that 'hflush' can be true when it gets written to by an inline asm.

        Arnd
