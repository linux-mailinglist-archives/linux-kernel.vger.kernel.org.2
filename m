Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872CE442CDE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhKBLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhKBLlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD7C061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:38:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fk0392z4xdH;
        Tue,  2 Nov 2021 22:38:33 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev@lists.ozlabs.org, Eric Paris <eparis@redhat.com>
In-Reply-To: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
References: <a4b3951d1191d4183d92a07a6097566bde60d00a.1629812058.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 RESEND] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
Message-Id: <163584790624.1845480.1785827913484538939.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:46 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 13:36:13 +0000 (UTC), Christophe Leroy wrote:
> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> targets") added generic support for AUDIT but that didn't include
> support for bi-arch like powerpc.
> 
> Commit 4b58841149dc ("audit: Add generic compat syscall support")
> added generic support for bi-arch.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
      https://git.kernel.org/powerpc/c/566af8cda399c088763d07464463dc871c943b54

cheers
