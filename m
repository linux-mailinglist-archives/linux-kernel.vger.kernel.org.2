Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F6939C412
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 01:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhFDXtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 19:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229853AbhFDXtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 19:49:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E245E613BF;
        Fri,  4 Jun 2021 23:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622850472;
        bh=NLvDgBamIlTsoUpyubJK48lcnagyEU52NZCy5eYLioo=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=hnxH246GlLi904F4IdS+r6IcKoaZB6Hpcn3tJlLzavyZGdzveTbYwgivS5lcoIrFs
         CS7Z5xbGgfdhE0VQehGBRWNYH35/X0EI8uh57HuuP2P0Q9oENxr+6VJE5VT8TNjlC+
         A+Hw4Bb5Lw/3E0HUjW//cXOb2rZIWHZCS8OdGfnuplSb83bbExwsWI39Pv9Kw/4eUM
         9U/Yud3L7zPSV+5dkqe5JuCwgDkREwFSqR5UYZmYS4Tp89F0n9MCqdGjx+rp/P1B/0
         QrwU1zHCsbEvlb4BUEPOpQl1Hfqj1H3tuMxkOkkqedyGV1P597AyvvdHn7xVUAz2Z+
         0KkRsJVe151Sg==
Subject: Re: [f2fs-dev] [PATCH 2/2 v5] f2fs: support RO feature
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210521190217.2484099-1-jaegeuk@kernel.org>
 <20210521190217.2484099-2-jaegeuk@kernel.org> <YK5UOfzwdZni7c5W@google.com>
 <YK5edM0igwfd47LV@google.com> <YLfV4EPW5Yw6wP+v@google.com>
 <YLj+mQJ6IlADZksB@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <a6f00d18-e9a0-42cc-f0af-fe3852b54243@kernel.org>
Date:   Sat, 5 Jun 2021 07:47:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLj+mQJ6IlADZksB@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/4 0:08, Jaegeuk Kim wrote:
> Given RO feature in superblock, we don't need to check provisioning/reserve
> spaces and SSA area.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
