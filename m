Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35FA633EFE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhCQL5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:57:49 -0400
Received: from ozlabs.org ([203.11.71.1]:40001 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhCQL5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:57:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4F0pYT4yrVz9sTD;
        Wed, 17 Mar 2021 22:57:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1615982241;
        bh=Zhmy2g9i1U4R/4NbsT62uiLktGvcjXOQHf91TVlASCo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=o7FCwonQdnQAExLznUTypn+iMH7d97qDlNwxwgN8+JhdS3g9O3FWkMU/0jcrxay33
         HPYyHpQC+h/b3SmyS4YD8WBu/RCdQeGZKuDqmJ92xAK81UgMvecMxw2D0l09LBS3Mh
         jp0/+Bu3vk29Fe1xYt15TMLoK1++2Pz/2ZS8wERNgh8l+xAdecH8QsOdSCwZOPNf9b
         SkxsVnrq6nYjioVDGvZZ1LVabuLbT89sQW+ldA32nBHewmYpk5dmxY2ztHRSjdy1JE
         eg+q86EOvnBvxxUX133QQHy1ta89glwyc2rrJOUrYECjoP9IvpViKENHK4NF618IaQ
         OnG7EKuQu8sWQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>, "heying (H)" <heying24@huawei.com>,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        rppt@kernel.org, ardb@kernel.org, clg@kaod.org,
        christophe.leroy@csgroup.eu
Cc:     johnny.chenyi@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: arch/powerpc/kernel/setup_64.c - cleanup warnings
In-Reply-To: <87tupab4a1.fsf@dja-thinkpad.axtens.net>
References: <20210316041148.29694-1-heying24@huawei.com>
 <87wnu6bhvi.fsf@dja-thinkpad.axtens.net>
 <f0130916-a8f3-75ba-b5da-7d37d9139ff3@huawei.com>
 <87tupab4a1.fsf@dja-thinkpad.axtens.net>
Date:   Wed, 17 Mar 2021 22:57:14 +1100
Message-ID: <877dm6ouw5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> "heying (H)" <heying24@huawei.com> writes:
>
>> Thank you for your reply.
>>
>> =E5=9C=A8 2021/3/17 11:04, Daniel Axtens =E5=86=99=E9=81=93:
>>> Hi He Ying,
>>>
>>> Thank you for this patch.
>>>
>>> I'm not sure what the precise rules for Fixes are, but I wonder if this
>>> should have:
>>>
>>> Fixes: 9a32a7e78bd0 ("powerpc/64s: flush L1D after user accesses")
>>> Fixes: f79643787e0a ("powerpc/64s: flush L1D on kernel entry")
>>
>> Is that necessary for warning cleanups? I thought 'Fixes' tags are=20
>> needed only for
>>
>> bugfix patches. Can someone tell me whether I am right?
>
> Yeah, I'm not sure either. Hopefully mpe will let us know.

It's not necessary to add a Fixes tag for a patch like this, but you can
add one if you think it's important that the fix gets backported.

I don't think the cleanups in this case are that important, so I
wouldn't bother with a Fixes tag.

cheers
