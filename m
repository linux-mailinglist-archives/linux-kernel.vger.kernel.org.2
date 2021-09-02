Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600A73FEDC5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344320AbhIBMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:30:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54322 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhIBMav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:30:51 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A69C6225EB;
        Thu,  2 Sep 2021 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630585792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTqZMysm+LJ+94OQTFSZh1X2ymjjfpUxWo7nIjwarjM=;
        b=RJ+TjjZVQTKKJk2Z36M9Of44tCfRPAvLCY8WN62mV+oV/HL/8Y9aGvwEfxLORFJ4PsfXZx
        pO5j6tiUGmRJAe5u3cCyEUWPW9vSaZa4lsleglN2SFH4WUfUT06LZntiINHTCgZ6Q9eBdW
        w3A/VxM6Ci5ntkOVOMAW0OwAn22Mubk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630585792;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YTqZMysm+LJ+94OQTFSZh1X2ymjjfpUxWo7nIjwarjM=;
        b=kGN+vMCGABu5b5mMf+lNqdkdxSqr+QSEHMxdxEzVPP+/tQ3nQs2BThBnulrQDI7pfVuLbq
        +J2oXMuuRO+ewRBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 34060132AB;
        Thu,  2 Sep 2021 12:29:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WRyvCsDDMGECBgAAGKfGzw
        (envelope-from <jroedel@suse.de>); Thu, 02 Sep 2021 12:29:52 +0000
Date:   Thu, 2 Sep 2021 14:29:50 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 22/24] x86/entry: Implement and use do_paranoid_entry()
 and paranoid_exit()
Message-ID: <YTDDvnvslnjjok2H@suse.de>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-23-jiangshanlai@gmail.com>
 <YTCoenvIaHjLQmAC@hirez.programming.kicks-ass.net>
 <44e08066-bbfb-222e-dffc-63e5b64f125f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e08066-bbfb-222e-dffc-63e5b64f125f@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 07:58:51PM +0800, Lai Jiangshan wrote:
> Oh, #VC will need to switch stack.  I think we need ASM code to switch
> stack since the original stack need to be "free" for next #VC.

Right, #VC switches off its IST stack to make it free for subsequent
#VCs. The switch mostly happens in C code already, see
vc_switch_off_ist(), only the actual RSP update is still ASM.

Regards,

	Joerg
