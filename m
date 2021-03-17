Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D24233EAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 08:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCQHzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 03:55:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhCQHzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 03:55:01 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MEmMt-1lTGeG2Qn5-00GEn4 for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021
 08:54:59 +0100
Received: by mail-oo1-f42.google.com with SMTP id n12-20020a4ad12c0000b02901b63e7bc1b4so342161oor.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 00:54:59 -0700 (PDT)
X-Gm-Message-State: AOAM532+DucYiBdWiglc/4NY4Mve3PFJemp4LJ+SB5zV0kcJBzszkfAL
        beITd6GlTKpdF7YODNueX/dOKdzClxmSXfJ3dFw=
X-Google-Smtp-Source: ABdhPJzZdnCKyGkix2AX1KZ8MvuG4J0YDH/ajg643LqQK/un1mnEh1NJMcHZybuhM8IY5iaf1gLAfwPJHLlkz96pFRA=
X-Received: by 2002:a4a:e9a2:: with SMTP id t2mr2259266ood.15.1615967698408;
 Wed, 17 Mar 2021 00:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <1615966419-20549-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1615966419-20549-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Mar 2021 08:54:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3V=nhE9o6qvmjAHzakQesT9SWniRHW3mCe6Q+kd9J2PQ@mail.gmail.com>
Message-ID: <CAK8P3a3V=nhE9o6qvmjAHzakQesT9SWniRHW3mCe6Q+kd9J2PQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched: replace if (cond) BUG() with WARN_ON()
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Jeremy Kerr <jk@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WbvoJvkq4gTEpqyzcJuch8EuoqB5Oa5f/Lh805kHeZ0T+D9x1Mk
 raoJxf8GgG7f0doND+RomVG1hdqkWahpQUF4BCfsyE7i35Fp8+Qkz3vPugyxOS41Jq+2U8E
 R7M2S+q1rlpv2SusOacJs64oS+VoZYTT9WmucUxcxPdZYR/BADBR2byIxAQrsRltIvw5NTH
 VzVy+4mz5yZ0EwiomRsgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4rQ/fZbXcnI=:+VnbZpoX532ymUdm5WBHvK
 J08VEsQeXrOj1WFadhi62I+8xizG3EznDYtrlfl6HzM4mSfhSzyngUqXzKWJBsc5oSMobQhp1
 s7oOHH1dYQUsfEJ9M6jMD9+/FdW/gFlxYFC8SmQk1KFIwJzpTV8Hvk5dCyVGPH2kdqr4qpeHH
 bjNeA1WLcYiu3jkV0+lAlr+pwN4VlTmZBiZMTgrWHlhXlbq6+B2olUR8AQIiDJ4ZRx4z9dI8S
 vPi+Jqp+nyzymY27eS7YUDdbczxYeI3BQF/P75TU3HyBTJ3OYRUN29syaIAUn08534hJTQFlj
 zJsqgFgAacZNV06nSOYnDEsWOpSQ5iMZSMvKxtcbq9g+o0ZXFifZVkEwkYF2NTga4ApT6H9qz
 3YV6UU21O00yx2/M1hJzvTVOY49KYXkaZkQ5+TEJ9rY+nvKUdVPmcK3960TaL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 8:35 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warnings:
>
> ./arch/powerpc/platforms/cell/spufs/sched.c:908:2-5: WARNING: Use BUG_ON
> instead of if condition followed by BUG.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

If you change it from BUG() to WARN_ON(), you should explain why it's safe to
do that in this case. Here it is not, since the following spu_release() will
end up making things worse if the acquire failed. Also if there was a signal
pending, then spusched_tick() will just get called again and constantly
print these warnings.

There is probably a way to use WARN_ON_ONCE() here, in combination
with a way to terminate the thread safely, but this has to be done carefully.

       Arnd
