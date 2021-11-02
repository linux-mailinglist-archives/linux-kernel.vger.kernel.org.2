Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509F84426D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 06:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKBFot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 01:44:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43792 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhKBFos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 01:44:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 68B001FD75;
        Tue,  2 Nov 2021 05:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635831731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5iSbSVtg7clUuGcdawRiOVahh2RXyZGcG8j/mPWFZE=;
        b=bifZUZnI2xuXfLnkDmhXYfAmfecOi2SpYKkG4ELGfHg6jFt1deXHyGfkAEI7QWyZ7lRrQY
        bWLRT8l3ecjqRqMM6vwRVgZ3O8q8c+cfp6VL/w7nzSoKZbhVCk73l3jlehTZ/BJICASJYk
        WlLbLPDNWt77AghmsbAigMBRNPC6MHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635831731;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5iSbSVtg7clUuGcdawRiOVahh2RXyZGcG8j/mPWFZE=;
        b=yI1a2SYxW/JCEHhGJVbF/VARWNSZbcYLNFaRq9yvaHyYfAPzEcqIZVR3oU68wbHwIpBJm1
        QCLetgcaM1b5x6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 515BD13B6F;
        Tue,  2 Nov 2021 05:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AOZ9E7PPgGGkLgAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 02 Nov 2021 05:42:11 +0000
Date:   Tue, 2 Nov 2021 06:42:06 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/cpu for v5.16
Message-ID: <YYDPrpg8CvILId0A@zn.tnic>
References: <YX/BhEUBTK4bkQNm@zn.tnic>
 <CAHk-=wijTDq+_TQtk9NdRi7AyDpmhvtMzs5=jvPJvNT6qA3HkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wijTDq+_TQtk9NdRi7AyDpmhvtMzs5=jvPJvNT6qA3HkA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 03:44:46PM -0700, Linus Torvalds wrote:
> "a.o."? Is that a common German shorthand, possibly anglicized?

Haha, exactly. :-)

> I'm assuming - and rewrote it - that it stands for "or similar".

Apparently, the "proper" thing to write is https://en.wiktionary.org/wiki/i.a.

> Possibly "among other" aka "inter alia"? Very occasionally shortened
> "i.a.", although "e.g." is the _much_ more common form of much the
> same thing.

Yeah, I saw "e.g." being suggested also for "among others".

> Never seen that "a.o." thing.

Sorry about that - I'll make sure to avoid such misguided abbreviations
in the future. We have enough confusion as it is - no reason for me to
add more.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
