Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075893C7D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 05:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhGNEAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 00:00:20 -0400
Received: from m32-153.88.com ([43.250.32.153]:27472 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229457AbhGNEAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 00:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=rm2lLaB6O1Qj6SBTUbJAP6ni2BTzbos2FjjL9
        R4HcFk=; b=cKEzJ/RnSxRUN5Alr7ntEX15NQ0pli36+R/y1fB4bR8UbQWZxSR2H
        5cFGOjb72xH7MAgQMlXYm78BCJ7y5mDxouDG521sz01sdQ7t8LBnRCOLpCP+IVGH
        J1L3wcpZjeHjYkKAWbXUc36VgLZwR5ycOTPBHGevti1JNLFnlssvPw=
Received: from [0.0.0.0] (unknown [113.251.12.220])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgDnvfyhYO5gSb1SAA--.11711S3;
        Wed, 14 Jul 2021 11:57:22 +0800 (CST)
Subject: Re: [PATCH v3 3/4] docs/zh_TW: fix an issue while building
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210703143130.18349-1-src.res@email.cn>
 <20210703143130.18349-3-src.res@email.cn> <87r1g3pied.fsf@meer.lwn.net>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <889b9541-43cf-a92d-b9f2-a46acd528120@email.cn>
Date:   Wed, 14 Jul 2021 11:57:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87r1g3pied.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgDnvfyhYO5gSb1SAA--.11711S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr45JFW7XFW3uF1fGFy7GFg_yoW8Gw1xpa
        9rKFZ7tasrCFyUGFs7Gr12yw4FyrWI9a1rGF1Dt34kuwnxAFn3KFZIgr9I9FZ5urs5tFnY
        qF4qqr95uw1UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUymb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0x
        vYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_
        Cr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
        xvr21lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1U
        Jr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
        14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jABM_UUUUU=
X-Originating-IP: [113.251.12.220]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/13 上午1:10, Jonathan Corbet 写道:
> Hu Haowen <src.res@email.cn> writes:
>
>> When building the documentation, the following issue was reported:
>>
>>     /home/src-resources/Coding/Projects/Other-Projects/Linux/Documentation/
>>     translations/zh_TW/admin-guide/reporting-issues.rst:712: WARNING:
>>     duplicate label translations/zh_tw/admin-guide/reporting-issues:
>>     檢查「汙染」標誌, other instance in /home/src-resources/Coding/Projects/
>>     Other-Projects/Linux/Documentation/translations/zh_TW/admin-guide/
>>     reporting-issues.rst
>>
>> Consequently, replace "檢查「汙染」標誌" with "檢測「汙染」標誌" to
>> solve it.
>>
>> Signed-off-by: Hu Haowen <src.res@email.cn>
> Please, just update the original patch to not introduce the error in the
> first place.  While you are at it, add the SPDX headers when you first
> add the files rather than fixing it up afterward.


Thanks for your notification. I'll pay more attention next time.


> This is a vast amount of material that I am absolutely incapable of
> making any sort of informed decision on.  Is there any chance that
> somebody can review this work?


I've already checked the files line by line and everything goes well.
Considering nobody who is accustomed to the language can be contacted
at the moment, you're able to apply these changes.

Thx,
Hu Haowen


> Thanks,
>
> jon

