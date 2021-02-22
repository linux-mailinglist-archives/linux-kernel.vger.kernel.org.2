Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C571321E68
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhBVRnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:43:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhBVRmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:42:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A719164F02
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614015729;
        bh=ucpe8l1xlT3KE7H9NkJLSoHHuTstbkJCkhSCSRIJhcA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ESuLuDMj05PhMn89mmnvnN5D7nx95cA8aPpEXmEx2ZxqaVvyqLP7wQ+/b/yC2xKww
         IV8w8seoshTPFqoKNvWscwxeHk7BKF+3pRm8eQNfrykduRSYQh8NF/9sLeP084HRWH
         lIPvxkAG1h7XpusBmK4UwJ98+uQtWUk8Pz16eW40M4oVN/oZV/JprALs0hVZlrhgOa
         EdI+FDZ8Tb1MgI5yHrFGftIWMZoF6VVhITr42i8lh6xfAMoKvQmPxrQa+4nKq3C84M
         5EXVvcftHsB3VRty66ynYI5hxuVnosGlGSFVtzKOTC+F/X0ulHJkYgNNtzjkSrn/89
         HB4hHurGM9lKA==
Received: by mail-ej1-f48.google.com with SMTP id w1so30621083ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 09:42:09 -0800 (PST)
X-Gm-Message-State: AOAM531CNdwSeppFnA0Bv0qomHrsMkiN45wWw6GS8z8wXnLyZVimM6lD
        5XFFVm5e31kdckQ88NyXkQ5EvGzvsvifWGblQw==
X-Google-Smtp-Source: ABdhPJxcxlLyPpKY6MYnrSiYr8NsChy16rB0Il78JdQMP/GVF5nkhd3gweoflXSc3KklV47o5XMqFI2tLVklQ/VZfuI=
X-Received: by 2002:a17:906:f85:: with SMTP id q5mr21544446ejj.108.1614015727967;
 Mon, 22 Feb 2021 09:42:07 -0800 (PST)
MIME-Version: 1.0
References: <87o8gctii6.fsf@mpe.ellerman.id.au>
In-Reply-To: <87o8gctii6.fsf@mpe.ellerman.id.au>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 22 Feb 2021 11:41:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5u82rS+izM2Ds0jdsQKc9C_MCFLmmRvrxhD_6ofNiJQ@mail.gmail.com>
Message-ID: <CAL_Jsq+5u82rS+izM2Ds0jdsQKc9C_MCFLmmRvrxhD_6ofNiJQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-1 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, ananth@linux.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        atrajeev@linux.vnet.ibm.com, Qian Cai <cai@lca.pw>,
        christophe.leroy@csgroup.eu,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        cmr@codefail.de, cy.fan@huawei.com, eerykitty@gmail.com,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        Florian Fainelli <f.fainelli@gmail.com>, fbarrat@linux.ibm.com,
        ganeshgr@linux.ibm.com, Haren Myneni <haren@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        jiapeng.chong@linux.alibaba.com, kernelfans@gmail.com,
        kjain@linux.ibm.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michal Suchanek <msuchanek@suse.de>, nathanl@linux.ibm.com,
        Nicholas Piggin <npiggin@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, po-hsu.lin@canonical.com,
        Randy Dunlap <rdunlap@infradead.org>, sandipan@linux.ibm.com,
        skirmisher@protonmail.com,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        zhengyongjun3@huawei.com, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 6:05 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Hi Linus,
>
> Please pull powerpc updates for 5.12.
>
> There will be a conflict with the devicetree tree. It's OK to just take their
> side of the conflict, we'll fix up the minor behaviour change that causes in a
> follow-up patch.

The issues turned out to be worse than just this, so I've dropped the
conflicting change for 5.12.

Rob
