Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028C336CFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhD1AGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:06:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41307 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235653AbhD1AGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:06:23 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 13S05LvS952011
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 27 Apr 2021 17:05:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 13S05LvS952011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021032801; t=1619568327;
        bh=tNUNXGHMIILCFNhZ+vmwXye4RudA6BzWEic674v0qHE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FUD2HzcYBwpmlty4glmomzJ8xM6793gFMKME7usQFqRBakyDxw+rZ5sNNgKzHDm4E
         GqBvSM45OzjPdNXP8jfybkz1w/vZYZgWZLzsDQzxZsj3HUmbj7SN08RWQJGzN465b5
         TeBR1jg9iwuktfvsHT+WQXY+1ZF+8aHE/bD8H2vhpc+7HzD6wbOHFJbjBhV40mzqms
         BY0vJZaY1skIOkPXXju/3mOwJZEsbWl82E3bLoodKXs0EtVTyWyxcOKmynvkALNQj4
         JgE4DQUkT4jfaAdB9mc7yj5DI0wFR+tideeTuzr815pFs2hRfAKFBBAHZosdxLvXyQ
         MjuobgbD3PeJQ==
Subject: Re: pt_regs->ax == -ENOSYS
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
References: <f0240e15-223a-7600-4494-7a0a75155bdb@zytor.com>
 <F9F5E9D4-C1EE-455A-A6B1-4DF9D349BBAA@amacapital.net>
 <06a5e088-b0e6-c65e-73e6-edc740aa4256@zytor.com>
 <CALCETrW7Vu5ZU-Lv4RRG5DSGxMBJmDMqpvP7kqO16DwajproBQ@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <3626eea3-524e-4dbd-78dd-9ade5a346a08@zytor.com>
Date:   Tue, 27 Apr 2021 17:05:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CALCETrW7Vu5ZU-Lv4RRG5DSGxMBJmDMqpvP7kqO16DwajproBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/21 4:23 PM, Andy Lutomirski wrote:
> 
> I much prefer the model of saying that the bits that make sense for
> the syscall type (all 64 for 64-bit SYSCALL and the low 32 for
> everything else) are all valid.  This way there are no weird reserved
> bits, no weird ptrace() interactions, etc.  I'm a tiny bit concerned
> that this would result in a backwards compatibility issue, but not
> very.  This would involve changing syscall_get_nr(), but that doesn't
> seem so bad.  The biggest problem is that seccomp hardcoded syscall
> nrs to 32 bit.
> 
> An alternative would be to declare that we always truncate to 32 bits,
> except that 64-bit SYSCALL with high bits set is an error and results
> in ENOSYS. The ptrace interaction there is potentially nasty.
> 
> Basically, all choices here kind of suck, and I haven't done a real
> analysis of all the issues...
> 

OK, I really don't understand this. The *current* way of doing it causes 
a bunch of ugly corner conditions, including in ptrace, which this would 
get rid of. It isn't any different than passing any other argument which 
is an int -- in fact we have this whole machinery to deal with that subcase.

If it makes you feel better, we could even sign-extend the value in 
orig_ax, but that seems unnecessary and a bit broken to me.

	-hpa

