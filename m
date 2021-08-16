Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2114C3ECD84
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 06:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhHPEPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 00:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhHPEPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 00:15:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 453AC619E1;
        Mon, 16 Aug 2021 04:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629087319;
        bh=joQfJDa6jYkYAOeq+GjOycG0LtXj3Zk0aKsaKrbhQjI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aYM6pmMGFwnhaeeZHuZab3dkBpAqqk05BR8yssOf7e/gdEF9N0E428nBFHcxUYMxl
         mIkbi6uDrEvQsoxCDzVJ060AGgwwVSwZebSXQ3O2Syxr92vpvZ9AtnRfjPQWRB5TF1
         vCxZRqZGnMFO/e9PIiqMXA+Iw4QNJMDaUM8aw+B/A59gKY1B+0T53vPl2CuFlw2so8
         kVjC/DQ7e4LDB7N1attrogGPLZ2qP2tRqOOhXy259Rak5XiCtvYc2caFzRjzmmvaTw
         2V+5g7dgUlbx6MzGgm9Jemfp7q/nZ8Olwuc198+bCVypLAEUKXDlR43tAdou5P8law
         fp3eMr8GS0wdg==
Subject: Re: [PATCH 1/2] f2fs: add sysfs nodes to get discard information
To:     =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <ACIArwDxD7lffBbq-DPSbarm.3.1629081754403.Hmail.frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <af34f9cd-8972-583b-bae2-f11fe9058e63@kernel.org>
Date:   Mon, 16 Aug 2021 12:15:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ACIArwDxD7lffBbq-DPSbarm.3.1629081754403.Hmail.frank.li@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/16 10:42, 李扬韬 wrote:
>>> I've added new sysfs nodes to show discard stat since mount, which
>>> will help us analyze whether the performance problem is related to
>>> discard.
>>>
>>> issued_discard  - Shows the number of issued discard
>>> queued_discard  - Shows the number of cached discard cmd count
>>> discard_cmd_cnt - Shows the number of cached discard cmd count
>>> undiscard_blks  - Shows the number of undiscard blocks
>>
>> We have exported them in debugfs, can you use that?
>>
>> Thanks,
> 
> But now Android is forbidden to open debugfs, and in fact we have not
> opened this configuration for a long time.

Weren't them be used for debug purpose? can you please explain more about
your use case?

Thanks,

> 
> Thx,
> Yangtao
> 
> 
> 
