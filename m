Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF445DE14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356353AbhKYP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356385AbhKYPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:54:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD1C0619D5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LXQYLcp960apIGbPoKxQF0mN2aizT63xwlc7nrknHaM=;
        t=1637855113; x=1639064713; b=I5S5xClVYdAAU7wuM2drqabFXbQl8z7aECntfeQuJcNAy+t
        tm3xAr/HmytcYuDf2dVGZza4gZa1IBYkqGOLhkhOxQsxJdX9N9wyem2kwdFQvxYDYeWtGSH1SaZcv
        t7jojvF+HqNV9ArEVnQxeuXacQLhdYTULsVpUxAs9dbmrr3Qnf1D24m8tP+XiRZiEmTlcpYzr68jr
        tjBASn22D2AY8JEenR3jBe5ek4vOEhsFZgMhV34SllXOpX1PVUbjqvir1r/b1/tE+mN5vkj4mU+RJ
        edn/LSUsS654B20b6sq7bBnMTXv9IagKH7o1IiylERAhlpEJQxSy+FP9dfVmn29w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mqGvs-002nF4-7l;
        Thu, 25 Nov 2021 16:45:08 +0100
Message-ID: <a5274ba1922d5eaf9568886191e0a05bdfc55506.camel@sipsolutions.net>
Subject: Re: [gcov]  1391efa952:
 BUG:KASAN:slab-out-of-bounds_in_gcov_info_add
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Sang, Oliver" <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>
Date:   Thu, 25 Nov 2021 16:45:07 +0100
In-Reply-To: <20211125142622.GD3109@xsang-OptiPlex-9020>
References: <20211125142622.GD3109@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-25 at 14:26 +0000, Sang, Oliver wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with clang-14):
> 
> commit: 1391efa952e8b22088f8626fc63ade26767b92d6 ("gcov: use kvmalloc()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: boot
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 

I don't think it actually *caused* the issue, but who knows? To me it
rather looks like it exposed an issue, which wasn't noticed before
because vmalloc() always allocates a page anyway? Assuming KASAN doesn't
track vmalloc() allocations more granular than their actual page-aligned
memory size (though perhaps it should?)

In any case, reviewing my commit again I see nothing wrong there, and I
don't understand the code/clang well enough to see what might be the
issue.

johannes
