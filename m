Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A541946E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbhI0MlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:41:18 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49543 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234333AbhI0MlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:41:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E2665C0101;
        Mon, 27 Sep 2021 08:39:38 -0400 (EDT)
Received: from imap46 ([10.202.2.96])
  by compute4.internal (MEProxy); Mon, 27 Sep 2021 08:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com.au;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=cSK1Y29NFVS0Ah7Kq0hNWcYUvsD0
        TEDqK24Satd6ZL4=; b=IRRQBZbcablRzNL9foAjy3v4B6vzhX66iFYWOpq6oQa6
        7v2348YsiqY9D+WT5/XblTbXMce5FFXKEn36kvpPn4W6a72v/nmhkEvbDM++vmEM
        yNoQ6lP7KHL8AaZ94RDtI+DMWo83gjCpUmMRjwNXzZRo+aQaniQR+qxyqMVcHJHl
        1s0q7wUZ3fGhSY/840shyjzUBjP/SweJP/GWEjJ8f+VCxuRLPCAU3umAxcYQhRKS
        8MWhZWnxGrhO0CSQCWbi+y/0MuUKgsoUx/swjgtcb2UmmhAQRb6gbNE74T9Rfslq
        YAqX6i17tl9CMOtOu4HIQ56LASEnL4CH3dLtb+8/ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cSK1Y2
        9NFVS0Ah7Kq0hNWcYUvsD0TEDqK24Satd6ZL4=; b=uwPSZzzMOOVIRqKPIDMvyq
        N8J9Lg35N2C6f/+xQgctqn0aHxdeiqSfAPKLwsc9BaW28e35gXppHgCBohL7xJu9
        MisptuCdyrS0y/blsEQrNtV11t18RYwqy32GRBkEBVxK5yotDHF/Mcbv9tuVcGDr
        pPh5Sn8GPHODE+nv7ctHfZvsvU+0uVgyPtvBMblqjkuvdg2Hp897h3wg5a1doE4B
        liTcjiJyOVGDCmBxXEPF2/807P+PDSbOMBVhAWX7LG48qAft6spXNd4Hc0BCNqJE
        aYw8N3zWNS/4ApTfU38kCtsxJ7dhoIAR2eLUOLxGXg01bMnv+K3vxrXrpKzLnlVA
        ==
X-ME-Sender: <xms:irtRYZzB9mJBP_FrjN_YiFEOTa6vMbrEpUzZUlg5DC0hzp2JOYtyLQ>
    <xme:irtRYZSzyOD0KdhAePiV25T5l7tFj_PRxo7qnxivkIr5_n7_eF28hQULCDIuGi0hb
    oURjE0VRgZDNcehQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejkedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkjghffffhvffu
    tgesthdtredtreertdenucfhrhhomhepfdflohhhnhcuvfhhohhmshhonhdfuceojhhohh
    hnsehjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghuqeenucggtffr
    rghtthgvrhhnpeetieeileetudfhkeefleetveefuddutddugfegveeufeeiveeugfefud
    duueduveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrihhonecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhohhhnse
    hjohhhnhhthhhomhhsohhnrdhfrghsthhmrghilhdrtghomhdrrghu
X-ME-Proxy: <xmx:irtRYTXGm-KTE0gQV2OZ9oY53Max3ccVECn3i7SRuokpCoPFxO92LA>
    <xmx:irtRYbhuJmRCy7ymgkqMivfz1qeYWIS_CsEuFdu_LuCmK6aSwDUEjA>
    <xmx:irtRYbA4ugmC7YIC9DkzQ47P9eK64kkyDIHH7LS-BmlAl45ffe9nFw>
    <xmx:irtRYSMrF7d4mWRuhqx_Tq_BmX0SmdZ_AtMOXaKuknTNcFjWCZ8XLQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3C6441EE0074; Mon, 27 Sep 2021 08:39:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <d83c2613-70d2-48e8-84ac-978967b49dfb@www.fastmail.com>
In-Reply-To: <65df8099-28a0-fe95-57fc-11c9e90af835@linaro.org>
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-2-vadym.kochan@plvision.eu>
 <43023500-dd6a-5180-057e-cecc1f1b6500@linaro.org>
 <20210616123356.GA9951@plvision.eu>
 <fea907ed-06ce-5c82-667d-d11f3e902616@linaro.org>
 <vrcxh2zgsnl841.fsf@plvision.eu>
 <7e6d75ed-cebc-597f-7062-34261d184968@linaro.org>
 <vrcxh2pmt3bl4h.fsf@plvision.eu>
 <0e471789-fe29-b747-5153-75c9b4616c7f@linaro.org>
 <vrcxh2o88nbias.fsf@plvision.eu>
 <1da03714-8f23-1004-e89a-891e4599e04a@linaro.org>
 <vrcxh2mto7bfcb.fsf@plvision.eu>
 <1e146349-9fef-972b-9084-577f02d5168b@linaro.org>
 <vrcxh2lf3rbcjc.fsf@plvision.eu>
 <169d3f36-4297-32a3-3d23-824989625b26@linaro.org>
 <77b11bf7-3003-483f-b91e-bd93576eaae1@www.fastmail.com>
 <65df8099-28a0-fe95-57fc-11c9e90af835@linaro.org>
Date:   Mon, 27 Sep 2021 12:38:51 +0000
From:   "John Thomson" <john@johnthomson.fastmail.com.au>
To:     "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Vadym Kochan" <vadym.kochan@plvision.eu>
Cc:     "Rob Herring" <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Robert Marko" <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 1/3] nvmem: core: introduce cells parser
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Mon, 27 Sep 2021, at 10:12, Srinivas Kandagatla wrote:
> On 21/09/2021 06:50, John Thomson wrote:
>> Hi Srinivas,
>> 
>> Can I note here that I would like to parse
>> TLV data from an SPI-NOR device to NVMEM cells.
>> The same general use case (getting mac-address from OEM data).
>> 
>> Was planning to base my work on this series, as well as
>> https://lore.kernel.org/all/20210908100257.17833-1-qiangqing.zhang@nxp.com/
>
> This series is for post-processing nvmem cell data before it gets to 
> consumers.
> Are you referring to parsing nvmem cell information (offset, name) in 
> your usecase like: 
> https://opencomputeproject.github.io/onie/design-spec/hw_requirements.html
>
> Or
> Are you referring to post-processing nvmem cell data ?

Both.
I have TLV data where I want to parse the tag lengths and tag IDs to map them into offsets and names like a NVMEM cells lookups table.

Then, some of these cell data would need to be post processed to use directly.
I have only a base MAC address available, and would like to specify increments for different network ports.
As an additional example, another TLV tag:value has compressed wifi calibration data. If I could post process this cell data I could then feed it into ath9k with: https://lore.kernel.org/all/f9b732b50a3453fadf3923cc75d365bae3505fe7.1630157099.git.chunkeey@gmail.com/

In my case, this is all currently done in userspace.
I saw this (ONIE TLV NVMEM parser) series and thought it offered something very similar to
(the first part of) what I would like to do.

Cheers,
-- 
  John Thomson
