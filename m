Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32BA36D071
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 04:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbhD1CJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 22:09:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47009 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236818AbhD1CJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 22:09:01 -0400
Received: from [IPv6:2601:646:8602:8be1:e065:664e:d52f:e11e] ([IPv6:2601:646:8602:8be1:e065:664e:d52f:e11e])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 13S27xHj976305
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 27 Apr 2021 19:08:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 13S27xHj976305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021032801; t=1619575681;
        bh=i2upMD0c98d+k4Ph6UAn9YCS0buIcnEd4HM0L+LF73E=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=CHM4yHPlMjZgURBbV6+CXJlZzdsu53OcvgWwDb8CHDcYiMnUo+LbUcJKgxFMkR6d1
         XhqG0DsEaGclNtML/AB70YoB7od6gabjzhvaa9x4sPrb6rBWu5QP33aRa+dAn5nBNK
         dBaNTJMb642sCIWKujCp6HUkjXIyvh94IEHKeHj6YGdi9w9pM/Iio18GnUZFbA4PMw
         aacAKU8q2vMlkfAy+eTOzLHcEjX+s+xb5ocdryVQO7TPeEMGYkM38l+jLtPc52iSzw
         O1ZhKG52r9hdOszdb8hC1CdIU+CiyCR0vQ+PSAkMVcgNmpU7mr6Vuwqzj9TO4MwRD4
         JvMxc5/gNCeXA==
Date:   Tue, 27 Apr 2021 19:07:51 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <202104271857.4708C9A25@keescook>
References: <202104271619.0DBE456@keescook> <78327AF2-575F-415E-98D4-6ECDFE311D0F@amacapital.net> <202104271857.4708C9A25@keescook>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: pt_regs->ax == -ENOSYS
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Will Drewry <wad@chromium.org>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <C9135D5F-AEB4-4093-A54B-8AD99AD570C4@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier in the thread the suggestion was to have (int)pt_regs->orig_ax < 0 =
indicate a nonsyscall=2E

On April 27, 2021 7:05:56 PM PDT, Kees Cook <keescook@chromium=2Eorg> wrot=
e:
>On Tue, Apr 27, 2021 at 04:51:06PM -0700, Andy Lutomirski wrote:
>> Fortunately there is not, and never will be, a syscall -1=2E  But I
>> agree that calling max syscall + 1 should behave identically to
>calling
>> a nonexistent syscall in the middle of the table=2E
>
>If that happens, we have to separate the meaning of -1L from ptrace,
>seccomp, etc=2E (i=2Ee=2E we can't just add an "else { result =3D -ENOSYS=
; }"
>to
>the syscall table dispatching code, since that'll overwrite any written
>return value when the syscall is meant to be skipped with a specific
>return value set by ptrace/seccomp=2E
>
>syscall_trace_enter() will currently return either -1 or the
>syscall=2E Which means someone making a "syscall -1" will get the skip
>semantics currently (though the preloaded -ENOSYS results in the
>"expected" outcome)=2E
>
>arm64 recently had to untangle this too:
>
>15956689a0e6 arm64: compat: Ensure upper 32 bits of x0 are zero on
>syscall return
>59ee987ea47c arm64: ptrace: Add a comment describing our syscall
>entry/exit trap ABI
>139dbe5d8ed3 arm64: syscall: Expand the comment about ptrace and
>syscall(-1)
>d83ee6e3e75d arm64: ptrace: Use NO_SYSCALL instead of -1 in
>syscall_trace_enter()

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
