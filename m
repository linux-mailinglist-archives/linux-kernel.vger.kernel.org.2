Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3E236B509
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhDZOjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:39:35 -0400
Received: from mail1.perex.cz ([77.48.224.245]:32850 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233825AbhDZOjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:39:33 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4AFD9A0040;
        Mon, 26 Apr 2021 16:38:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 4AFD9A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1619447927; bh=6XnVk6uucelw2ilTlLHMXVhROA8TS7AQk5AvvyBmftc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gUvHkg/fJ+SwnkMUGiKgRcGrnu4U+4zEClSjWG12Pnr11QJyoYrjrsW+er01XwtWu
         fz/3d2Em5SXNQWyw3dgTLQktu0rbY8BNbiGCDoOtcp2UfHlENf6bIikAshuKOq8Gmi
         efyXknkBXi+JOSeotQadSw/YGYEjOdW02TeMeGvE=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 26 Apr 2021 16:38:42 +0200 (CEST)
Subject: Re: [PATCH] sound/isa/sb/emu8000: Fix a use after free in
 snd_emu8000_create_mixer
To:     Takashi Iwai <tiwai@suse.de>, Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20210426131129.4796-1-lyl2019@mail.ustc.edu.cn>
 <s5ha6pl2kh8.wl-tiwai@suse.de>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <af5a6764-76ee-3184-2622-a756c23fbc98@perex.cz>
Date:   Mon, 26 Apr 2021 16:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <s5ha6pl2kh8.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 26. 04. 21 v 16:23 Takashi Iwai napsal(a):
> On Mon, 26 Apr 2021 15:11:29 +0200,
> Lv Yunlong wrote:
>>
>> Our code analyzer reported a uaf.
>>
>> In snd_emu8000_create_mixer, the callee snd_ctl_add(..,emu->controls[i])
>> calls snd_ctl_add_replace(.., kcontrol,..). Inside snd_ctl_add_replace(),
>> if error happens, kcontrol will be freed by snd_ctl_free_one(kcontrol).
>> Then emu->controls[i] points to a freed memory, and the execution comes
>> to __error branch of snd_emu8000_create_mixer. The freed emu->controls[i]
>> is used in snd_ctl_remove(card, emu->controls[i]).
>>
>> My patch set emu->controls[i] to NULL if snd_ctl_add() failed to avoid
>> the uaf.
>>
>> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> 
> Thanks, applied now.
> 
> The bug was hard to be seen due to the coding style, so we'd need a
> cleanup, but it's a different story...

Yes, it would be better to assign the return value from snd_ctl_new1 to a
local variable and set emu->controls[i] only when everything succeeds.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
