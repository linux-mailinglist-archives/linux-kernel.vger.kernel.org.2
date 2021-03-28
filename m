Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F234BF93
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 00:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhC1WTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 18:19:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39906 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhC1WTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 18:19:01 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616969939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBnlulUcudFGOrMXbrxctGOnuMwn/8hxknEjvKvwBvM=;
        b=xX/QeM4Ihfdqs7qopLP9Zw7oOjxZnd+spYdThjM4VDvHjJwvXRPeI/TVp5eC+g2g676oBd
        wIZJLZul0ox4uxjoO8CeK6SRpEAhQn/0ljUDM4ldaPmnvjd75vTk9Qjtc3So7E2pB1irfe
        n15a/c/ePdRLPqWicgdPNVfufx6iymua3FIFDZxoJPiUhzwMv7ZuKZMmxis283NdJAEZCx
        PqnjOFQvUaGzdfW7dTMeIA2tUK2R53KOcCL2IKF3AfYQRtDuA335mw+pSQ/v8gpb+emRbB
        bMZDkZEqQtbHRxYghRBI17MSjTO7Z7ohIzEGe9DppBbnMYkA7g/YV2PsHHzJkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616969939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rBnlulUcudFGOrMXbrxctGOnuMwn/8hxknEjvKvwBvM=;
        b=Ct8K9ehAA9WGeYqFE+2W42BV3Mzw1NHSe+2aZHqytnUI1BIdKP+b0LDXDsGG0d53R2MMqb
        Qu37alhzvR9w6JBg==
To:     Willy Tarreau <w@1wt.eu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mateusz Jonczyk <mat.jonczyk@o2.pl>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Testers wanted: Atom netbooks with x86_64 disabled by BIOS
In-Reply-To: <20210328215807.GA26428@1wt.eu>
References: <20210327203218.119372-1-mat.jonczyk@o2.pl> <20210327211322.121708-1-mat.jonczyk@o2.pl> <20210327232551.GA20783@1wt.eu> <87lfa8cchf.ffs@nanos.tec.linutronix.de> <20210328061837.GA22710@1wt.eu> <CAHp75Ve_Yhs3ib5yk=d-+bhb4vHpx-j6D4jGGBKuD2k1qv38Vg@mail.gmail.com> <20210328215807.GA26428@1wt.eu>
Date:   Mon, 29 Mar 2021 00:18:59 +0200
Message-ID: <87y2e6c46k.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2021 at 23:58, Willy Tarreau wrote:
> On Sun, Mar 28, 2021 at 11:14:05PM +0300, Andy Shevchenko wrote:
>> Where did you get an idea that it had 64-bit SoC from?
>
> It's an N2600, and I bought this laptop because N2600 supports 64-bit
> (and do have another mini-itx motherboard at work with the same CPU
> on it working pretty well in 64-bit):
>
>    https://ark.intel.com/content/www/us/en/ark/products/58916/intel-atom-processor-n2600-1m-cache-1-6-ghz.html

I bet that laptop is forced to 32bit via SMM or whatever because IIRC
there was some issue with the graphics drivers for 64 bit windows when
they were hot of the press 10 years ago.

>> Atom Based 64-bit ones are Bay Trail, Cherry Trail, Tangier (Merrifield),
>> Anniedale (Moorefield) and all based on Skylake family (Apollo Lake,
>> Broxton, Gemini Lake, ...).
>
> Well, to be honest, I've never been able to remind (nor sort) all these
> totally crazy names. The day someone gives me a mnemotechnic hint to
> remind them and their ordering, that will make me reconsider them. For
> now they're all "something lake", and I find it particularly difficult
> to map them to SKUs.

It's more than 'lake'. You'd need also a mindmap for trail, ville and
whatever magic endings they have. There is no mnemotechnic hint to map
them into something which makes sense.

I gave up long ago and the only thing I ask for is to provide me the
family/model number instead of the random code name of the day.

Thanks,

        tglx
