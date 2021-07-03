Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE42A3BA78F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 08:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhGCGl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jul 2021 02:41:29 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46381 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhGCGl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jul 2021 02:41:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 5E95C32003AC;
        Sat,  3 Jul 2021 02:38:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 03 Jul 2021 02:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=UOVQzo5peU9hwquiGwR5ViUp2k9
        ewftmmdtIsg9qScw=; b=QcN1SRQRNScvREtQ7Qz078kAsUVQiueobP2eBHB07CJ
        xwvV1WHaxoEY6nzC0YcjuctiR5FEcSsNbD+s32qMrNuPmzxUwVj9ghIfXh4nqaSM
        WC/v+r4rzVw82nBvS/78kp1bVOOJJZ9QQRI/y8TOPB2ydVKrXawz788qNr3H86Bc
        28I6PILaFfC+uVsaCA4td6v8hnFw2IhlTyZ83Qd/m7EuqYlBVasHqevCsQhJ396j
        rEsnUuocF9/epLbF8CwhR6f309HoULJP+pXfHrqh+alJ7042bJOSOJ64VUuety+3
        1zB91WT9C7SzzxorNpkWPxPtEgmeJQLbWmTk1BItT4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UOVQzo
        5peU9hwquiGwR5ViUp2k9ewftmmdtIsg9qScw=; b=U+3NTxvxx71BQXB7CERqUF
        T6gVnr2fbpR29q0jpu0xj2zmNE5zsKKTsAfSQAyvROCwbCwZCwtL89/WUqpqh4fY
        jC9GUCPFQLwTpxmEJ6dmeU6GMLIn6GWsgaCj17gidqXK1JCi4hsO8cjQtHQYk8rn
        QTWB1LqXfz+bSb38pT1Y9FTdRam1xELzPWijhywW0ZYb+56AyrSpjoEzkBdEvk0g
        mXwHaMPjfGzyVyK2wl84D5EcS0CMdT6p5LZfwciTsMT/ncDDvpToXTdzY/4Rdy5p
        /GCbOL4F+W/jjB75e3F3G7LTznJaDSiFA5ot1P66kwyUrYUj0RvIA0raZci1bLRA
        ==
X-ME-Sender: <xms:_QXgYKk14eHpJ7QHNesA_Gkcbq6JmXwHzhnJlCVzzue4VRpgfgwfNw>
    <xme:_QXgYB3L29CQ8IIdZgtfC4RfkXjvHshoLBMcR36Pa76tYVAE9z0-ZqOcAkDpaMRG8
    KkXMhxnc_cyc-0h6Rk>
X-ME-Received: <xmr:_QXgYIrhLcJI70S-O1O_6Ksbgv026jxyJwY1Xg62qi_VHhnwgkqdZJiXxhcc72yu91qAwHGz-pyB79W8g2H5qcv5FQbZ0yAShQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeiledguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnheplefhueegvdejgfejgfdukeefudetvddtuddtueei
    vedttdegteejkedvfeegfefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:_QXgYOlvRsKxpUN0zc16vImy_ViaFl7CQCcIYR8VoSkU5dowuZAy9w>
    <xmx:_QXgYI3AmHU6sfCx1-4SgSxxbwBeXz8glYiZ7DuEkI-8kLzUV2EcbA>
    <xmx:_QXgYFtG65fELIspQ4ARxoK5eIHXeN3zwNaYwGZJIF0ha-nVbNHOHA>
    <xmx:_gXgYM8s-NbBUiZfKz609JzV59Bi6BrqJnBqV0YuCDRsft4QUkuNgQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jul 2021 02:38:51 -0400 (EDT)
