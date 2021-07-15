Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722DE3C9C94
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbhGOKXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbhGOKXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:23:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC02DC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:20:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id bt15so3550250pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=0c0M98GqS4QoBfMDYa+Mw0Q7vATtc9/MXR1xed72h1w=;
        b=FeWcPG1lAYUu3WIf0My0cXXHp16Gs9Q3sHWaTxutlzafsprsG8h4gVOQ0UUweX5VdV
         gTqX3rL7qKqBPbstco9HX8aHLksw35RmNhgfLP/hmdSnrwCesuDBV2Ax+LYgKvozJySQ
         ESN3cC5mtY9+PRLHBZcZwyIXj5Lz+S+GOPgtOTbEJqeG2cj4gkW60ZPicGw01TkPrSMX
         E5z5tDYTjytU0+cD5i6sylaUFk3ap1YJ0PUFYkqHEFdKsWBIBWqhHtfIvPBLC9gGg8Hb
         /AR9EmlULP4YWPUX1YX9mLcpMH/clry/La2LCRavG9ZxddkZlKo33mfyMYT0YA58wKXD
         ooqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=0c0M98GqS4QoBfMDYa+Mw0Q7vATtc9/MXR1xed72h1w=;
        b=NepZSQGo/7sIEhharQVaIzn0niphvagcN+htIJjubbGOE8Ah5S7y0zKfVnHNIUnOgW
         Pq9oZUBlH6VKBWKNEUbVoFDtDhuzkwKG7NMr5j2ztooGKH/QCXxNppBCK5M9IdIC9JDm
         XShwq5LrVSFZXfM5wepCF5PyV1JUyrmibNt9mAqmvhbMyy9feky2coTEyG+d6jWF0qE/
         GDtIO2V31SGzBK3s0490daj/oI0idA8Vc+/g1GXgi+shFJ/4l+RIHbdK1/kw7uf/cS6w
         vu5ktpe1E1u5Qzm0FFlbkzB4QG3psihGg1sTtSAnZMByN7vVR5vLa6ob7OU6t9g977VC
         RsmA==
X-Gm-Message-State: AOAM530bqVKMUFMuNE3EyZM5WFxCIAzxgw8WgxW0+v/QxsRllP5i4qIA
        1zujOYGSx3pdlhgT9PLZeWtGnfTE6j0=
X-Google-Smtp-Source: ABdhPJy2jKC1wIy3IY6eyCK9pnNyhDoZsiaiRN1V/ykXH1UDW2vRdqDFOIduaSOB8r28siVHMLekpA==
X-Received: by 2002:a17:902:d50a:b029:12b:59a9:9586 with SMTP id b10-20020a170902d50ab029012b59a99586mr759156plg.62.1626344440114;
        Thu, 15 Jul 2021 03:20:40 -0700 (PDT)
Received: from [10.162.0.18] ([45.135.186.83])
        by smtp.gmail.com with ESMTPSA id p40sm6079690pfw.79.2021.07.15.03.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 03:20:39 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] ALSA: sb16: possible ABBA deadlock in snd_sb_csp_stop() and
 snd_sb_csp_load()
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org >> linux-kernel" 
        <linux-kernel@vger.kernel.org>
Message-ID: <7b0fcdaf-cd4f-4728-2eae-48c151a92e10@gmail.com>
Date:   Thu, 15 Jul 2021 18:20:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I find there is a possible ABBA deadlock in the SB16 driver in Linux 5.10:

In snd_sb_csp_stop():
876:     spin_lock_irqsave(&p->chip->mixer_lock, flags);
882:     spin_lock(&p->chip->reg_lock);

In snd_sb_csp_load():
614:     spin_lock_irqsave(&p->chip->reg_lock, flags);
653:     spin_lock(&p->chip->mixer_lock);

When snd_sb_csp_stop() and snd_sb_csp_load() are concurrently executed, 
the deadlock can occur.

I check the code and find a possible case of such concurrent execution:

#CPU1:
snd_sb16_playback_close
   snd_sb16_csp_playback_close (csp->ops.csp_stop(csp))
     snd_sb_csp_stop

#CPU2:
snd_sb_csp_ioctl
   snd_sb_csp_riff_load
     snd_sb_csp_load_user
       snd_sb_csp_load

I am not quite sure whether this possible deadlock is real and how to 
fix it if it is real.
Any feedback would be appreciated, thanks


Best wishes,
Jia-Ju Bai
