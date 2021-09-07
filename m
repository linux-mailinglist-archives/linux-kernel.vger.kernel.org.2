Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698C8403026
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347036AbhIGVSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:18:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57074 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243883AbhIGVSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:18:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 10B2F22077;
        Tue,  7 Sep 2021 21:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631049449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxyUhBlnCJaef3wt8dCSefgZM0wYX3ZWkIB0Mn4y7hQ=;
        b=LMyVXYzhgMUO1XPZiu+bKe3SiVQx8TAky0NyFUqHeC59y40Yq0RoTXznbn4vyEU66FUFBU
        OapiMiNfXXVEtsJi1soe7HTJxQqgvIvC8ehqib/ozqCjwIOKQkgZDHwQ44L2jtPa72byrZ
        7p5qJIZmmIgSuRL1pPjCURB37K53im4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631049449;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxyUhBlnCJaef3wt8dCSefgZM0wYX3ZWkIB0Mn4y7hQ=;
        b=r2bnL9Y1efEgPQoHNvZzvc4FAJCLDStr+T5Trn8AJCBF5vulsWMwQVmcxXeyWyWuFMkBJr
        5PrOKtL1Sk81qlCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C193113A59;
        Tue,  7 Sep 2021 21:17:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Bt5+LOjWN2HHXQAAGKfGzw
        (envelope-from <jdelvare@suse.de>); Tue, 07 Sep 2021 21:17:28 +0000
Date:   Tue, 7 Sep 2021 23:17:27 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [GIT PULL] dmi fix for v5.15
Message-ID: <20210907231727.32a74c4c@endymion>
In-Reply-To: <CAHk-=wgLh7BGv-6_TFsqezM31o0ZoZruBkUs8fus-Fm-sn233g@mail.gmail.com>
References: <20210907102428.616e5087@endymion>
        <CAHk-=wgLh7BGv-6_TFsqezM31o0ZoZruBkUs8fus-Fm-sn233g@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2021 13:17:20 -0700, Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 1:24 AM Jean Delvare <jdelvare@suse.de> wrote:
> >
> > Please pull dmi subsystem fixes for Linux v5.15 from:  
> 
> Please give me a blurb about what this fixes.
> 
> I did look at the single commit and made something up, so this is
> already merged (as pr-tracker-bot has noticed), but in general even
> just one-liner trivial "this fixes modalias that got broken by a
> misplaced field" would have been appreciated.

OK, I've updated my template to remember to include such an executive
summary next time. Sorry for the inconvenience.

-- 
Jean Delvare
SUSE L3 Support
