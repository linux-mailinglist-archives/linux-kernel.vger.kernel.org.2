Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3514403582
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350051AbhIHHes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:34:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35290 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347750AbhIHHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:34:46 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 693A12223D;
        Wed,  8 Sep 2021 07:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631086418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6h8YZTx7xXQnfNkm+DDzIlZYm7doAL7yUOPCHmJhXno=;
        b=gl7tPg2mIal5OlfCS+rQJuMgcY7RpyMW3EVn0n/klpIeYZ9azHkJb5hdj6HcAgawfm5H2g
        us+M4DYK6/V0WDPC0tjTcdA4chP6fQI3z+FiNuDDzmfsr2t+ndy5kmcwFBVsKS3cTCKRXp
        5lh+4y1bnkFh7saqWLJGZNTdg/fz5XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631086418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6h8YZTx7xXQnfNkm+DDzIlZYm7doAL7yUOPCHmJhXno=;
        b=d19bmkWJi/WUfz4U0sz4wkaD+dAZ3diBGJgcUfm64+uvZug6E4WvGsl/k2HIec8zs2eRQV
        rsSZxM/ujD1tllBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id ECB1313721;
        Wed,  8 Sep 2021 07:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EGAAOFFnOGE9RQAAGKfGzw
        (envelope-from <mliska@suse.cz>); Wed, 08 Sep 2021 07:33:37 +0000
Message-ID: <124a19ef-0b50-2cf2-c6cc-12f443706883@suse.cz>
Date:   Wed, 8 Sep 2021 09:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to
 arch/x86/entry/
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chester Lin <clin@suse.com>, Juergen Gross <jgross@suse.com>,
        andrew.cooper3@citrix.com, linux-toolchains@vger.kernel.org
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-3-jiangshanlai@gmail.com> <YTCGov+vvAMvso7q@suse.de>
 <1f327579-e62a-df65-0763-e88243829db3@linux.alibaba.com>
 <YTCsWpSmPYvXa1xz@hirez.programming.kicks-ass.net>
 <4c589fef-8c98-a6fc-693f-b205a7710e42@linux.alibaba.com>
 <YTC+FTo4uLLdyBxA@hirez.programming.kicks-ass.net>
 <YTDS/p/bnsTFzNES@hirez.programming.kicks-ass.net>
 <CAKwvOdmhUzR0QfAU+nVRtSPu11vg9yvyJ09Pb8q1X6CEfez=8w@mail.gmail.com>
 <36cf9869-4e4d-e0c6-bf71-981285bd8041@suse.cz>
 <CAKwvOd=HfA-08N6LqCS54QcYBcuRgqjcuhVk0dioEte_DxqVqg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <CAKwvOd=HfA-08N6LqCS54QcYBcuRgqjcuhVk0dioEte_DxqVqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 23:12, Nick Desaulniers wrote:
> On Fri, Sep 3, 2021 at 12:36 AM Martin Liška <mliska@suse.cz> wrote:
>>
>> On 9/2/21 19:05, Nick Desaulniers wrote:
>>> IIRC GCC only
>>> added the attribute recently in the 10.X release, so it might be too
>>> new to rely on quite yet.
>>
>> The no_stack_protector attribute was actually added in the GCC 11.x release:
>> https://gcc.gnu.org/gcc-11/changes.html
> 
> Ah right, that lays more weight though that this feature is still too
> new to rely on quite yet.

Sure.

> Martin, do you know if what happens with
> regards to inlining when the callee and caller mismatch on this
> function attribute in GCC?  This is very much a problem for the
> kernel.

That's a know issue that was already discusses both in a Kernel mailing and
GCC bugzilla:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94722#c9

Martin

> 
>> Note the compiler is definitely used by Fedora, openSUSE Tumbleweed
>> and other cutting edge distributions.
> 
> Kernel supports GCC 4.9+ currently. This feature can only be emulated
> with the coarse grain -fno-stack-protector (or gnu_inline with out of
> line assembler definition...:( ).
> 

