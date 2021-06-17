Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131663AAC86
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhFQGlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:41:00 -0400
Received: from m32-153.88.com ([43.250.32.153]:49867 "EHLO email.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229560AbhFQGlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cn;
        s=dkim; h=To:From:Date; bh=gVCYY4y0rSp4bU2KZBiLrHcjxN8EnJN3SmevO
        doeLWw=; b=fR0qkOXpjoXIAMLAxI0vO97MUZshMdGho4C0qfsyN5yatD4ogvPWc
        3Vzth/IsxQ4jbMkhjOOYY7DjIlySERwck6U5lnCnp9vqSo5r48Ll89mPORPvrNAB
        myWSj7ekfJz2slK3mXYDMWo11o09BH33BWw4IMQsFf3zfFggRWtETo=
Received: from [0.0.0.0] (unknown [113.251.12.91])
        by v_coremail2-frontend-2 (Coremail) with SMTP id GiKnCgBnPfz07cpg9jMZAA--.1960S3;
        Thu, 17 Jun 2021 14:38:45 +0800 (CST)
Subject: Re: [PATCH] docs: add traditional Chinese translation for kernel
 Documentation
To:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210607132414.44601-1-src.res@email.cn>
 <4ecfaca0-801b-1827-2d6a-13690e016957@email.cn> <87wnqxbcjb.fsf@meer.lwn.net>
 <YMagPMuKYKWDpUj8@casper.infradead.org>
From:   Hu Haowen <src.res@email.cn>
Message-ID: <ecb06eb5-9319-a851-98e3-6b1554b90a37@email.cn>
Date:   Thu, 17 Jun 2021 14:38:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMagPMuKYKWDpUj8@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: GiKnCgBnPfz07cpg9jMZAA--.1960S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr18Cr1UGF47urWDtFW7twb_yoW8AF1Dpr
        4YgFy7C3WUAr1akwnakr48ua18tFs5Gw45Xr1rKwn5Ja98A34rKF4Sy3s0kFyY9F4xGF42
        vr4YgryrGF1DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUglb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
        cIk0rVWUuVWrJwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
        v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
        CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26F4U
        Jr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY4
        87MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Cr1UJr1l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
        xhVjvjDU0xZFpf9x07jHBTOUUUUU=
X-Originating-IP: [113.251.12.91]
X-CM-SenderInfo: hvufh21hv6vzxdlohubq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/14 上午8:18, Matthew Wilcox 写道:
> On Sun, Jun 13, 2021 at 04:55:04PM -0600, Jonathan Corbet wrote:
>> Hu Haowen <src.res@email.cn> writes:
>>> 在 2021/6/7 下午9:24, Hu Haowen 写道:
>>>> Add traditional Chinese translation (zh_TW) for the Linux Kernel
>>>> documentation with a series of translated files.
>>> Is this patch applied? I have another amount of changes on this, so
>>> please handle it as soon as possible.
>> I have been away from the keyboard for the last week, and haven't had a
>> chance to look at it yet.  That will happen soon.  Meanwhile, please be
>> patient; it has not yet even been a week since you posted this work.
>>
>> Taking a quick look, there are a couple of things you can do:
>>
>>   - We have a Chinese translation, now you are creating a different one.
>>     Please explain why that is needed?
> I think this explains it:
>
> https://stackoverflow.com/questions/4892372/language-codes-for-simplified-chinese-and-traditional-chinese
>
> So if we would consider having (eg) fr_FR and fr_CA, it's reasonable to
> have both zh_CN and zh_TW.  No, I'm not volunteering to produce en_GB
> (or is that en_UK?)
In my view, Chinese is not like other languages. The traditional Chinese
has numerous differences from the simplified Chinese, both in characters
and word groups. Hence it may make readers who favors traditional Chinese
feel unconfortable to read the translated content based on simplified
Chinese. So I think it's not a "volunteered" job but a meaningful thing.

Also, it is not a bad idea to bridge the gap for readers whose mother
tongue is traditional Chinese. That's the aim of the kernel documentation

translation work -- to provide as many translations as possible.


Thx,

Hu Haowen


