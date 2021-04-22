Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC6368565
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbhDVRCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:02:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDVRB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:01:59 -0400
Received: from zn.tnic (p200300ec2f0e2900329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:2900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C35CB1EC0288;
        Thu, 22 Apr 2021 19:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619110880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+EX3N/gvFrXpHJ1GEsmaOZJTZVcILi5Ui/2IEpF961c=;
        b=Ruz8oZT5ljaG7POpeRKhqRJ2oTx6qlTGn4bIJR/c6b0WLmknBSxWwgbTFZtQXGdkpj+uk7
        qO/oUfLFknqx5c+AYUsLtv3LkuYpfbGSLpiQjKfG+23/p5ld/tzAWfFnnbr0k32BCizy9O
        pp29t2GrGqwTcZGklOO5O7f2ujufDU4=
Date:   Thu, 22 Apr 2021 19:01:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Message-ID: <20210422170118.GC7021@zn.tnic>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
 <20210421005728.1994268-2-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421005728.1994268-2-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:57:26AM +0900, Naoya Horiguchi wrote:
> From: Tony Luck <tony.luck@intel.com>
> 
> There can be races when multiple CPUs consume poison from the same
> page. The first into memory_failure() atomically sets the HWPoison
> page flag and begins hunting for tasks that map this page. Eventually
> it invalidates those mappings and may send a SIGBUS to the affected
> tasks.
> 
> But while all that work is going on, other CPUs see a "success"
> return code from memory_failure() and so they believe the error
> has been handled and continue executing.
> 
> Fix by wrapping most of the internal parts of memory_failure() in
> a mutex.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  mm/memory-failure.c | 37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
