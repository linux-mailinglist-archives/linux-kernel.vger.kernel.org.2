Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826FF312F6A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhBHKrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:47:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:54654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232520AbhBHKhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:37:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612780578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5UpmvGJTacd6yUXg2H9+bLosTdiuU5Va+P2BDP3oi4Y=;
        b=QrwXNShCzDyYAZA4BYXeiZBCyfJGNbF/wzlZPiEU3K8Ie6xvQEI1yjQpnzynJRqYeVDDfU
        KODbn7VjygcHyxQAPUiPYawbNC9JOaoFJqTVptTceuTM4hTUTnHQJIaAqTaLykBtTgvKb5
        g5ANxsDslCGRmAKiMXbh/ZysXVTk3KU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5FFD2AC6E;
        Mon,  8 Feb 2021 10:36:18 +0000 (UTC)
Subject: Re: [PATCH 6/7] xen/evtch: use smp barriers for user event ring
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20210206104932.29064-1-jgross@suse.com>
 <20210206104932.29064-7-jgross@suse.com>
 <2d354cad-3413-a416-0bc1-01d03e1f41cd@citrix.com>
 <dfa40af0-2706-2540-c59a-6593c1c0553a@suse.com>
 <e68f76a5-27ce-a6d8-88a3-1e8fa1c30659@citrix.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <def49076-f943-9418-86b0-2aafbd0bf7de@suse.com>
Date:   Mon, 8 Feb 2021 11:36:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e68f76a5-27ce-a6d8-88a3-1e8fa1c30659@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.2021 11:23, Andrew Cooper wrote:
> On 08/02/2021 09:50, Jan Beulich wrote:
>> On 08.02.2021 10:44, Andrew Cooper wrote:
>>> On 06/02/2021 10:49, Juergen Gross wrote:
>>>> The ring buffer for user events is used in the local system only, so
>>>> smp barriers are fine for ensuring consistency.
>>>>
>>>> Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>> These need to be virt_* to not break in UP builds (on non-x86).
>> Initially I though so, too, but isn't the sole vCPU of such a
>> VM getting re-scheduled to a different pCPU in the hypervisor
>> an implied barrier anyway?
> 
> Yes, but that isn't relevant to why UP builds break.
> 
> smp_*() degrade to compiler barriers in UP builds, and while that's
> mostly fine for x86 read/write, its not fine for ARM barriers.

Hmm, I may not know enough of Arm's memory model - are you saying
Arm CPUs aren't even self-coherent, i.e. later operations (e.g.
the consuming of ring contents) won't observe earlier ones (the
updating of ring contents) when only a single physical CPU is
involved in all of this? (I did mention the hypervisor level
context switch simply because that's the only way multiple CPUs
can get involved.)

Jan
