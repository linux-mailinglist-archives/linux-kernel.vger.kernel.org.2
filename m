Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501CF4210C9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbhJDN4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbhJDN4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:56:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BAAC0612AD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 06:44:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633355087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlqUi6UmtWoAEEnR2YBd8pYb9sadLQ39RmmUDRfncKA=;
        b=eR3KdjDVjlNg0whEUqH/p1vITc5DhYyrJvehyOYvp9sJidx+eKdejjl+d1beGQfZkOKnpb
        zFDXP+kOX3vNk/3h8Vbhlj8kUn6Nw8yRAxBpqPvezM1QNLYEQ267BtM9B9naSWVfQ31v3g
        msOuWxmMi0q3wXb5m4H4CC4+ntHWB9idJC1LpBM6x7n8uiQXk/l9wII4V9PSYKaTfvg2sJ
        wGuXm7lNb/jPhrlvxvaQL7g1gKgbkOH3AJQF0Pm76w8hhSgyoUT20Bloz8eqdK/f2fJ9Qi
        fIAngpzR5JXoGytY00VnZzXImJlQQnyyuDynrushS5NUZK08CylzdNLWek/MjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633355087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlqUi6UmtWoAEEnR2YBd8pYb9sadLQ39RmmUDRfncKA=;
        b=5u1RacOiWDyEpT/UDCs/9R/yQM77nwW5Sff9LtEJtIYA4oqahAD9c9NKIScLwtiTnujBIq
        Br2SWt2ij1k935Ag==
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
In-Reply-To: <5677A76F-82AA-458A-A910-C92E8B0C1061@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <87mtnrgkij.ffs@tglx> <5677A76F-82AA-458A-A910-C92E8B0C1061@intel.com>
Date:   Mon, 04 Oct 2021 15:44:47 +0200
Message-ID: <8735pghpkg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 02 2021 at 22:11, Chang Seok Bae wrote:
> On Oct 2, 2021, at 14:54, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Fri, Oct 01 2021 at 15:36, Chang S. Bae wrote:
>>> The patches are built on top of the recent upstream x86 FPU changes [13=
].
>>=20
>> which does not apply on:
>>=20
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
>>=20
>> because the relentless x86 folks changed the FPU code some more...
>>=20
>> You should know the drill by now.
>
> Oh, I=E2=80=99m sorry, that sentence was copied from the old cover letter=
s.
>
> I should have fixed that by saying it is no top of the mainline 5.15-rc3 =
as
> shown on the bottom:
>
>> base-commit: 5816b3e6577eaa676ceb00a848f0fd65fe2adc29

I know what a base commit is, but this still does not make it apply on
the tip tree which has already 10 patches against the FPU code applied
in the x86/fpu branch for 5.16. And that's the reference tree not some
arbitrary chosen base commit.

Thanks,

        tglx
