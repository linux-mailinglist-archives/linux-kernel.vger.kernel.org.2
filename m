Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF037AB31
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhEKP4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:56:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43571 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhEKP4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:56:45 -0400
Received: from [IPv6:2607:fb90:a629:4785:a5a6:19f5:d1a:b505] ([IPv6:2607:fb90:a629:4785:a5a6:19f5:d1a:b505])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14BFtS762622669
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 11 May 2021 08:55:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14BFtS762622669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620748529;
        bh=eKHXKtJwhPGNhioJIaM+MEPlGqAd5loFCltzZv53jLg=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=k+VVuQEzC41hqA5bXMVy3q0jzwED0Q4YnB8Gokp6On+1bEqzOeR6KfSXa1T7wo4iS
         ajd3ulVAErcAggj5Y8LcVsz771drrKbAge5A2inR8u623ZPhEbLOGpapEpl858Kdlj
         odsJu2ekmJg2Av1Jpx1UxRaoGttqPMkxpC/JKl0lz2LFy9GLOz4bPrWJyw0vwUs28Y
         t6IJQtQzafr69HSyFPEqELylOjva5zh+TcL+Fbv4e+bM8TyeFrwfq/R0AXddQoo3yA
         aheCZZCHZlFnX0A6zKHx1otyjW6hUBBByl5fLmI5rxUSt7Izg19B73B1tzGRndVX6m
         20Cg/OCVOc9KQ==
Date:   Tue, 11 May 2021 08:55:24 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <87im3pfix2.ffs@nanos.tec.linutronix.de>
References: <20210511005531.1065536-1-hpa@zytor.com> <20210511005531.1065536-6-hpa@zytor.com> <87im3pfix2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 5/6] x86/irq: WARN_ONCE() if irq_move_cleanup is called on a pending interrupt
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
CC:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <6B00421C-8B00-45FB-BE54-EED082494D8C@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You are, of course, correct =E2=80=93 or 2 and 3 can be reversed, I believe=
=2E

On May 11, 2021 7:23:53 AM PDT, Thomas Gleixner <tglx@linutronix=2Ede> wro=
te:
>On Mon, May 10 2021 at 17:55, H=2E Peter Anvin wrote:
>> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>>
>> The current IRQ vector allocation code should be "clean" and never
>> issue a IRQ_MOVE_CLEANUP_VECTOR IPI for an interrupt that could still
>> be pending=2E This should make it possible to move it to the "normal"
>> system IRQ vector range=2E This should probably be a three-step
>process:
>>
>> 1=2E Introduce this WARN_ONCE() on this event ever occurring=2E
>> 2=2E Move the IRQ_MOVE_CLEANUP_VECTOR to the sysvec range=2E
>> 3=2E Remove the self-IPI hack=2E
>
>Actually 2+3 must be combined because _if_ this ever happens then the
>self-IPI loops forever=2E
>
>Thanks,
>
>        tglx

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
