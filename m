Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21264386F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 03:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345914AbhERBhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 21:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345904AbhERBhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 21:37:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37095C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 18:35:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v8so6614788lft.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 18:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Y4UC937pcRi6mdp2HazCoUPjtNxk9PJkqRxwraum1Y=;
        b=gqVqIx8Ym2P95cU1nEwsXDnOMInJKjvLvl6PdHm+m4USuWxwS7QapJ/4AnjrYoQgjp
         Ul+p1xz0jsBYnf7HxkvT5KEQQnHy9T/2McLKcqfpIWocA0q+0ATrVtMzn0XcOX6uS6dk
         /MUMbUdum0s43SXkfV0oQ3/kVHBjAyHYj0f2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Y4UC937pcRi6mdp2HazCoUPjtNxk9PJkqRxwraum1Y=;
        b=cQrPLUtL9f95TdoygjUBoEKqonYOoyxitDEH9FQmQCNP6H162WF27BWKzrOQK39+nJ
         7TCdtSqxBD7TTbkY4XS2t95sjTkPEMU02EW+AH7u6QNlh5cjEd7WaOUC35GiWPT3N0E7
         mJH1NoHquZPC+wLOrGnk7kYlF/v8xyfgN3ViYzW9TfJ8VB9mBLpS7pU+maXJi8tdbxpt
         uPQ9WoZgZbcp5U6rzTlFG2V2a7+jqUQOTLqXYwkizCREo153RYVMC3nC643y0MqNiDbu
         K3bUk0gZCpvaRo3xrvA7OJecxP51QhTwBjOg8nEY/qphJZufLYTAn2DHWBy7WJHTDrnQ
         J5dA==
X-Gm-Message-State: AOAM530Fxu9NMTe7ceBmJWBs9Zv9fgys4sv9huZHtPeruxBIPjAyUxiE
        5DxJtVhvQdEQxJKKJbRXYRt7O9PxU62tzcCg
X-Google-Smtp-Source: ABdhPJyl133unQm+lGBXXNkqCXhTw3ILe95MZyihWUcdMtSEkOYgzjq0M0Gy+4wkDvPpSiN6zv6Hag==
X-Received: by 2002:ac2:418f:: with SMTP id z15mr2132927lfh.2.1621301745518;
        Mon, 17 May 2021 18:35:45 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m17sm2114060lfh.146.2021.05.17.18.35.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 18:35:44 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id w33so3631621lfu.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 18:35:44 -0700 (PDT)
X-Received: by 2002:a05:6512:36c5:: with SMTP id e5mr2066552lfs.41.1621301740633;
 Mon, 17 May 2021 18:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210518010940.1485417-1-sashal@kernel.org> <20210518010940.1485417-5-sashal@kernel.org>
In-Reply-To: <20210518010940.1485417-5-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 May 2021 18:35:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whw9_rp0NYTsCqcGnUkcV5Qgv7FTxADtPrdq4KFmsj+Lg@mail.gmail.com>
Message-ID: <CAHk-=whw9_rp0NYTsCqcGnUkcV5Qgv7FTxADtPrdq4KFmsj+Lg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.12 5/5] tty: vt: always invoke
 vc->vc_sw->con_resize callback
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 6:09 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>
> [ Upstream commit ffb324e6f874121f7dce5bdae5e05d02baae7269 ]

So I think the commit is fine, and yes, it should be applied to
stable, but it's one of those "there were three different patches in
as many days to fix the problem, and this is the right one, but maybe
stable should hold off for a while to see that there aren't any
problem reports".

I don't think there will be any problems from this, but while the
patch is tiny, it's conceptually quite a big change to something that
people haven't really touched for a long time.

So use your own judgement, but it might be a good idea to wait a week
before backporting this to see if anything screams.

          Linus
