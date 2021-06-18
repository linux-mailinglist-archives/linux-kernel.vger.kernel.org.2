Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE753AD3CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhFRUqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:46:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47548 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhFRUqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:46:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9333921B36;
        Fri, 18 Jun 2021 20:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624049063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PIGLG6imWm0pH7cEpuP3tSu7rB+YVUU8KI9kmgIiz80=;
        b=hSXquGkEeE7k/dTsaSRL2mmyPGbmGmnPaswSyog2k1FLVvQ0L02Z/bl480yLgmyvpzhaEd
        4VHUlrjdUOV4CB/FA6qSRO1xK4ydLUFew87X25fQAzuj9va3n38jeMdnG1/Y15McIhV2Us
        AIa5hV+ciSMqSsRci3NT3nWDewFmDmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624049063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PIGLG6imWm0pH7cEpuP3tSu7rB+YVUU8KI9kmgIiz80=;
        b=vZ0U5zUoWfk6O9P9T3MEakQG5pXMRDZ4v0c+MGAH+Pzb5FdMB2aJaJlVJNtfeEFLJ6Zv+h
        LrqGHYlUOPXz8YCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7F1CD118DD;
        Fri, 18 Jun 2021 20:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624049063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PIGLG6imWm0pH7cEpuP3tSu7rB+YVUU8KI9kmgIiz80=;
        b=hSXquGkEeE7k/dTsaSRL2mmyPGbmGmnPaswSyog2k1FLVvQ0L02Z/bl480yLgmyvpzhaEd
        4VHUlrjdUOV4CB/FA6qSRO1xK4ydLUFew87X25fQAzuj9va3n38jeMdnG1/Y15McIhV2Us
        AIa5hV+ciSMqSsRci3NT3nWDewFmDmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624049063;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PIGLG6imWm0pH7cEpuP3tSu7rB+YVUU8KI9kmgIiz80=;
        b=vZ0U5zUoWfk6O9P9T3MEakQG5pXMRDZ4v0c+MGAH+Pzb5FdMB2aJaJlVJNtfeEFLJ6Zv+h
        LrqGHYlUOPXz8YCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id MSn2HacFzWDRZAAALh3uQQ
        (envelope-from <bp@suse.de>); Fri, 18 Jun 2021 20:44:23 +0000
Date:   Fri, 18 Jun 2021 22:44:08 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andrew Cooper <amc96@cam.ac.uk>
Subject: Re: [patch V3 02/66] x86/fpu: Make init_fpstate correct with
 optimized XSAVE
Message-ID: <YM0FmL2NUrQcON9C@zn.tnic>
References: <20210618141823.161158090@linutronix.de>
 <20210618143444.587311343@linutronix.de>
 <87v96aewiq.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v96aewiq.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 10:41:01PM +0200, Thomas Gleixner wrote:
> Doh, I wanted to add Borislav's R-B tag and either my brain tricked me
> because I was staring at this way too long or my tired finger memory
> ended up using the wrong shortcut. So this should obviously be:
> 
>   Reviewed-by: Borislav Petkov <bp@suse.de>

Well, it is in a disadvantage this way: it is waay better if you review
your own patch than I.

:-P


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
