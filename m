Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8635F48F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351122AbhDNNLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:11:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48700 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351180AbhDNNKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:10:39 -0400
Received: from zn.tnic (p200300ec2f0e8f0048923c048b418a85.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8f00:4892:3c04:8b41:8a85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 445FE1EC0258;
        Wed, 14 Apr 2021 15:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618405816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ub16e8IgsqCsaQskNeYCBWNu+OwjL3P+PDajfBScz2g=;
        b=eOUVItvGPZmx64t3BeuBZnhqA0RvaTr46W3ZuhcgzHBQSeGW31lRrhGfLCuaPi38qj78qm
        HnO90lsvBhSyQcqZxmLQ7btlvp47NL3Cp1gNaNCl9f14oplZ7BRp6xcu5k7DbIWCRe2Uic
        lfJXsfATPXGHVO7tKxFvCezuRt6Jpxo=
Date:   Wed, 14 Apr 2021 15:10:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jue Wang <juew@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        naoya.horiguchi@nec.com, tony.luck@intel.com, x86@kernel.org,
        yaoaili@kingsoft.com
Subject: Re: [PATCH 3/4] mce/copyin: fix to not SIGBUS when copying from user
 hits poison
Message-ID: <20210414131018.GG10709@zn.tnic>
References: <CAPcxDJ6xx00Gjn6DxoMpdJ7UjNeJUp2613jqGRm7ZZeuMNeSjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcxDJ6xx00Gjn6DxoMpdJ7UjNeJUp2613jqGRm7ZZeuMNeSjQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 10:47:21PM -0700, Jue Wang wrote:
> This path is when EPT #PF finds accesses to a hwpoisoned page and
> sends SIGBUS to user space (KVM exits into user space) with the same
> semantic as if regular #PF found access to a hwpoisoned page.
> 
> The KVM_X86_SET_MCE ioctl actually injects a machine check into the guest.
> 
> We are in process to launch a product with MCE recovery capability in
> a KVM based virtualization product and plan to expand the scope of the
> application of it in the near future.

Any pointers to code or is this all non-public? Any text on what that
product does with the MCEs?

> The in-memory database and analytical domain are definitely using it.
> A couple examples:
> SAP HANA - as we've tested and planned to launch as a strategic
> enterprise use case with MCE recovery capability in our product
> SQL server - https://support.microsoft.com/en-us/help/2967651/inf-sql-server-may-display-memory-corruption-and-recovery-errors

Aha, so they register callbacks for the processes to exec on a memory
error. Good to know, thanks for those.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
