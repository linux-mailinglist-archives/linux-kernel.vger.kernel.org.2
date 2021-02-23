Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E60322352
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 01:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhBWAyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 19:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhBWAyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 19:54:49 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143EFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 16:54:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Dl0tB6d2Dz9sS8;
        Tue, 23 Feb 2021 11:53:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1614041645;
        bh=aa+K8Nsatfk9ECjgauAQRY0LNVMvN0lgz7Bn7cRNvPI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OoK4jrhrRNDhE5HESbrR/JIr1yTHMJvXEhNrsVZ6kTWFctv0wc11QiChVTa4ZoNrV
         KhwyC3IONpVjkhOhDK/UzhSaaoJZxo/AoHce8c4QYkCAReD/uePXk0m76fdDIzG+y3
         IzYUe4tQlrZh/hSDKOGiRZkUDzvet2ZmoX9aLrFwXDpotGFY9KSI3NN9ptcuR82SPW
         Iw2+VmOmnKt9G1zabmvgLNChXNxB7Mubm6hq0bfb3h1wZTfGyoH5iPnF8Ldr3ncHFe
         cmNf3K0RUMRlOB0H7MDPB4ndf5fA/KeQmxFzNeBfq9TU9nI2aCbpJFKaEgGLiWDNFt
         RGbsCzc6NPBSw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Qian Cai <cai@lca.pw>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
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
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-1 tag
In-Reply-To: <CAOSf1CH67Htam33UvYhaypD7HW7q1xU4tUW0soshao2FKa+Czw@mail.gmail.com>
References: <87o8gctii6.fsf@mpe.ellerman.id.au>
 <CAHk-=wj9nZYEZnTYMpHwVT6B6P+zFXW_P-PWH_bRR5bp-cWbOQ@mail.gmail.com>
 <CAOSf1CH67Htam33UvYhaypD7HW7q1xU4tUW0soshao2FKa+Czw@mail.gmail.com>
Date:   Tue, 23 Feb 2021 11:53:53 +1100
Message-ID: <87k0qztxi6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Oliver O'Halloran" <oohall@gmail.com> writes:

> On Tue, Feb 23, 2021 at 9:44 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Mon, Feb 22, 2021 at 4:06 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> >
>> > Please pull powerpc updates for 5.12.
>>
>> Pulled. However:
>>
>> >  mode change 100755 => 100644 tools/testing/selftests/powerpc/eeh/eeh-functions.sh
>> >  create mode 100755 tools/testing/selftests/powerpc/eeh/eeh-vf-aware.sh
>> >  create mode 100755 tools/testing/selftests/powerpc/eeh/eeh-vf-unaware.sh
>>
>> Somebody is being confused.
>>
>> Why create two new shell scripts with the proper executable bit, and
>> then remove the executable bit from an existing one?
>>
>> That just seems very inconsistent.
>
> eeh-function.sh just provides some helper functions for the other
> scripts and doesn't do anything when executed directly. I thought
> making it non-executable made sense.

Yeah I think it does make sense. It just looks a bit odd in the diffstat
like this. Maybe if we called it lib.sh it would be more obvious?

cheers
