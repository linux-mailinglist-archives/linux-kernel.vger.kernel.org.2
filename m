Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D1309A05
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 03:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhAaCvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 21:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhAaCvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 21:51:36 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF99C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 18:50:56 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ke15so18814730ejc.12
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 18:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUPQkjW5pYAAUYX4jIZLQH5E02MdUbc4NK9n0fOKeiQ=;
        b=kIcIJ8aOokcICYWuOxJ9c7LZkX4eYflIkvTt6cAtCXf8wI9DXPpCMQ+JYpvka9We3K
         vhfhuofSYaqpKSNbPiUp0U/DfT8hn3ESDgz/RWbLs+eaD4+3/XtCeSSmbkydwXAO3DE5
         S4+ZSuM60kQFe7Px4f5Jf4gjOCweEPSHoCN86HBhOhbEfJO1TdtST7KtE1EoRlzb+GFU
         TQoxYBeLPknDIFjjiSLVBTMWSrF73aqxw1sEi9Grocrk7d4n3SLVC+XBrOgX/w55Ynfi
         W/YIM/B24VtWX9zi9pmxJvntV7q1TvYnSwHY3YaLkUNB9okkApBKVT5q06tBKRW9j6X3
         2yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUPQkjW5pYAAUYX4jIZLQH5E02MdUbc4NK9n0fOKeiQ=;
        b=rqQBaccOtOO2egCnRysz5Rg+itXbGRc+OC1khSD4eZEBhbdPTun2hCn4OvywCsSXx3
         zb/uMgeXeX1TWj2nXMyIctKPrjMGfPULZ0wbnMmAnFH8r8MYUXsS/AqEZpEqleTH5JuV
         nKp3HwuqByatQGY3LIplPvWuEDq1TIDkhM4xMoAiEDg+QItoerbkO72zhWeHV3PZ02Zx
         y2dcEAOUVpJGl+K1+zY2eBKFKNNsIjl5+56YJyg45JIaX+ocDepbCwDWHJlR2R95V0v6
         9AdoRaqm+OPbwDFnJohXKt9QsMj9yXa9ODPB9mG5Bu6bAqA8l2LM6XtACglE6kN1Sm6i
         jNDw==
X-Gm-Message-State: AOAM532eEGhi6+sW+UTRbyWplsR+mlUScUxkfpF3xmJQ6Ugcuemh64Lh
        Wn0AdEpjPu+T9v7QRGJrcS/zML9/O/+cLUTJiT2bRQ==
X-Google-Smtp-Source: ABdhPJw4mJLkvojrXjkouJld8U67wqAoO95Mt8cBJsHC+kcE7bawKdMg8+GhVRaAfgw+D2BiCGFIRFuuA6xi+YQ1Yms=
X-Received: by 2002:a17:906:2454:: with SMTP id a20mr11390025ejb.203.1612061454725;
 Sat, 30 Jan 2021 18:50:54 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoL4=6L16Nxi4TW7Jt8dqNXBQTvZZOqBEBRRcZdHCQ_VA@mail.gmail.com>
 <CAHk-=wjqzP5UuZ4=F4ok18R5_1_vAZw9m_3G-W9Eodc1raM3TQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjqzP5UuZ4=F4ok18R5_1_vAZw9m_3G-W9Eodc1raM3TQ@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Sat, 30 Jan 2021 18:50:43 -0800
Message-ID: <CAP045ApxLJ7vXOVp5Cwx7WEyDr6v01D9YD3xGFDv3WAp6czaMQ@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 5:56 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jan 30, 2021 at 5:32 PM Kyle Huey <me@kylehuey.com> wrote:
> >
> > I tested that with 2991552447707d791d9d81a5dc161f9e9e90b163 reverted
> > and Yuxuan's patch applied to Linus's tip rr works and passes all
> > tests.
>
> There's a patch in the -tip tree that hasn't been merged yet:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
>
> (there's only that one patch in that branch right now, commit ID
> 41c1a06d1d1544bed9692ba72a5692454eee1945).
>
> It should be making its way my direction any day now, but in the
> meantime if you can verify that it makes things work for you, that
> would be great..

Right, I'm saying that that is not sufficient.

41c1a06d1d1544bed9692ba72a5692454eee1945 does indeed fix the bug
introduced in 64eb35f701f04b30706e21d1b02636b5d31a37d2, but
2991552447707d791d9d81a5dc161f9e9e90b163 introduced another bug that
remains unfixed.

- Kyle
