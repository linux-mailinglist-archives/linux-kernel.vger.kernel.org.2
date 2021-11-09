Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE144B0A1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbhKIPth convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Nov 2021 10:49:37 -0500
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:56550 "EHLO
        ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbhKIPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:49:36 -0500
X-Greylist: delayed 1075 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Nov 2021 10:49:35 EST
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: https://help.uis.cam.ac.uk/email-scanner-virus
Received: from hades.srcf.societies.cam.ac.uk ([131.111.179.67]:39002)
        by ppsw-32.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.136]:25)
        with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        id 1mkT33-000x3r-0M (Exim 4.95)
        (return-path <amc96@srcf.net>);
        Tue, 09 Nov 2021 15:28:33 +0000
Received: from [192.168.1.10] (host-92-12-61-86.as13285.net [92.12.61.86])
        (Authenticated sender: amc96)
        by hades.srcf.societies.cam.ac.uk (Postfix) with ESMTPSA id C53601FBEE;
        Tue,  9 Nov 2021 15:28:32 +0000 (GMT)
To:     Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, jgross@suse.com
References: <1635896196-18961-1-git-send-email-boris.ostrovsky@oracle.com>
 <YYk+D17oIOGKWNtN@hirez.programming.kicks-ass.net>
 <48fb48fa-c65d-8e38-dabb-cf9be21365ca@oracle.com>
 <YYqPd1c9HIQH9k/9@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <amc96@srcf.net>
Subject: Re: [PATCH] x86/smp: Factor out parts of native_smp_prepare_cpus()
Message-ID: <aef8093d-f7da-c8b4-ebf6-6053b50b77ba@srcf.net>
Date:   Tue, 9 Nov 2021 15:28:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YYqPd1c9HIQH9k/9@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2021 15:10, Peter Zijlstra wrote:
> On Mon, Nov 08, 2021 at 12:20:26PM -0500, Boris Ostrovsky wrote:
>>> But looking at those functions; there seems to be more spurious
>>> differences. For example, the whole sched_topology thing.
>>
>> I did look at that and thought this should be benign given that Xen PV
>> is not really topology-aware. I didn't see anything that would be a
>> cause for concern but perhaps you can point me to things I missed.
> And me not being Xen aware... What does Xen-PV guests see of the CPUID
> topology fields? Does it fully sanitize the CPUID data, or is it a clean
> pass-through from whatever CPU the vCPU happens to run on at the time?

That depends on hardware support (CPUID Faulting or not), version of Xen
(anything before Xen 4.7 is totally insane.  Anything more recent is
only moderately insane), and whether the kernel asks via the enlightened
CPUID path or not.

On hardware lacking CPUID faulting, and for a kernel using
native_cpuid() where it ought to be using the PVOP, it sees the real
hardware value of the CPU it happens to be running on.

~Andrew

