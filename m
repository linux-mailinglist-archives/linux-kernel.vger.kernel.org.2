Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F7C3D4E1E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhGYNuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 09:50:09 -0400
Received: from [43.250.32.171] ([43.250.32.171]:52984 "EHLO email.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S231128AbhGYNuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 09:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=iCtZ6/DP/wOdXDUqSLO6T1YWhOlDxOcRzS1zd
        PtML7M=; b=hRoBnXp4XtgR8ygzlHXDoqz7EBAiUcRmcRqv60/DWX/lLtXK7JqPL
        NZneq8rSScY8EyutZipTvJ9ofODEK6u7cfN/Q644j3ofufj/Wjm7pBMOzn9k+OPy
        NGPtVLcndA579eHYoCo4IJaYNbV5Ftn51R90StEi1hoGwNWbYcp8cA=
Received: from [0.0.0.0] (unknown [113.251.13.19])
        by v_coremail2-frontend-1 (Coremail) with SMTP id LCKnCgDX5QSIdf1gMEEGAA--.18133S3;
        Sun, 25 Jul 2021 22:30:34 +0800 (CST)
Subject: Re: [PATCH v5 1/2] docs: add traditional Chinese translation for
 kernel Documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     panyunwang849@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210721142537.29409-1-src.res@email.cn>
 <20210725141435.112074-1-src.res@email.cn> <87eebmwk9n.fsf@meer.lwn.net>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <b46316da-9c91-4407-649f-c3304e73696f@email.cn>
Date:   Sun, 25 Jul 2021 22:30:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87eebmwk9n.fsf@meer.lwn.net>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: LCKnCgDX5QSIdf1gMEEGAA--.18133S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4fAr1kGw1DCr15JF47Arb_yoW3ZrXEkF
        y8twn5Cw17AF18tF4ftFsrCw1Iqa10g3WYk3y0q3yrJ3yqg3ykZrs7Xwnav39YyF48CasI
        kF1kZrW5ZrnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbwxYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_Cr1U
        Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr2
        1lc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
        AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
        cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
        8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUjwIDDUUUU
X-Originating-IP: [113.251.13.19]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/25 ÏÂÎç10:17, Jonathan Corbet Ð´µÀ:
> Hu Haowen <src.res@email.cn> writes:
>
>> Add traditional Chinese translation (zh_TW) for the Linux Kernel
>> documentation with a series of translated files.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
>> Reviewed-by: Pan Yunwang <panyunwang849@gmail.com>
> When you send a new version of a patch set, please include (after the
> "---" line) what changed.  Otherwise maintainers have no idea why you
> keep sending the patch out or whether it seems to be stabilizing.


Sorry, forgot to append them.

v2:
* Added more translations for zh_TW.

v3:
* Fixed building errors.
* Added SPDX identifiers for each file.

v4:
* Reorganised patch format and compressed patch content.

v5:
* Added Reviewed-by tag.

Thx,
Hu Haowen


> Thanks,
>
> jon

