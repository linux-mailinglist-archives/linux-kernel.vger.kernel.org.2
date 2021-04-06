Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2715355073
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhDFKCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:02:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37150 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237486AbhDFKCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:02:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617703360; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=AxkI4O0vgqQfFbvB7SnO+C+rk9AJjNc9XgX9InDdib0=; b=nMBTbMbbDkJAvk4Ag0ndOdLGiQG6VH2LK41l71K4+hg/k2APRgUA9lOvpl9gzbCidi2oGLE0
 I8kpHiNhVh6ucxyTTdp6RU6dqKrFuu/FsaqOADmS7lNIR08F1k16nKmvreY6frkJJ4GyyhCk
 Dy/F/aSRsI/joMmiodTKAp/FFcw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 606c31478807bcde1d1b3a67 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 10:00:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 19C47C43462; Tue,  6 Apr 2021 10:00:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED0D3C43461;
        Tue,  6 Apr 2021 10:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED0D3C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: rtlwifi/rtl8192cu AP mode broken with PS STA
References: <e2924d81-0e30-2dd0-292b-428fea199484@maciej.szmigiero.name>
        <846f6166-c570-01fc-6bbc-3e3b44e51327@maciej.szmigiero.name>
Date:   Tue, 06 Apr 2021 13:00:33 +0300
In-Reply-To: <846f6166-c570-01fc-6bbc-3e3b44e51327@maciej.szmigiero.name>
        (Maciej S. Szmigiero's message of "Sun, 4 Apr 2021 20:06:06 +0200")
Message-ID: <87r1jnohq6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> On 29.03.2021 00:54, Maciej S. Szmigiero wrote:
>> Hi,
>>
>> It looks like rtlwifi/rtl8192cu AP mode is broken when a STA is using PS,
>> since the driver does not update its beacon to account for TIM changes,
>> so a station that is sleeping will never learn that it has packets
>> buffered at the AP.
>>
>> Looking at the code, the rtl8192cu driver implements neither the set_tim()
>> callback, nor does it explicitly update beacon data periodically, so it
>> has no way to learn that it had changed.
>>
>> This results in the AP mode being virtually unusable with STAs that do
>> PS and don't allow for it to be disabled (IoT devices, mobile phones,
>> etc.).
>>
>> I think the easiest fix here would be to implement set_tim() for example
>> the way rt2x00 driver does: queue a work or schedule a tasklet to update
>> the beacon data on the device.
>
> Are there any plans to fix this?
> The driver is listed as maintained by Ping-Ke.

Yeah, power save is hard and I'm not surprised that there are drivers
with broken power save mode support. If there's no fix available we
should stop supporting AP mode in the driver.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
