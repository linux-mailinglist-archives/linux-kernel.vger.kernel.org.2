Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF6D30B2DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBAWoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhBAWoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:44:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E56EC64EAA;
        Mon,  1 Feb 2021 22:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612219403;
        bh=GGx9mLzXB13SrdAkv11a3+KtOC9QBxi7gQxIdR+x0ec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oiErCaAXy1bcMVsVEC5+5/QOKGiK+/Ol/8/E2aLIWXtQ1hU+pfoyFn+twiBDVUyC+
         bAb6casYE/K//pHk6jtfbU6/b4EANBXsfsT+hdlv16VRShc+z+j+jlKlCV0kaZg2LW
         zJoDHWnuSCaE+qHDTTaiBGUCAGPh9GO3Lrlc/ntb5I0iFNTA8o6SBEt8DvKIxSer1e
         5cu6yBjx5B52MTpOze3QisP52wZMSI1yNNltRyGhZqjG+F9tP3nLmwVOU4qz01N1d+
         K1uhIZUfnKIkBgPBOW0aZJvH5Gt2Fq7vsE7tcxZbbs2SzcytEKVzEazSe5hqVpuXJE
         LaFN7PZTC2vIg==
Date:   Mon, 1 Feb 2021 14:43:21 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH RESEND] random: remove dead code left over from blocking
 pool
Message-ID: <YBiECal3aFOb7xPT@sol.localdomain>
References: <20210112192938.70666-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112192938.70666-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 11:29:38AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Remove some dead code that was left over following commit 90ea1c6436d2
> ("random: remove the blocking pool").
> 
> Cc: linux-crypto@vger.kernel.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> Andrew, please consider taking this patch since the maintainer has been
> ignoring it for 4 months
> (https://lkml.kernel.org/lkml/20200916043652.96640-1-ebiggers@kernel.org/T/#u).
> 

Ping.
