Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811A83C157C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhGHO4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:56:14 -0400
Received: from mail1.perex.cz ([77.48.224.245]:39948 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGHO4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:56:13 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id E7812A003F;
        Thu,  8 Jul 2021 16:53:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E7812A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1625756009; bh=50Pcd5aTX9wikvo2sIBF0vJ6IcrjySrof/14/tpqP8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=phgeDJEeL3CJ2C+r+weBuDGCtGDMtCBf8XucknY8xtRV+9n1UxbGse81CzdL9m7Ru
         AntvgEqAMSaowOfV+vTJPwyqirFmSYAYpmlhCPFRLL4DZVRlhH4VHxn85oxOFgnFsJ
         gt6H/bNUob/HValmw35d8rWFyLg9tbCG5ViZFM0Q=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu,  8 Jul 2021 16:53:20 +0200 (CEST)
Subject: Re: [Patch v2] ALSA: compress: allow to leave draining state when
 pausing in draining
To:     Robert Lee <lerobert@google.com>, Takashi Iwai <tiwai@suse.de>
Cc:     vkoul@kernel.org, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, carterhsu@google.com,
        zxinhui@google.com, bubblefang@google.com
References: <20210708020815.3489365-1-lerobert@google.com>
 <s5ho8bd59q4.wl-tiwai@suse.de>
 <CAOM6g_Cv6rsLOAb0+Lr_YkjHpKfw+zvWXH0X5LKR=Z4dtXGRng@mail.gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <e2705267-4400-bb7f-e96a-9b103872c0a1@perex.cz>
Date:   Thu, 8 Jul 2021 16:53:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAOM6g_Cv6rsLOAb0+Lr_YkjHpKfw+zvWXH0X5LKR=Z4dtXGRng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 07. 21 15:47, Robert Lee wrote:
> Hi Takashi,
> 
> It is a little complex to describe the design in detail, but try to
> explain simply
> what issue we meet.
> 
> If w/o the change,  after user resumes from the pause, our system would call
> snd_compr_drain() or snd_compr_partial_drain() again after it returns from
> previous drain (when EOF reaches). Then it will block in this drain and no one
> wake it up because EOF has already reached. I add this change to return from
> the previous drain.

It looks like that the driver does not call snd_compr_drain_notify() so the
state is not updated to SETUP on EOF.

> Actually, I am wondering how the pause-during-drain can keep the state in
> DRAINING. It should have a different design. :)

I already proposed to add a new state (because it's a new state), but the
conservative way was elected to avoid user space changes.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
