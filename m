Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57273346A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 19:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhCJSX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 13:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhCJSXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:23:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C19264EE2;
        Wed, 10 Mar 2021 18:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615400591;
        bh=ofwr0djgmV5AwKLBclBoFXU08p4fHrwTsEPkjAt2/fs=;
        h=Date:From:To:Cc:Subject:From;
        b=AEGjpzvLa7RfaY0h8oucryFjkgkIcnhtkgAhT2MHcu44s+8mMXR92hV3saEDnUG2V
         ya1YQaO2yZAvzLhBPBRD4RAOApvBocEw3rTb3DGDzwbnYYbODluN1IlHMVTG9WbK26
         8YRCiNLQCwnkHT+1CZ/PqTuy2vUs6r7t43MiIj/egaSEix18bwtFikly7Rz/xjTq9c
         GAYvmYWEPtK9MIR6hsUYJPrMlkFFmchspBPJRLt2R931wF13Xjj8Z/utoNFUuAHeas
         fPBNca/2Q5l9wau/uGIVKTNrj1jFixlGqJ9ArojTZXTbkrFI+zBnxoA29EQYlBOm+A
         kVIzS3/OvJsMQ==
Date:   Wed, 10 Mar 2021 11:23:07 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: -Walign-mismatch in block/blk-mq.c
Message-ID: <20210310182307.zzcbi5w5jrmveld4@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

There is a new clang warning added in the development branch,
-Walign-mismatch, which shows an instance in block/blk-mq.c:

block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to
32-byte aligned parameter 2 of 'smp_call_function_single_async' may
result in an unaligned pointer access [-Walign-mismatch]
                smp_call_function_single_async(cpu, &rq->csd);
                                                    ^
1 warning generated.

There appears to be some history here as I can see that this member was
purposefully unaligned in commit 4ccafe032005 ("block: unalign
call_single_data in struct request"). However, I later see a change in
commit 7c3fb70f0341 ("block: rearrange a few request fields for better
cache layout") that seems somewhat related. Is it possible to get back
the alignment by rearranging the structure again? This seems to be the
only solution for the warning aside from just outright disabling it,
which would be a shame since it seems like it could be useful for
architectures that cannot handle unaligned accesses well, unless I am
missing something obvious :)

Cheers,
Nathan
