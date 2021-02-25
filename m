Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6899E32548D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhBYRbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:31:20 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:50547 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhBYRbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:31:18 -0500
Received: from localhost ([109.247.224.130]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MkYLW-1lg9wq2PDq-00m3Ry; Thu, 25 Feb 2021 18:28:42 +0100
Date:   Thu, 25 Feb 2021 18:28:41 +0100
From:   Heinz Diehl <htd+ml@fritha.org>
To:     linux-kernel@vger.kernel.org
Cc:     tiwai@suse.de, lpoetter@redhat.com
Subject: Re: [BISECTED] Kernel 5.11.x breaks pulseaudio
Message-ID: <YDfeSZjdNKFcNKN8@fritha.org>
References: <YDfYAYCaC9KDc1F0@fritha.org>
 <s5him6gnkdu.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5him6gnkdu.wl-tiwai@suse.de>
X-Accept-Language: no,dk,se,en,de
Organization: private site
OpenPGP: id=60F4A92C; url=http://www.fritha.org/htd.asc;
 preference=signencrypt
User-Agent: Mutt/1.14.7+158 (b0ccf259) (2020-09-25)
X-Provags-ID: V03:K1:n0kF3Z86RfE3OP5/qHaL2WMm0u0k36i6rJT8fb4zDI5PG9RyY7F
 KvXtrBTsmIcBm7lQ4xWTy1hSOZxxRnEIB99/jKfgLZPE0aBX0t/c44jMgc0Q+CWiu3RWkix
 2G1FsMz004874CiiQ/We7f1UXgK/H3jJRQ0VPh+tqf549oE7jrhnU3yyd+cyEonNra4Xf3L
 20ucASohb09/8JvxqaYog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oVyuLM1ygsU=:if5Q38qqRwuGEUpz8NAN6c
 0DlBWr8M062/CRzbWzjWBaUacOCIJRm1AfT5qwWCsmdZueuVkMMN1NwgywE2MwgpkJ3gESjsx
 96XzhCA7MllIPU6PkkG09gTC3vs6fw15ZWlpp+1gNzP2t6AIMHCxfav6veZqI+bh/eJB7TjEM
 t5VPoEEEkAl3Y7biIJP5QaYzTSvhCF5LpaYSgeZFgsgkrFPmFqTMckXTiu1Azt0Pc2ypuuW6n
 F5ywtO26oOIc/CvYwQIupDUK8juqhWiVMqo6DAoJYg5cHz3kJmotTCGFRY64S7/aABXW5pMYG
 pk+UgUq8CxvCiCJWfSD5qdESuH3wcm3ehz68OE4ENNLvcXHE2fqGcvfk9kcAYyGNBqRC3BPc/
 Pz6T/1L0uP16+fyVe5cwTzU8oYQNGgLhZErDlSd0YrpeLNqS4ytV+zB4Qxy1c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.2021, Takashi Iwai wrote:

> It's no regression but the right behavior.  This indicates that you're
> trying a stream in 44.1kHz in one side of the full duplex stream while
> 48kHz in another rate, and this cannot work properly with the implicit
> feedback devices.
[....]

Well, I'm by no means an audio or recording professional, but if what you describe
is the correct behavior, it means that absolutely all audio files played on
my machine always will be resampled to 44.1kHz. Youtube from native 48kHz,
highres audio 24/96, virtually anything I play. Could that be correct? And
what can I do to be able to listen to highres audio again?

Thanks,
 Heinz
