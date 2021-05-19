Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627FB38937C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355169AbhESQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:19:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47013 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355156AbhESQTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:19:24 -0400
Received: from [IPv6:2601:646:8602:8be1:9435:8c14:a4d5:681] ([IPv6:2601:646:8602:8be1:9435:8c14:a4d5:681])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14JGHehX4156114
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 19 May 2021 09:17:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14JGHehX4156114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621441064;
        bh=QZq82rVmyfNAQRGIThX8b6YcFi2fZNziFxXOsphMPf8=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=RuqkvFEpRqv0P2p9GIvXEI060homz7gPy1W5NvGeqYtJDM65NNl7UdIlxZI3qCFIW
         sfnYUGt8EGB2C+ghGCLD4u2LWI5+FP1CHfqwRIKaWVLcmbKip+QzkcV2/54zlAVSLX
         Ll/daff6jOvQR3YllO90IBUNSxRt0LKGm1JK1aSyVW4mkCTa4E50JP/ndQTfbSzfph
         +SIKZx3T6T9jVWCxvj5qnDcjtmznoG/fzrKdn5uOPqYWYIdH37+7A4PVU2mLrUxIzA
         p2GXa5nvdwo7POkBV4ahLZyOWyVVLiTZBwOWegJCYTFl7de55JvdaIsPGWxOXYVK4M
         dlbI3J1BF5B+g==
Date:   Wed, 19 May 2021 09:17:30 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <YKT2mW0xVZltBOSh@gmail.com>
References: <20210518191303.4135296-1-hpa@zytor.com> <YKT2mW0xVZltBOSh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/6] x86/syscall: use int for x86-64 system calls
To:     Ingo Molnar <mingo@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <62DB118D-3923-42E8-B3D2-3DF98F9A84C7@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

:)

On May 19, 2021 4:29:29 AM PDT, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>
>> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>>=20
>> This patchset addresses several inconsistencies in the handling of
>> system call numbers in x86-64 (and x32)=2E
>
>>  arch/x86/entry/common=2Ec                         |  93 +++--
>>  arch/x86/entry/entry_64=2ES                       |   2 +-
>>  arch/x86/include/asm/syscall=2Eh                  |   2 +-
>>  tools/testing/selftests/x86/syscall_numbering=2Ec | 488
>+++++++++++++++++++++---
>>  4 files changed, 508 insertions(+), 77 deletions(-)
>
>Thanks Peter - this series is really nice now, and I agree that this=20
>inconsistency should be fixed=2E
>
>Thanks,
>
>	Ingo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
