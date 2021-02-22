Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74A832227A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBVXBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhBVXBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:01:41 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:01:01 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v206so14471570qkb.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 15:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EsKV0Pl9cBg0dGkFXYlZCn6qWyBn5vHTyFKd2EuGsKo=;
        b=fq4R2dSQQyl5znQa4yVu7EyaNlBck4uM94y1rknmYjQGUU7Cr8D4pE0iVKYbD2htIN
         pz9KVEK/iiES/PPK8aq+TVtOGkW9pEUmtwl0eMZGizs5ZzIIDnKw3iHpgQUfzxl8feMm
         Ayt/PZGOUMMaEJ/92FCotBtm7b36hJFAt8bqDJirvpeV5gty4+DQaJPkHffXrIYlGjti
         5ETYr1ncQ1qL2lYxQNBCAivx8QWkGMceq0GET3JI9QrNvpynUb6UaO+XC/pvo7VF5NOr
         k8MCAK59+93GudItyq4PKr8s2b5c+6pDXjI5V27cWHMUuc/roktuuwsMC0J+xNGZVfT3
         /zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EsKV0Pl9cBg0dGkFXYlZCn6qWyBn5vHTyFKd2EuGsKo=;
        b=Ol3uQcJPUmebiwOy3zzFdL/EucqG187uPu8Rft+RVhECTsao0W4C1pzU/Fezb20owC
         HXhGPtkJlufuc7wxrPm1jQn3oNNU6d8PkNAj/s/KJ2flHg3B5oWX5qK32khERf5RstJU
         z1T71nFWpi7+S7WVDFqzKJwDKZMkgwZzV2dDQCg4Wl7J1yJABU4vT/mYDOhRQ8qdJ8Wm
         9jVDduZqN/BLRN2lNamyhbuisxCqz5KhgLxIuF8GF5kTRGSuwlWdxr0Cj45aIb2HVXi2
         dhibbl5s0XOayPjRUxsnu1yC1CQo1KzkuwlOucidNe7hS3uvB8JCjbGqjWqJnDl6mdeW
         EG1A==
X-Gm-Message-State: AOAM533DQzrY4iurRu2aUBT80Z9YJ2jTUbmos7WBppAL6QTkzt2ivrvr
        Cop4B4r43/CJhtCI/KHX10f6RuatwS6Tuc//SnA=
X-Google-Smtp-Source: ABdhPJwWRqCJEdEzHNjaLGBSsRfe2TL5ESD7hupDlSFVSwOcNv+kd6nMpHN6ZC+Q9JkUP1C5K3eyn7pka3B8/q5HiFE=
X-Received: by 2002:a37:7245:: with SMTP id n66mr24129320qkc.374.1614034860347;
 Mon, 22 Feb 2021 15:01:00 -0800 (PST)
MIME-Version: 1.0
References: <87o8gctii6.fsf@mpe.ellerman.id.au> <CAHk-=wj9nZYEZnTYMpHwVT6B6P+zFXW_P-PWH_bRR5bp-cWbOQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj9nZYEZnTYMpHwVT6B6P+zFXW_P-PWH_bRR5bp-cWbOQ@mail.gmail.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Tue, 23 Feb 2021 10:00:49 +1100
Message-ID: <CAOSf1CH67Htam33UvYhaypD7HW7q1xU4tUW0soshao2FKa+Czw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-1 tag
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Qian Cai <cai@lca.pw>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        cmr@codefail.de, cy.fan@huawei.com, eerykitty@gmail.com,
        Markus Elfring <elfring@users.sourceforge.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        ganeshgr@linux.ibm.com, Haren Myneni <haren@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        jiapeng.chong@linux.alibaba.com,
        Pingfan Liu <kernelfans@gmail.com>, kjain@linux.ibm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
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

On Tue, Feb 23, 2021 at 9:44 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 22, 2021 at 4:06 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Please pull powerpc updates for 5.12.
>
> Pulled. However:
>
> >  mode change 100755 => 100644 tools/testing/selftests/powerpc/eeh/eeh-functions.sh
> >  create mode 100755 tools/testing/selftests/powerpc/eeh/eeh-vf-aware.sh
> >  create mode 100755 tools/testing/selftests/powerpc/eeh/eeh-vf-unaware.sh
>
> Somebody is being confused.
>
> Why create two new shell scripts with the proper executable bit, and
> then remove the executable bit from an existing one?
>
> That just seems very inconsistent.

eeh-function.sh just provides some helper functions for the other
scripts and doesn't do anything when executed directly. I thought
making it non-executable made sense.

>
>              Linus
