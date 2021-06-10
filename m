Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66AC3A2798
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFJJDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230113AbhFJJDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:03:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DAA760E0B;
        Thu, 10 Jun 2021 09:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623315696;
        bh=oHe8XcKEKLKDeuczDRI5GTPHAyzZzPeeYWrrKnD+Opg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxIxupouoekDcM7btq1RBeEeCiJm6dBAlhOQuXMXWAM4YPvKVYTw5uBQ6EpQK4IBz
         5Q5eW2PAIhusIJgOVo63nycde2B3kNjSTaLjrym8FC0urw0Y7PsMSDFe+Gv/ErGLcQ
         0tfRGPILHL62YouQUE5YoKSBKR3pqCpj6dCPciTRjhsv9fx0iwr7iZR1jofHpjzMdO
         5SQfpEiSgkgqjrf8irplCwqJea3qaq9mFCI8dZ/LBxdbWuv4IJMTuP7sSqnhkZ9PIM
         JVAYq7wv6A6DWP0pr6gIMWU1du9N4xeCqC7O+W/AdxI0uTdfqq11KbTutleFYHAV4X
         6WYBp178VsjIA==
Date:   Thu, 10 Jun 2021 12:01:34 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Add SGX_PAGE_REPEAT flag for
 SGX_IOC_ENCLAVE_ADD_PAGES
Message-ID: <20210610090134.xetwllckm4dugg5c@kernel.org>
References: <20210610072117.76987-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610072117.76987-1-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 10:21:17AM +0300, Jarkko Sakkinen wrote:
> For uninitialized data, there's a need to add the same page multiple times,
> e.g. a zero page, instead of traversing the source memory forward. With the
> current API, this requires to call SGX_IOC_ENCLAVE_ADD_PAGES multiple
> times, once per page, which is not very efficient.
> 
> Add a new SGX_PAGE_REPEAT flag to resolve the issue. When this flag is set
> to the 'flags' field of struct sgx_enclave_pages, the ioctl will apply the
> page at 'src' multiple times, instead of moving forward in the address
> space.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

After sending this, I started to think that maybe it would actually better
to just add SGX_PAGE_ZERO flag, i.e. add zero pages and ignore src. That's
the main use case right now, and saves the user space from extra trouble of
having to do such page by hand.

That neither does prevent adding SGX_PAGE_REPEAT later on. I just see no
point of that generic functionality right now. It only makes simple use
case more complex.

/Jarkko
