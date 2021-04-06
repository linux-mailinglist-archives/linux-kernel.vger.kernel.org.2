Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4693556B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbhDFOej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:34:39 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:44796
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S232976AbhDFOeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:34:36 -0400
Received: from NeildeMBP.local (unknown [60.24.14.254])
        by mailapp1 (Coremail) with SMTP id A7CowAAnjdhbcWxglyIAAA--.985S3;
        Tue, 06 Apr 2021 22:34:04 +0800 (CST)
Subject: Re: [PATCH] mm/vmscan.c: drop_slab_node with task's memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1617359934-7812-1-git-send-email-neilsun@yunify.com>
 <YGwMD3DOymOFJ7O5@dhcp22.suse.cz>
 <4dba277d-e497-5c34-0e68-fd2283585de2@yunify.com>
 <YGxIVDXw7wtBytIg@dhcp22.suse.cz>
From:   Neil Sun <neilsun@yunify.com>
Message-ID: <d21f3b10-0c39-211f-dc45-e81c8da5dd9d@yunify.com>
Date:   Tue, 6 Apr 2021 22:34:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGxIVDXw7wtBytIg@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: A7CowAAnjdhbcWxglyIAAA--.985S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyxKrykJw1xWFWfuF1DAwb_yoW8GF4kpa
        y8GFWrGF4qyFySyrWIv3s2gw1F93s5GrWjkwn8Cw4DZr15Gr13Zr1IyayUZFyUArWxCanr
        ta9ru3yDXw1DtaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgg_TUUUUU
X-CM-SenderInfo: xqhlz21xq653pqli5hhfrp/1tbiAQAEClhaKtAGGgABsq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/6 19:39, Michal Hocko wrote:
> On Tue 06-04-21 19:30:22, Neil Sun wrote:
>> On 2021/4/6 15:21, Michal Hocko wrote:
>>>
>>> You are changing semantic of the existing user interface. This knob has
>>> never been memcg aware and it is supposed to have a global impact. I do
>>> not think we can simply change that without some users being surprised
>>> or even breaking them.
>>
>> Yes, do you think add new interface to sysfs is a good way? such as
>> /sys/fs/cgroup/memory/lxc/i-vbe1u8o7/memory.kmem.drop_caches
> 
> There were other attempts to add a memcg specific alternative to
> drop_caches. A lack of a strong usecase has been a reason that no such
> attempt has been merged until now. drop_caches is a problematic
> interface because it is really coarse and people have learned to (ab)use
> it to workaround problem rather than fix them properly.
> 
> What is your usecase?
> 

We have some lxc containers running on the server, when mysqld running 
backup jobs in the container, page cache will grow up and eat up all 
unused memory in the container, then some new jobs come, we can see that 
tasks are busy on allocing memory with reclaiming, so we want to drop 
page cache after mysql backup job for individual container, it will 
speed up allocing memory when new jobs come.

This patch only drop slab cache but not page cache, this can be the
first step if people really need this interface.

---
Neil

