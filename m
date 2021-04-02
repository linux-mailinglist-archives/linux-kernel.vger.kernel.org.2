Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587223528F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 11:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbhDBJjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 05:39:21 -0400
Received: from salscheider.org ([94.16.116.164]:53820 "EHLO
        mail.salscheider.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhDBJjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 05:39:17 -0400
Received: from [IPv6:2001:16b8:22e6:f000:21fa:7b6c:134e:4cff] (200116b822e6f00021fa7b6c134e4cff.dip.versatel-1u1.de [IPv6:2001:16b8:22e6:f000:21fa:7b6c:134e:4cff])
        by mail.salscheider.org (Postfix) with ESMTPSA id 94F02201303;
        Fri,  2 Apr 2021 11:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salscheider.org;
        s=dkim; t=1617356355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqGU/mIsh6XX3fG2+m4bEUq3VRTFexbNKJFJC1MoNqU=;
        b=ZZeWBmzGCQ9XK5ByazgvxRd7Ise/ascA4MHzfCVn/7IBoO+eoOLAB4CIucxblxGwEcTswB
        ZvLXGn+zjEIVhyaAStDNVKYHBERwpzc5EAhEWi4LMdifEpRv/0R+OllFOjdvl4JFkztUz5
        1CwYAXJ25sGiBbSWB7x4lUzjbtfXQXc=
Subject: Re: ASM2142: Transfer event TRB DMA ptr not part of current TD
 ep_index 6 comp_code 13
From:   Ole Salscheider <ole@salscheider.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
References: <04cfcd19-5bd8-2ec1-4840-3865dfec398e@salscheider.org>
 <df84d903-1107-8f53-2389-8a4f5af32783@salscheider.org>
Message-ID: <273ca008-d219-eaa3-8603-dab0e1d861b8@salscheider.org>
Date:   Fri, 2 Apr 2021 11:39:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <df84d903-1107-8f53-2389-8a4f5af32783@salscheider.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

ok, skimming over the xhci spec helped me to understand a bit more.

The problem is the following:
The xhci driver enqueues TRBs for transfers on the transfer ring. When 
it comes to the end of the segment, the cycle bit of the link TRB at the 
end of the segment is toggled in "prepare_ring" and we continue to 
enqueue TRBs on the next segment. So far, so good.

The controller reads the TRBs and processes them. But I assume that this 
happens asyncronously. The driver receives the corresponding events on 
the event ring from the host controller a bit later.

But once the cycle bit of the link TRB is toggled the host controller 
just reports the address of the first TRB in the next segment on the 
event ring. It forgets about all outstanding TRBs on the first ring 
before the link TRB.

I assume that this is a HC firmware bug. I can successfully work around 
it by toggeling the cycle bit of the link TRB not in "prepare_ring" but 
in "handle_tx_event" after receiving the event for the TRB right before 
the link TRB.

I'm not sure if that is the best way to work around the problem though. 
Do you have any ideas how to best fix this?

Best regards,

Ole


On 01.04.21 21:41, Ole Salscheider wrote:
> Hello,
> 
> I tried to debug this a bit.
> 
> It seems that the XHCI ring has two segments. For me, the first has DMA 
> address 0x00000000fffb9000 and the second has 00000000fffb8000.
> The TRBs on the first segment are used successfully up to address 
> 00000000fffb9fd0 (which seems to be 253 TRBs?).
> After that, the DMA address in "handle_tx_event" in "xhci-ring.c" points 
> to the first TRB in the second segment, but "deq_seg" of the ring still 
> points to the first segment. This obviously will cause the error I see.
> 
> Now the real question is why it still points to the old segment. I guess 
> this should be handeled by a link TRB? Then it seems that it is either 
> missing or handeled wrongly?
> I'm still a bit confused about if this is a host controller or driver 
> problem.
> 
> Thank you in advance and best regards,
> Ole
> 
> 
> On 31.03.21 11:46, Ole Salscheider wrote:
>> Hello,
>>
>> I have a PCIe card with ASM2142 USB Host Controllers on them. I have 
>> attached a SuperSpeed UVC camera to it. This camera works on other 
>> host controllers, but with the ASM2142 the transfer stops after a 
>> frame or so. Dmesg shows me the following error:
>>
>>  > Transfer event TRB DMA ptr not part of current TD ep_index 6 
>> comp_code 13
>>
>> I have tried different XHCI quirks but did not have success with any.
>> The full log with xhci_hcd debugging enabled is as follows:
>>
>> [   30.458244] xhci_hcd 0000:60:00.0: Get port status 10-1 read: 
>> 0x2a0, return 0x2a0
>> [   30.458254] xhci_hcd 0000:60:00.0: Get port status 10-2 read: 
>> 0x1263, return 0x263
>> [   30.458264] xhci_hcd 0000:60:00.0: Get port status 10-2 read: 
>> 0x1263, return 0x263
>> [   30.458271] xhci_hcd 0000:60:00.0: Set port 10-2 link state, 
>> portsc: 0x1263, write 0x11201
>> [   30.458749] xhci_hcd 0000:60:00.0: Port change event, 10-2, id 2, 
>> portsc: 0x401203
>> [   30.458757] xhci_hcd 0000:60:00.0: resume SS port 2 finished
>> [   30.458762] xhci_hcd 0000:60:00.0: handle_port_status: starting 
>> port polling.
>> [   30.503906] xhci_hcd 0000:60:00.0: Get port status 10-2 read: 
>> 0x401203, return 0x400203
>> [   30.523908] xhci_hcd 0000:60:00.0: clear port2 link state change, 
>> portsc: 0x1203
>> [   30.524884] xhci_hcd 0000:60:00.0: Get port status 10-2 read: 
>> 0x1203, return 0x203
>> [   30.553470] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.553860] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.554278] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.554667] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.555067] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.555454] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.555848] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.556160] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 30388 bytes untransferred
>> [   30.559697] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.560083] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.560484] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.560904] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.561290] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.561693] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.562079] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.562515] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.562876] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.563278] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.563678] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.564072] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.564466] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.564860] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.565263] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.565666] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.566067] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.566455] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.566847] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.567251] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.567652] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.568055] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.568447] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.568847] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.569229] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.569640] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.570040] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.570443] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.570834] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.571217] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.571615] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.572028] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.572428] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.572831] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.573205] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.573611] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.574028] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.574416] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.574817] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.575204] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.575599] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.576015] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.576402] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.576804] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.577204] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.577583] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.577983] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.578402] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.578776] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.579191] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.579578] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.579980] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.580387] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.580777] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.581177] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.581584] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.581967] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.582361] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.582762] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.583165] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.583552] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.583946] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.584351] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.584764] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.585150] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.585540] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.585946] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.586338] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.586736] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.587138] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.587538] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.587941] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.588323] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.588723] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.589114] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.589527] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.589927] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.590334] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.590708] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.591022] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 30468 bytes untransferred
>> [   30.594565] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.594947] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.595346] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.595750] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.596152] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.596553] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.596940] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.597333] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.597735] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.598138] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.598538] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.598941] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.599327] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.599731] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.600112] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.600526] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.600927] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.601330] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.601720] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.602099] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.602512] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.602915] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.603302] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.603704] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.604096] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.604513] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.604913] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.605303] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.605695] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.606082] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.606482] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.606901] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.607288] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.607691] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.608070] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.608480] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.608869] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.609276] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.609690] xhci_hcd 0000:60:00.0: ep 0x83 - asked for 32768 bytes, 
>> 16388 bytes untransferred
>> [   30.610065] xhci_hcd 0000:60:00.0: ERROR Transfer event TRB DMA ptr 
>> not part of current TD ep_index 6 comp_code 13
>> [   30.610071] xhci_hcd 0000:60:00.0: Looking for event-dma 
>> 00000000fffb8010 trb-start 00000000fffb9fe0 trb-end 00000000fffb9fe0 
>> seg-start 00000000fffb9000 seg-end 00000000fffb9ff0
>> [   30.610433] xhci_hcd 0000:60:00.0: ERROR Transfer event TRB DMA ptr 
>> not part of current TD ep_index 6 comp_code 1
>> [   30.610437] xhci_hcd 0000:60:00.0: Looking for event-dma 
>> 00000000fffb8020 trb-start 00000000fffb9fe0 trb-end 00000000fffb9fe0 
>> seg-start 00000000fffb9000 seg-end 00000000fffb9ff0
>> [   30.610469] xhci_hcd 0000:60:00.0: ERROR Transfer event TRB DMA ptr 
>> not part of current TD ep_index 6 comp_code 13
>> [   30.610473] xhci_hcd 0000:60:00.0: Looking for event-dma 
>> 00000000fffb8030 trb-start 00000000fffb9fe0 trb-end 00000000fffb9fe0 
>> seg-start 00000000fffb9000 seg-end 00000000fffb9ff0
>> [   30.767918] xhci_hcd 0000:60:00.0: xhci_hub_status_data: stopping 
>> port polling.
>>
>> Do you have any idea what might cause this, or any suggestions how I 
>> can debug this further?
>>
>> Thank you in advance!
>>
>> Best regards,
>> Ole
