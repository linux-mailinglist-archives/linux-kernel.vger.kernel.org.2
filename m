Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6901458967
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 07:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhKVGuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 01:50:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:33481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232560AbhKVGuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 01:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637563611;
        bh=C6LIvmc696yIdTukGLDaZor0Z2/Ukm396tIyvEaAsfg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=jQ6REg+4I80JoLJkgSalT8ad+oxxJOnJ9MhDAlubCdfTZszkes+5xAqeLS8FdSddg
         HVnBspflDfhap7v9WuZdCN0wqrU7iimJknBB3QO0plw+iu28tdgz2TszulO11xKiVL
         1eVfvrG0ZW5S6xoWMoLQgW8aIJj3NCwN+bzNITjM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.218]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QJJ-1mps342f1p-001UnP; Mon, 22
 Nov 2021 07:46:51 +0100
Message-ID: <723736b7736da3810cab582dee4591fec063618b.camel@gmx.de>
Subject: Re: mm: LTP/memcg testcase regression induced by
 8cd7c588decf..66ce520bb7c2 series
From:   Mike Galbraith <efault@gmx.de>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        lkml <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Mel Gorman <mgorman@techsingularity.net>
Date:   Mon, 22 Nov 2021 07:46:50 +0100
In-Reply-To: <6cc591c5-ed71-3213-3119-c778b3b2823d@leemhuis.info>
References: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
         <6cc591c5-ed71-3213-3119-c778b3b2823d@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LgTFEfLTW34s5E/9UQnKKGKkWuiSMJxzqz8SKD8VEZDVKkCDi4g
 giQQ+qjOZYM2SvbO9ZDmjIj3PA+Glbxac8eX2hdb/6v1NC1PoFRfff1YTiA4KEXrkA6joF5
 30yxpDb9JwSLOAvAwCgRUPAZpXj1eWr2iGQjdyiHf3n8GRQt+HkkVVj/3COHse7hbjJALXl
 DxUkvtO8Jfp79WnFxAIjg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ASGXN+dd1OM=:U4165REqhXYapPxWlx18uT
 6QD3/3cUI+H8t9MA6x3azns+7tgsRKY6hygGkt8C1A2P4+7pN5FCcTYuMbyvhFezg8wTXnKoR
 bgJrp5SSAnJciotzqZOxD8bhuGokHRbWBpYdQEiGkyRbkr91ZDwHHDPwtS27oah6aicjYmekZ
 0fR/dvqC4iCflDB+CD4poLeEHUusplVCuMmO763JNSpsDfkWEPmgO77+rrbbfwyB4vC/6BdyZ
 IFqYtHYbpf/bcWQbtqiJ+M4IHVCvSfOD0FyQB/BbGXhhyOWCCzPaEI9mTHwO485WMdsDe4ihE
 MweE2MC2356mqi7YCWr3zFKE9rzKfLlhEqBD5sfTQgevU5Y58wohsFvQPW0GmTXp9gdHc6mo4
 YWbE7O/2oiy4Uu1yJTxRkQI1yEhB8IK0S2cSJhVEyW758FivyoraPXSkGYmu1L6QeC1y8Hcxf
 AFVM1UzdP4jp0dPX+/6/OIe7yrabliVz/4sBKJHOJkrj0hjNO7VHeESOUSMdnr55wpz9tkY1e
 dzX8ES4Mwq1fUxU9iRB2+LFKSQWfTd+sszsPIdEZL4tTXt1zbQ6RNrU1fqbvOCs68aQkFv0eA
 64TaRGyK9DNmioYVVYDgqFfNLhnADaU4XaA7ywksbRLGDEZjVf91nmfpfmAvzmN7mcHPiHGZo
 /NRdyADLa+Ta0r74VWKCDhSp0wFExl23+vsfpeOIwegPfbGH0uK3iWKTqZ0GVqdY/VMvO7XgU
 eWTSXU8iR+aBDdaj1saNj/1mXfaNFKsO2BKYMd2q10kEVdVxHrnKFifKthYwwSk3kHY5kuhHw
 /zqcjCikb4/Q+BiKyyBpOaspZKRgaV8dUXYZp1KQxjSsobxs0SuRGuEyliMM1E1Mvjw0YVk4K
 9bNKiVmhTolaUY5f2tx/hZn23d8QpsQE/7bLM/7RpKsPW3c7xRGxNVqlyJu2AdVvS8i0SIChQ
 IToq03dWWWdj4Nmjn/U7HB/fi7TJFoa0i1RJXhvSnSWrJme3adL//naIyiCqi20ucy4XsKJDe
 /ppMFu6AjBaTbvhObG8vVrMQIauCZL2/D4oirrs23D1gPHdq1nH7QaAo/mSTkxH6zIU3Bt/T0
 kp6NnGcTZwXL+E=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-11-21 at 14:51 +0100, Thorsten Leemhuis wrote:
>
> Hi, this is your Linux kernel regression tracker speaking.

This isn't necessarily a kernel regression, though the fact that
bystander tasks like ps can get snagged for ages as the testcase runs
at an amazingly glacial pace doesn't look particularly wonderful.

homer:/root # time ps lax
...
real    11m33.258s
user    0m0.004s
sys     0m0.008s
homer:/root #

The other memcg tests complete fine, though taking more time to do so.
Running all tests except memcg_regression, (and  memcg_stress because
it's a 30 minute swap storm from hell as delivered), runtime increased
from 0m37s to 4m43s.

The problematic testcase is root intentionally shooting its own foot,
then checking for battle damage that occurred in days of yore, so it
now hurting in a different way isn't necessarily grounds to gripe at
the kernel.. even with the rather ugly side effects.. maybe <shrug>.

#-------------------------------------------------------------------------=
--
# Bug:    The bug was, while forking mass processes, trigger memcgroup OOM=
,
#         then NULL pointer dereference may be hit.
# Kernel: 2.6.25-rcX
# Links:  http://lkml.org/lkml/2008/4/14/38
# Fix:    commit e115f2d89253490fb2dbf304b627f8d908df26f1
#-------------------------------------------------------------------------=
--
test_1()
{
        mkdir memcg/0/
        echo 0 > memcg/0/memory.limit_in_bytes

        ./memcg_test_1

        rmdir memcg/0/

        check_kernel_bug
        if [ $? -eq 1 ]; then
                tst_resm TPASS "no kernel bug was found"
        fi
}


I'm gonna just comment the little bugger out as obsolete and walk away.

	-Mike
