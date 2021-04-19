Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635CF364D66
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhDSV6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhDSV6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:58:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FFCC06174A;
        Mon, 19 Apr 2021 14:58:15 -0700 (PDT)
Received: from zn.tnic (p200300ec2f078100695c51a35ee1b820.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8100:695c:51a3:5ee1:b820])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97BD01EC0300;
        Mon, 19 Apr 2021 23:58:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618869492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HSPaq69kDxbXvcDRlK8QBCQJYBR8HBSCY4Mm1C6F54o=;
        b=IgN79Z3R8uS+TkID/1zTU6PFt1/HlA53LP8UFvBFoMR45MZDxDwNexsTNl1EcLc85tV73P
        UDbzzmsNVLEwQDsL6PHQUlk9NuKWecG8uACBXRw8F9A6cPo1EFpA1x86/NphMQliJk4ED0
        WHhpbDIvBdwNUF8RlNswWjd6oSusWQk=
Date:   Mon, 19 Apr 2021 23:58:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Len Brown <lenb@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210419215809.GJ9093@zn.tnic>
References: <20210414095804.GB10709@zn.tnic>
 <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
 <20210415044258.GA6318@zn.tnic>
 <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic>
 <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic>
 <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic>
 <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 05:33:03PM -0400, Len Brown wrote:
> For this to happen, every thread would not only have to include/link-with
> code that uses AMX, but that code would have to *run*.

It looks like either I'm not expressing myself clearly enough or you're
not reading my text: the *library* does that decision automatically!

Which means *every* possible thread on the system.

Which means, *every* thread has a fat 8K buffer attached to it because
the library uses AMX on its behalf by *default*.

> I'm sure that the AI guys are super excited about matrix multiplication,
> but I have a hard time imagining why grep(1) would find a use for it.

It doesn't matter if you're imagining it or not - what matters is if the
decision whether the thread uses AMX or not is put in the hands of the
thread and *NOT* in the hands of the library.

Which means, majority of the threads should not allow AMX and only a
handful who do, will have to explicitly state that. And the library will
have to comply. Not the library decides for every thread itself because
the feature's there.

> Indeed, if anyone expected AMX to be used by every task, we would have
> never gone to the trouble of inventing the XFD hardware to support the
> kernel's lazy 8KB buffer allocation.

If it gives me fat-buffers-off-by-default and on only for a handful
of threads which really want it and *request* it *explicitly*, sure,
whatever gets the job done.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
