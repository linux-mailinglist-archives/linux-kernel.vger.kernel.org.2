Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A148F3EEC05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbhHQMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 08:00:12 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:24130 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236854AbhHQMAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:00:11 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17H5G88X006623;
        Tue, 17 Aug 2021 06:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=QrMTdVAszLcR9CMpWeF6bTLtoBvMHkTMYmWrt+imPnA=;
 b=JYwdfJGNYYwIrrDYV2rv+4ijZFDM8DwtHwJ2I0FloEPvB656+cpUfujx1ZUYio7uU2Q5
 1KzeEx7xYVbsi/efge8aQJ48Bu0GYOjD5KA8StP/+k19NWU6ZA3mh9U9Gzll4C1GYMsA
 co/rVaP22ZQo5c/grhtuSJ9Q+A4UyOW27wMs3EPMmhPN/zqSlrGiyHs6zZjURHgXArIR
 zyrM30LlSOEfffuG2jHaNB13+Qaj3vNg7YzkXRCZ86LoIaBBB6FfQXfVUD5qcHbOGCEz
 ZvR6/zANQOgArx0mMFOcj44znbRoHIQvpL+adv2HU9bgjAdb861x0HNWTCso11+UuaCa Nw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3ag0nggwpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 Aug 2021 06:58:29 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 12:28:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 17 Aug 2021 12:28:22 +0100
Received: from [198.90.238.180] (unknown [198.90.238.180])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7E34E45D;
        Tue, 17 Aug 2021 11:28:21 +0000 (UTC)
Subject: Re: [PATCH 2/2] ALSA: hda/cs8409: Prevent pops and clicks during
 reboot
To:     Takashi Iwai <tiwai@suse.de>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
References: <20210812183433.6330-1-vitalyr@opensource.cirrus.com>
 <20210812183433.6330-2-vitalyr@opensource.cirrus.com>
 <s5h1r6xlvrs.wl-tiwai@suse.de> <s5hczqgil3v.wl-tiwai@suse.de>
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <6595e87d-1dae-b536-c17b-eafa07d04bbe@opensource.cirrus.com>
Date:   Tue, 17 Aug 2021 12:28:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <s5hczqgil3v.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-GUID: AnC5RTzh0mPaqUW5ZXINb2_B0nfTkEzj
X-Proofpoint-ORIG-GUID: AnC5RTzh0mPaqUW5ZXINb2_B0nfTkEzj
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2021 7:41 am, Takashi Iwai wrote:
> On Fri, 13 Aug 2021 08:10:47 +0200,
> Takashi Iwai wrote:
>> On Thu, 12 Aug 2021 20:34:33 +0200,
>> Vitaly Rodionov wrote:
>>> From: Stefan Binding <sbinding@opensource.cirrus.com>
>>>
>>> During reboot, when the CS42L42 powers down, pops and clicks
>>> may occur due to the codec not being shutdown gracefully.
>>> This can be fixed by going through the suspend sequence,
>>> which shuts down the codec cleanly inside the reboot_notify
>>> hook, which is called on reboot.
>>>
>>> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
>>> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
>> I hold this one for now, as there is a fix series that deprecates the
>> reboot_notify callback of HD-audio by forcibly doing runtime-suspend
>> at shutdown.  Please check the three patches in
>>    https://bugzilla.kernel.org/show_bug.cgi?id=214045
>>
>> I'm going to submit those soon in anyway.

Hi Takashi,

Thanks for letting us know. We have tested against for-next branch and 
we have an issue.

Loud pops on reboot. It looks like suspend have never been called on 
reboot or shutdown for us.

> The removal of reboot_notifier landed in my for-next branch now.
> Please rebase and adapt the changes appropriately.  In short, the
> runtime suspend is applied at the shutdown, so the workaround is
> needed only for suspend.
>
>
> thanks,
>
> Takashi


