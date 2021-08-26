Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956843F9087
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbhHZWG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 18:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhHZWG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 18:06:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0CDA60FD8;
        Thu, 26 Aug 2021 22:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630015569;
        bh=VBa/teRBr1EjEHOGDgemDtGoBFFDgIjQWza+BjNZgBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sy2FUSfVBK2UJl59avQ8+vYglAmltCJFf+1GkbbmRraCT70TGMHIiOCqyCn/Fwxe0
         3eDqeNqDSYzwBgDcRHrnaht6Bsv9MYb8xu3W0an46/OvopE//SwD+6fipR/O7gPqkq
         eus7Yap7GLJd+BixxuThac2Vx9yeiw5cCVwb7voeBYKC12MPHT0WTcxesvpCO2rfNe
         qDhfGzgfSEjUmlOEnrswALFLHl4i79nvin2Rkz4tyhRoIKwnVJPYshMRkyX1zW0yBz
         L/GNBWotZDfmyS+vUqMsauvG95ESv98fQdl2XBQFxY6AOSPINgb8+cwHY6qc294/fK
         WKTu2q3ZRMW2w==
Date:   Thu, 26 Aug 2021 15:06:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: Remove GPL boilerplates from decompress lib
 files
Message-ID: <YSgQUNys90jh/ZgA@sol.localdomain>
References: <20210826214441.1614837-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826214441.1614837-1-kari.argillander@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:44:41AM +0300, Kari Argillander wrote:
> Files already have SDPX identifier so no reason to keep boilerplates in
> these files anymore.
> 
> CC: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>

It's fine with me.

Acked-by: Eric Biggers <ebiggers@kernel.org>

- Eric
