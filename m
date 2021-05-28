Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E891F3947E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 22:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhE1UWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 16:22:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40135 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229520AbhE1UWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 16:22:14 -0400
Received: from [IPv6:2601:646:8602:8be1:98d9:d1bf:53df:75dc] ([IPv6:2601:646:8602:8be1:98d9:d1bf:53df:75dc])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14SKKIIW1331793
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 28 May 2021 13:20:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14SKKIIW1331793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1622233221;
        bh=X23WMSn9jCLm7Ii1JTp+Z5ckc4p+t9rPT5IcweeBPjg=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=c/B4HBiGCLmzseTgNXqgTpHT+IYramm1a+vn1nZmtB4IKjtpoih7IFcoUcuhd6+7d
         hMZbpw/xW8CBrXsOC92bxxbfCiBp7ws9qpsEgWJ1/dPct9d5FWoJIe3T2BPodiX7SO
         dcM4wb0NwqMSA9mdMmEX3m8XkpyxgW86QvPR1RnquhJ2A/pvA/c3i4dryzPn8InqKp
         E+whdZDR4R2Er9oWX+vyfjNdchjEwXqE+NbB51e3CoXeg6AGvQgpMw9gsC4ZsT2m9a
         kIw2Ftxypa8E+jDmH/DA761S7ys3t9SGfQb3vUma2bqXsVIfFnghYy2uZYssAZXZS7
         jJb29GpzyVc7w==
Date:   Fri, 28 May 2021 13:20:08 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <YLEBeJwHgnLxRtYW@zn.tnic>
References: <20210526081100.12239-1-rppt@kernel.org> <YK4LGUDWXJWOp7IR@zn.tnic> <YK53kWHb4cPeeHsd@kernel.org> <YK6QFLUoPZ7btQfH@zn.tnic> <f7525409-3987-f79d-9f52-71f6c0231491@zytor.com> <YLEBeJwHgnLxRtYW@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
To:     Borislav Petkov <bp@alien8.de>
CC:     Mike Rapoport <rppt@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        untaintableangel@hotmail.co.uk, x86@kernel.org,
        linux-kernel@vger.kernel.org
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <5AFA0407-7F2F-403A-B5BA-7D535993C776@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please just do it=2E It is insane to spend more effort on reclaiming at the=
 very most a few hundred kilobytes in this day and age=2E

On May 28, 2021 7:43:04 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Thu, May 27, 2021 at 07:12:51PM -0700, H=2E Peter Anvin wrote:
>> BIOSes have been known to clobber more than 64K=2E They aren't supposed
>to
>> clobber any=2E
>
>Yah, the BIOSes and what they're not supposed to do=2E Like they even
>care=2E
>
>> 640K is the limit because that is the address of the EGA/VGA frame
>> buffer=2E In the words of Bill Gates "640K ought to be enough for
>anyone=2E"
>
>Right=2E
>
>So thoughts on:
>
>https://lkml=2Ekernel=2Eorg/r/YK%2Bgv0vDfLVD7Sqp@kernel=2Eorg
>
>?
>
>Time to do what windoze 7 does?

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
