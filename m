Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0083FEA6E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 10:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243953AbhIBIKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 04:10:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36220 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhIBIKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 04:10:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA3A21FF71;
        Thu,  2 Sep 2021 08:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630570148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9V2Am55fle0zZoK0A1Qw1f0HLKTRjXFk1l0SErdL94=;
        b=K1+cNbREuQ5cl3KvcLwLCQsUsTJnpIsICPsoKsBH1w+qKIZqkzoQO5+RWObQ7zgxPEbkhS
        +lSFWw3FQ+cL1ymxMiS98Kni84J6Cg2n+INEOhy2ZA8/qLLcz1pRcfl/Ek+283Hs63Xgj8
        JZ+LavKcq6yHw6W+DQWsfgw7yFAQTTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630570148;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u9V2Am55fle0zZoK0A1Qw1f0HLKTRjXFk1l0SErdL94=;
        b=CpfaKrMphasM9wJ6LZXvYRL3KxNsrJ76Enwit8xOhwoOyFFS71ZzMvjZjndeHpWh/XM6r7
        Y04w7zqek7IT7xCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1682713A75;
        Thu,  2 Sep 2021 08:09:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Gwg0A6SGMGG9RAAAGKfGzw
        (envelope-from <jroedel@suse.de>); Thu, 02 Sep 2021 08:09:08 +0000
Date:   Thu, 2 Sep 2021 10:09:06 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to
 arch/x86/entry/
Message-ID: <YTCGov+vvAMvso7q@suse.de>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831175025.27570-3-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:50:03AM +0800, Lai Jiangshan wrote:
>  arch/x86/entry/Makefile            | 5 ++++-
>  arch/x86/{kernel => entry}/traps.c | 0
>  arch/x86/kernel/Makefile           | 5 +----
>  3 files changed, 5 insertions(+), 5 deletions(-)
>  rename arch/x86/{kernel => entry}/traps.c (100%)

From looking over the patch-set I didn't spot the reason for putting the
entry C code into traps.c. Can you explain that please? Otherwise I'd
prefer to create a new file, like arch/x86/entry/entry64.c.

Thanks,

	Joerg
