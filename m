Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3276F37EEEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhELWhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 18:37:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54757 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236601AbhELW0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 18:26:25 -0400
Received: from [IPv6:2601:646:8602:8be1:812f:3a6f:ca96:944b] ([IPv6:2601:646:8602:8be1:812f:3a6f:ca96:944b])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14CMOxP72846191
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 12 May 2021 15:25:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14CMOxP72846191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620858302;
        bh=Q2WUrsXVkyCwU5E/IBJ8TipdTznxB7biauepHNpCqEU=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=NB4n7ZWf8Gv6pYbQ67SEiZc1QV+gJgib47Zx1+AMsEu9PnKz0EdG4o4Er+HXn94eg
         35vOFZNUrocF9X+S5kJ7L9jTkagLeOlxyKDevKdKcU7p/XER5JOUcDr4jMUuVz5DjR
         o7qGWmcBBiocSQVtvOhr4hPgLXJaaWHGKagJQkTyf8BzivxLZ+ZtttEH6U5wqe3K+F
         w6TlS7RsEs/CGkUO7BoBWveIIeFLPnOwfm0mGaToeNDgUW8Mgs1Br1VY/H9xa1TMEJ
         JeaBdAveY7DnqfQnrtArr3G6bAm8g7HvgNEXObT/wRsKFCO/QvC//zr879M4hqD6R/
         Eu3xMxgt0mg1g==
Date:   Wed, 12 May 2021 15:24:50 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <87mtsz619u.ffs@nanos.tec.linutronix.de>
References: <871racf928.ffs@nanos.tec.linutronix.de> <60495dd3-ea68-4db3-47ad-b7b45796bf76@zytor.com> <87o8dfer7k.ffs@nanos.tec.linutronix.de> <b0ca952a-fd82-7833-ac82-ea8ecad48b53@zytor.com> <87mtsz619u.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC v2 PATCH 7/7] x86/entry: use int for syscall number; handle all invalid syscall nrs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <C2397A4D-8709-43F9-9967-51538B2B87FE@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, indeed=2E I hope my reply to Ingo clarifies it as I'm going to try to =
wordsmith that into a better piece of text=2E

On May 12, 2021 3:22:05 PM PDT, Thomas Gleixner <tglx@linutronix=2Ede> wro=
te:
>On Wed, May 12 2021 at 15:09, H=2E Peter Anvin wrote:
>> On 5/12/21 11:34 AM, Thomas Gleixner wrote:
>>>>
>>>> That is intentional, as (again) system calls are int=2E
>>>=20
>>> They are 'int' kernel internally, but _NOT_ at the user space
>visible
>>> side=2E Again: man syscall
>>>=20
>>>      syscall(long number,=2E=2E=2E);
>>>=20
>>> So that results in a user ABI change=2E
>>>=20
>>>> As stated in my reply to Ingo, I'll clean the various descriptions
>and
>>>> try to capture the discussion better=2E
>>>=20
>>> If we agree to go there then this wants to be a seperate commit
>which
>>> does nothing else than changing this behaviour=2E
>>>=20
>>
>> Good idea=2E
>>
>> As far as this being a user ABI change, this is actually a revert to
>the=20
>> original x86-64 ABI; see my message to Ingo=2E
>
>I'm not against that change, but it has to be well justified and the
>reasoning wants to be in the changelog=2E You know the drill :)
>
>Thanks,
>
>        tglx

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
