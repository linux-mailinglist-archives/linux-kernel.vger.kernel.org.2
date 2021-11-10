Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B83C44C018
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhKJLZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 06:25:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhKJLZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:25:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B80D610F7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636543338;
        bh=JJEJ0tHHeGp+FP6EO0A4+0isjqnnyVA1sF9pPEwkcb8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fZDX777AunbNc7BpUBb3G/P+dYnJPeLi3mCVbJhBuwHkqBkuyEWBxjBXYRI4RVfZH
         OiijF5xISe16ibxPIjXZD9+M2MgwWw+Dbcs0g6fpCXH/XTHiCBjAig396CiwyzlUu3
         SymqqSZh8BzW5SzQRrhAcyzJYcMzklDjhtA/37amX7c7W+W3DWrLhqufHfmQI868/t
         D0HVSbXj6mf3SLgiQbDvPSThc3gGZH8S2CsrOd3RROzM4+ELXyl6cPuLfq7X7LZIme
         vKEhTKuGkX+GXXTkEji9E2psMoP+ajAqqv1WKdTpfJOa8zl4UBc97kGLlx/p9ieEW0
         NAq6g5xIKExuQ==
Received: by mail-wm1-f42.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso4312334wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:22:18 -0800 (PST)
X-Gm-Message-State: AOAM531/8tLLO2RGPt1wUt+kZ0UCuLatbvqjiqzdGitPjRLLP00SP0UA
        ifWTg22JpYReFiE2YazJJ+htV2Qs/LfHuXkImxg=
X-Google-Smtp-Source: ABdhPJydqYb7KoxStdvShqfhu2/xlA8MazV4FnrWc6e0xf/9uc3aRIL7BPop+KiYmdHuZftW8IFAZoVjyDibbJWJ55E=
X-Received: by 2002:a1c:2382:: with SMTP id j124mr15209276wmj.35.1636543336974;
 Wed, 10 Nov 2021 03:22:16 -0800 (PST)
MIME-Version: 1.0
References: <20211109123621.52474-1-arnd@kernel.org> <20211110110038.GA4048@quack2.suse.cz>
In-Reply-To: <20211110110038.GA4048@quack2.suse.cz>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 10 Nov 2021 12:22:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a23tbPkA5Ay7tNnh=BnE=F9REEi9nQ7CTES3M6hcHRgng@mail.gmail.com>
Message-ID: <CAK8P3a23tbPkA5Ay7tNnh=BnE=F9REEi9nQ7CTES3M6hcHRgng@mail.gmail.com>
Subject: Re: [PATCH] udf: shut up pointer cast warning
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 12:00 PM Jan Kara <jack@suse.cz> wrote:
>
> Thanks Arnd but the problem was actually (mostly theoretical) problem on
> 32-bita archs and furthermore I've realized it didn't completely fix the
> original problem either. Yesterday I've pushed a different fix to
> linux-next. So the warning should disappear.

Yes, I saw your new patch and it is definitely a better fix.

Thanks,

        Arnd
