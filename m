Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1C834A65A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCZLQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:16:18 -0400
Received: from ozlabs.org ([203.11.71.1]:54673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhCZLPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:15:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4F6KCP2c3Rz9sRf;
        Fri, 26 Mar 2021 22:15:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616757347;
        bh=aRK3MQjYc8DtzjUuBc8xtlY540Ysa4fJ5l5A1e+TZmE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GoGD11HhuUw1qdgZmx/Tgdnea2zeS5ZMScO9rFgOkLJo3r7GmMiXyNdzEQRXZV2u4
         FhsU9AtTulFd0yq/uSEpQ39ucW6ql6RSTMsDnN5f2xF+ulUWm4Z1Lp6AWJGr3mLJ9W
         fiRGCVkytIoHCXOzWXWFh2W3gULBzh4cJ/xhwFqCx3ls5POyNGqfBI+w67AKR01cOy
         YK6t6VBG9njhtzqlukRW6HRJ2SuU6ib8uZw2amcVGD3ecREBYCudiWZDXxt3569Kaj
         R3PQRp/bLooVYEwVxwhwcLFtS0RxzfQJVKzrxjcJcw1KLo2eS7FOP0vUxwcNaXr1lF
         N6SpcfH8RcKPA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     He Ying <heying24@huawei.com>, benh@kernel.crashing.org,
        paulus@samba.org, corbet@lwn.net, ruscur@russell.cc,
        oohall@gmail.com, heying24@huawei.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: powerpc: Fix misspellings and grammar errors
In-Reply-To: <20210326100853.173586-1-heying24@huawei.com>
References: <20210326100853.173586-1-heying24@huawei.com>
Date:   Fri, 26 Mar 2021 22:15:43 +1100
Message-ID: <878s6ago80.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

He Ying <heying24@huawei.com> writes:
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>  Documentation/powerpc/booting.rst                | 2 +-
>  Documentation/powerpc/dawr-power9.rst            | 2 +-
>  Documentation/powerpc/eeh-pci-error-recovery.rst | 2 +-
>  Documentation/powerpc/elfnote.rst                | 2 +-
>  Documentation/powerpc/firmware-assisted-dump.rst | 2 +-
>  Documentation/powerpc/kaslr-booke32.rst          | 2 +-
>  Documentation/powerpc/mpc52xx.rst                | 2 +-
>  Documentation/powerpc/papr_hcalls.rst            | 4 ++--
>  Documentation/powerpc/transactional_memory.rst   | 4 ++--
>  9 files changed, 11 insertions(+), 11 deletions(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
