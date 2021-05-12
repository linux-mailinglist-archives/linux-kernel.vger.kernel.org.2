Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC637EEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349054AbhELW3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbhELWXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 18:23:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E0FC061761
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 15:22:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620858126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGFID5hbvdrny8vdO/7dK4gdvpGzABRsXw2hjMkzC/s=;
        b=PlnJ39VFhObqUWUaU3Kd9mVCLyZ0hqSTR2eet7RIYLR06SYuV4r1CCjK7TasBenzzEI0Ds
        5eE7NtI5PF4Vn8bllaYSGDvUyJVTYUK1vSMhnWqAyxyZXhhIxVA4mEImT2GCeWNSy4pG5R
        Sn3ODKb47PvSJ8JTzHYpbS3YyBbRdnfNAGrFuroMRVVTgRxEdVmVsIqkP9gwXywZ+b6p2b
        K1O38KTud+R1JjOFIbQmdAYduP3O3Ch+Yxi6kmuFDVggFcf4WcFwAKTiTRQE0FStoHGe6o
        L9vsiFWLIKpcDk4MSU7Ae9GYIDN48FYTX610M7PmL+ACZjaYota1vOGfsbEuvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620858126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGFID5hbvdrny8vdO/7dK4gdvpGzABRsXw2hjMkzC/s=;
        b=wIJGBrUERFqMiNZacQXR3BgedEHZF9PcBDAeylY0FHsNdEKlMTf3Hv8ZQgNLCRpy2H9oCt
        BfK7eBvsWIb4ZjBg==
To:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle all invalid syscall nrs
In-Reply-To: <b0ca952a-fd82-7833-ac82-ea8ecad48b53@zytor.com>
References: <871racf928.ffs@nanos.tec.linutronix.de> <60495dd3-ea68-4db3-47ad-b7b45796bf76@zytor.com> <87o8dfer7k.ffs@nanos.tec.linutronix.de> <b0ca952a-fd82-7833-ac82-ea8ecad48b53@zytor.com>
Date:   Thu, 13 May 2021 00:22:05 +0200
Message-ID: <87mtsz619u.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12 2021 at 15:09, H. Peter Anvin wrote:
> On 5/12/21 11:34 AM, Thomas Gleixner wrote:
>>>
>>> That is intentional, as (again) system calls are int.
>> 
>> They are 'int' kernel internally, but _NOT_ at the user space visible
>> side. Again: man syscall
>> 
>>      syscall(long number,...);
>> 
>> So that results in a user ABI change.
>> 
>>> As stated in my reply to Ingo, I'll clean the various descriptions and
>>> try to capture the discussion better.
>> 
>> If we agree to go there then this wants to be a seperate commit which
>> does nothing else than changing this behaviour.
>> 
>
> Good idea.
>
> As far as this being a user ABI change, this is actually a revert to the 
> original x86-64 ABI; see my message to Ingo.

I'm not against that change, but it has to be well justified and the
reasoning wants to be in the changelog. You know the drill :)

Thanks,

        tglx
