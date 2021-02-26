Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842CA326007
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhBZJ2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:28:39 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:45347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBZJ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:26:31 -0500
Received: from localhost ([109.247.224.130]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M1YpJ-1lEBVP1ocN-0031i0; Fri, 26 Feb 2021 10:23:56 +0100
Date:   Fri, 26 Feb 2021 10:23:55 +0100
From:   Heinz Diehl <htd+ml@fritha.org>
To:     linux-kernel@vger.kernel.org
Cc:     tiwai@suse.de, lpoetter@redhat.com
Subject: Re: [BISECTED] Kernel 5.11.x breaks pulseaudio
Message-ID: <YDi+K4RXmoZ0AM3z@fritha.org>
References: <YDfYAYCaC9KDc1F0@fritha.org>
 <s5him6gnkdu.wl-tiwai@suse.de>
 <YDfeSZjdNKFcNKN8@fritha.org>
 <s5hft1kni08.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hft1kni08.wl-tiwai@suse.de>
X-Accept-Language: no,dk,se,en,de
Organization: private site
OpenPGP: id=60F4A92C; url=http://www.fritha.org/htd.asc;
 preference=signencrypt
User-Agent: Mutt/1.14.7+158 (b0ccf259) (2020-09-25)
X-Provags-ID: V03:K1:3ic/i931As9LCJJEC3kWPP8Kqnau7MH2EaC/E2+JfRsP/GOnQLw
 8mJ/lGlrmvKKhW2iMQsU21oqTgqwegRoY/gKtu3ARKHjQz7llSrGIi4FBX8C+8vMTNy2kNy
 +kPGsskTVs6QsQH8vXp+xy14Dey3Xh0P0f17fz7fA1Hja90f378L09ayCUuWBuue0nmu8CS
 hGeGELT9aozVXaJQcJYYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oS4cSzpf6e4=:0PjyLKMtDxQvLDD6JQyyr3
 +i3CQxPJNwjkE1/xLuEab7FFy0mQuIcvnSyosEkUhSogSHdt+hCAcWBwyAfNrUrYHCpG927ZU
 txziujATHAfh7ROmh2qXQZSm9kdiifWKs69OhDWs/s/0H/eFKXylw6Hl90Zwgxl3iuQhSCecP
 CIXeNwx4gXVHCpTqLasak2B9PpuE3+N0DnjcnW0isiaoB+oeH9l1xuV/2JdwiEUe1Zng9PDUt
 mdhbwzyrdHKUWWaMeA68EavuObUdSMgn1E7KvTwMrlpJ2l1M6L5qYJIVXJhiHzM0onS2efFtu
 OCYqn9T262vbc3GTQ+1oloUluV/DnT3GfXO8AX6uTft1s8TLSAhDeXVF482ONCKlHmbpS8xQI
 h3HOn69rkkc0oCvKmfmxs2lzOOWr474ufrIPln8zs6kqJ3iMaTcAvaAJM/En+KvXuW/lJMSjO
 0c0l5KCBTQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.02.2021, Takashi Iwai wrote: 

> Check which streams are running when you get the unexpected sample
> rate by inspecting /proc/asound/card*/pcm* entries.

I see, thanks for explaining! Pulseaudio no longer works properly for me, but
after configuring my audio player to use ALSA directly, all is fine so
far and all audio files are played with the correct sample rate and
without any resampling, just as they should.

Thanks, Heinz.
