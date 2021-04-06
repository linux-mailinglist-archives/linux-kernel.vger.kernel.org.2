Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D518D355777
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 17:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbhDFPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 11:13:09 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:33816
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S233155AbhDFPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:13:08 -0400
Received: from NeildeMBP.local (unknown [60.24.14.254])
        by mailapp1 (Coremail) with SMTP id A7CowADnybpjemxg7igAAA--.726S3;
        Tue, 06 Apr 2021 23:12:36 +0800 (CST)
Subject: Re: [PATCH] mm/vmscan.c: drop_slab_node with task's memcg
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1617359934-7812-1-git-send-email-neilsun@yunify.com>
 <YGwMD3DOymOFJ7O5@dhcp22.suse.cz>
 <4dba277d-e497-5c34-0e68-fd2283585de2@yunify.com>
 <YGxIVDXw7wtBytIg@dhcp22.suse.cz>
 <d21f3b10-0c39-211f-dc45-e81c8da5dd9d@yunify.com>
 <YGxyojApNhi5DjFc@dhcp22.suse.cz>
From:   Neil Sun <neilsun@yunify.com>
Message-ID: <cc6bdbbd-bf9d-fa1b-ef53-933e877cf189@yunify.com>
Date:   Tue, 6 Apr 2021 23:12:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGxyojApNhi5DjFc@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: A7CowADnybpjemxg7igAAA--.726S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYr7k0a2IF6FyUM7kC6x804xWl14x267AK
        xVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I
        6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
        1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY
        62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7V
        C2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0
        c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjxUc_-PUUUUU
X-CM-SenderInfo: xqhlz21xq653pqli5hhfrp/1tbiAQAEClhaKtAGzQABs9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/6 22:39, Michal Hocko wrote:
> 
> Have you considered using high limit for the pro-active memory reclaim?

Thanks, Michal, do you mean the procfs interfaces?
We have set vm.vfs_cache_pressure=1000 and so on.
would you please take an example?

--
Neil

