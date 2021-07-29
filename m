Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA013D9AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 02:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhG2Ayw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 20:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232837AbhG2Ayv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 20:54:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EEC26101C;
        Thu, 29 Jul 2021 00:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627520089;
        bh=ySj2WLCx/U6vUSMi0vPV9bFB7St2XGwXoloT+C5A3Nw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=SFP9YXncg5J/gGtO/esR7/KSWhcLNz1iJ5uG1SyKwNU7FtPsfj8o8gXd3BybRE4lF
         F9RpYK7o9OaHPVeBE82p8gZCA4coIrA2lTqV9gRrYygxFiHKdXIDLgLnRAaXZctbux
         s9eRq9YQn65n9TyZNVTHj7gBLxIRwgX+Ho7ajEEWjWkiKVKrxtMMBoqALXT3AMbulV
         w0MW5jgLNk4xWvOAFnCJw6YqxMMqmQA6R9aFuTwBERthv0KugWxLWSPgGiiX45FKrx
         XlWRpqJNzoJXiTsrPMPaqSnWjH3qtyS4OH3iCw3a2fR1zGp4LxH0kaBvPtV6f0GlJ8
         7MUmaPeW23Evw==
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not submit NEW_ADDR to read node
 block
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210726161357.105332-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <26d8629e-ade4-43e7-b95a-073809d59936@kernel.org>
Date:   Thu, 29 Jul 2021 08:54:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726161357.105332-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/27 0:13, Jaegeuk Kim wrote:
> After the below patch, give cp is errored, we drop dirty node pages. This
> can give NEW_ADDR to read node pages. Don't do WARN_ON() which gives
> generic/475 failure.
> 
> Fixes: 28607bf3aa6f ("f2fs: drop dirty node pages when cp is in error status")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
