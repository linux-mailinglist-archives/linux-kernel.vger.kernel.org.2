Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C71635F1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbhDNKxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232196AbhDNKxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:53:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 278C56128E;
        Wed, 14 Apr 2021 10:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618397568;
        bh=0c0DKD6R3exJ1ALKp0ZnNiJTJMmJ82AFfIDhibBbQjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I95/MfzqPZi2LAE9J5fOO9WSTnWTyfy69u8Wc3KSUCHKmGBnsSLoNdW77oZjEhZjX
         uchIecdDVJ3c/lgVimaE/bb9MGQrGdrdmcMwEWo7QQGN2LBgSaZzVvDn5mxww96L3X
         SerzpWT62JdHYGTy5E4UHQmX0eLLw1fjYioBRZHQaeA+VZbbMpjULZvzcQCMix2VaP
         kMe+XIkHFIWAY26ow7MO2mBfTAqrr1/JdsfDIxy+298L774pN7pPizaJzV4TlOA+9d
         0eIebquwDJBQmkzkJERq8BpUS8cRSITFDLwA7kqPJj1xSY9NwpjDx74O52mg5ySx5J
         Rh0g6QwlpFmBQ==
Date:   Wed, 14 Apr 2021 13:52:45 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Raoul Strackx <raoul.strackx@fortanix.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] x86/sgx: eextend ioctl
Message-ID: <YHbJfXqyhtUb1AKw@kernel.org>
References: <da7ae1e7-59b8-63db-a9f1-607b4e529639@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da7ae1e7-59b8-63db-a9f1-607b4e529639@fortanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:59:56AM +0200, Raoul Strackx wrote:
> Creation of an SGX enclave consists of three steps. First, a new enclave
> environment is created by the ECREATE leaf function. Some enclave settings
> are specified at this step by passing an SGX Enclave Control Structure
> (SECS) that contains the enclave MRENCLAVE, MRSIGNER, etc. This
> instruction also starts a cryptographic log of the enclave being built.
> (This log should eventually result in the MRENCLAVE.) Second, pages are
> added to the enclave. The EADD leaf function copies 4KB data to an empty
> EPC page. The cryptographic log records (among other properties) the
> location and access rights of the page being added. It _does not_ include
> an entry of the page content. When the enclave writer wishes to ensure the
> content of (a part of) the enclave page as well, she must use the EEXTEND
> leaf function. Extending the enclave cryptographic log can only be done
> per 256 bytes. Extending the log with a full 4K page thus requires 16
> invocations of the EEXTEND leaf function. It is however up to the enclave
> developer to decide if and how enclave memory is added to the 
> cryptographic log. EEXTEND functions may be issued only for relevant parts
> of an enclave page, may happen only after all pages have been added, and
> so on. Finally, the enclave is finalized by the EINIT leaf function. Any
> new invocations of the EADD or EEXTEND leaf functions will result in a
> fault. With EINIT a number of checks are performed as well. The 
> cryptographic hash of the final cryptographic log is compared to the
> MRENCLAVE field of the SECS structure passed to the ECREATE leaf function
> (see step one). The signature (MRSIGNER) over this MRENCLAVE is verified
> as well. When all checks pass, the enclave loading is complete and it
> enters the executable state.

Who do you expect to read this paragraph, seriously?

> The SGX driver currently only supports extending the cryptographic log as
> part of the EADD leaf function and _must_ cover complete 4K pages.
> Enclaves not constructed within these constraints, currently cannot be
> loaded on the Linux platform. Trying to do so will result in a different
> cryptographic log; the MRENCLAVE specified at enclave creation time will
> not match the cryptographic log kept by the processor and EINIT will fail.
> This poses practical problems:
> - The current driver does not fully support all possible SGXv1 enclaves.
>   It creates a separation between enclaves that run everywhere and
>   enclaves that run everywhere, except on Linux. This includes enclaves
>   already in use on other systems today.
> - It limits optimizations loaders are able to perform. For example, by
>   only measuring relevant parts of enclave pages, load time can be
>   minimized.
> 
> This patch set adds a new ioctl to enable userspace to execute EEXTEND
> leaf functions per 256 bytes of enclave memory. With this patch in place,
> Linux will be able to build all valid SGXv1 enclaves.
> 
> See additional discussion at:
> https://lore.kernel.org/linux-sgx/20200220221038.GA26618@linux.intel.com/
> T/#m93597f53d354201e72e26d93a968f167fcdf5930
> 
> 
> Raoul Strackx (3):
>   x86/sgx: Adding eextend ioctl
>   x86/sgx: Fix compatibility issue with OPENSSL < 1.1.0
>   x86/sgx: eextend ioctl selftest
> 
>  arch/x86/include/uapi/asm/sgx.h         | 11 +++++
>  arch/x86/kernel/cpu/sgx/ioctl.c         | 81 ++++++++++++++++++++++++++++-----
>  tools/testing/selftests/sgx/defines.h   |  1 +
>  tools/testing/selftests/sgx/load.c      | 57 +++++++++++++++++++----
>  tools/testing/selftests/sgx/main.h      |  1 +
>  tools/testing/selftests/sgx/sigstruct.c | 43 ++++++++---------
>  6 files changed, 154 insertions(+), 40 deletions(-)
> 
> -- 
> 2.7.4
> 
> 

/Jarkko
