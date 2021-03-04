Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941F532CBC7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 06:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhCDFPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 00:15:05 -0500
Received: from mail-ej1-f50.google.com ([209.85.218.50]:43130 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbhCDFO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 00:14:58 -0500
Received: by mail-ej1-f50.google.com with SMTP id p8so20583416ejb.10;
        Wed, 03 Mar 2021 21:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSIypw1gJds7lAPyMLE7FS5X4k+fvlO0M2Uln3WKofI=;
        b=IEDe16jnhyW+cWqA0dPLFBKF0U04iVnQ2rVMKb6ki7lizaC1D14HSTsk5WEv+qVgLj
         N8CpO2jbLttKSdOyjgmc/YImkgnnUpY7osTSZR2orrBj4t5g5LSspEniKd33lJri+zrO
         a/WkvA7mgyOUnPK/B4m9CLmNFYJF5SqPoRflb0SiF5nDLEKetbcSCalSA7iyanlLfEpW
         LJ92Hso3mPOfKlMyR9CeKLpy0dxGCOL+ZUo3810eK0MIojtGgyka5TMwFS7hi2CQE89Z
         87oLBEUVuPrwNNNXUdWlYtr57MdxJ8bJd0MbfGAlDlS9fYHEj266Kij/G0eZ9H11zsET
         TxLQ==
X-Gm-Message-State: AOAM5311vNSbvzaNtznyQfq/rcFFY5e9He+vJBueJKk2c/YX1Bm63oy3
        y4yAF5aehQmyzTWzdV0S6wpNFyBtrSrPKshJalY=
X-Google-Smtp-Source: ABdhPJzRlgTmF5hN4QBDxejbDzbAXOew/il/TLHwchMUXKBA6NZGM+g9jAoz+gnvE3T1HudvDor7ZtiuQA8jvNEbubc=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr2361861ejx.168.1614834856800;
 Wed, 03 Mar 2021 21:14:16 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1kwk0h9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1kwk0h9.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 4 Mar 2021 00:14:06 -0500
Message-ID: <CAPig+cSC8uNfoAjDKdBNheod9_0-pCD-K_2kwt+J8USnoyQ7Aw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.31.0-rc1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 7:23 PM Junio C Hamano <gitster@pobox.com> wrote:
> Pratyush Yadav (1):
>       git-gui: remove lines starting with the comment character

Is there some way that this can be removed from v2.31.0 before final
release? It badly breaks git-gui on macOS[1,2] to the point of making
it unusable (Tcl throws errors at launch time and when trying to
commit, and committing is 100% broken).

[1]: https://lore.kernel.org/git/CAPig+cT-sfgMDi9-6AEKF85NtOiXeqddJjk-pYuhDtTVAE-UEw@mail.gmail.com/
[2]: https://lore.kernel.org/git/20210228231110.24076-1-sunshine@sunshineco.com/