Date:   Sat, 3 Jul 2021 15:38:48 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        marcan@marcan.st
Subject: Re: [GIT PULL] sound updates for 5.14-rc1
Message-ID: <YOAF+EnvdBvSeZnR@workstation>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        marcan@marcan.st
References: <s5hbl7li0fe.wl-tiwai@suse.de>
 <CAHk-=wiTwX5mzzEcw3jk3QdW600Hntt=Ehgoyz8K-VU8zbEmBg@mail.gmail.com>
 <CAHk-=whhDWDsVz12mhKtnS6DG-GzVWxBk2XjoOp=gwNJ7T0bTw@mail.gmail.com>
 <CAHk-=wisOVeVpH42f6i5qW1gxtYxbRJQXvpt=mdVx+8p=w-yMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wisOVeVpH42f6i5qW1gxtYxbRJQXvpt=mdVx+8p=w-yMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 02, 2021 at 10:19:46PM -0700, Linus Torvalds wrote:
> On Fri, Jul 2, 2021 at 9:37 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But I thought I'd report this as a likely candidate.
> 
> Confirmed. The watchdog hang bisects right down to commit 9ce650a75a3b
> ("ALSA: usb-audio: Reduce latency at playback start").
> 
> And reverting it on top of my tree also fixes the hang, so it's not
> some bisection fluke.
> 
> I have no idea what is actually wrong with that commit, but it most
> definitely is the problem, and I have reverted it in my tree so that I
> can continue merging stuff tomorrow.

The cause seems to be the attempt to lock PCM substream recursively
introduced by the issued commit.

Would I ask you to test with below patch? I apologize that the patch is
still untested in my side since at present I have no preparation to debug
USB stuffs instantly (I'm just a maintainer for ALSA firewire stack...),
so I'm glad if getting your cooperation for the issue.

======== 8< --------

From f7ab449f10152635ad7083aa73d80e3fb1adabb4 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Sat, 3 Jul 2021 15:23:25 +0900
Subject: [PATCH] ALSA: usb-audio: fix recursive lock of PCM substream when
 starting playback PCM substream

A commit 9ce650a75a3b ("ALSA: usb-audio: Reduce latency at playback start")
unfortunately introduced the call of snd_pcm_period_elapsed() under acquired
lock of PCM substream. This causes recursive lock and results in dead-lock.

->ioctl(2)
  (sound/core/pcm_native.c)
  ->snd_pcm_stream_lock_irqsave() <-
    ...
    ->struct snd_pcm_ops.trigger()
    (sound/usb/pcm.c)
    = snd_usb_substream_playback_trigger()
      ->start_endpoints()
        (sound/usb/endpoint.c)
        ->snd_usb_endpoint_start()
          ->prepare_outbound_urb()
            ->struct snd_usb_endpoint.prepare_data_urb()
            (sound/usb/pcm.c)
            = prepare_playback_urb()
              (sound/core/pcm_lib.c)
              ->snd_pcm_period_elapsed()
                (sound/core/pcm_native.c)
                ->snd_pcm_stream_lock_irqsave() <-

This commit fixes the issue to use newly added function;
snd_pcm_period_elapsed_under_stream_lock() with condition to check running
context.

Reported-by: Hector Martin <marcan@marcan.st>
Fixes: 9ce650a75a3b ("ALSA: usb-audio: Reduce latency at playback start")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/usb/pcm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index c66831ee15f9..235070f0236a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1395,8 +1395,16 @@ static void prepare_playback_urb(struct snd_usb_substream *subs,
 
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer_length = bytes;
-	if (period_elapsed)
-		snd_pcm_period_elapsed(subs->pcm_substream);
+	if (period_elapsed) {
+		// The callback of struct snd_pcm_ops.trigger with SNDRV_PCM_TRIGGER_START command
+		// can reach here, under acquired lock of PCM substream. To avoid dead-lock, check
+		// current context and call corresponding function.
+		if (in_softirq()) {
+			snd_pcm_period_elapsed(subs->pcm_substream);
+		} else {
+			snd_pcm_period_elapsed_under_stream_lock(subs->pcm_substream);
+		}
+	}
 }
 
 /*
-- 
2.30.2

======== 8< --------

Thanks

Takashi (not subsystem maintainer) Sakamoto
