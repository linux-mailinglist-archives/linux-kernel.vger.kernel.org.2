Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9650F41EC8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354116AbhJALwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:52:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49668 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354023AbhJALwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:52:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4165D2269A;
        Fri,  1 Oct 2021 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633089026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1EvXfeiJN3iwTV+521sVFc+j6T5GdBvrP4eEqij5gI=;
        b=KgYNShoISQr4geVLA1a9TsiuLooWtKyH+F7zblaX1VzRtRfaE8X1w3fHxcPKL9+FUHAHNH
        hipb7/uGMUSajBug4Fu/F0gI//puzkcp7a7HOBHMI0BAkY5RBSzsx8Zms0g5loUYyCNxWQ
        OR8zFigHO9Z0QcfZZrql3Gecj1GHS80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633089026;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1EvXfeiJN3iwTV+521sVFc+j6T5GdBvrP4eEqij5gI=;
        b=bnPGMTTzHN9EcKqSVVM3V6vGIBjsAahzc8GheO4UkjhPyT3ZVYtsFJ7LcNCAMa850JNqoT
        Hm3ya1ZRFZrxIHCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E323D13C33;
        Fri,  1 Oct 2021 11:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ygSwNQH2VmGZRgAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 01 Oct 2021 11:50:25 +0000
Date:   Fri, 1 Oct 2021 13:50:24 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/sev: Fully map the #VC exception stacks
Message-ID: <YVb2AGXAwYx/OI6J@suse.de>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
 <YVbNlXwiASQEsG+x@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVbNlXwiASQEsG+x@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 10:57:57AM +0200, Borislav Petkov wrote:
> Please use those defines so that this keeps working when someone mad
> decides to increase those exception stack sizes again because everything
> *and* the kitchen sink wants to instrument the damn kernel. Nothing to
> see here people...

Yeah, I think the right fix is to export cea_map_percpu_pages() and move
the cea_map_stack() macro to a header and use it to map the VC stacks.

Regards,

	Joerg
