Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80533325455
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhBYRHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:07:10 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54969 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbhBYREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:04:31 -0500
Received: from localhost ([109.247.224.130]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N9d4t-1lrMUo0Cmb-015YOo; Thu, 25 Feb 2021 18:01:55 +0100
Date:   Thu, 25 Feb 2021 18:01:53 +0100
From:   Heinz Diehl <htd+ml@fritha.org>
To:     linux-kernel@vger.kernel.org
Cc:     tiwai@suse.de, lpoetter@redhat.com
Subject: [BISECTED] Kernel 5.11.x breaks pulseaudio
Message-ID: <YDfYAYCaC9KDc1F0@fritha.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Accept-Language: no,dk,se,en,de
Organization: private site
OpenPGP: id=60F4A92C; url=http://www.fritha.org/htd.asc;
 preference=signencrypt
User-Agent: Mutt/1.14.7+158 (b0ccf259) (2020-09-25)
X-Provags-ID: V03:K1:6kv1+b1m3bpcqzD41nyt84EbcOe+4VwSCoZpqBlydzmzeWzNhJa
 hjjUDe4ItYgUslZLNmKDoDE0qeEIGIgoiLIl1kZ2KHqbE23nxsMgAFwYJOfDCweH3y4TN3D
 BpGRvMEzJWufw1mweHHUU85MyAdMuTxwBFebIrW00NsN6IVStbla9jMZb5VSzI8CL002FcB
 W933FdCl8AqAOeqYaVSIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vo8d7Ye1T3w=:6xVerhlssNvFcoZowoiicH
 SzrANwTKQ64XmUQkt1okR5cu+XxGbnOupnZpZXuW+kWFL4mqtWAZC7/4z89DLaZpgJ0Ycaa7u
 lG8Q9dhKh7WxXszBIXUcCMx/O0zt6f2n4cyScHUlY5UTIhcO+B294cNcKvIRmQY3ZiuNqsnXk
 YTkyvcjybPo0ZHRQVpQFPOPwyrnETpN0wH9VYZCHRxk9GqEl4ApZIx/zDrDgilIf9AOBRcBX1
 vcDMPRu+W7PqdpriNjJdVBJV0zJQgPm7/a1+lHkToG1aNKUBCDeH3bdNXMGhQVcK36kFd/vur
 zYvCuQyB9Ye0E2aDAKY527tcj0MkQzOzLRFteOGnw/nHUKg6eNjmOmpYkcFv/WvekLjhlVDot
 qvu1h/PJXa8ovPFIwExTABS1pINxM9HklB6gS3YDBhl4rPWHtkvUVkdJ4qHGvHqi82ng4fj7u
 vamuyNNNhA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

from kernel 5.11 on, pulseaudio always resamples audio to the sample
rate specified by default-sample-rate, despite "avoid-resampling =
true". Audio that matches alternate-sample-rate is resampled in the same way.
This means that both "alternate-sample-rate" and
"avoid-resampling=true" are no longer working.

Steps to Reproduce:
1. Set "avoid-resampling = true" in daemon.conf
2. Set default-sample-rate = 44100 in daemon.conf
3. Set alternate-sample-rate 48000 in daemon.conf
4. Restart pulseaudio
5. Play a 48000 (or any other) audio file

Actual results:
File is played as 44100 audio. Pacmd list-sink-inputs shows that
resampling is happening. Play an audio file with any other sample
rate, and it will be resampled to 44100.

Expected results:
Audio file plays at 48000. Any other file is played in its own sample rate.

In my case, this affects USB audio. Tried both a Dragonfly Red, a
Fostex HP-A4 and an unknown Soundblaster USB audio dac/amp, and all of
them show the same behaviour as described here. Most probably, the
regression affects all USB audio devices.

All kernels from the 5.10 series are fine. Here's the offending patch
that introduced the regression. Reverting it on top of kernel 5.11 /
5.11.1 resolves the problem:

[root@chiara linux-stable]# git bisect good
e4ea77f8e53f9accb9371fba34c189d0447ecce0 is the first bad commit
commit e4ea77f8e53f9accb9371fba34c189d0447ecce0
Author: Takashi Iwai <tiwai@suse.de>
Date:   Mon Jan 11 09:16:11 2021 +0100

    ALSA: usb-audio: Always apply the hw constraints for implicit fb sync
    
    Since the commit 5a6c3e11c9c9 ("ALSA: usb-audio: Add hw constraint for
    implicit fb sync"), we apply the hw constraints for the implicit
    feedback sync to make the secondary open aligned with the already
    opened stream setup.  This change assumed that the secondary open is
    performed after the first stream has been already set up, and adds the
    hw constraints to sync with the first stream's parameters only when
    the EP setup for the first stream was confirmed at the open time.
    However, most of applications handling the full-duplex operations do
    open both playback and capture streams at first, then set up both
    streams.  This results in skipping the additional hw constraints since
    the counter-part stream hasn't been set up yet at the open of the
    second stream, and it eventually leads to "incompatible EP" error in
    the end.
    
    This patch corrects the behavior by always applying the hw constraints
    for the implicit fb sync.  The hw constraint rules are defined so that
    they check the sync EP dynamically at each invocation, instead.  This
    covers the concurrent stream setups better and lets the hw refine
    calls resolving to the right configuration.
    
    Also this patch corrects a minor error that has existed in the debug
    print that isn't built as default.
    
    Fixes: 5a6c3e11c9c9 ("ALSA: usb-audio: Add hw constraint for implicit fb sync")
    Link: https://lore.kernel.org/r/20210111081611.12790-1-tiwai@suse.de
    Signed-off-by: Takashi Iwai <tiwai@suse.de>

 sound/usb/pcm.c | 171 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 108 insertions(+), 63 deletions(-)
[root@chiara linux-stable]#

Feel free to contact me if you think I can help.

Thanks, Heinz.


