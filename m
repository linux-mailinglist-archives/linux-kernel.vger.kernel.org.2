Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682C33FC09B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 03:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbhHaB6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 21:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239306AbhHaB6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 21:58:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F1CD6101C;
        Tue, 31 Aug 2021 01:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630375026;
        bh=F+z5UHuWDdV+ffpMysnS1XGdtsy8b9i8pwL3eUp8Y/Y=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=XkQ21EPBzspO8UnY4PdnPN/P5iO5aqRfgY/egkyCMWg2eLOpT1ag6BEIcI2Y6w+0b
         rt4eWnILpvYj1TOhBiMx0h5wtpRG2sqeCb+AZ57LpfjsHSrCU2QOTAm7+hFtImzycv
         Nc43yb3AZ3NI/JU8RFe3I3EV1ahBbxPbfbVPRCmWcx0QnMUwLX8RD/PNjN38yvWs7J
         Ro3qWoob8Q2ge8qVwL7KFc3blISIgwaV13E08VWM8Ysxppr067Vp5xnu3atSPmqnRS
         bGuhaZZDp0ulipvoM7R9rKH9B5V87mbu5z2BPOn3yrIo8Jk6H2T8k3g93Mu9dGegl8
         AfwELM5tUCYWg==
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: deallocate compressed pages when
 error happens
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210831005346.118701-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <d7268523-aa56-323a-d5a8-bef7fc69f126@kernel.org>
Date:   Tue, 31 Aug 2021 09:57:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210831005346.118701-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/31 8:53, Jaegeuk Kim wrote:
> In f2fs_write_multi_pages(), f2fs_compress_pages() allocates pages for
> compression work in cc->cpages[]. Then, f2fs_write_compressed_pages() initiates
> bio submission. But, if there's any error before submitting the IOs like early
> f2fs_cp_error(), previously it didn't free cpages by f2fs_compress_free_page().
> Let's fix memory leak by putting that just before deallocating cc->cpages.
> 

Fixes: 4c8ff7095bef ("f2fs: support data compression")

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
