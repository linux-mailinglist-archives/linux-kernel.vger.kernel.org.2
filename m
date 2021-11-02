Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610C04426AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 06:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhKBFZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 01:25:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49886 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhKBFZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 01:25:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E431821763;
        Tue,  2 Nov 2021 05:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635830582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5dlqJyDOuNq4/V6WKBIrNkUiQX93JERQgfsRThuqcu8=;
        b=TvshN6V6E8QMLZpdFh85ZaO6eggCFN+XSundM01hMZeDo6Tz4F3Awl4E/XpnOnbPxRzzvL
        qy9pnVpubpwcjg1vVAime2oCLvrJu0TbkPBkckdEzLLhLVWXt6VmPrd+4EXBUfxPpjjhtx
        6QO2qvq9QK9hhtbmv/MEEQsJE56qBv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635830582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5dlqJyDOuNq4/V6WKBIrNkUiQX93JERQgfsRThuqcu8=;
        b=WXRYVg+OBwY7b14b/R4/GkIy7++kso/iRN5/intSzzbbWjdaCZE/aplh0E7CKWML8Vb+sv
        xn2ypZTIXuzFH9DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBC0913B6F;
        Tue,  2 Nov 2021 05:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TIM4MTbLgGHGKQAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 02 Nov 2021 05:23:02 +0000
Date:   Tue, 2 Nov 2021 06:22:55 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL (not really)] x86/core for v5.16
Message-ID: <YYDLL7aHi3c8jpmC@zn.tnic>
References: <YX/AmFgkQ0AEqDaG@zn.tnic>
 <CAHk-=wiNyR-cAxicOD6nkRQNw-q+uzFvB3hpA-s=7asEKom=og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiNyR-cAxicOD6nkRQNw-q+uzFvB3hpA-s=7asEKom=og@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 02:16:24PM -0700, Linus Torvalds wrote:
> So other developers do this kind of thing fairly regularly, because
> they have some "core branch" that does the basic core development
> (say, a driver subsystem), and then they have other branches (eg the
> lowlevel drivers themselves etc) that depended on the core work but
> are sent as individual pull requests to keep the conceptual separation
> alive, and make it easier to review.

Right, exactly.

> The way to do it tends to be:
> 
>  (a) make it clear that some pull request depends on a previous one,
> so that I'm aware of it, and don't do them out of order and get
> confused

Ok.
 
>  (b) when you have a series of pull requests that aren't independent,
> create the series of pulls yourself in a temporary tree, and generate
> the pull request from that series, with the previous merge always as
> the "base".

Ah ok, that sounds good.

> The reason for (a) is obvious, and the reason for (b) is that then
> each pull request automatically gets the right shortlog and diffstat.
> 
> Of course, if this is the only time you expect to haev this kind of
> dependency, you don't need to have much of a process in place, and a
> hacky manual one-time thing like the above works fine too.

Yeah, it does happen but not too often. With tip, the usual situation
is one branch does change/add something which is needed elsewhere and a
merge is needed. Basically the case you described above.

> And in general, the more independent the pull request can be, the
> better. But having two or more branches that have some serial
> dependency certainly isn't unheard of or wrong either.  It happens.

Yeah.

Ok, thanks for explaining.

/me writes this down for the future.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
