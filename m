Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3440EB83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbhIPUSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIPUSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:18:40 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2D0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:17:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b15so4787569lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWrZXTMMEqJtqrGMGepc86HxXmmszewV5GT+dchm6nE=;
        b=a+yaa6b3Vz/aWhJ6PBuJI4QWj7FqZSfl7CICaqyFPJCb2Fl1X9ECyQTS011hVSPuQY
         tvEr/Nvpx2uA+FO1SRfqZ51Q5eHmF3E0XVSEImc+B8hRPLEvHvliEoiC3qaDCZyG2spq
         0IEoPJI4w0I5e08bXCu0DAGQhQBZLJpHxp+nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWrZXTMMEqJtqrGMGepc86HxXmmszewV5GT+dchm6nE=;
        b=kV/LAenZJqTHcGT6NuvFZKLP/OyY4x4q/0cmBYWU1V0bgicai0HaKUilULfGLW1J5D
         USA6d9H8v9wXFZ5Q4c3j/gTiZGWF3XU7KF6RJPWNGou9ve/3Xp1esGZoBrJ6j/fjcGoQ
         tnD/K5sjZmUIf6g3dqAGDumSpAYIhC6oxJfvzwMekRX8xu/CRmeG3/OQHof+SUay9hWv
         QhjXOUvwFNuUAPxos6WiSqBZ/trqNLjVmG9t/aM3Wuf3rJxfeW3IuJBuHRxmM6stxfQ8
         r/rzJNSezKtxuw7dvt11CFgQ8JuTYtFugDiXCbtD7BilZELBSI0ftuGvW1HcjLhv3zoo
         wIbg==
X-Gm-Message-State: AOAM5314U9RgRz6VFOnotERmjQeZE02mYPoEGDQLSeRSJzqhn5Amnwod
        FBkIZFnudVLnF4oWhl6XY3BvpWTxFw45LW4bIJc=
X-Google-Smtp-Source: ABdhPJxpZCSbNtOABf0vssHTVt1OwPWPsbIs7dWM3JEpvQWSg8wYldmBj1YnEkMGBiIcyusto1Inkg==
X-Received: by 2002:a05:6512:3405:: with SMTP id i5mr5308512lfr.396.1631823436925;
        Thu, 16 Sep 2021 13:17:16 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a25sm436797ljj.109.2021.09.16.13.17.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 13:17:16 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id g1so23356442lfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 13:17:16 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr6219496ljg.31.1631823435793;
 Thu, 16 Sep 2021 13:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <163177338366.682366.5998343833719057348.stgit@devnote2>
 <163177341667.682366.1520674275752512771.stgit@devnote2> <20210916092630.48e01b5e@gandalf.local.home>
In-Reply-To: <20210916092630.48e01b5e@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Sep 2021 13:16:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsST9kbbDf9a3pa91jaPS-of2fB5L2808APd1mnMpCPQ@mail.gmail.com>
Message-ID: <CAHk-=wgsST9kbbDf9a3pa91jaPS-of2fB5L2808APd1mnMpCPQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] bootconfig: Rename xbc_destroy_all() to xbc_fini()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 6:26 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> I didn't know this was a thing. But looking for other use cases with
> "*_fini(", there seems to be plenty of precedence in the kernel for this
> change.

I wouldn't encourage it.

It's an odd compiler thing, where initializers and destructors are in
'init' and 'fini' segments respectively.

It makes absolutely no sense in any other context, and the fact that
it has bled into kernel usage is not a good thing imnsho.

Honestly, "exit" is the normal prefix/postfix, and is actually a real
word. As is "destroy", used elsewhere.

So I'm not going to NAK 'fini', but it's a completely stupid and
pointless thing to use and there are better character sequences that
aren't any more typing and are real words.

          Linus
