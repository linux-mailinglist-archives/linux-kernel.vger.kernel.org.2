Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0CC3B9F24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhGBKgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhGBKgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:36:46 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698EBC061765
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 03:34:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id AF1C8419BC;
        Fri,  2 Jul 2021 10:34:08 +0000 (UTC)
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: [tiwai/for-next] hard lockups with pipewire and snd-usb-audio
Message-ID: <4e71531f-4535-fd46-040e-506a3c256bbd@marcan.st>
Date:   Fri, 2 Jul 2021 19:34:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

I've been testing builds from your for-next branch to get the recent 
firewire fixes. All that works fine, but instead I've been getting hard 
lockups with pipewire and snd-usb-audio. I'm currently on 9a7b7ec3c6.

Backtrace:

  do_raw_spin_lock+0x8e/0x90
  _raw_spin_lock_irqsave+0x3e/0x50
  ? snd_pcm_period_elapsed+0x10/0x30 [snd_pcm]
  snd_pcm_period_elapsed+0x10/0x30 [snd_pcm]
  snd_usb_endpoint_start+0xd8/0x270 [snd_usb_audio]
  start_endpoints+0x50/0x70 [snd_usb_audio]
  snd_usb_substream_playback_trigger+0x58/0x100 [snd_usb_audio]
  snd_pcm_action+0x74/0xb0 [snd_pcm]
  snd_pcm_action_lock_irq+0x36/0x80 [snd_pcm]
  snd_pcm_ioctl+0x1e/0x30 [snd_pcm]
  __x64_sys_ioctl+0x7d/0xb0
  do_syscall_64+0x45/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

To me it looks like it's recursively trying to lock the stream spinlock.

I'm not sure what version this is a regression from; I've only triggered 
it with pipewire so far, which I wasn't previously using. It's easy to 
reproduce. Usually, pulling up pavucontrol on pipewire with the USB 
audio device on an active profile will do it.

Just thought you might want to know. Let me know if you need any more info.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
