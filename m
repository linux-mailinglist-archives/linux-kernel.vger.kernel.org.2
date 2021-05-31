Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A701A395B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 15:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhEaNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 09:02:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41051 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhEaNCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 09:02:09 -0400
Received: from [IPv6:2601:646:8602:8be1:6d92:e814:a227:752f] ([IPv6:2601:646:8602:8be1:6d92:e814:a227:752f])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14VCxu311716979
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 31 May 2021 05:59:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14VCxu311716979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021052901; t=1622465999;
        bh=RhXhzl0nfT4L3gJHIb81pwCQTtyZ7/HupNUUU3YGQSA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=hl5p55dbk2pc3iUhN99+5EiNbS9vqC+jy9ebGEzk4mXOc00/3PGcniH0Bp6IyV6ex
         5GAjXJPHSNqbs5B7wvU2bEQJbJ/zuNGijoPEhc77gehMY4gZ5U8/PJAhUdVrbS9mJe
         KmHohRn9+tDZNUBskmhjVRtkQ5fbYMoXDQjyUQMbxI0a4Q9pZGfEd213p/X0l7mAf4
         jvkU6DN5m85ArHuE7PH5kXku65NDNOwNqgJBV5t0UDc1G6EkRWFEnq9DI/305X7jW9
         BsYvUMpc5tAvP0NWalyluQgcacEirM8dE3+KLWT6g5Sn7xTtAWtsm5GizGhMhPPBph
         LlINcnjuPRi6w==
Date:   Mon, 31 May 2021 05:59:47 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <8f74d4bd0d97445c8a976eab44fc9372@AcuMS.aculab.com>
References: <20210526081100.12239-1-rppt@kernel.org> <YK4LGUDWXJWOp7IR@zn.tnic> <YK53kWHb4cPeeHsd@kernel.org> <YK6QFLUoPZ7btQfH@zn.tnic> <f7525409-3987-f79d-9f52-71f6c0231491@zytor.com> <8f74d4bd0d97445c8a976eab44fc9372@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] x86/Kconfig: decrease maximum of X86_RESERVE_LOW to 512K
To:     David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "untaintableangel@hotmail.co.uk" <untaintableangel@hotmail.co.uk>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <E49AE58D-3C42-410B-8D6B-0768A11BA858@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry=2E=2E=2E very few correct answers here=2E

The load address is 0x7c00=2E The MBR is relocated to 0x600 by DOS=2E

MS-DOS doesn't *have* a TPR base, you are thinking of CP/M-80=2E

The IBM PC memory map reserved 640-768K for video, but the first generatio=
n adapters (CGA and MDA) didn't use the bottom 96K/64K (respectively) so it=
 was possible to add a little more RAM=2E The ROM BIOS wouldn't enumerate i=
t, though, so you had to hack around that=2E EGA took that away, though, bu=
t it seems that virtually no machines including clones had taken advantage =
of it anyway=2E

As far as affording it: the first IBM PC 5150 I personally used had 512K R=
AM=2E Not cheap, but not unheard of either; this was still before the 64K D=
RAM market crashed in early 1985=2E


On May 31, 2021 2:32:22 AM PDT, David Laight <David=2ELaight@ACULAB=2ECOM>=
 wrote:
>From: H=2E Peter Anvin
>> Sent: 28 May 2021 03:13
>=2E=2E=2E=2E
>> BIOSes have been known to clobber more than 64K=2E They aren't supposed
>to
>> clobber any=2E
>
>They probably shouldn't need anything above the base of the DOS
>transient program area preserved=2E
>Can't remember where that is though :-(
>
>It is hard enough finding a safe memory area for the MBR
>code to relocate itself to before loading the PBR=2E
>Both the MBR and PBR load at the same address - 0xc00=2E
>
>> 640K is the limit because that is the address of the EGA/VGA frame
>> buffer=2E In the words of Bill Gates "640K ought to be enough for
>anyone=2E"
>
>I thought the original memory map allocated 512K for memory
>and 512k for memory mapped I/O=2E
>No one could afford more then 512K DRAM :-)
>
>The 640K limit appears because nothing was actually mapped
>as the bottom of the 'I/O area' so memory could expand up
>that far=2E
>
>	David
>
>-
>Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
>MK1 1PT, UK
>Registration No: 1397386 (Wales)

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
