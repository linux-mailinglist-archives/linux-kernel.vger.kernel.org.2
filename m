Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8920D328083
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhCAOQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:16:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235686AbhCAOQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:16:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 975ED64DFB;
        Mon,  1 Mar 2021 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614608167;
        bh=3Rhut/BhHs+UNJ1y8XYOOu+7cTQI+a+CansNeF7J0Fw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=awBNsXMyC45D5DQr5/foB+lSLWtBeyBqIf+5spcD+lIcyhJzRIQ37NBsec/sRtJ4G
         jD7cMbejGSj8CjyTQ7XrXopPmAr6eKSsExgKXRgOdmz5G6on9h9j7wEwC0xCxJY6GL
         bIBJUTXng7LO3tWiQSpjJSdNK+Q8ONJlGQWd/tA8ciymUyVYV8egTyX4++85gLVzQm
         VAMz6zuthpvKIUgTGUS94t0s77zXFDqNG9rCdW9kE/GzddJGmACzGe61IhKCxFoA53
         Q1QA2Lc/9IlNKqDNZl82rwFl5VRUPN4R3VfjIzah+SH2A7ukDX8zmO5Lu8ENQUyZvO
         eMyZzRuh9lgOw==
Subject: Re: [f2fs-dev] [PATCH v2 3/3] f2fs: check if swapfile is
 section-alligned
To:     Huang Jianan <huangjianan@oppo.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, zhangshiming@oppo.com
References: <20210301045844.154809-1-huangjianan@oppo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <57c26fef-5566-cf91-3768-206ed7f09c7e@kernel.org>
Date:   Mon, 1 Mar 2021 22:15:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301045844.154809-1-huangjianan@oppo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/1 12:58, Huang Jianan via Linux-f2fs-devel wrote:
> If the swapfile isn't created by pin and fallocate, it can't be
> guaranteed section-aligned, so it may be selected by f2fs gc. When
> gc_pin_file_threshold is reached, the address of swapfile may change,
> but won't be synchronized to swap_extent, so swap will write to wrong
> address, which will cause data corruption.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
