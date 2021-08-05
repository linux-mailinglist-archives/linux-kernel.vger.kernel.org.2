Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E043E0B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 02:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhHEAaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 20:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229991AbhHEAaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 20:30:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE4D7610FD;
        Thu,  5 Aug 2021 00:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628123388;
        bh=fKieLesTCiXaeb8urF0Ymy+tmaf0uoqUENpfp0I62go=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vn5s/oVc4bdLiD2TOHDBnJ22Avzhv08uEdKUm50DR7qHK/EDLsSSNSy39IkNKM/XF
         KNHE01w6CuBc1oOktxPWGegJMb+8pxk117cVipqwomyhISSjn1ZjM3lLwt0Moe3nC4
         ae1wLfe98IFvzSE4/v92+NuWnKEQ83PL9H4EupHvtedjY72NSYBtlRBkpa8mu+kLGw
         aGSYqPm/KGRvPtNyvPNKF3T7JSz9HdXp5HLocRPutOC+Cc8g6RF2C5SWqk9KkOcdKS
         1uPTGhnpsm/YV3DJMSr+Au9nOB17PgrP08CK3oY4//mCOiEJNrxrzEczka7yVKhbsL
         Ev+48jc/QeSbg==
Subject: Re: [f2fs-dev] [RFC v3] f2fs: extent cache: support unaligned extent
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210804022348.1414543-1-chao@kernel.org>
 <YQsIj0wKk6YbN/FJ@google.com> <YQsmfm3ibU6bhvZr@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <0dad9863-4aa2-3ea3-fd97-457aa635ed66@kernel.org>
Date:   Thu, 5 Aug 2021 08:29:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQsmfm3ibU6bhvZr@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

On 2021/8/5 7:45, Jaegeuk Kim wrote:
> Chao,
> 
> How about this?
> https://github.com/jaegeuk/f2fs/commit/d6bbe121bc24dfabfedc07ba7cb6e921fb70ece0

Looks more clean, thanks,

> 
> I'm digging one bug in __insert_extent_tree w/ the patch tho.

Shouldn't we initialize @ei in f2fs_update_extent_tree_range(), otherwise,
__try_merge_extent_node(&ei) -> __is_extent_mergeable() will do the check
w/ uninitialized c_len of @ei.

>> On 08/04, Chao Yu wrote:
>>> +	if (from_dnode)
>>> +		goto skip_reading_dnode;

Wrong condition here, thanks for fixing.

Thanks,
