Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD67381F0F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 15:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhEPNSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 09:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhEPNSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 09:18:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792DC061573;
        Sun, 16 May 2021 06:17:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j14so1954658wrq.5;
        Sun, 16 May 2021 06:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+weRdtfsmgJ3fVjRKfIEjFe2XchM/2eivewIT+ylU88=;
        b=nnYIQw5nfrshTJ5KRwybLAjQv98nPLEyw3Y2YIkfpz6bblFR+VZgiA1yQktM5bsiSH
         wH50fdCe0FH/ejr7N94hCYzx/aUOxp1vA9NpImS8V79E3RdP2crgudjTrV9ze1wpO7P9
         hDt4bSL+oNIs+hDNzTmxFB53/pVG/ODaQJS8L0Ty3tVO+cPTYHUDF9SDsVAHIODAmo1x
         1xMCU017w3ZUgmfsDvrRBNXW32U9W/fvqydPkchYb/KU6zABfKrGYnBmPkhqBvhfB9pQ
         XsttBFYsTeoEkESuLfpTJmvB4KvXiwrSb3HkK4h+wpt8v3Fbf2ubRteQrl+XZ/7N8r4E
         FisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+weRdtfsmgJ3fVjRKfIEjFe2XchM/2eivewIT+ylU88=;
        b=DXhcqUTUTciDf0ALKvtIg4bidLBRI9RnPjXl8/H29h28/V1fdz3h5MhYw4oTiZ08XR
         cUet14MmcyiznM/T8lDN5peY33++q8WMCu38B1sZrJl+4sDp5sMEPQtpdU30WMEh4tO7
         lvpMYMfGIpkEHReI/EnG/F+NLB+j8PQkJssIac4DSFcp/IoSk/98rnS/O1nw86o0MsKi
         +jlZVaZjRhlWGkhRL0DhD3VMQu2Loika30N1qdg5w00ajfzJqR3ibEobDCEYkNojCkjI
         aSowjYSVTbSemVnO4vhekK9PQ+ZKnhO9HHcYsKUrg3rulre2se9p1v5gmrWv4BS/0npq
         JyBg==
X-Gm-Message-State: AOAM530v5Rkzi1qeAoKs/TCvXT1AGYbQmnm88rKlDmFsKx9XHhF/TW2L
        X6rSRNXdnJH57GvkivXbxkiQ0ZlW0iZA4L/H
X-Google-Smtp-Source: ABdhPJwm8SqqSIWe/jY7chFdBhRbyo/lx81TVv5xiEW55CCPMgzsqmvqo6dqVEjoU3vQ0qYMQZMaXw==
X-Received: by 2002:a5d:58d0:: with SMTP id o16mr32689178wrf.420.1621171038219;
        Sun, 16 May 2021 06:17:18 -0700 (PDT)
Received: from ard0534 ([102.156.106.137])
        by smtp.gmail.com with ESMTPSA id x8sm13091104wrs.25.2021.05.16.06.17.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 May 2021 06:17:17 -0700 (PDT)
Date:   Sun, 16 May 2021 14:17:14 +0100
From:   Khaled Romdhani <khaledromdhani216@gmail.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     peterz@infradead.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH-next] x86/kernel: Fix unchecked return value
Message-ID: <20210516131714.GB32445@ard0534>
References: <20210515202212.24836-1-khaledromdhani216@gmail.com>
 <YKAw3Yl8c6nU1zng@zn.tnic>
 <6f149c2e-eeb0-6b50-2b54-a56ae4646ea5@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f149c2e-eeb0-6b50-2b54-a56ae4646ea5@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 09:51:23PM +0100, Colin Ian King wrote:
> On 15/05/2021 21:36, Borislav Petkov wrote:
> > On Sat, May 15, 2021 at 09:22:12PM +0100, Khaled ROMDHANI wrote:
> >> From the coverity scan analysis, the return value from
> >> insn_decode_kernel is not checked. It is a macro constructed
> >> from the insn_decode function which may fail and return
> >> negative integer. Fix this by explicitly checking the
> >> return value.
> >>
> >> Addresses-Coverity: ("Unchecked return value")
> >> Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> >> ---
> >>  arch/x86/kernel/jump_label.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> >> index a762dc1c615e..bf0ea003b6e7 100644
> >> --- a/arch/x86/kernel/jump_label.c
> >> +++ b/arch/x86/kernel/jump_label.c
> >> @@ -23,7 +23,7 @@ int arch_jump_entry_size(struct jump_entry *entry)
> >>  {
> >>  	struct insn insn = {};
> >>  
> >> -	insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
> >> +	WARN_ON(insn_decode_kernel(&insn, (void *)jump_entry_code(entry)));
> > 
> > I don't think coverity is smart enough to notice...
> > 
> >>  	BUG_ON(insn.length != 2 && insn.length != 5);
> > 	^^^^^^^^^^^^^
> > 
> > ... this line.
> > 
> > 
> Indeed. One needs to be careful with false positives with Coverity.
> 
> Colin

Yes. I shall be.

Thanks,

Khaled.
