Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EF23B49D1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 22:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFYUlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 16:41:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53055 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhFYUlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 16:41:42 -0400
Received: from [IPv6:2601:646:8602:8be1:493a:1894:bb79:383b] ([IPv6:2601:646:8602:8be1:493a:1894:bb79:383b])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 15PKcxPM2493588
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 25 Jun 2021 13:39:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 15PKcxPM2493588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021052901; t=1624653542;
        bh=igp6XzZHI+E6Xfij5w+bZK5PcIM6uGnLsBOjp1oo5XA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=IpX2dV9XNpR3SIeniryqT/62mEPx+WQ9Ol9xhuLANrVcX2w/oZm0AwJEfvr96e+nu
         y71LzIJbBpJ7rLOnpBJQUo2KGWxNnGgwCcUY3cL/9dbdHLKEy3XeOLZdJp/nEN3S81
         BPru/g2H0LOpbDCZdViFShUwYTiqF4HTPv2afLrbT8C/qAZ3zivBX3YhDrHpWMJFbE
         n+CApA3hlXggKsuFKP0no8zryMUgbU7qMxAJWLTOZPgp/teUoko7u0AEUV9fyL4+HG
         ZknJA7N8src5wFQAhLAHNlyTXmT20SxUonzEwfFFEqAKLY2btSFJ6uLYJ0Dq0mbOFp
         lYzUGSPMePcYA==
Date:   Fri, 25 Jun 2021 13:38:51 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <YNYJ9vVQPVWqCvVq@zn.tnic>
References: <YNRzSy3NuwBDYWwr@kroah.com> <YNR7aw+C+7AJnBIG@zn.tnic> <YNXG472lXPHlbuCF@kroah.com> <YNXkVBcmBvZL7khv@zn.tnic> <F8B4FDC6-851F-4EC5-A308-BBAB52A75EF3@zytor.com> <YNYJ9vVQPVWqCvVq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH] x86/tools/relocs: add __printf attribute to die()
To:     Borislav Petkov <bp@alien8.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <1EFF7FE1-D341-41DF-8681-D386A1BD6F7A@zytor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

64-bit cross build on a 32-bit platform=2E=2E=2E or Windows=2E

On June 25, 2021 9:53:10 AM PDT, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Fri, Jun 25, 2021 at 09:19:38AM -0700, H=2E Peter Anvin wrote:
>> You can use PRIu32/64 or cast to unsigned long long; it's not like
>the
>> performance for this case is going to matter one iota=2E
>
>Why "unsigned long long"?
>
>Those fields are typedeffed as:
>
>typedef __u32	Elf32_Off;
>
>or
>
>typedef __u64	Elf64_Off;
>
>respectively so they should fit in an "unsigned long" on the respective
>width=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
