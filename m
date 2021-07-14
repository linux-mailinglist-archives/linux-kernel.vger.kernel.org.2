Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182AF3C8970
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 19:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhGNRQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 13:16:24 -0400
Received: from foss.arm.com ([217.140.110.172]:37398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhGNRQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 13:16:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74511D6E;
        Wed, 14 Jul 2021 10:13:29 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D64153F774;
        Wed, 14 Jul 2021 10:13:28 -0700 (PDT)
Subject: Re: [PATCH] cacheinfo: clear cache_leaves(cpu) in
 free_cache_attributes()
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     linux-kernel@vger.kernel.org, bobo.shaobowang@huawei.com
References: <1626148058-55230-1-git-send-email-wangxiongfeng2@huawei.com>
 <20210713113315.thsvrvqvqptc7hje@bogus>
 <303cd2bf-7142-6ec9-548a-afe7f6e5ca8f@huawei.com>
 <20210713132612.gvx7xpdp3tjcmxxu@bogus>
 <ee4db21a-e1cc-5847-d1fb-1d7735cf2164@arm.com>
 <93e6b13b-10b3-f371-d905-ba114df803fd@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ae05d599-3470-ec49-f354-79a6421c0d9c@arm.com>
Date:   Wed, 14 Jul 2021 18:13:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <93e6b13b-10b3-f371-d905-ba114df803fd@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng,

(CC: dropping Greg, Rafael and Sudeep as this isn't likely to be of interest to them)

On 14/07/2021 03:10, Xiongfeng Wang wrote:
> On 2021/7/14 1:38, James Morse wrote:
>> On 13/07/2021 14:26, Sudeep Holla wrote:
>>> On Tue, Jul 13, 2021 at 08:46:19PM +0800, Xiongfeng Wang wrote:
>>>> Actually, it's our own code that crashed. My colleague Shaobo(CCed) tried to add
>>
>> Seems to have dropped off the CC list.
> 
> Yes. I don't know why I didn't CC him success. CCed again.
> 
>>
>>>> MPAM support on ARM64.
>>
>> Do you want me to CC either of you on the series that refactor the resctrl code? This is
>> the bit that needs doing to get MPAM working upstream
> 
> It would be nice if you could CC him. His email address is
> bobo.shaobowang@huawei.com. Thanks a lot !

Thanks, I will!


> Below is the (openEuler version) MPAM support code he wrote based on your
> private version in linux-arm.org repo:
> https://gitee.com/openeuler/kernel/tree/openEuler-1.0-LTS/arch/arm64/kernel/mpam
> It would be appreciated if you could give some advice.

(I've not looked in any detail, but)

Beware duplicating any of the code that is involved in the user facing ABI. This will
create subtle differences between the behaviour of x86 and arm64 for the resctrl
filesystem. This must not be allowed to happen as its bad for user-space.


> console display:
> [root@localhost ~]# mount -t resctrl resctrl /sys/fs/resctrl/ -o
> cdpl3,caPbm,mbHdl,mbMax
> [root@localhost ~]# cd /sys/fs/resctrl/
> [root@localhost resctrl]# cat schemata
> L3CODEPBM:0=7fff;1=7fff;2=7fff;3=7fff
> L3DATAPBM:0=7fff;1=7fff;2=7fff;3=7fff
> MBHDL:0=1;1=1;2=1;3=1
> MBMAX:0=100;1=100;2=100;3=100

Please don't create new 'things' visible to user-space.
You should not need to change user-space software.

The whole point of using resctrl is so that existing user-space software works, and linux
has one behaviour across all architectures. (It doesn't matter if the names are wrong,
only the behaviour matters)

If new schema are needed, we should wait until we've got the existing resctrl stuff
working upstream, then discuss it with the x86 folk, as any new schema must be possible to
support on x86 too.


Thanks,

James
