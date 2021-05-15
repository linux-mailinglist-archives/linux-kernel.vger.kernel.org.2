Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB40381A62
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 20:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhEOSCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 14:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhEOSCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 14:02:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66BEE61355;
        Sat, 15 May 2021 18:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621101683;
        bh=yyDvkWDmS1l2BU9gEExbDmJ9Mh+fBWnlVK+32mSOm68=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ea7vQ7JstNbmjkITWdAQBrdHhqrUk14dva+VNdKfT8aG0L408nv8GFMxw/B6jQPNG
         MZ1I1R/6uZ23m4HUXyjf3549B/sjvZMsIp9bP3gyE4kiFREvC6wG2jPXdT1zDLliUL
         nzlBUgmLWbAEyM/q2F30aM6sRayX+q3yQPKtW54upsjTAFAjI67WeoujXPKcI3UEOB
         MyOHfWM8l7/JwJhwV0A/vZTi4XsgEXNO5j8/xQ430dr5Sv/1QXc8fk4WYFzKyDrFLR
         uXDxh4xOCpfyQgq8tnQnvEsfnH5zzvu8+cNswWksRjOfBhiQ5XHiwbogPPfp1cTOUs
         XaU4D79uPWsfw==
Subject: Re: [RFC PATCH v2 00/11] x86: Support Intel Key Locker
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, tglx@linutronix.de,
        mingo@kernel.org, bp@suse.de, x86@kernel.org,
        herbert@gondor.apana.org.au
Cc:     dan.j.williams@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210514201508.27967-1-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <9f556d3b-49d3-5b0b-0d92-126294ea082d@kernel.org>
Date:   Sat, 15 May 2021 11:01:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514201508.27967-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/21 1:14 PM, Chang S. Bae wrote:
> Key Locker [1][2] is a new security feature available in new Intel CPUs to
> protect data encryption keys for the Advanced Encryption Standard
> algorithm. The protection limits the amount of time an AES key is exposed
> in memory by sealing a key and referencing it with new AES instructions.
> 
> The new AES instruction set is a successor of Intel's AES-NI (AES New
> Instruction). Users may switch to the Key Locker version from crypto
> libraries.  This series includes a new AES implementation for the Crypto
> API, which was validated through the crypto unit tests. The performance in
> the test cases was measured and found comparable to the AES-NI version.
> 
> Key Locker introduces a (CPU-)internal key to encode AES keys. The kernel
> needs to load it and ensure it unchanged as long as CPUs are operational.

I have high-level questions:

What is the expected use case?  My personal hypothesis, based on various
public Intel slides, is that the actual intended use case was internal
to the ME, and that KL was ported to end-user CPUs more or less
verbatim.  I certainly understand how KL is valuable in a context where
a verified boot process installs some KL keys that are not subsequently
accessible outside the KL ISA, but Linux does not really work like this.
 I'm wondering what people will use it for.

On a related note, does Intel plan to extend KL with ways to securely
load keys?  (E.g. the ability to, in effect, LOADIWKEY from inside an
enclave?  Key wrapping/unwrapping operations?)  In other words, is
should we look at KL the way we look at MKTME, i.e. the foundation of
something neat but not necessarily very useful as is, or should we
expect that KL is in its more or less final form?


What is the expected interaction between a KL-using VM guest and the
host VMM?  Will there be performance impacts (to context switching, for
example) if a guest enables KL, even if the guest does not subsequently
do anything with it?  Should Linux actually enable KL if it detects that
it's a VM guest?  Should Linux have use a specific keying method as a guest?

--Andy
