Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA1D386B59
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242595AbhEQUZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:25:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59263 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239459AbhEQUZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:25:53 -0400
Received: from [IPv6:2601:646:8602:8be1:c569:1cd0:3c83:3a98] ([IPv6:2601:646:8602:8be1:c569:1cd0:3c83:3a98])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14HKO82p3798008
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 17 May 2021 13:24:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14HKO82p3798008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621283052;
        bh=aTYSqhCKxLgX68/2PoXpp4s/LEOV3rjxKcfUXJ3LzYk=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=Byk55k+ywBwqDv/QZTAuLYM2fNPKX6CfkKinvB4Uij4G2DoECnoicoDBYXITADva3
         c0TDd9gYGGa+JQHIYexlcwIXfl7mlkxt+I5tjH+O9IPOd8KRwIt6DZbIxqFKpV2iQJ
         AeBOdoGXwgKl9myuEckARqAYkwshwTKbm22g5EjY0AB216uE1IMzePjKvBvnMpyUMS
         nwNDqbP9f01PKmA4cbfDWcfgYGTcpnb74y4VY3d2x+S3lcvJYIEi9BHBNhjDIThcZe
         ViY0YokJjrhriow39NKlMITJngXq+woqEzQWf2o0KtZ91FE7w6KaTukcMSGGfEFyVK
         WF5BIaE4h4mtQ==
Date:   Mon, 17 May 2021 13:23:59 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <YKDOQxRS+kX1WhQq@gmail.com>
References: <20210515011015.2707542-1-hpa@zytor.com> <20210515011015.2707542-2-hpa@zytor.com> <YKDOQxRS+kX1WhQq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/4] x86/syscall: sign-extend system calls on entry to int
To:     Ingo Molnar <mingo@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <4127D74A-A110-4EAB-9745-46997B1B031C@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No, this is what the Linux kernel did for a very long time=2E

On May 16, 2021 12:48:19 AM PDT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>
>> This is an ABI change, but is in fact a revert to the original x86-64
>> ABI=2E The original assembly entry code would zero-extend the system
>> call number; this patch uses sign extend to be explicit that this is
>> treated as a signed number (although in practice it makes no
>> difference, of course) and to avoid people getting the idea of
>> "optimizing" it, as has happened on at least two(!) separate
>> occasions=2E
>
>The original x86-64 ABI as documented by AMD, as we (probably) never
>had=20
>this in Linux, right?
>
>Sounds sensible to do this, assuming nothing relies on the weirdness=2E
>
>Thanks,
>
>	Ingo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
