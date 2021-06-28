Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413923B5A15
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 09:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhF1Hyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 03:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhF1Hye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 03:54:34 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904DAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:52:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id v15so1576652ybs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C0yWlT/4HPYEjhQwQo23/zNO+SRVMntY6s55i1EBsOM=;
        b=TPdi5Gn44fq763ifqFU+ipTI09hYQkCaeTMI90cYgZJZ0SvHzv9MJGB7jcmozXHPcd
         1ykfWviKegJgNcxd8A61lNNvVQnObQaD2MpnTe1Nlez8lwCCLzRJtDWWfKJBobW+JGZd
         ZsxbLW2Iz2EChGhAZXvooXUFT0z+LwFeXgpyW+cBOjJFEXjMzDXn083tLHsYZqsBxqTC
         pGi70QXirjTeHKZWQdrx8xfi2t+DqrdW2J5LlpaqFywwCGNV6iS0zQFVW7pZpaxvv3Ks
         omfewZxL/MsI7iwRNbvIFJk8cbTK/uotO83eD++Qt5vF7hLQ8D264t8eTdHMPlPnPfjh
         tSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C0yWlT/4HPYEjhQwQo23/zNO+SRVMntY6s55i1EBsOM=;
        b=QBrCx/cwfbHXCiLitYws9J183JVt1t8Ij2/uZBWtgl1WyAYpxDCUKJRhpo4yPfo5kH
         Nt1utajX/zRrES7HChahOzgYRNaPDgu/Pr0AlIDzLpJQc/FB/2mUbgIodBclhP+7Do7J
         DlJcPdWdUv+wx15EEmE1V7pSIH1qGGYeLFzcX2NTrCz0AheFBx5SNeUO/JEIpM3tav1u
         S2ItiqyZIOFQPUrErk3PJ6cZzwIXMrwmmopiQZYEar8EhXyS89BaE/PQjQ2clfXZy1xi
         WAjPrKS4tV+N5lWJz9Jm41OFV8xbDtBFiPiB0DukEusDYuorXm+dQUehtm56kySO83J1
         qJtw==
X-Gm-Message-State: AOAM533PwpdxcWO9VfQxbCxj/v3Dy2KtKeOqPNonrbPVAGSs3fuDwcEy
        B36aDUPrcdF0SP5pHRKytp4EsYEYwqYm0kUUkNcUCQ==
X-Google-Smtp-Source: ABdhPJxOfQ2Xrwu5SBrTBwKf2SKldv8YOQmxZTGiOK7rSlkOQ8Kk25Nd7UQKDoinp/oZ8/D0c9ltvOlcLXLcdCy9ZJw=
X-Received: by 2002:a25:2589:: with SMTP id l131mr6712420ybl.451.1624866727866;
 Mon, 28 Jun 2021 00:52:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:30b:0:0:0:0:0 with HTTP; Mon, 28 Jun 2021 00:52:07 -0700 (PDT)
X-Originating-IP: [73.70.188.119]
In-Reply-To: <20210509000103.11008-1-mforney@mforney.org>
References: <20210509000103.11008-1-mforney@mforney.org>
From:   Michael Forney <mforney@mforney.org>
Date:   Mon, 28 Jun 2021 00:52:07 -0700
Message-ID: <CAGw6cBv2NBCDrZb7ZnmAhZOJ_EwgW6tR-8AfY2v=T9OkD=6O8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] objtool: Check for gelf_update_rel[a] failures
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-08, Michael Forney <mforney@mforney.org> wrote:
> Otherwise, if these fail we end up with garbage data in the
> .rela.orc_unwind_ip section, leading to errors like
>
>   ld: fs/squashfs/namei.o: bad reloc symbol index (0x7f16 >= 0x12) for
> offset 0x7f16d5c82cc8 in section `.orc_unwind_ip'
>
> Signed-off-by: Michael Forney <mforney@mforney.org>

Ping on these patches.
