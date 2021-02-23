Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68141322367
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhBWBOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBWBOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:14:19 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED604C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:13:38 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Dl1Js3xT9z9sS8;
        Tue, 23 Feb 2021 12:13:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1614042816;
        bh=FAcIZ5QF9ArI7FFOyovUOaKnveLQ6XJR1r7QpX3zQzg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ib8ZIzG1GEbGcHcBE1SB4ZyJSeZWWenriFLSahoMqCiVPPPyFHLBAgI5S9mB7CY4f
         PapNrBrGhVMP01t8FXhxqZABzcaNn6Fk9lwUFdsZqPIqofMSlo7pR5vKA+6Z4ZLrFD
         XOMGiDYTlqtryPeeKOQQj6KkIkXKn3YDo9PMyloUTQhQHk+ZsvHV8z6QWdUfYSwaJD
         SwN2ZD2EfMuNgqpo5bKflJq+gVIQ8/H5HeMjvAgVL61GUvtO4N+bHY/bZbZjOC3aFo
         YuYo9rJ9Z/PFtk13tejf7P5/7o6QzWkaCGANjpMAm+2ErvJ/W3pyG7EBFpjJbiblmM
         iYlCp/DdbhkIw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, ananth@linux.ibm.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        atrajeev@linux.vnet.ibm.com, Qian Cai <cai@lca.pw>,
        christophe.leroy@csgroup.eu,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
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
        Oliver O'Halloran <oohall@gmail.com>, po-hsu.lin@canonical.com,
        Randy Dunlap <rdunlap@infradead.org>, sandipan@linux.ibm.com,
        skirmisher@protonmail.com,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        zhengyongjun3@huawei.com, Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-1 tag
In-Reply-To: <CAL_Jsq+5u82rS+izM2Ds0jdsQKc9C_MCFLmmRvrxhD_6ofNiJQ@mail.gmail.com>
References: <87o8gctii6.fsf@mpe.ellerman.id.au>
 <CAL_Jsq+5u82rS+izM2Ds0jdsQKc9C_MCFLmmRvrxhD_6ofNiJQ@mail.gmail.com>
Date:   Tue, 23 Feb 2021 12:13:33 +1100
Message-ID: <87h7m3twle.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:
> On Mon, Feb 22, 2021 at 6:05 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> Hi Linus,
>>
>> Please pull powerpc updates for 5.12.
>>
>> There will be a conflict with the devicetree tree. It's OK to just take their
>> side of the conflict, we'll fix up the minor behaviour change that causes in a
>> follow-up patch.
>
> The issues turned out to be worse than just this, so I've dropped the
> conflicting change for 5.12.

OK, no worries.

cheers
