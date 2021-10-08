Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC942650E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhJHHO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:14:29 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:37256 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230453AbhJHHOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:14:25 -0400
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-05 (Coremail) with SMTP id zQCowAD32O1D719hKcjVAg--.40575S2;
        Fri, 08 Oct 2021 15:12:03 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: Re: [PATCH] x86/microcode/amd: Add __list_del_entry_valid() in front of __list_del() in free_cache()
Date:   Fri,  8 Oct 2021 07:12:01 +0000
Message-Id: <1633677121-81314-1-git-send-email-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: zQCowAD32O1D719hKcjVAg--.40575S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZryDCFy5uFWDCF1rKFW3KFg_yoWxArg_W3
        WUC348WwsrCFZFga12vr4Fya97AFn8GFZ7tryftryxJw15KFZ8J3ZxuFW5ury5Wr1Yqrs3
        Kr4rJryqgFySvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8CwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUrVyIUUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 22:29:19PM +0000, Christoph Hellwig wrote:
>On Tue, Sep 28, 2021 at 09:04:44AM +0000, Jiasheng Jiang wrote:
>> Directly use __list_del() to remove 'p->plist' might be unsafe,
>> as we can see from the __list_del_entry_valid() of 'lib/list_debug.c'
>> that p->plist->prev or p->plist->next may be the LIST_POISON,
>> or p->list is not a valid double list.
>> In that case, __list_del() will be corruption.
>> Therefore, we suggest that __list_del_entry_valid()
>> should be added in front of the __list_del() in free_cache.

>No one should be using list_del directly anyway, so please fix that.

What the 'fix that' means?

