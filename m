Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C52D41EE08
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353687AbhJANC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:02:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35506 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353502AbhJANCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:02:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98AE222675;
        Fri,  1 Oct 2021 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633093240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KM+xbda/WIoRg9sPEGIZlEe401mZyQLLM/2ulb4YBQ=;
        b=p+F5M+3Mim8vVwUoc4pVPv9FD+vwt25tYG3I1KrNLmCvg1ic8howqbCE72Yr2UKjkkDjd4
        Qy0ekpRSVaULREpGTLlLj4hYliu7epqHdpe1BXKsxXF6eBkPtZk6ck868mlU6w532mrNPa
        3haxDsWjnQaJ/zqf96fLfk3LIsyUB4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633093240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KM+xbda/WIoRg9sPEGIZlEe401mZyQLLM/2ulb4YBQ=;
        b=Y5zBaqK3BQL4QZKwsufqCXJRjDWURw15qHhZIYlH7Ktl9SkgR0DEq+ncmHjF43A8DDp74v
        S+0fGpUb4gHL6qCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 442D213C5D;
        Fri,  1 Oct 2021 13:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9dnZDngGV2GZdAAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 01 Oct 2021 13:00:40 +0000
Date:   Fri, 1 Oct 2021 15:00:38 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] x86/sev: Fully map the #VC exception stacks
Message-ID: <YVcGdpVuSsieFL8W@suse.de>
References: <113eca80a14cd280540c38488fd31ac0fa7bf36c.1633063250.git.thomas.lendacky@amd.com>
 <YVbNlXwiASQEsG+x@zn.tnic>
 <YVb2AGXAwYx/OI6J@suse.de>
 <YVcF9ENTfLAGaLec@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVcF9ENTfLAGaLec@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 02:58:28PM +0200, Borislav Petkov wrote:
> On Fri, Oct 01, 2021 at 01:50:24PM +0200, Joerg Roedel wrote:
> > Yeah, I think the right fix is to export cea_map_percpu_pages() and move
> > the cea_map_stack() macro to a header and use it to map the VC stacks.
> 
> I'll do you one better: Put the #VC stack mapping into
> percpu_setup_exception_stacks(), where it naturally belongs and where
> the other stacks are being mapped instead of doing everything "by hand"
> like now and exporting random helpers.

The VC stack is only allocated and mapped when SEV-ES is detected, so
they can't always be mapped by generic code.

Regards,

	Joerg
