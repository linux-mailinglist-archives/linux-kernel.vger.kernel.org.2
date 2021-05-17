Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D524F382C3A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 14:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhEQMfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 08:35:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:33412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237055AbhEQMe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 08:34:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24C30B0BF;
        Mon, 17 May 2021 12:33:42 +0000 (UTC)
Date:   Mon, 17 May 2021 14:33:39 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/sev-es: Invalidate the GHCB after completing VMGEXIT
Message-ID: <YKJio9XDepU+CR28@suse.de>
References: <fa408ec4020d7ab056875ec8c80d793b75f20a39.1621019553.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa408ec4020d7ab056875ec8c80d793b75f20a39.1621019553.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Fri, May 14, 2021 at 02:12:33PM -0500, Tom Lendacky wrote:
>  arch/x86/kernel/sev-shared.c |  1 +
>  arch/x86/kernel/sev.c        | 37 ++++++++++++++++++------------------
>  2 files changed, 20 insertions(+), 18 deletions(-)

Having this change in one patch is okay. No need to split it up.

> +static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
> +{
> +	struct sev_es_runtime_data *data;
> +	struct ghcb *ghcb;
> +
> +	data = this_cpu_read(runtime_data);
> +	ghcb = &data->ghcb_page;
> +
> +	if (state->ghcb) {
> +		/* Restore GHCB from Backup */
> +		*ghcb = *state->ghcb;
> +		data->backup_ghcb_active = false;
> +		state->ghcb = NULL;
> +	} else {
> +		vc_ghcb_invalidate(ghcb);

A comment would be good to explain why the invalidate here is
necessary.

Regards,

	Joerg
