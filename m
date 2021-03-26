Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13FC34ACE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhCZQxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhCZQwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:52:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71582C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:52:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h10so7028772edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDbl67tvF8OovMe6VinvfdUCa6x5BHz6kSSiYldWfJk=;
        b=Qbs0yBiRKtLJ2KCXp+J5GjFs4U7GpBFybUduP+k8nrWQYJgbtVExVU4UwQR4b8omfK
         IhQtGNsPwO5LMmxMomfTaoid94NJ48p0lr1aamzf8/ZKeFpZ1gozChEU1I1LnbfV8hP4
         q+MArBckr3rjae6N8Io62zJ1K6quOqC+kwsDboStUB5TCtsuaZOg+vBI5Sh2FQbZ+e2G
         E54wiErhTqoQfRBfjBdh9xg3qicNLT0hQfdZifnzg8nZYoFxkDcmgIpdQSB8VEF8tfM5
         wUfvWNap/TrQ5ZCUz5nguKaNP2x+voyxKym/BW3wv+6Jd1nscxtX8VHc9xPjP+YIomdn
         Gltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDbl67tvF8OovMe6VinvfdUCa6x5BHz6kSSiYldWfJk=;
        b=jTWOvKSSCg6SuVi9Dr2h2LJNemU4lqJM/p6Ipb0m/81sX/oaHMR+DI/OVxdF9hag9k
         z+OWIzZ4PdBmGTY5Ao9cl5lABUB13NFTz3Oklce+03Ok5pLJceLu/1swYDej2JbcVY/O
         cdhfpAOEuvQ6Ri45uGUz46OsL4QineA3RuCxKVntIb0XWzo9W/n/2ID1Kr8snq59Qj5R
         vjwrD+2thUP7rULxfNLQY3hA8BHkwzubonOZiK5NfASzJGMbjX8XTz4YIFT3ib4ZG7fS
         ciycjGcJM7qrmwAX6On5kSNbMMedHca/pW0jnDOOlr1/JEF3o+0vnCiZGuLBGvl9xzfw
         wuSQ==
X-Gm-Message-State: AOAM533pVgQb+3LEaD5MpyOK0bEqcKXE6mmEkQu5+EdrQCF4g3ibo7+Q
        NjsOue8MHV2QLKBf8ua1L85OaiSYVL/L6iwFC4s=
X-Google-Smtp-Source: ABdhPJxG5L4xR1xkmSPVaNGmo7Cuk/Ev2JHNRDjqvio+PhFTxUUSX39pjPdtuUkWh8A714ubgmde0lHlDX6qUzKtj0s=
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr15875581edb.71.1616777566087;
 Fri, 26 Mar 2021 09:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210325040832.26018-1-unixbhaskar@gmail.com>
In-Reply-To: <20210325040832.26018-1-unixbhaskar@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 26 Mar 2021 09:52:34 -0700
Message-ID: <CAMo8BfJarLtN1mU3MMSeRik17k13MAFK8fP+E2SHkcHdLnLfUg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: Couple of typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 9:09 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
> s/contans/contains/
> s/desination/destination/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/xtensa/kernel/head.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, applied to my xtensa tree.


--
Thanks.
-- Max
