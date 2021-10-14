Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DC642D96F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhJNMqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:46:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37704 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNMqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:46:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C3C8C1FD29;
        Thu, 14 Oct 2021 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634215467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJId1ojWsub/w97ZHLFGuzH74soILV0egGkPDhG79p8=;
        b=Skupsgu0LPQOdGvCMShBoovoQGeZDaqxOS+WmGeBXG9VgXU2e77GqjGASYAYu2CmUI/x+D
        WsXBeZr6LfSshnMVwLdfv5PS42jd0pYRuHcVvog0fNznVkS2Czh1gYfWu27GieKkxWxMv+
        AfebV2QmKhqJTcCCbewzA7Urk/oqGg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634215467;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJId1ojWsub/w97ZHLFGuzH74soILV0egGkPDhG79p8=;
        b=Y7OqztqhUjhy8e5pfKzpER0OZm4Wt0SgPZL+BbpeAo2X+HnBAzauojX0ttc3LsVQ8p4zvu
        K9W7SFfN0h4uqsBw==
Received: from wotan.suse.de (wotan.suse.de [10.160.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 782A7A3B83;
        Thu, 14 Oct 2021 12:44:27 +0000 (UTC)
Received: by wotan.suse.de (Postfix, from userid 10510)
        id 6A0A865F5; Thu, 14 Oct 2021 12:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by wotan.suse.de (Postfix) with ESMTP id 68EC56514;
        Thu, 14 Oct 2021 12:44:27 +0000 (UTC)
Date:   Thu, 14 Oct 2021 12:44:27 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Willy Tarreau <w@1wt.eu>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
In-Reply-To: <YWcOvmXkSiecGkER@zn.tnic>
Message-ID: <alpine.LSU.2.20.2110141234390.3481@wotan.suse.de>
References: <YWXwQ2P0M0uzHo0o@zn.tnic> <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id> <YWbUbSUVLy/tx7Zu@zn.tnic> <20211013125142.GD5485@1wt.eu> <YWbZz7gHBV18QJC3@zn.tnic> <20211013140723.GE5485@1wt.eu> <YWbrR1BqI1CxneN/@zn.tnic>
 <20211013142433.GB8557@1wt.eu> <alpine.LSU.2.20.2110131601000.26294@wotan.suse.de> <20211013163023.GD8557@1wt.eu> <YWcOvmXkSiecGkER@zn.tnic>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 13 Oct 2021, Borislav Petkov wrote:

> > > In short:  Ammars initial claim:
> > > 
> > > > Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").
> > > > 
> > > >   - rax for the return value.
> > > >   - rcx to save the return address.
> > > >   - r11 to save the rflags.
> > > > 
> > > > Other registers are preserved.
> > > 
> > > is accurate and I will clarify the psABI to make that explicit.
> > 
> > Many thanks for this very detailed explanation! Ammar, I'll take your
> > patch.
> 
> Great, why are we dealing with some funky document when the law is in
> glibc sources?!

In theory, theory and practice are the same, in practice, they are not.

Usually it's good to resolve a conflict towards what the document says, or 
intended to say.  But glibc of course provides a huge amount of pressure 
to resolve toward it ;-)

(laws are also changed toward practice when the latter overtakes :) )


Ciao,
Michael.
