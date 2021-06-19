Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DF13AD96B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 12:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhFSKhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 06:37:32 -0400
Received: from m32-153.88.com ([43.250.32.153]:27558 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230430AbhFSKhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 06:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=+uYqnPvtogFyEN7LANfThcJt1DZC50wi6LCxp
        +VDjU8=; b=TmhHGoCH4RLIsmp6ST0wqP76vEcjnMgDcBLRA57F7sSyvX1DMAixb
        MR5fAuUj+XC1q4jfGe8TlzSYDjJjKAYx9ACiDu4tDMaE/2+AQx3B/B1TlMJQmlev
        oeZHnFoW9WxjBdRWNPp1s62fHpX33KV4ldPNBTj8q78HHuWrp1JAiA=
Received: from [0.0.0.0] (unknown [113.251.9.208])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgCnffxjyM1g3SIeAA--.13172S3;
        Sat, 19 Jun 2021 18:35:17 +0800 (CST)
Subject: Re: [PATCH v2] docs: add traditional Chinese translation for kernel
 Documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210618014527.59826-1-src.res@email.cn>
 <87o8c3qd9n.fsf@meer.lwn.net>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <2a38e8ad-84d1-dd36-f6bd-3bf06a77f6f5@email.cn>
Date:   Sat, 19 Jun 2021 18:35:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87o8c3qd9n.fsf@meer.lwn.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgCnffxjyM1g3SIeAA--.13172S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4fAr1kGw1DArWxCryxGrg_yoWftrXEy3
        sakFn2kw17AryIqF4fAFsIkFsFka93Krs8Cr1kJryxZa4Utw4kuFWDW3sav3s5t3y8Cr9x
        GFs7Xry2qrnxujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbw8YjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6r1S6rWUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1U
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr2
        1lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UbAwxUUUUU=
X-Originating-IP: [113.251.9.208]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/19 ÉÏÎç1:43, Jonathan Corbet Ð´µÀ:
> Hu Haowen <src.res@email.cn> writes:
>
>> Add traditional Chinese translation (zh_TW) for the Linux Kernel
>> documentation with a series of translated files.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
> So this patch still adds a build warning:
>
>    /stuff/k/git/kernel/Documentation/translations/zh_TW/admin-guide/security-bugs.rst:31: WARNING: unknown document: ../process/submitting-patches
>
> Please do not resubmit this until you have built the result and know
> that it adds no further problems.  Take your time; I'm about to draw the
> line for 5.14, so there is no hurry at this point.
>
> When you do post a new version (of any patch), please include a comment
> describing what has changed since the previous posting.



No problem. I'll go to check everything over and provide the well-tested
version after Linux 5.14 release.


Thx,
Hu Haowen


> Thanks,
>
> jon

