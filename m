Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2C363A07
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237565AbhDSEFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54971 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237439AbhDSEE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:57 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVd24ZHz9vHP; Mon, 19 Apr 2021 14:04:24 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20210301153019.362742-1-masahiroy@kernel.org>
References: <20210301153019.362742-1-masahiroy@kernel.org>
Subject: Re: [PATCH 1/2] powerpc: syscalls: switch to generic syscalltbl.sh
Message-Id: <161880479712.1398509.4808432527378753490.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 00:30:18 +0900, Masahiro Yamada wrote:
> Many architectures duplicate similar shell scripts.
> 
> This commit converts powerpc to use scripts/syscalltbl.sh. This also
> unifies syscall_table_32.h and syscall_table_c32.h.

Applied to powerpc/next.

[1/2] powerpc: syscalls: switch to generic syscalltbl.sh
      https://git.kernel.org/powerpc/c/14b3c9d24a7a5c274a9df27d245516f466d3bc5f
[2/2] powerpc: syscalls: switch to generic syscallhdr.sh
      https://git.kernel.org/powerpc/c/672bff581e19d5d7bef993f910ed385c4054cbbc

cheers
