Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99B30A29E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 08:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhBAHYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 02:24:37 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:8917 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhBAHXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 02:23:11 -0500
X-AuditID: 0a580155-6fbff700000550c6-f8-6017a5b3c440
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 21.70.20678.3B5A7106; Mon,  1 Feb 2021 14:54:43 +0800 (HKT)
Received: from aili-OptiPlex-7020 (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Feb 2021
 15:21:42 +0800
Date:   Mon, 1 Feb 2021 15:21:41 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     <x86@kernel.org>, <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] x86/fault: Send SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210201152141.42d5bf1e.yaoaili@kingsoft.com>
In-Reply-To: <20210129225529.GA42172@agluck-desk2.amr.corp.intel.com>
References: <20210128194326.71895e92.yaoaili@kingsoft.com>
 <20210128174352.GA33283@agluck-desk2.amr.corp.intel.com>
 <20210129113334.344377ac.yaoaili@kingsoft.com>
 <20210129225529.GA42172@agluck-desk2.amr.corp.intel.com>
Organization: Kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXCFcGooLt5qXiCwe2vAhaXd81hs7jYeIDR
        4s2FeywWPzY8ZnVg8Vi85yWTx6ZVnWweL65uZPH4vEkugCWKyyYlNSezLLVI3y6BK+Njc0LB
        J66K5qlLmRsYb3F0MXJySAiYSNz/94m5i5GLQ0hgOpPEtPfP2CGc54wS/VumMYJUsQioSExs
        X88MYrMJqErsujeLFcQWEVCTuLT4AVicWSBbouf+cSYQW1ggTuJE3z2gGg4OXgErifeL00DC
        nAKuErNPbWCDmP+QUWLjh3csIDX8AmISrxqMIQ6yl3j+9yzYSF4BQYmTM5+wQIzXkTix6hjU
        KnmJ7W/ngNlCAooSh5f8YofoVZI40j2DDcKOlVg27xXrBEbhWUhGzUIyahaSUQsYmVcxshTn
        phttYoQEeOgOxhlNH/UOMTJxMB5ilOBgVhLhPTVJLEGINyWxsiq1KD++qDQntfgQozQHi5I4
        b7kDX4KQQHpiSWp2ampBahFMlomDU6qBqdNWL6juJbuvyYnkxUU3DVcdOrNBXJNTumrnhu4p
        CZ2sS8P3b7lX9Ib7VfKVILmIS6ePy7S3rL7/N2HNppR1Mx/YcyplzXjLdXJzxOGyy5Pz9M/F
        v9lvb98dseRgbkvhu2vHtZrO3TlzslU7f3PGhouzZ9cuuMVfZlnfUPBqzhtH+8o3ya+PHAx6
        LL3AajdTva6S8/b57S/kzJxF49wycyqaI7kD5qvPmvRJ4avjLq3t/pGFC05eCOc+NfGOffe1
        Z8dj9/9WWGTzppL5qPee2JyIeNGz3o6XPjn0yc7kWpzMIX2z/CvjY2PvmiJP3Us+3RpvdSWi
        trXxLWdSX3UmwDM+1iL8Ocf9fFODwNKrSizFGYmGWsxFxYkAxXDhoN8CAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021 14:55:29 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> Thanks for the explanation and test code. I think I see better what
> is going on here.
> 
> [I took your idea for using madvise(...MADV_HWPOISON) and added a new "-S"
> option to my einj_mem_uc test program to use madvise instead of ACPI/EINJ
> for injections. Update pushed here:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/aegl/ras-tools.git ]
> 
> There have been some small changes to arch/x86/mm/fault.c since you wrote
> the patch.  Can you rebase to v5.11-rc5?

Yes, I will rebase it to newest version.
 
> Also maybe this might be a case to use IS_ENABLED() instead of #ifdef to
> make the code a little less ugly. At least for the 2nd hunk in your patch
> this would work well:
> 
> 	if (IS_ENABLED(CONFIG_MEMORY_FAILURE) &&
> 	    (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)))
> 		no_context(regs, error_code, address, SIGBUS, BUS_MCEERR_AR);
> 	else
> 		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
> 
> The first hunk might need a bit more thought.
> 
Do you mean the force_sig_mceerr and force_sig_fault difference? I see a hwpoison related comment
there, but it's better to follow the usual way force_sig_mceerr, I will modify this in a v2 patch.

Or something other, you may post a better one.

Thanks

-- 
Best Regards!

Aili Yao
