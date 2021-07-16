Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531A93CB8A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbhGPOVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhGPOVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:21:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB2CC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 07:18:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ca14so13234408edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y2DHnDO22YqXsXeeLtUzFhSLKp3spjaHgmh9Z0w22wE=;
        b=nAwHoNJCgNBJrjooT/pq6cKj5ezaLiTG6eQum1zK1S8Lfu/oQRbSuKhKt5Qr5CZ3wJ
         PHq/044G7aRBnQdaNWKsNE/nGzPmYdKGfQJiFXy3b7KJ7RZOY/X7YX4tM+Cvb5wE5Vci
         uYdpswvj5m9d7U1QWQckWXEGZzV21Z2PHz4Mk9FG3RE4d4M+EreyUm/xaPibV0My9RIr
         efutkjdYQtzo8HMaKvdWcgesta+PxZy8+o9w968ejPuI+S/RdlmVgnC6p17YgpZdimYG
         N5zCJHVvK0TIE0OZm/hk1MFtOGV4AFPf7MAo+knifId0NMp3EM0D2j9O9xgEUYSccLCS
         cXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y2DHnDO22YqXsXeeLtUzFhSLKp3spjaHgmh9Z0w22wE=;
        b=g8DKLRVxoHjwYebu8kLsWfegfCy1SyxKfULIuKVKt/0k6DvEfbcuqkzzauzE5J7vxA
         LQ9JctIhVkL3hapq2/dyuYlOKSBhND2MLOmaiqVXh7KckgmfIgmEsczPaZnfjVcbkGZv
         7sSNKTdMKCfxH0nyX/LtD6QYvktdxahfyQ0qiNz3jy5x4/Cev/Zg9EHZJHYXWZuxCyoT
         EuiRe4UafHPmlL5QCxMpgCWn16ZWPaFvOlehAnutXQbbwFDj8YfvOOU94T7fgJYRh3lG
         xQlksZK7mkxDoak2AlBDT5SN2rDpO2PdBzQF/H1hUzFNZEQ93BwhlkK9AW86wMdq7yX+
         6KxA==
X-Gm-Message-State: AOAM532WqQ186EUB3MwVc5euJ52vbjFKJTGikNVgyzT89vQNKT8SLLdI
        OzELiS/E3Z/qGgaYqs4RuIc=
X-Google-Smtp-Source: ABdhPJxAktE2IHu/2kusi+pGfUT4k9rc87m70DsVtpGiIrNA2FEc7+pl7kFxP7BMho0fzIb1D3VAMg==
X-Received: by 2002:aa7:d84f:: with SMTP id f15mr9558676eds.216.1626445123594;
        Fri, 16 Jul 2021 07:18:43 -0700 (PDT)
Received: from localhost.localdomain ([5.176.51.215])
        by smtp.gmail.com with ESMTPSA id a4sm385132ejr.101.2021.07.16.07.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:18:43 -0700 (PDT)
Date:   Fri, 16 Jul 2021 17:18:37 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        syzbot <syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in profile_init
Message-ID: <20210716171837.69bcc1b6@gmail.com>
In-Reply-To: <949a12a0-a0a6-0574-4e87-4ed196ff6d78@i-love.sakura.ne.jp>
References: <000000000000610af005c714c1d1@google.com>
        <20210716152440.368d4250@gmail.com>
        <949a12a0-a0a6-0574-4e87-4ed196ff6d78@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 23:10:25 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> On 2021/07/16 21:24, Pavel Skripkin wrote:
> > But this function can be called not only from sysfs and I can't
> > understand will my patch break something or not. And, I think, error
> > message is needed somewhere here to inform callers about wrong shift
> > value.
> > 
> > 
> > Thoughts?
> 
> Subsequent profiling_store() attempts will return -EEXIST if
> profile_setup() once set prof_on to non-zero value. Therefore,
> if you try to return -EINVAL when profile_setup() returns 0,
> you need to make sure that prof_on is set to non-zero value
> only if prof_shift is valid.
> 
> But, the userspace might not be aware of the value of MAX_PROF_SHIFT
> because it is an architecture dependent value, and par might become
> negative value because get_option() accepts negative value.
> Therefore, it might be better to
> 
> +		par = clamp(par, 0, MAX_PROF_SHIFT - 1);
> 
> than
> 
> +		if (par < 0 || par >= MAX_PROF_SHIFT)
> +			return 0;
> 
> .
> 

Yes, this sounds much better, thank you. I will send reworked patch to
syzbot. Do you mind if I add 

Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

tag to final patch?



With regards,
Pavel Skripkin
