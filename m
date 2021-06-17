Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FAF3AB3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhFQMiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:38:08 -0400
Received: from server.eikelenboom.it ([91.121.65.215]:40714 "EHLO
        server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFQMiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=eikelenboom.it; s=20180706; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Iq7qdsDsVjBjx3WrDBIM54QXGdH+Ntk8viW76NT5q2g=; b=fyKFlq8/vKowL8Pv4ceazD6cNR
        heZJUaVIV0RryDwRVVvuH4U4C5+XHvUi7E1r72BTz4J2xPWH+h3Pdc6VjRcA1ifK4CgYTUfG5WZat
        qSFHOqdeOYjYSbRUWw/T24bV7JecZTEVWTYpso6cztNwuMwKshaTKoPjmq5kvtjfhJ0Y=;
Received: from 76-24-144-85.ftth.glasoperator.nl ([85.144.24.76]:51062 helo=[172.16.1.50])
        by server.eikelenboom.it with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <linux@eikelenboom.it>)
        id 1ltrK1-0005dC-5w; Thu, 17 Jun 2021 14:40:37 +0200
Subject: Re: Linux 5.13-rc6 regression to 5.12.x: kernel OOM and panic during
 kernel boot in low memory Xen VM's (256MB assigned memory).
To:     Juergen Gross <jgross@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <ee8bf04c-6e55-1d9b-7bdb-25e6108e8e1e@eikelenboom.it>
 <6bcd447e-fd49-0519-a59e-478f84e9120f@suse.com>
From:   Sander Eikelenboom <linux@eikelenboom.it>
Message-ID: <46c90fab-5928-d181-432f-228304a7e019@eikelenboom.it>
Date:   Thu, 17 Jun 2021 14:35:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6bcd447e-fd49-0519-a59e-478f84e9120f@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2021 12:30, Juergen Gross wrote:
> On 17.06.21 11:26, Sander Eikelenboom wrote:
>> L.S.,
>>
>> I just tried to upgrade and test the linux kernel going from the 5.12
>> kernel series to 5.13-rc6 on my homeserver with Xen, but ran in some
>> trouble.
>>
>> Some VM's boot fine (with more than 256MB memory assigned), but the
>> smaller (memory wise) PVH ones crash during kernel boot due to OOM.
>> Booting VM's with 5.12(.9) kernel still works fine, also when dom0 is
>> running 5.13-rc6 (but it has more memory assigned, so that is not
>> unexpected).
>>
>> The 5.13-rc6'ish kernel is a pull of today, tried both with and without
> 
>> last AKPM's patches, but that
>> makes no difference.
>>
>> Below are stacktraces from a few of the crashing VM's.
>>
>> Attached is the kernel .config
>>
>> Any pointers ?
> 
> Did you compare memory usage with a bootable guest between kernel 5.12
> and 5.13-rc6?
> 
> Any chance you could bisect?
> 
>
> Juergen
> 

Yeah a bisection is already underway, still 10 steps to go ...

--
Sander
