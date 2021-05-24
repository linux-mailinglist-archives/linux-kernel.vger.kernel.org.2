Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3180538E2D7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 10:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhEXJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:00:45 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:57100 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232313AbhEXJAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:00:43 -0400
Received: from [10.0.31.199] (unknown [10.0.31.199])
        by uho.ysoft.cz (Postfix) with ESMTP id 3ADA7A0445;
        Mon, 24 May 2021 10:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1621846754;
        bh=9gXHRkL0/lNEZcmId1P1XQF8Biy3VxhzAmq1CA/LKkU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gLOIc+RBlBTV5n0x/21GY2lHumdpywKDfHHGyK2vAUcx/twWYVQnrGOWcv967SPW9
         xChwb9DwuKfZyXBvcK2ZtfFKF/m2MbDmcsuhu9lBTd+mTCwc3NUGclJvDYOnGRLHw8
         LtUjHdoufLWCy21gXmgLLgaH8Soufbk9BzeMu/ng=
Subject: Re: [PATCH RESEND] ARM: dts: imx6dl-yapp4: Configure the OLED display
 segment offset
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
References: <1620813314-30803-1-git-send-email-michal.vokac@ysoft.com>
 <20210523034952.GU8194@dragon>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <9add872f-0c98-3c11-ea1f-5349f0f0bed2@ysoft.com>
Date:   Mon, 24 May 2021 10:59:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210523034952.GU8194@dragon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 05. 21 5:49, Shawn Guo wrote:
> On Wed, May 12, 2021 at 11:55:14AM +0200, Michal Vokáč wrote:
>> The imx6dl-yapp4 platform uses a GE-LX012864FWPP3N0000 OLED display.
>> The display consist of a 128x64 OLED panel and a SSD1305 controller.
>>
>> The OLED panel resolution is 128x64 but the built-in controller default
>> resolution is 132x64. To display properly a segment offset needs to be
>> configured.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> 
> Why are you resending?  Please state reason when you resend.

I can't tell where but a while ago I read in some documentation
that if you do not get any response for aprox. two weeks you
can/should resend the patch in case it fell through the cracks.
I sent these patches in the middle of April, four weeks ago,
and have got no replies since then. So I [RESEND PATCH] these.

I totally understand that you, and all maintainers and reviewers
in general, are very busy so it may take a long time to reply.

AFAIK one does not need to state a reason for RESEND PATCH.
The word RESEND itself should explain the reason. This is not v2,
where I would of course describe what has changed.

Please correct me if my understanding of this part of the submitting
process is incorrect.

Thank you,
Michal
