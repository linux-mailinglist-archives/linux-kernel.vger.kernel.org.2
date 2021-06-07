Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696EC39DE29
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 15:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFGN7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhFGN7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:59:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DC8A60FF0;
        Mon,  7 Jun 2021 13:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623074274;
        bh=PpzF3zWAl8Xl1TXx6+EAS7kLqch5FlBePP3ou+vk7Ug=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=rXjQyMsxFA7O5vsEx2sM/b/mez3iFLAqAsIDt7RDs2kPS3WrJUbu+eiJSItSOYhfE
         JVT+e54LgAesk4Rs7PHPMOMbalbhoYT4+WYvfXjQSQBAZhhygswFBKD9zz9Nkwss1J
         Y3Fb78kOTyeT0Zi3IYobvC7QmDJN/z7vu1nPBeSsdXXaJowHwGcUb5UQIggeb9Ln0G
         0R6t3S1tO0lMpE/RvMzo+qhm61NOFLxdPgKLXef1dil9ahti3bREfbZNCosYdZc9Qj
         tgFvn6fITewnr61IBhcU6VpefoMnwCVJIk0+7PiKRAqAH0mvh8Nd1Kfb1dl4MAi1sK
         ZtjiPpI1PQMyw==
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: add pin_file in feature list
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210605003210.856458-1-jaegeuk@kernel.org>
 <20210605003210.856458-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <b6c48972-7135-cec7-60d0-e6c067505052@kernel.org>
Date:   Mon, 7 Jun 2021 21:57:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210605003210.856458-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/5 8:32, Jaegeuk Kim wrote:
> This patch adds missing pin_file feature supported by kernel.
> 
> Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
