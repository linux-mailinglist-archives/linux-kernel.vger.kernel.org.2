Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C48389942
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhESW0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:26:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44641 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhESW0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:26:17 -0400
Received: from [IPv6:2601:646:8602:8be1:9435:8c14:a4d5:681] ([IPv6:2601:646:8602:8be1:9435:8c14:a4d5:681])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14JMOllh4193710
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 19 May 2021 15:24:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14JMOllh4193710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621463089;
        bh=eYBU9eQoc//DOagRIDo7bdMQ+ey1GFKvUIB5TSfZv3c=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=X+ruoyTv9V9BGIVlyXiHVmMZrIC8mUbqRcgqRrSYLg8Q5cU0C+d/ewdjqseszXMVE
         SX3yunq7GWGul9Lr77Ac7Fw8GsgukYYIdgOUDi69yYVLtDeCLEcNawy6JBf13RJKu7
         v/RqBARqfHgMBHTzAVnou0E9My9egICoLDS1CCTruAiM7htcjTsLSb5K+Mlu++PWwM
         w6KHELTzH6qznwR/elARoMuYMFHqzJbKRpASYEYCaN6jtoE6hzVjiZF20D6xJow8Fm
         wBHadunNQzJcFkmWT3gBB7bMCqT3VYNA/zyyDyaDafLc/TymkIiOq7HNP9Tc0TylFF
         ZH0/eE2iISs/A==
Date:   Wed, 19 May 2021 15:24:37 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <87bl96cqqy.ffs@nanos.tec.linutronix.de>
References: <20210519212154.511983-1-hpa@zytor.com> <20210519212154.511983-2-hpa@zytor.com> <87bl96cqqy.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/8] x86/traps: add X86_NR_HW_TRAPS to <asm/trapnr.h>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <E1F71F76-747B-4A22-98A2-5FBF17B83A1A@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not right now, but it will be used in the FRED enabling patchset at t=
he very least (since the number of exception vectors and FIRST_EXTERNAL_VEC=
TOR are not necessarily the same anymore=2E)

On May 19, 2021 3:17:57 PM PDT, Thomas Gleixner <tglx@linutronix=2Ede> wro=
te:
>On Wed, May 19 2021 at 14:21, H=2E Peter Anvin wrote:
>> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>>
>> The x86 architecture supports up to 32 trap vectors=2E Add that
>constant
>> to <asm/trapnr=2Eh>=2E
>
>Where is that actually used?
>
>Thanks,
>
>        tglx

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
