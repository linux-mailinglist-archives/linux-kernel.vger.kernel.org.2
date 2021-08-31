Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C8D3FC0AE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 04:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbhHaCFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 22:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239356AbhHaCFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 22:05:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21343600AA;
        Tue, 31 Aug 2021 02:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630375466;
        bh=tLp4LG+o8dZOpplbm9O+XCZS+ucavCtGk1I1yTmjv1Y=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=qwtrb9H/Ahn+PQZ9nIO7SGw7b07RIau5V+8u5rN47So/2Ti9SBHM+6myyLfYj8xII
         2F0Yr2Naq8nfb9wt3WFeOLcLefCs4PEXEb/ngk1HtqbC7Yfl2h0Aw9IpjcgCdTr8or
         bpBgakK/LcIBpr4a1PnePNU2kbc96E4m/2zAzo1XaN616Nx2qqiV1Mmd4vfpBueui9
         fTHaqu+c0u+LxNCYwbMQ+pi2vyngT1KiSRb4BBzNwJWgWgFwK3gvjb3zuhuGf7BW4v
         CFRdtaR4O5qKjBYpMXzsV8JQ/INzeEyVUvO7cTVegOSynMJdeqMCGO3xG1L0CTeB/F
         zGTjB6h4lNAyw==
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: should put a page beyond EOF when
 preparing a write
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210831005346.118701-1-jaegeuk@kernel.org>
 <20210831005346.118701-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f4ef1181-87e9-d76a-9084-29808aeef7b4@kernel.org>
Date:   Tue, 31 Aug 2021 10:04:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831005346.118701-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/31 8:53, Jaegeuk Kim wrote:
> The prepare_compress_overwrite() gets/locks a page to prepare a read, and calls
> f2fs_read_multi_pages() which checks EOF first. If there's any page beyond EOF,
> we unlock the page and set cc->rpages[i] = NULL, which we can't put the page
> anymore. This makes page leak, so let's fix by putting that page.
> 

Fixes: a949dc5f2c5c ("f2fs: compress: fix race condition of overwrite vs truncate")

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
