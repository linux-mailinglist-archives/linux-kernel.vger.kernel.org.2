Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8B345D792
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 10:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353889AbhKYJwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 04:52:34 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:36193 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348012AbhKYJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:50:33 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J0Chm5pk4z4xbs;
        Thu, 25 Nov 2021 20:47:20 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Neuling <mikey@neuling.org>
In-Reply-To: <bc683d499a411730504b132a924de0ccc2ef1f79.1636971137.git.christophe.leroy@csgroup.eu>
References: <bc683d499a411730504b132a924de0ccc2ef1f79.1636971137.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] powerpc/code-patching: Improve verification of patchability
Message-Id: <163783299124.1228879.4298818921531087489.b4-ty@ellerman.id.au>
Date:   Thu, 25 Nov 2021 20:36:31 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 11:12:22 +0100, Christophe Leroy wrote:
> Today, patch_instruction() assumes that it is called exclusively on
> valid addresses, and only checks that it is not called on an init
> address after init section has been freed.
> 
> Improve verification by calling kernel_text_address() instead.
> 
> kernel_text_address() already includes a verification of
> initmem release.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/code-patching: Improve verification of patchability
      https://git.kernel.org/powerpc/c/8b8a8f0ab3f5519e45c526f826a655817486c5bb

cheers
