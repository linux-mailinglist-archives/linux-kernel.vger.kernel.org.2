Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F352B41EE02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352766AbhJANAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:00:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38158 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhJANAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:00:17 -0400
Received: from zn.tnic (p200300ec2f0e8e00c9205f48360a92d6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8e00:c920:5f48:360a:92d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 326D41EC008F;
        Fri,  1 Oct 2021 14:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633093112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tLM81yc0/7+B7uHrmMgKEmO5b6UgFGAaiCJVMuEeJXM=;
        b=Ml3NHsy7CUwTkPrFBFlA3X5jnQTTIVigF8AFuKzUJu+/yBEuWERTM1FzxWNdPoGh0e07xu
        3MKpvdaOoqomyjfHk+HKYrnjcMljpN3s0N0IDgOtlQvBwitx2PF2f7RCu2GNvYDxAlQV2K
        AXemiTsJ3J7ZWPnVwAVqMpeIe7rSANk=
Date:   Fri, 1 Oct 2021 14:58:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/sev: Fully map the #VC exception stacks
Message-ID: <YVcF9ENTfLAGaLec@zn.tnic>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
 <YVbNlXwiASQEsG+x@zn.tnic>
 <YVb2AGXAwYx/OI6J@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVb2AGXAwYx/OI6J@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 01:50:24PM +0200, Joerg Roedel wrote:
> Yeah, I think the right fix is to export cea_map_percpu_pages() and move
> the cea_map_stack() macro to a header and use it to map the VC stacks.

I'll do you one better: Put the #VC stack mapping into
percpu_setup_exception_stacks(), where it naturally belongs and where
the other stacks are being mapped instead of doing everything "by hand"
like now and exporting random helpers.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
