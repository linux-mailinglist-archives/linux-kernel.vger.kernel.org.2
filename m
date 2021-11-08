Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE53448024
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 14:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbhKHNUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 08:20:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:37349 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235636AbhKHNUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 08:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636377466;
        bh=8VRJuqz5mdm7M5ya9dOR1Lz1mK1IdCM+kXHPM6HmnT0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=TFnKQmhrPsrMdBAjFJsECfGiWPPXmX5wYuxF1Bd9dN7DQXeILqa6VuR9jmt5Q19u0
         tUme9HGxYd/JVoBjcyLzsxK1/5uS7ouhb3Xx6yeOTxSSAU41gCd6w1knmfXUOIWWi9
         YsDrF4y2QIaGv944DMkOY66S6ygPsiSNQOJ/IYKc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.252] ([46.146.146.157]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrhUK-1mPIYo28Au-00nlTW; Mon, 08
 Nov 2021 14:17:46 +0100
Message-ID: <e8091012-dfac-ce9f-1b78-b07213a110e1@gmx.com>
Date:   Mon, 8 Nov 2021 13:17:45 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v1 (RFC)] docs: discourage users from using
 bugzilla.kernel.org
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
References: <20210110121033.130504-1-linux@leemhuis.info>
 <6abc7248-efda-b569-9030-5384e5ce1f29@gmx.com> <87mtme98l6.fsf@intel.com>
 <0b78b74e-5c72-1258-8373-5385d5709a6c@gmx.com> <871r3q950t.fsf@intel.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <871r3q950t.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FTWFyB2fwvLd9vaNQrqurIfdOn59dhILmVrObFI98JhHToy9sgf
 ZqPeReKBsokCCrDdKkyrB/ucebhLpB5xyimtJeQzBpFPdUhXaStgSwlpahGup0x3YJiyNHT
 AesvLqxV6V6ywR0bpHDqkPrdfQ52J18osaBnPmYhYTZtjySkoG5lG5pOlEbZ9abVUwuUgcQ
 SfTPALYy5FuRDZzs41ibg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ivR7jGVh0gg=:F/yNay50V7IAKii7npGcru
 XJ81S40Ba6uxqmkZ8Ez7K93cvyuY1zqUXHLJqaxFbBhjdy1nLTuv/z7xdc5y4RJ5Ijf8FqKhR
 9NO8w3AgnsRO9Jr3Xa47WlutnYoqcWHrTW10I27g1Lp3jyt31Kogtc/v5JEKPIxqWT1avsstG
 g79mgqUyI64v2ub+CMLJbdAKOt3q70af9zm4aqaTxABSzI8SkNgjfy/AgjiT9GKNnRXTPv0+A
 NWr9vJRtF7uyXNPUuKbbYb+Zxk2CohGTLkHCunkh6X4JTI8BDvIxtgLqL2RVUoxt+EO+BPgvT
 3Sbe4fhuy8EbnP5tB8/4jYTrtLZJbPd/0aJN2CBuh6fJx2g1x3Ic487O22D8vxsKJ9LCwL5v2
 JvMJQC64ixIFwkRJ/7NDhv7uQeydb32ulcu9/+Nl1000k3K1S5vzYi1OkudH2MQ71pmFGaY8c
 Xo4uWt0XX6xACm5clJXWea+jiqzxdVwCxhxS3IO529LiYBfTlyz0hcc+wJ6e6O7B6oi8GppNs
 /5egnBFnzrPbALqMuTd3uRJRJ31SDwqbU4o90tUVPVkuX3mMdL1dD4r1tUpRaLUf0EBD2C3+W
 O/+F5+PK1JVcYNrXscRibtV644JPso12sEwwdWdoEPIM6uiXgNHp3N3MFc0f16uuF5dup1hF+
 OVCGBRckinKs/1i7qN1++gHgLcPw4mcqkMF4RxmM/9PBxANdb+bRpe6FBFb9eFVEwo7UFNcVZ
 9sgfu9dI8O8AoGlbK5DQrWK/FDybZSRbhsB3jWM+3SBLJyy4I3/atGyWpXPvCra0hNkFXMfT+
 28uezYm4GRDHEiT4L0uaPXG4M9WJKnxPJILZRQsl6eKmLRxiVUBSnpzSZ4TW01iwsX/UggNqO
 pok3awykMnc3lmV9lpW5467qgbZIUeMNe1T+Ab4qK6/MF2GWXURHxgf1g8B8/xaZbQD3M6wJG
 4yy2z4GDIPJD/QNKrFi8wboQWQmzwfab8Bogk9zaAxOLTw4QEU2QEQWFScqzKd7osQYl/0sMa
 qU9o4E5b0TuXrZdERRg5ShZzHIMXJgTSNqI3uBnrx2iKZhoygHCNgFPOeAAhweQfDg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/21 13:00, Jani Nikula wrote:
> On Mon, 08 Nov 2021, "Artem S. Tashkinov" <aros@gmx.com> wrote:
>> It does *not* help one bit that we have different bug trackers and
>> mailing lists for a *single* component which is the kernel. No other
>> software project under the sun makes the user rack their head trying to
>> understand how and where to post bug reports.
>
> I suppose the kernel is a single component only from a fairly narrow
> user centric view. Sure, it would be nice, from a user perspective, to
> have a single bug tracker for everything. But behind the scenes, the
> kernel development community is so broad and fragmented it's basically
> impossible to get people to agree on a tracker that would suit everyone
> and that everyone would use. Furthermore, there are users that insist on
> reporting bugs on their own terms anyway, refusing to sign up to any
> trackers.
>
> Arguably "the single bug tracker" most users should report their kernel
> problems for triage first is their distro bug tracker.
>
>> Can we shut down bugzilla.kernel.org completely? In its current form
>> it's nothing but disgrace.
>
> Works for me, ymmv.

Linux hackers probably don't need anything at all, I'm talking about
average people.

 From the Official Debian documentation (
https://wiki.debian.org/DebianKernelReportingBugs ):

 > "If an oops is reproducible on latest please notify upstream via
email. Another way to notify upstream is to file a bug in
https://bugzilla.kernel.org/".

Lots of bug reports about the kernel in the Debian bug tracker see this:

 > "Report upstream".

Which is the opposite of what you can see at bugzilla.kernel.org

It's quite amazing that absolute most distros except maybe RedHat and
Ubuntu have zero people who can actually resolve kernel bugs yet the
kernel bugzilla denies the option of using it.

Anyways, looks like all the responsible people have their ears shut, so
let's leave everything as it is.

