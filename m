Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFB34E090
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhC3FIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhC3FHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:07:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF11C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 22:07:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w8so7116691pjf.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 22:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=D6RX73L1stgYWvYfUjXfH9nUeLArVwqYEE8k8Kohk2o=;
        b=vkS7yzx2kUSiFhvokAA1TDF14aAab2V/mDJlC2TZsgk23EIfFsTIzjVcpgHXHqJCcG
         dDK6hxbEH0IstblMbaJlDhEmizAHw5+BWEDd1n5U9FItcfCa5IIvsEmtUJG7uBywpO6s
         pCpm8ZetvZeKBudaxEX/3IF5JJ35tDgDBrcbGsm4oD89xexggremJbrr7A2L77KD1dZf
         17HhkWMFOGoR+QJz4FnhTClV+AlJePmMnzBsc1mP+z8HUW6jtjZbA6HIE1Asl4bn6ef2
         B6re8AplkYunj6whhPQa3XKW5nzoYs1qPKQ8J6Y09sMdzlEaAfLPXhft+3pu3MwxUYTo
         2sKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=D6RX73L1stgYWvYfUjXfH9nUeLArVwqYEE8k8Kohk2o=;
        b=ta0rKNvyyvTrSlYxSKCUHVZfvSeVibh69upD+GHubmyeV6mdP1sCSySZHOZyfl4eqx
         VyCj08uQ6YcUmLe40wyMiC/XfNOQ0JcJerhtF2ZqqOPFdkP5sgnz+QI23pEbqmHZ1j1b
         BXmLXeMsfiey2J9kF4DL4f4it+HpF8qhIELgatlo1Lh2C1/s7xJlRVDMZ4FzlrwHaMmH
         OVCUDEhxRMIIYDobwVYo29Vb/zz5u1DyTq54RlI8aURq6Y+CnQ8xwVuBO7hIMLDa5ACz
         PnwtcraAd+yjfxWwqUG7tHRsIokW/SQvnNKlyCO+1uVwdT3JwSUz0X+ni2dAM84rI3q0
         EFdw==
X-Gm-Message-State: AOAM5331+Bx7YyJSSPzLAxPv6OHpJb6HLcwr5ZRWAK525N/3cYp8Gp+f
        h7MgIXQEkC9D1ilPib9EsWTrhk3FToqosg==
X-Google-Smtp-Source: ABdhPJxOMS/xpJureu44VvyywEZSKLnMsvLurrdxGN3jowDiWSfuDfYkKiBEfsNsSwdLBIrKIu1Uhw==
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr2675534pjb.46.1617080867717;
        Mon, 29 Mar 2021 22:07:47 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 25sm19101666pfh.199.2021.03.29.22.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 22:07:47 -0700 (PDT)
Date:   Mon, 29 Mar 2021 22:07:47 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Mar 2021 22:07:38 PDT (-0700)
Subject:     Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
In-Reply-To: <20210316193420.904-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, dvyukov@google.com,
        linux-api@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-885e3a79-49cf-42fc-8561-a52c7b7e1ac6@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 12:34:20 PDT (-0700), alex@ghiti.fr wrote:
> Increase COMMAND_LINE_SIZE as the current default value is too low
> for syzbot kernel command line.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/include/uapi/asm/setup.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 arch/riscv/include/uapi/asm/setup.h
>
> diff --git a/arch/riscv/include/uapi/asm/setup.h b/arch/riscv/include/uapi/asm/setup.h
> new file mode 100644
> index 000000000000..66b13a522880
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/setup.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_ASM_RISCV_SETUP_H
> +#define _UAPI_ASM_RISCV_SETUP_H
> +
> +#define COMMAND_LINE_SIZE	1024
> +
> +#endif /* _UAPI_ASM_RISCV_SETUP_H */

I put this on fixes, but it seemes like this should really be a Kconfig 
enttry.  Either way, ours was quite a bit smaller than most 
architectures and it's great that syzbot has started to find bugs, so 
I'd rather get this in sooner.
