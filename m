Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309193332D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 02:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhCJBis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 20:38:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbhCJBiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 20:38:20 -0500
X-Greylist: delayed 3828 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 20:38:20 EST
Received: from wld181.hos.anvin.org ([73.241.8.88])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 12A0XnbN592126
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 9 Mar 2021 16:33:51 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 12A0XnbN592126
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021022501; t=1615336432;
        bh=MzuFaeZu6QRPAlMI4iKJwuvy4eL8SE2fjzwpcBF6Ev0=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=fptORvHHK2qftaFAC/79iYgavjjVn/3+WMnLGW/MfI8p+sCzejAu0ZqMLW6dwihfQ
         FlLOF6fokj2NkqmmApIc7fnt7Ncw92vq8D7YoEGa2HIH8VXondRgTy4kXWd5QeIDdu
         FyPXWoi/4FqDF5gDDra/ewoqtwpyIlxf1jvrYE5/H6rYVpZhzA6pJcatnrh07XXMTM
         uRPbQCgsZDwHd4j+2IIPPaJUQQHCViTvugj/T7NBtCW3Bc6Byv320GzzTBpmuD8vwq
         93wmHC+0Vd/kK7Xvhrrzocm9NlckAS1y0ZvjleOSzzVyqlaqDLyjSUbjLUadk57xQv
         uvi0+YVtq02rA==
Date:   Tue, 09 Mar 2021 16:33:45 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
References: <YEepKVHc5kkDybu6@hirez.programming.kicks-ass.net> <20210309120519.7c6bbb97@gandalf.local.home> <YEfnnFUbizbJUQig@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: The killing of ideal_nops[]
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     x86@kernel.org, linux-kernel@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <362BD2A4-016D-4F6B-8974-92C84DC0DDB4@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 9, 2021 1:24:44 PM PST, Peter Zijlstra <peterz@infradead=2Eorg> wr=
ote:
>On Tue, Mar 09, 2021 at 12:05:19PM -0500, Steven Rostedt wrote:
>> On Tue, 9 Mar 2021 17:58:17 +0100
>> Peter Zijlstra <peterz@infradead=2Eorg> wrote:
>>=20
>> > Hi,
>> >=20
>> > AFAICT everything made in the past 10 years ends up using p6_nops=2E
>Is it
>> > time to kill off ideal_nops[] and simplify life?
>> >=20
>>=20
>> Well, the one bug that was reported recently was due to a box that
>uses a
>> different "ideal_nops" than p6_nops=2E Perhaps we should ask him if
>there's
>> any noticeable difference between using p6_nops for every function
>than the
>> ideal_nops that as found for that box=2E
>
>If the machine is more than a decade old, I'm not really caring about
>optimal performance=2E If it is 32bit, I really couldn't be arsed as long
>as it boots=2E

p6_nops don't boot on all 32-bit chips=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
