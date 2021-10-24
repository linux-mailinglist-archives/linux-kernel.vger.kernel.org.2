Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E09438971
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhJXOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhJXOKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 10:10:06 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6114C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 07:07:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q16so4191714ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 07:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=2xg8b0PhImUgFD1vlcegBC3Dkb/ADebVx1OoidLwJVg=;
        b=FExO0P6XGeA99jiK3jYyzGzYwfir+9cK3AbnVKHG0jw8cklwsMepg+lvdP/ng/WkJw
         Z0Brf2IZGrAmoWOnZCJabD0mAkYYPL7q4pSOmlQfvJBIPRGdcwKHIFAcZEW2IOQ+VBuX
         4H8rwZ4R/hKgIrHTOx5eXUWV9kr/a0PrlxGWMR/iovA/DX+CB5Ri6CBN7wpLYMzPh19i
         n15PCbbMYzY42y1vxxOJgZ1QPz8azrgWKoKuOPImlBIzXh8n9LzbaCVRLPt2RSt1mhC4
         KpsYSbvh/IQhUCTutjn5jLe/dNBW3b9q9bKTL1fKngILL04w/d57mLGvuQ2TNeGqIB5p
         AhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2xg8b0PhImUgFD1vlcegBC3Dkb/ADebVx1OoidLwJVg=;
        b=Hlm/y5eX1bm/eQj7cVaUKaQEmLYrW72kqjKJcQuNr5HnHty/6WVgdDL1ZrXW/6PXS7
         13SXLVdMvCmW8mDhzzr0kV+r4PeM/uwikzIExv7UXw3EeHyoO148cvvIVElIcoB5P4s8
         KsC37bHVJOUag6UQGQlUxs0f3dFPi4aFVYLhdwDWltetYdpK27yTJto92AHKOsun2XAe
         LS9dPcL5P1m0qapzNZJgf2SiYiBG1kkfktxc9bWPYQhJBPboVujq7wIYLiUyn+7i8I0Z
         p5DQZmBYPHGKyLxbCmSqGbyHV8UBw336OtU2PLYtmHMNcYbv1K2NWyixz3YSAaJMWQ+L
         4uSA==
X-Gm-Message-State: AOAM531dTHTOI8uAM8roO6VdPez/X6mdOXyG7nsomMkdwE3zLbVbPXHp
        oZVc/cyvjUZSWUtsJI9w2WY=
X-Google-Smtp-Source: ABdhPJxmkRTwgt82Aprhr0dbm9VZy5cvpqlWfDoGR/+Iaj57ZsQhuowrE5c6LYnNo9oAKm8YXTZ55Q==
X-Received: by 2002:a2e:2e03:: with SMTP id u3mr12779117lju.269.1635084464059;
        Sun, 24 Oct 2021 07:07:44 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.8])
        by smtp.gmail.com with ESMTPSA id g18sm813835lfv.25.2021.10.24.07.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 07:07:43 -0700 (PDT)
Message-ID: <b6ec6d46-1eb8-42c1-33ab-0142dd142c84@gmail.com>
Date:   Sun, 24 Oct 2021 17:07:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [syzbot] possible deadlock in snd_mixer_oss_ioctl1
Content-Language: en-US
To:     syzbot <syzbot+ace149a75a9a0a399ac7@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org, joe@perches.com,
        lars@metafoo.de, linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
References: <00000000000067a98805cf0a3a98@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <00000000000067a98805cf0a3a98@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/21 22:35, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    cf6c9d12750c Add linux-next specific files for 20211022
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15d3d4c4b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e694204255ade3a3
> dashboard link: https://syzkaller.appspot.com/bug?extid=ace149a75a9a0a399ac7
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c0530cb00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1129c952b00000
> 
> The issue was bisected to:
> 
> commit 411cef6adfb38a5bb6bd9af3941b28198e7fb680
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Wed Oct 20 16:48:46 2021 +0000
> 
>      ALSA: mixer: oss: Fix racy access to slots
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=167f6454b00000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=157f6454b00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=117f6454b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ace149a75a9a0a399ac7@syzkaller.appspotmail.com
> Fixes: 411cef6adfb3 ("ALSA: mixer: oss: Fix racy access to slots")
> 
> ============================================
> WARNING: possible recursive locking detected
> 5.15.0-rc6-next-20211022-syzkaller #0 Not tainted
> --------------------------------------------
> syz-executor206/6529 is trying to acquire lock:
> ffff888021ff09c8 (&mixer->reg_mutex){+.+.}-{3:3}, at: snd_mixer_oss_set_volume sound/core/oss/mixer_oss.c:316 [inline]
> ffff888021ff09c8 (&mixer->reg_mutex){+.+.}-{3:3}, at: snd_mixer_oss_ioctl1+0x630/0x19a0 sound/core/oss/mixer_oss.c:375
> 
> but task is already holding lock:
> ffff888021ff09c8 (&mixer->reg_mutex){+.+.}-{3:3}, at: snd_mixer_oss_set_volume sound/core/oss/mixer_oss.c:300 [inline]
> ffff888021ff09c8 (&mixer->reg_mutex){+.+.}-{3:3}, at: snd_mixer_oss_ioctl1+0x4b1/0x19a0 sound/core/oss/mixer_oss.c:375
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&mixer->reg_mutex);
>    lock(&mixer->reg_mutex);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 

Looks like typo in previous ALSA patch. [1] should fix it


[1] 
https://lore.kernel.org/alsa-devel/20211024140315.16704-1-paskripkin@gmail.com/T/#u




With regards,
Pavel Skripkin
