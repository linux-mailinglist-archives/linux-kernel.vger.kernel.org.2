Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7500350602
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhCaSJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:09:46 -0400
Received: from mail1.perex.cz ([77.48.224.245]:35946 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233735AbhCaSJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:09:30 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 50375A003F;
        Wed, 31 Mar 2021 20:09:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 50375A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1617214165; bh=cVlBUFphs/dnp74K2p5kRDyfBDi3OUtOUvGdNmBLsP4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sBeAQc3JNSuqQS+Lcy4Gncbk+pJfATshMepPkXFUdX1HwkUhHIm1/haAjQb1Hfz1v
         06blgNKsS56DwNFOFLb6Xs5AJa9bKGph6vBV7HxOpgXnDXj9M5tPNyrbEXSi3W7iVs
         qtfeT3BowNx5VOWrz/mJ6T/G6Dr0NJa8tC8mCyKk=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 31 Mar 2021 20:09:19 +0200 (CEST)
Subject: Re: ALSA: control - add layer registration routines
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <96e9bd5c-c8db-0db8-b393-fbf4a047dc80@canonical.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <51ba335d-45ac-b50d-2ec6-333afd1daebf@perex.cz>
Date:   Wed, 31 Mar 2021 20:09:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <96e9bd5c-c8db-0db8-b393-fbf4a047dc80@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 31. 03. 21 v 17:17 Colin Ian King napsal(a):
> Hi,
> 
> Static analysis on linux-next with Coverity has detected a potential
> issue in the following commit:
> 
> commit 3f0638a0333bfdd0549985aa620f2ab69737af47
> Author: Jaroslav Kysela <perex@perex.cz>
> Date:   Wed Mar 17 18:29:41 2021 +0100
> 
>     ALSA: control - add layer registration routines
> 
> The static analysis is as follows:
> 
> 2072 void snd_ctl_disconnect_layer(struct snd_ctl_layer_ops *lops)
> 2073 {
> 2074        struct snd_ctl_layer_ops *lops2, *prev_lops2;
> 2075
> 2076        down_write(&snd_ctl_layer_rwsem);
> 
>     assignment: Assigning: prev_lops2 = NULL.
> 
> 2077        for (lops2 = snd_ctl_layer, prev_lops2 = NULL; lops2; lops2
> = lops2->next)
> 2078                if (lops2 == lops) {
> 
>     null: At condition prev_lops2, the value of prev_lops2 must be NULL.
>     dead_error_condition: The condition !prev_lops2 must be true.
> 
> 2079                        if (!prev_lops2)
> 2080                                snd_ctl_layer = lops->next;
> 2081                        else
> 
>     'Constant' variable guards dead code (DEADCODE) dead_error_line:
>     Execution cannot reach this statement: prev_lops2->next = lops->next;.
>     Local variable prev_lops2 is assigned only once, to a constant
> value, making it effectively constant throughout its scope. If this is
> not the intent, examine the logic to see if there is a missing
> assignment that would make prev_lops2 not remain constant.
> 
> 2082                                prev_lops2->next = lops->next;
> 2083                        break;
> 2084                }
> 2085        up_write(&snd_ctl_layer_rwsem);
> 2086 }
> 
> I couldn't quite figure out the original intent of the prev_lops use, so
> I'd thought I'd report this issue as the code does look incorrect.

Thank you. I submitted the fix here:

https://lore.kernel.org/alsa-devel/20210331180702.663489-1-perex@perex.cz/

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
