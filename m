Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386A1442CDB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhKBLld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhKBLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D8FC061766
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:38:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fh1NTkz4xd4;
        Tue,  2 Nov 2021 22:38:32 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <c904599f33aaf6bb7ee2836a9ff8368509e0d78d.1631887042.git.christophe.leroy@csgroup.eu>
References: <c904599f33aaf6bb7ee2836a9ff8368509e0d78d.1631887042.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/32: Don't use a struct based type for pte_t
Message-Id: <163584791399.1845480.3255775736155038063.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 15:57:31 +0200, Christophe Leroy wrote:
> Long time ago we had a config item called STRICT_MM_TYPECHECKS
> to build the kernel with pte_t defined as a structure in order
> to perform additional build checks or build it with pte_t
> defined as a simple type in order to get simpler generated code.
> 
> Commit 670eea924198 ("powerpc/mm: Always use STRICT_MM_TYPECHECKS")
> made the struct based definition the only one, considering that the
> generated code was similar in both cases.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Don't use a struct based type for pte_t
      https://git.kernel.org/powerpc/c/c7d19189d7241e135cd2e450a7fbc77cb7bd40ee

cheers
