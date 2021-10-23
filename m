Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEAE438558
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 22:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhJWUo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 16:44:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55769 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhJWUoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 16:44:24 -0400
Received: from [IPV6:2601:646:8600:40c0:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8600:40c0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 19NKf4Af2291380
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 23 Oct 2021 13:41:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 19NKf4Af2291380
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021093001; t=1635021673;
        bh=M08KcBBnZ5xmty6COK1mkhbDyM7w0Gb9jHjSINaeOAM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dZvMZMmVpSQ9jOXTcsOi5gUFL9hjNHLSmAoNQ3x8SN5O86573QYFUEzpH1ea1ZJ/Z
         blrK7hKNDJnr3qlR/LmLKLpYj9roSJqJ2yQGn07/bMYGKqEtKYaBFqVrVpM248ou2W
         3s+i9sgrKMVQ5st9QtD0ZHdn+PqIZ1gZyR73ZBWDdT4mfVCJbpjDrfmNOk0wN5yZBB
         x84V9ypM8XVZUlLwsvQMPMn/rt+dWDw+dKLL83A68pweWNBfirVY7sOf8kQm68oTnD
         6pidgTdvsNqMopXkk8eJq2wTAyz5FE/4kbY1kuFNLImrOnvhA1UpUI/uIa/Ln+ehh/
         ufrHcw//Dx/Cg==
Message-ID: <8147f571-0da2-f20c-31dd-72ad56eb1ba0@zytor.com>
Date:   Sat, 23 Oct 2021 13:40:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the
 clobber list
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>
Cc:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
 <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
 <YWbUbSUVLy/tx7Zu@zn.tnic>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <YWbUbSUVLy/tx7Zu@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/21 05:43, Borislav Petkov wrote:
> On Wed, Oct 13, 2021 at 05:23:11AM +0700, Ammar Faizi wrote:
>> "Figure 3.4: Register Usage" is not the answer, if it were, nolibc.h
>> would be broken as it is missing "rdi", "rsi", "rdx" in the clobber list.
> 
> It is not about what happens in practice but what the contract is:
> syscall argument registers can potentially get clobbered and userspace
> should treat them as such. Because if the kernel decides to actually
> clobber them for whatever reason and some userspace thing thinks
> otherwise, then it is the userspace thing's problem as it doesn't adhere
> to the well known ABI.
> 

Currently the kernel doesn't, but some past kernels have zeroed some of 
these registers rather than preserving them.

	-hpa
