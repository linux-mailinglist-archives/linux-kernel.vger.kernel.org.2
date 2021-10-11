Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB3428C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhJKMJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbhJKMJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:09:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C7BC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:07:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HScxg5VgDz4xqM;
        Mon, 11 Oct 2021 23:07:51 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <025754fde3d027904ae9d0191f395890bec93369.1631541649.git.christophe.leroy@csgroup.eu>
References: <025754fde3d027904ae9d0191f395890bec93369.1631541649.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mem: Fix arch/powerpc/mm/mem.c:53:12: error: no previous prototype for 'create_section_mapping'
Message-Id: <163395400153.4094789.2095560885525137957.b4-ty@ellerman.id.au>
Date:   Mon, 11 Oct 2021 23:06:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 17:17:26 +0200, Christophe Leroy wrote:
> Commit 8e11d62e2e87 ("powerpc/mem: Add back missing header to fix 'no
> previous prototype' error") was supposed to fix the problem, but in
> the meantime commit a927bd6ba952 ("mm: fix phys_to_target_node() and*
> memory_add_physaddr_to_nid() exports") moved create_section_mapping()
> prototype from asm/sparsemem.h to asm/mmzone.h
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mem: Fix arch/powerpc/mm/mem.c:53:12: error: no previous prototype for 'create_section_mapping'
      https://git.kernel.org/powerpc/c/7eff9bc00ddf1e2281dff575884b7f676c85b006

cheers
