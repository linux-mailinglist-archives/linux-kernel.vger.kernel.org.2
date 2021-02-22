Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16FD32101F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhBVFGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:06:41 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:46850 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229487AbhBVFGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:06:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UP9fL7J_1613970355;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UP9fL7J_1613970355)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 13:05:56 +0800
Subject: Re: [PATCH] doc: use KCFLAGS instead of EXTRA_CFLAGS to pass flags
 from command line
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210221152524.197693-1-masahiroy@kernel.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b1d148cf-5264-54c7-1b6a-b0b4a5e866a1@linux.alibaba.com>
Date:   Mon, 22 Feb 2021 13:05:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210221152524.197693-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>


在 2021/2/21 下午11:25, Masahiro Yamada 写道:
> You should use KCFLAGS to pass additional compiler flags from the
> command line. Using EXTRA_CFLAGS is wrong.
> 
> EXTRA_CFLAGS is supposed to specify flags applied only to the current
> Makefile (and now deprecated in favor of ccflags-y).
> 
> It is still used in arch/mips/kvm/Makefile (and possibly in external
> modules too). Passing EXTRA_CFLAGS from the command line overwrites
> it and breaks the build.
> 
> I also fixed drivers/gpu/drm/tilcdc/Makefile because commit 816175dd1fd7
> ("drivers/gpu/drm/tilcdc: Makefile, only -Werror when no -W* in
> EXTRA_CFLAGS") was based on the same misunderstanding.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  Documentation/process/4.Coding.rst                            | 2 +-
>  Documentation/process/submit-checklist.rst                    | 2 +-
>  Documentation/translations/it_IT/process/4.Coding.rst         | 2 +-
>  Documentation/translations/it_IT/process/submit-checklist.rst | 2 +-
>  Documentation/translations/zh_CN/process/4.Coding.rst         | 2 +-
>  drivers/gpu/drm/tilcdc/Makefile                               | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
