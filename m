Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29B53D9655
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 22:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhG1UDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 16:03:52 -0400
Received: from mail.ispras.ru ([83.149.199.84]:35726 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhG1UDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 16:03:51 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 6F2F340755F2;
        Wed, 28 Jul 2021 20:03:45 +0000 (UTC)
Date:   Wed, 28 Jul 2021 23:03:45 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Takashi Iwai <tiwai@suse.de>
cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hui Wang <hui.wang@canonical.com>,
        Kailang Yang <kailang@realtek.com>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Chris Chiu <chris.chiu@canonical.com>,
        PeiSen Hou <pshou@realtek.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: hda/realtek: add mic quirk for Acer SF314-42
In-Reply-To: <s5h7dhabcck.wl-tiwai@suse.de>
Message-ID: <alpine.LNX.2.20.13.2107282230090.20403@monopod.intra.ispras.ru>
References: <20210721170141.24807-1-amonakov@ispras.ru> <s5h7dhabcck.wl-tiwai@suse.de>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021, Takashi Iwai wrote:

> > 1) at high enough gain, recording the microphone is picking up what is
> > being played via the headphones; maybe it's supposed to be like that,
> > but it surprised me;
> 
> Hrm, that doesn't sound right.  Some internal loopback in the codec?
> Dunno.  It doesn't pick up the sound physically, right?

How can I tell? If I don't have anything plugged into the jack, playback
uses the built-in speakers. In that case there's no feedback. And if I
plug in a headset or common headphones, then built-in speakers are automatically
muted, and recording the mic can pick up the output signal.

Is there a way to forcefully direct output to the jack instead of built-in
speakers even when there isn't anything plugged in?

I am sure it is not picking the sound over the air, but I'm considering it's
picking it up electrically near the jack somehow.

> > 2) there is a very noticeable "pop" when plugging the headset in/out,
> > accompanied by
> > 
> > pcieport 0000:00:08.1: PME: Spurious native interrupt!
> > pcieport 0000:00:08.1: PME: Spurious native interrupt!
> > 
> > in dmesg. I'd appreciate info and any help about this issue.
> 
> The pop noise is often a thing with the codec and there are a bunch of
> different workarounds found in the driver.  But the spurious interrupt
> is more worrisome.  Is the PCI slot corresponding to the HD-audio
> controller?

No, it's actually the PCI bridge under which the HDA core resides:

00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus
00:08.1/03:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) HD Audio Controller

Note that I have autosuspend enabled for PCI devices. If I disable PCI
autosuspend for the 03:00.6 HDA device, there's no "pop" and no spurious
interrupt. My understanding that the chip generates a power management event
when it senses a jack plug/unplug event while suspended. Apparently something
about the PME interrupt is not fully in order?

> As of now, I'm inclined to take your patch as is, at least as a
> first-aid workaround.  Let's see whether we get a better development
> soonish.

*nod*, I will appreciate it!

Thank you.
Alexander
