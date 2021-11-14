Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3C44F9D9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 18:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhKNSBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 13:01:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40358 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhKNSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 13:01:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DBA232190B;
        Sun, 14 Nov 2021 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636912694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pm/+XZb1gEqqWc+ddieV4Hp6KrJXh2SiK5CQkRhwEf4=;
        b=q4g0CIZg6zF/7PeT8ZLCd45q1zon4zWeOo7jTNDR+aU6G534U792II/PnzpIAdJuZCO9kV
        4gfKy4wkel3jdAsra4MDrGQzC5f4m16a2NatjX87G4iC+6Kq+zTSs1hG//yMm64w3cKAWf
        HO10PsHdsSq1IhmT/ts1HkKntQHlCG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636912694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pm/+XZb1gEqqWc+ddieV4Hp6KrJXh2SiK5CQkRhwEf4=;
        b=aUM6RNQ6p2fEBI/o5x6w/75Wt8lNWfhfShqjAGLD0JA42/H7PznmQx9UwdPewJMtI9tvwK
        B4uycuH5VBsah/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C62DB13A98;
        Sun, 14 Nov 2021 17:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xOP+LzZOkWFGEwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 14 Nov 2021 17:58:14 +0000
Date:   Sun, 14 Nov 2021 18:58:06 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Marco Elver <elver@google.com>
Subject: Re: [GIT PULL] sched/urgent for v5.16-rc1
Message-ID: <YZFOLprnkH+LdSY+@zn.tnic>
References: <YZDxFAYjVp2nRteh@zn.tnic>
 <CAHk-=wiMYyYUsMC8kMkCUvAnq3usC98Tw9_ogkznS+2anzvR5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiMYyYUsMC8kMkCUvAnq3usC98Tw9_ogkznS+2anzvR5A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 09:42:27AM -0800, Linus Torvalds wrote:
> Heh. Too late for those of us who build our kernels during the merge
> window who now end up seeing that question again, but I appreciate it.

Adding the involved parties to Cc in order for them to feel the
appreciation. :)

But yah, it keeps happening every so often that people reorg. stuff and
old Kconfig items get queried again. Oh well, when one does allmodconfig
builds and that especially with clang, there's no shortage of build-time
querying.

I even tend to do

  yes "" | make ...

so that the thing gets built already.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
