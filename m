Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688783EB6E1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240855AbhHMOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 10:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233567AbhHMOle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:41:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7576360C41;
        Fri, 13 Aug 2021 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628865667;
        bh=lTE5dn1H2YpYJhp+KIjBVxOkkJJGTQc9GEOAL7tSiwA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=H2gjhKOwV+yFuZJQFg7xBJnDa37RmRuz0bql3OAK8punjgpTtBjc3R37ZmmYx3zA4
         QM9TZIBsDpfTZZs5p67PmaU6eaAt4iwLm9L1Y7BysAC71YITQpztblqiONVMYZ3h93
         EQMW5pW17PsPoTBmMpkfHNDG+boc63cX8P44m8/zbPcvNwVzfh6+snAVoOQiUnAEW2
         RyS+0r68PZfxMZ9ouOWcPtO/Px8nLOJZ5u2G8T+McY/F8492T2bZmWMS1r+e0iJGNC
         XKRHLrfTOhhEhQEw4qOzAAdyY4/ElBtVVzGTNwtwXeM+Hwil8Xq93P0VhQ6FFoD6ZB
         66KOA+EoGc2Lw==
Subject: Re: [PATCH] f2fs: convert /sys/fs/f2fs/<disk>/stat/sb_status to use
 string
To:     =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <AKcA0QDJDw7c2rSjY0-LUKqD.3.1628864269869.Hmail.frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <9b000232-c3dc-458c-2507-1dde8a8d985c@kernel.org>
Date:   Fri, 13 Aug 2021 22:41:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <AKcA0QDJDw7c2rSjY0-LUKqD.3.1628864269869.Hmail.frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/13 22:17, 李扬韬 wrote:
> HI Chao,
> 
> From: Chao Yu <chao@kernel.org>
> Date: 2021-08-13 22:09:53
> To:  Yangtao Li <frank.li@vivo.com>,jaegeuk@kernel.org
> Cc:  linux-f2fs-devel@lists.sourceforge.net,linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] f2fs: convert /sys/fs/f2fs/<disk>/stat/sb_status to use string>On 2021/8/13 22:01, Yangtao Li wrote:
>>> Do not use numbers but strings to improve readability when flag is set.
>>
>> This breaks output rule of sysfs entry, see below link:
>>
> Which rule? one entry should show one value？

Yes, one value per file please, which is suggested by Greg.

https://lkml.org/lkml/2021/6/3/319

> 
> But I see that:
> # cat /sys/fs/f2fs/<disk>/features
> encryption, quota_ino, verity, pin_file
> 
> So the format of features also wrong?

  What:		/sys/fs/f2fs/<disk>/features
  Date:		July 2017
  Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
  Description:	<deprecated: should use /sys/fs/f2fs/<disk>/feature_list/

Thanks,

> 
> Thx，
> 
