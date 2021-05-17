Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070B2382635
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 10:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhEQIIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhEQII3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 04:08:29 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B551C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:07:13 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h4so7517335lfv.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PsWxchSj6IsfblxIjcdWW7ZX83ze5SRG4vA70cLrM7A=;
        b=fk7lEsgVhMM8fOmwyUfed66RSTd8ey3C8TrJYxrYuVdaJCaxGJpgFmswJvDOyJ2kA2
         2COMzLfb9TrxQc4G2WItTgb/jKu7DfkMaUlHaBEmtlr43KuMCzYJ/5ubVWZW9jjc5h8r
         RymapGTPQLOeIFURsfPiJ0ji+P6njJCBpMJo79Nvmkcb4L+nb8YmqTsH+0uQj8yA6mrS
         efsv8tPZNMaF2xIW6pmfY7AzXlulWce2I+CR/F7uNsZvxNKJw7Ldbw4A/LDOE3sUYtlv
         /w9QnUDplcUQokTFyNHhWWsoju9/RSNh2EKnTnbjJC4weixNYSQn00oDfTejeJ56/g6V
         1YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PsWxchSj6IsfblxIjcdWW7ZX83ze5SRG4vA70cLrM7A=;
        b=dtMSGHMd8bwQRYlXAtixOgd0u+dMMrwtmU7SVKM686l1SpR0zT7DCf6PSVb44AIR+j
         HMS5bs9dzMfvpmN7l7SwRR5hqGaRodpJCNEqjS/7+xz5xH2CSmS8DA6ZORN6siMvPJbm
         GgZMoztvR1xOlyOxGM2TlhvunrwhWi2oH/PXDtDesE8PdoV/zLsZQ6SrbohN581OMt2a
         k2QhcgmDKU1dMH5cC2p7nQOTX20S+OmzPJIxfthVFjaitngS19QKFkxKZ552J8bELMLv
         q1RJSYbSjSYYfr5bTKl2OtEfaHAxLjcLrYV8RgzSZiqK61Ff5x/LkYalv2xbYvwI07sc
         7L0Q==
X-Gm-Message-State: AOAM532E/sUC2NnBdfVRV4UIY9fF87fjVVGSLIijIWvjnGIJuICnZqbU
        VE4EuYdgKQfW0fq3qjf4kckJD73xI1A/4AkX
X-Google-Smtp-Source: ABdhPJw1SjBEjNJNPkIQKq/gztKPKO5hpbNaaCpp2o7nB24mtW8/2D/Ia7pjqpFncXqQH3yiuumtxA==
X-Received: by 2002:a19:c511:: with SMTP id w17mr10749915lfe.113.1621238831207;
        Mon, 17 May 2021 01:07:11 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id z18sm1902645lfd.180.2021.05.17.01.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 01:07:10 -0700 (PDT)
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, amistry@google.com,
        nartemiev@google.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1619195089-29710-1-git-send-email-Vijendar.Mukunda@amd.com>
 <20210423164617.GG5507@sirena.org.uk>
 <e1268120-7a91-da49-0bb6-89d5cb4e2cce@gmail.com>
 <b32fcc42-d67e-bfbd-ed83-7f7274fb2f79@amd.com>
 <ac5244d1-643d-6577-80cd-bf6867e75ca2@gmail.com>
 <b86ad586-9513-8fa9-54e3-a0b4a3a7fd92@amd.com>
 <070b4e5b-b7bd-b8a6-beea-593a94ec3078@gmail.com>
 <26c79eec-5e74-38bc-465b-0ca2b2d9a6f5@amd.com>
 <9b689495-e956-6242-0784-af3ccf7c3238@amd.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dwc: add a quirk DW_I2S_QUIRK_STOP_ON_SHUTDOWN
 to dwc driver
Message-ID: <1c875eae-88f2-5bc7-849b-f1c4afb29dbe@gmail.com>
Date:   Mon, 17 May 2021 11:07:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9b689495-e956-6242-0784-af3ccf7c3238@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2021 20:27, Mukunda,Vijendar wrote:
>> Hardware signal broken between ACP and Designware I2S controller with
>> re-ordering the sequence.
>>   > It is surely not a designware IP issue, trying to solve it there
>> is wrong.
>>>
>> As it's not a designware IP issue, initially we started idea with
>> introducing quirk that applies for this ACP version based AMD platforms.
>>
> 
> Hi Peter,
> 
> Any suggestion on the work around for this issue?
> How about declaring a flag in sound card structure and this flag will be
> set in stoneyridge machine driver.

This can only be solved in the core, that's clear.
If this issue only affects this version of ACP with dw I2S (the same ACP
version works fine with other audio IP), then it is more like machine
driver level of quirk.
If this ACP have the same issue with other audio IPs as well then it is
platform quirk.
If the this ACP is only used in this setup then I would consider machine
level quirk as it might be simpler to implement.

Other thing to consider is how other setups with similar issues can use
the new quirk/flag... Some might need to make sure that a component is
first, not last for example.

> Based on flag check trigger stop sequence will be re-ordered.
> 
> Thanks,
> Vijendar

-- 
Péter
