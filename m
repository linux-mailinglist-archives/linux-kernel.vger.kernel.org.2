Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C153BA8A6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 14:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhGCMJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 08:09:16 -0400
Received: from marcansoft.com ([212.63.210.85]:53152 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhGCMJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 08:09:15 -0400
X-Greylist: delayed 91953 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jul 2021 08:09:15 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 127C1425EA;
        Sat,  3 Jul 2021 12:06:38 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 5.14-rc1
To:     Takashi Iwai <tiwai@suse.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <s5hbl7li0fe.wl-tiwai@suse.de>
 <CAHk-=wiTwX5mzzEcw3jk3QdW600Hntt=Ehgoyz8K-VU8zbEmBg@mail.gmail.com>
 <CAHk-=whhDWDsVz12mhKtnS6DG-GzVWxBk2XjoOp=gwNJ7T0bTw@mail.gmail.com>
 <CAHk-=wisOVeVpH42f6i5qW1gxtYxbRJQXvpt=mdVx+8p=w-yMg@mail.gmail.com>
 <YOAF+EnvdBvSeZnR@workstation> <s5hh7hbakzk.wl-tiwai@suse.de>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <6adcc9cd-d916-5a50-5a14-8f3b82f60ef6@marcan.st>
Date:   Sat, 3 Jul 2021 21:06:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <s5hh7hbakzk.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2021 16.56, Takashi Iwai wrote:
> Unfortunately I can't test much right now in my side as I'm traveling
> (until the next Tuesday).  So, Linus, Hector, please let me know if
> this works.  Once when it's confirmed to work, I'll prepare the new PR
> including the fix later in today.

Works for me on top of the for-next branch that was previously 
deadlocking. I can't get it to crash any more.

Tested-by: Hector Martin <marcan@marcan.st>

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
