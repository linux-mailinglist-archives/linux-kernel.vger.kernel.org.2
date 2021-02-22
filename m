Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB68322255
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhBVWqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhBVWqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:46:08 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40765C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:45:26 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h19so452469edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r7EOmcELM54UmBvApMBLdEmUEKDMh6qMssHdlFfkwGs=;
        b=d9XI9NKAdnQUgNlRYZBN0ZMIIfpSm1OKH1zyzI/Vkm8Org+COfvN9rrWRSaY0OwMtj
         0MSoqlsN/JtQLNk7i3pGVbZ8w+EBUMGSh5ktQZz7JRYQ4XKzTp810rS1z4q9D8IqBu6M
         mztM40DrDDZEkydB2ejwi0K1qqZ/Ec4RHWtec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7EOmcELM54UmBvApMBLdEmUEKDMh6qMssHdlFfkwGs=;
        b=BIoBBfy8MamVwIhgN2W4MbIDUCubXtmgsfno3JTRfoB/s388e/VT5JTHn5Lv+QLcuM
         nDMKnBnI1w/wIpr2zaZwpapMca/dGKJQIi3/rsStJwsCSYjtoFdIWPcZInGRjqkyL8zT
         7zX/0vLiscMM52DwqCfZN68pXGY8BNpG5BgFR1lvzank5g55ixYqpvU2vWN1ixvBRwkv
         EVlP5zWJbYNyg/bZxdko0PJ+8TWaMLk/QmryBoMJVf7nQKCJboDlEF7yr5NFlSd6cfiB
         GYhI9hkfAFHIVmedGrZBK5/TiYtB5PAsuaWAGQb750SOfrngoNV32w0Ef/hvzEMbIq0G
         KCxw==
X-Gm-Message-State: AOAM532IDvvwh/JobUAW/A4xYKF7Fvn5MmMJUnbog1nxE6GIKMxnwqy7
        Gjap+oQ3nZ0vf5HPR/FqIJRd/7EjeaSCXg==
X-Google-Smtp-Source: ABdhPJwznbXIa0GEd4MYIiiq/EtW/uFTFioQFTOH7+eXW+7yZAsdQAAGcQjK0LAi46azwK8SUREtIw==
X-Received: by 2002:a05:6402:1485:: with SMTP id e5mr11725818edv.192.1614033924687;
        Mon, 22 Feb 2021 14:45:24 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id y8sm8854835ejw.32.2021.02.22.14.45.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 14:45:24 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id v15so20736952wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:45:24 -0800 (PST)
X-Received: by 2002:a19:7f44:: with SMTP id a65mr14452663lfd.41.1614033479451;
 Mon, 22 Feb 2021 14:37:59 -0800 (PST)
MIME-Version: 1.0
References: <87o8gctii6.fsf@mpe.ellerman.id.au>
In-Reply-To: <87o8gctii6.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Feb 2021 14:37:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9nZYEZnTYMpHwVT6B6P+zFXW_P-PWH_bRR5bp-cWbOQ@mail.gmail.com>
Message-ID: <CAHk-=wj9nZYEZnTYMpHwVT6B6P+zFXW_P-PWH_bRR5bp-cWbOQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-1 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     aik@ozlabs.ru, ananth@linux.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Qian Cai <cai@lca.pw>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, clg@kaod.org,
        cmr@codefail.de, cy.fan@huawei.com, eerykitty@gmail.com,
        Markus Elfring <elfring@users.sourceforge.net>,
        Florian Fainelli <f.fainelli@gmail.com>, fbarrat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com,
        hbathini@linux.ibm.com, jiapeng.chong@linux.alibaba.com,
        kernelfans@gmail.com, kjain@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, msuchanek@suse.de,
        nathanl@linux.ibm.com, Nick Piggin <npiggin@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        Randy Dunlap <rdunlap@infradead.org>, sandipan@linux.ibm.com,
        skirmisher@protonmail.com,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 4:06 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Please pull powerpc updates for 5.12.

Pulled. However:

>  mode change 100755 => 100644 tools/testing/selftests/powerpc/eeh/eeh-functions.sh
>  create mode 100755 tools/testing/selftests/powerpc/eeh/eeh-vf-aware.sh
>  create mode 100755 tools/testing/selftests/powerpc/eeh/eeh-vf-unaware.sh

Somebody is being confused.

Why create two new shell scripts with the proper executable bit, and
then remove the executable bit from an existing one?

That just seems very inconsistent.

             Linus
