Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCC93ECCB2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 04:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhHPChr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 22:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhHPChq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:37:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BECDC6142A;
        Mon, 16 Aug 2021 02:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629081436;
        bh=WUD/8DbvF7bDWOd5JN9Kis9LnXnRA5Voh0Ka+8+qxDY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=upx9YR5t+qTBvxn52SAMoTzCYrJM93lUnea3J8A/m2EGuiNA4mmlZlijw5rAyY2Y+
         M8qs0TZKd4oKBQywnFw45LLzMStkniyBXBDwvnaBNXjH9M3BqvTmxJYITAHdeFEGaW
         k79Zn0OnqkHuZorut0YH9w9n302cqHkLxUefUbxLWr5QFFc2pQVEctT9A/eDDMlYDT
         u7CnOp5Gk3CHdG4/r5hQ6qumsG++cHm9V5Mx4Ii7sBc+Zh1msdnVLyEJejbTgIpa6J
         n2zt99YkREb//9hjOVy6HDjzDWuBEI1KsQsx17mJ+q5cDU7hBjvrPfCRsE+Gvj8xRF
         l2HtDK9jcLcKQ==
Subject: Re: [PATCH 2/2] f2fs: fix description about main_blkaddr node
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210814175840.115938-1-frank.li@vivo.com>
 <20210814175840.115938-2-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <90179e25-5ab7-bf66-2692-9715de8cb56e@kernel.org>
Date:   Mon, 16 Aug 2021 10:37:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210814175840.115938-2-frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/15 1:58, Yangtao Li wrote:
> Don't leave a blank line, to keep the style consistent
> with other node descriptions.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
