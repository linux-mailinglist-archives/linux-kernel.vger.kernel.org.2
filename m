Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0159B3A77D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFOHUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhFOHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:20:29 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF02CC0617AF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 00:18:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G40653jP4z9sRK;
        Tue, 15 Jun 2021 17:18:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1623741503;
        bh=PCjfL32gackDGGhjAkNyZ/DL6oMl+o8NKneVCsc9Szg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=H9Rn/WzGnluUtjcD4uSOsgVxG5L2reh9ymNdmNEBhQrT68Ie8SLd0LzUVOalYh2bH
         UlYm+iokrvjQ3nkBM6JAfWR4kslk0683JjsivYK4JlfzBkbgBraxUan7VCA0mXDKKw
         OXnv/acYi9KIw1RnMyQExJ329XkUUqhADqTzEF/ZL4q+VKJR6H5s3rS/KVurJsMDGi
         zC54DYBYWLL22h5yE+IyJP9QNKadC9ZVE6UX7tnf0CLsoeI099Oro9e0idzXknMsUG
         2I64WdzP5b8bPRGdBrl2ABFojf+Y3eU6LCV7qAHtwLFWgmeGGYeoSvBqIPd3kGudao
         2p8d7yZjjcpIQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/12] powerpc: Cleanup use of 'struct ppc_inst'
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
Date:   Tue, 15 Jun 2021 17:18:17 +1000
Message-ID: <87r1h3tx3a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> This series is a cleanup of the use of 'struct ppc_inst'.
>
> A confusion is made between internal representation of powerpc
> instructions with 'struct ppc_inst' and in-memory code which is
> and will always be an array of 'unsigned int'.

Why don't we use u32 *, to make it even more explicit what the expected
size is?

cheers
