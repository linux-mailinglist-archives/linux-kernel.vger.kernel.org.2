Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84E327225
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 13:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhB1LtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 06:49:04 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:42379 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhB1Lsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 06:48:46 -0500
Received: from localhost ([109.247.224.130]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MeUPU-1lqUgp3Xs4-00aWYK; Sun, 28 Feb 2021 12:46:12 +0100
Date:   Sun, 28 Feb 2021 12:46:11 +0100
From:   Heinz Diehl <htd-ml@fritha.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, lpoetter@redhat.com
Subject: Re: [BISECTED] Kernel 5.11.x breaks pulseaudio
Message-ID: <YDuCgy8D7eNdnA0J@fritha.org>
References: <YDfYAYCaC9KDc1F0@fritha.org>
 <s5him6gnkdu.wl-tiwai@suse.de>
 <YDfeSZjdNKFcNKN8@fritha.org>
 <s5hft1kni08.wl-tiwai@suse.de>
 <YDi+K4RXmoZ0AM3z@fritha.org>
 <s5h4khwli66.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h4khwli66.wl-tiwai@suse.de>
X-Accept-Language: no,dk,se,en,de
Organization: private site
OpenPGP: id=60F4A92C; url=http://www.fritha.org/htd.asc;
 preference=signencrypt
User-Agent: Mutt/2.0.5+121 (e0d08c59) (2021-02-24)
X-Provags-ID: V03:K1:T47UmijXLnf+iKwgqQRmTYmODySdN9mUqSye+s1Q5KW8vCL4XLw
 8vIwHXq9FuE+Y8HnYQCiAETI8icSph5gNMzYwzK/d2hf61ysuB97/4YlQXPFUUlgTkg/KCe
 W87chBWhR+hl4FP0NqRcQRC6rsvKZ+491kxen3j1vCzFFWVAtlp/4tie+FJuoeQKqqqL14z
 PD6FceQODs7+ieSKAcvIQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dR2gRtLZtTc=:br/TL9nBrCsoEJJhCz0KFX
 llGZDGUIxd/tCKuQB/2DDfdyBJ4xinc1gU/S8uDmDqECbhr1M27aYpWzp5zWLh+BO6fYTzrA6
 fZLmrxZKHESeYpvV9dIRji0m9fog1JuZc+zV8gFpkuxOUy7xvAxNn3XqlQmWSHijodd49CNPR
 eQPvwRmAWCFTt0US/kg4poFzxFaRIBDio8nMt9WNUW8GDaQAbp/4Tslm/PWQnrsAo19zZje2P
 PSJ60JCkqVrkIQ6apqkx+A2ulm5eRqOGQHzlLc4caoGC+aaFj1SBOcqZNT15hwHa7nxwgAZvL
 DHzJjXpB/Xr4TJWMAU1LZHv9O0Kh740b1H/5y3wefqeu6ytAtATTGqPv5Zw866P0++zIRAAzm
 fvgSJ48lswk2nQjkUImeiPHi10hPvJPpZvK2yeDPAX8Pno+cNygrqjNNu6MZJnT3KMzqAQdVb
 Y4xqxPoAyA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.02.2021, Takashi Iwai wrote: 

> The fix I merged today can also work around your problem.
> Please give it a try.
>   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=5f5e6a3e8b1df52f79122e447855cffbf1710540

Applied on top of 5.11.2 - now pulseaudio works perfectly again, many
thanks!

Heinz


