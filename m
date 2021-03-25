Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03B93498D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 18:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCYR5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 13:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhCYR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 13:57:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383E2C06174A;
        Thu, 25 Mar 2021 10:57:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616695031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aYU/XslC1ugInZNefjNDGx2r98GPcBH1b/Zsq00dTN8=;
        b=Gi/OWlsRoH8hTL+T4t0+0zk2kjHCqKDwpkuw859Yu7h/97u/L+5MEUY4bgPl2kCW9scR85
        RsitZ/HOSfBUB2ZfsXRUi5aOPgcYqUMys9XOCrzN7K72a9NC/yzgT0R7FzidcVIX10ozW0
        WEhe5VbRSVyLFfxaxF7urrIAiTHhk3QBvfKHsuMI6cvFGsKGtFk8P20lL8+zBk4GVzElEp
        LP323c5NGNwjD8f5xXMtgRqDwb8SlYTt1yP6VUNg0ts0WgG7fD/rmt91ZDrjrOChuUlzng
        tBtDgCWm2eDd1cwgp0VRhqf5C8zVFtAtTHkXv0oSv+tbl1FEfTfTFDRaSvnhbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616695031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aYU/XslC1ugInZNefjNDGx2r98GPcBH1b/Zsq00dTN8=;
        b=qMgylRfM54T8i3UeGik5bja9DFi769SYBCc5ANZBdww3yqDxzvuDdc3qOsH1TuEBwk2A1a
        4jFSe7sz7dX7slBw==
To:     Heiko Carstens <hca@linux.ibm.com>, Li Wang <liwang@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/3] lib/vdso: remove struct arch_vdso_data from vdso data struct
In-Reply-To: <87sg4jw21u.fsf@nanos.tec.linutronix.de>
References: <YFmUrVOyX4q+8Dy9@osiris> <20210323215819.4161164-1-hca@linux.ibm.com> <20210323215819.4161164-4-hca@linux.ibm.com> <87sg4jw21u.fsf@nanos.tec.linutronix.de>
Date:   Thu, 25 Mar 2021 18:57:11 +0100
Message-ID: <87pmznw1zc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25 2021 at 18:55, Thomas Gleixner wrote:
> On Tue, Mar 23 2021 at 22:58, Heiko Carstens wrote:
>> Since commit d60d7de3e16d ("lib/vdso: Allow to add architecture-specific
>> vdso data") it is possible to provide arch specific VDSO data.
>>
>> This was only added for s390, which doesn't make use this anymore.
>> Therefore remove it again.
>>
>> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
>
> Please route that with the rest of the fixes.
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Ah, you decided for the simpler variant. Fine with me.
