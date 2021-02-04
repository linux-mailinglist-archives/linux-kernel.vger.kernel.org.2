Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986E930B2E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBAWo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:44:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhBAWoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:44:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C903664EC8;
        Mon,  1 Feb 2021 22:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612219422;
        bh=8fryh4jUbbvx/ZeC4ZQFFdS9uZq/Klq4kVebe0v4jWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyPWXFWuo8+GPbM0W5/PBguyS9bDaY+LsLIMQlfzwdxavsX7i2d7pdDK4xW4bkH0w
         G+XP2YjoFwYttIZMMzvItLeg3YX1qz1op7OJp/TOogC75P5srnSXSacPdYPITzKj+2
         Os8kOuV6HiQgG7l27fNdoILNDnMFgRo62yA93YCy6EkWICN9LpUqUawAzKE3N8r0r5
         1x42BETBXZJ2wvGkpfzYqPhcCIvwgWb9fRikemLTeodlubyAp5R7c7gnBCj+92iI6O
         0vgcK4yb2jNZVPD/UEW5P/YYYiREBc6wL8YScYfvbbTcj/jU7cxeFVfJCT9yugWh0u
         VfJD7TpJKE4/Q==
Date:   Mon, 1 Feb 2021 14:43:40 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH RESEND] random: initialize ChaCha20 constants with
 correct endianness
Message-ID: <YBiEHO4hKFn9JcdY@sol.localdomain>
References: <20210112192927.70596-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112192927.70596-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:29:27AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> On big endian CPUs, the ChaCha20-based CRNG is using the wrong
> endianness for the ChaCha20 constants.
> 
> This doesn't matter cryptographically, but technically it means it's not
> ChaCha20 anymore.  Fix it to always use the standard constants.
> 
> Cc: linux-crypto@vger.kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> Andrew, please consider taking this patch since the maintainer has been
> ignoring it for 4 months
> (https://lkml.kernel.org/lkml/20200916045013.142179-1-ebiggers@kernel.org/T/#u).

Ping.
