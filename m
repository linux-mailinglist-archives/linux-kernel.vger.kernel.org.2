Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA632A249
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381398AbhCBH30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:29:26 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19579 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1836485AbhCBHDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:03:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603de32e0001>; Mon, 01 Mar 2021 23:03:10 -0800
Received: from [10.25.103.152] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 07:03:07 +0000
Subject: Re: [RFC PATCH 3/5] ASoC: audio-graph-card: Add bindings for sysclk
 and pll
To:     Rob Herring <robh@kernel.org>
CC:     Mark Brown <broonie@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
 <1614276364-13655-4-git-send-email-spujar@nvidia.com>
 <CAL_Jsq+9esDGw7ZCLnZS_KLmLUFyVenz83ohgNKFK3bdPD2ouQ@mail.gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <0ea5b885-2610-8f12-569d-15a8eff50c10@nvidia.com>
Date:   Tue, 2 Mar 2021 12:33:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+9esDGw7ZCLnZS_KLmLUFyVenz83ohgNKFK3bdPD2ouQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614668590; bh=mtH3d+wKblfOn6NGGlgdJ6FIympBFVhrzgmGLQmLWbs=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=LLRZtTv1H9RTl+yAYiBhRtJwAxwJ/aDjcHCbLRGLD9/OflQs4B/3Znyi1X+Uoxe9d
         qeBFOdLIBMz6zVF0BCinxrZGh6L5MTdXnzTtILf0n7+xFkU6OyHhGf1rDXevCZ0wDH
         RRi0r2+KGv09ATJ3lwlWt+wup6LDiaPMqNYbt65jnNkupzaxPV39S7+R3DvUeBtROx
         iezCuNx2B36jlT+b3xqncuQgZMuEffxb5yUDntI7+RTOuEzC4oZZlM5zrQ8opkrntH
         I5flCEmPFwZHRpdPbvxpVzjQWMRQPwzCw9j9trFnKMHXb1nVc1nV6otfYBLHdJY+HX
         EXqMjJxKQ8Adw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/2021 7:40 AM, Rob Herring wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Feb 25, 2021 at 12:06 PM Sameer Pujar <spujar@nvidia.com> wrote:
>> ASoC core provides callbacks snd_soc_dai_set_sysclk() and
>> snd_soc_dai_set_pll() for system clock (sysclk) and pll configurations
>> respectively. Add bindings for flexible sysclk or pll configurations
>> which can be driven from CPU/Codec DAI or endpoint subnode from DT.
>> This in turn helps to avoid hard codings in driver and makes it more
>> generic.
>>
>> Also add system-clock related bindings, "system-clock-direction-out"
>> and "system-clock-frequency", which are already supported.
> This all looks like duplication of what the clock binding can provide.
> We don't need 2 ways to describe clocks in DT.

This was targetted for external audio codecs. Their internal clock 
management is not exposed with the clock framework. Instead ASoC 
provides callbacks to set this up on Codec side. There are many 
references where this is followed with some hardcoded settings in the 
drivers.

Are you suggesting to instead expose codec internal clocks and manage 
via generic clock bindings? Would this mean each codec driver has to 
implement these clock APIs (for ex: set_rate()) and program registers 
accordingly?
For a platform, different audio cards can be plugged in. In that case, 
each codec has to be updated to follow this. Wouldn't it be simpler to 
use available ASoC callbacks?
