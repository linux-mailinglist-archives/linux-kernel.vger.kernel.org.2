Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553B6345DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCWMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:16:06 -0400
Received: from mail1.perex.cz ([77.48.224.245]:34902 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230335AbhCWMPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:15:55 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 2729FA0040;
        Tue, 23 Mar 2021 13:15:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 2729FA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1616501751; bh=L7RtC/J9cVnv8GxX8+4LxNg4WgklUuLLCUAYCPtdAPA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cct2tPYRtka1uAOJe3Kr8EryGViDEEB/mRyJYxpy6msE9ADZUzSEwgeiFo+NIwE9a
         Rbqswpf84YnohsVdSvY3toeWTU3E2z1T1CzNBPoAuFNTTNXFTNGseEmV/OuFhJ+UC0
         rc8z+A45mutcMSB/GXOirO1vQf+VlmvY2S5c0+HQ=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue, 23 Mar 2021 13:15:43 +0100 (CET)
Subject: Re: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        mirq-linux@rere.qmqm.pl, gustavoars@kernel.org
References: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <a0c862ec-44ba-52e0-551c-0347166ac4e9@perex.cz>
Date:   Tue, 23 Mar 2021 13:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 23. 03. 21 v 12:43 Codrin Ciubotariu napsal(a):

> To achieve this, the first thing needed is to detect whether a HW
> constraint rule is enforced by a FE or a BE DAI. This means that
> snd_pcm_hw_rule_add() needs to be able to differentiate between the two
> type of DAIs. For this, the runtime pointer to struct snd_pcm_runtime is
> replaced with a pointer to struct snd_pcm_substream, to be able to reach
> substream->pcm->internal to differentiate between FE and BE DAIs.

Think about other not-so-invasive solution. What about to use
'runtime->private_data' (struct snd_soc_pcm_runtime *) to determine FE / BE?

					Jaroslav
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
