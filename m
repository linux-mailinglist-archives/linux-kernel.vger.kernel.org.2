Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E0539DBC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFGL4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFGL4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:56:09 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1EDC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 04:54:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FzBc61xCSz9s1l;
        Mon,  7 Jun 2021 21:54:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623066854;
        bh=6vsO3F0B+iMvgvjpcar0bj8uHWL1Rpjga+QKyho2BXs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XFbDmldcheV3iuSUHU07i+8Xir7SZZlVMziHGVXKYwGjaPtpYNttU+XA1nwTCozUQ
         atgVBkV/j+10hdeY8l3eLhJ2l26SDq/GhJVfYpcAORs2zdGIcq+iqdMlT31nI5pcLp
         Xbi7WfOd1C7wDePF95+vjQccvp9XZhvTASJMQBAihPwyvB7AnpjJP/pbSYhKsEbL5W
         /pObX9Ay9ieKZbY2tRWwFqUO1g+04tkmUNKN01ngxgtzazHB4Nr24axZwGLbNt4lQd
         uSKHLflCCtaMA3YiQitEQ1WvsX1J/SRKRm+64JqoQBDxvZh0gsnm0hgUmSZgY4vJqF
         foIRsgTn8cvuQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc: Fixup for v3 "powerpc/nohash: Refactor
 update of BDI2000 pointers in switch_mmu_context()" in next-test
In-Reply-To: <d2d520231f8082f9c1f7a896af8db1d09565ac84.1623059495.git.christophe.leroy@csgroup.eu>
References: <d2d520231f8082f9c1f7a896af8db1d09565ac84.1623059495.git.christophe.leroy@csgroup.eu>
Date:   Mon, 07 Jun 2021 21:54:11 +1000
Message-ID: <87a6o1gaak.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> As mentionned in history, v3 doesn't apply to book3s/32 so the hunk
> on head_book3s_32.S has to be dropped from the commit mentionned
> in the title.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Michael, tell me if you prefer a v4 of the series.

Nah that's OK, I squashed this in.

cheers
