Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368243FFB2A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 09:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348029AbhICHhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 03:37:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54154 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbhICHhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 03:37:01 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3369F2202E;
        Fri,  3 Sep 2021 07:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630654561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ltqy+3DRfRdiQGosr4L+uYTJ4bKipSxcOsstokZ+jk=;
        b=DPcCKKA9qxNKVjhweOO7c670qU1jC6yb+amSSvmCifWjRFm+JTq/54FleHj4n8Qz+jjtcf
        NwRugrcC/FsJh25GAMZNZea7Jxe33JjpibYKmayrn9jgqj8t2bcU+/hp3BtsJ3KZ4861IQ
        Zznh6yens8OXjr2R/WBqtEusLHQuq9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630654561;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ltqy+3DRfRdiQGosr4L+uYTJ4bKipSxcOsstokZ+jk=;
        b=h5+y/0xCYJsVjpyJXbUMXLgaxfPdVolRoly/ux3YJmsSpmd9atLHCiHCLhYbsptEgbtj3C
        TqZYPgcP35gnk1AQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B8C83131F5;
        Fri,  3 Sep 2021 07:36:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id mT0QLGDQMWGCYwAAGKfGzw
        (envelope-from <mliska@suse.cz>); Fri, 03 Sep 2021 07:36:00 +0000
Message-ID: <36cf9869-4e4d-e0c6-bf71-981285bd8041@suse.cz>
Date:   Fri, 3 Sep 2021 09:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 02/24] x86/traps: Move arch/x86/kernel/traps.c to
 arch/x86/entry/
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
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
From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
In-Reply-To: <CAKwvOdmhUzR0QfAU+nVRtSPu11vg9yvyJ09Pb8q1X6CEfez=8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/21 19:05, Nick Desaulniers wrote:
> IIRC GCC only
> added the attribute recently in the 10.X release, so it might be too
> new to rely on quite yet.

The no_stack_protector attribute was actually added in the GCC 11.x release:
https://gcc.gnu.org/gcc-11/changes.html

Note the compiler is definitely used by Fedora, openSUSE Tumbleweed
and other cutting edge distributions.

Cheers,
Martin
