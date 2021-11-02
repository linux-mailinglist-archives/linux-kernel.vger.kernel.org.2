Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91730442CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhKBLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:40 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:43817 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhKBLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fk6C0vz4xdJ;
        Tue,  2 Nov 2021 22:38:34 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>
In-Reply-To: <6ec2a7865ed6a5ec54ab46d026785bafe1d837ea.1630484892.git.christophe.leroy@csgroup.eu>
References: <6ec2a7865ed6a5ec54ab46d026785bafe1d837ea.1630484892.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] powerpc/32: Add support for out-of-line static calls
Message-Id: <163584790887.1845480.9565993990239448984.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sep 2021 08:30:21 +0000 (UTC), Christophe Leroy wrote:
> Add support for out-of-line static calls on PPC32. This change
> improve performance of calls to global function pointers by
> using direct calls instead of indirect calls.
> 
> The trampoline is initialy populated with a 'blr' or branch to target,
> followed by an unreachable long jump sequence.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Add support for out-of-line static calls
      https://git.kernel.org/powerpc/c/5c810ced36ae1a8f1a7403c1635b0dc07c115086

cheers
