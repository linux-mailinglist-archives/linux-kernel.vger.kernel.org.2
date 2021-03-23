Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AC63457C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCWG1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:27:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:18207 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhCWG04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:26:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616480815; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=nxG09/5fx3UUe4ayx42t/gXPfWay4ftms22djpfW9nQ=;
 b=qDSH0tLwK3Z/xfDP2B2RotkSHin69cBtjCV++uXh9khkY4/8lVe+aqjQlau6JaTZyL6BOpNl
 EKCyEW/2vAen3TdwI63bUbvPmPSxDdjNjDBtJoWuBiFrJl8AB8wRhPd6YEG05Beh6MXki51w
 QjjG3kBzBNcxn957sb1nuOzEgug=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60598a2fc32ceb3a918110c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Mar 2021 06:26:55
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06F5DC43464; Tue, 23 Mar 2021 06:26:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D90FC433C6;
        Tue, 23 Mar 2021 06:26:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 23 Mar 2021 14:26:53 +0800
From:   Can Guo <cang@codeaurora.org>
To:     daejun7.park@samsung.com
Cc:     Bean Huo <huobean@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        stanley.chu@mediatek.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        JinHwan Park <jh.i.park@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Dukhyun Kwon <d_hyun.kwon@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Jaemyung Lee <jaemyung.lee@samsung.com>,
        Jieon Seol <jieon.seol@samsung.com>
Subject: Re: [PATCH v31 2/4] scsi: ufs: L2P map management for HPB read
In-Reply-To: <20210323061922epcms2p739666492ebb458d70deab026d074caf4@epcms2p7>
References: <1df7bb51dc481c3141cdcf85105d3a5b@codeaurora.org>
 <e9b912bca9fd48c9b2fd76bea80439ae@codeaurora.org>
 <20210322065127epcms2p5021a61416a6b427c62fcaf5d8b660860@epcms2p5>
 <20210322065410epcms2p431f73262f508e9e3e16bd4995db56a4b@epcms2p4>
 <75df140d2167eadf1089d014f571d711a9aeb6a5.camel@gmail.com>
 <d6a032261a642a4afed80188ea4772ee@codeaurora.org>
 <20210323053731epcms2p70788f357b546e9ca21248175a8884554@epcms2p7>
 <CGME20210322065127epcms2p5021a61416a6b427c62fcaf5d8b660860@epcms2p7>
 <20210323061922epcms2p739666492ebb458d70deab026d074caf4@epcms2p7>
Message-ID: <f224bea78cf235ee94823528f07e28a6@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-23 14:19, Daejun Park wrote:
>> On 2021-03-23 13:37, Daejun Park wrote:
>>>> On 2021-03-23 12:22, Can Guo wrote:
>>>>> On 2021-03-22 17:11, Bean Huo wrote:
>>>>>> On Mon, 2021-03-22 at 15:54 +0900, Daejun Park wrote:
>>>>>>> +       switch (rsp_field->hpb_op) {
>>>>>>> 
>>>>>>> +       case HPB_RSP_REQ_REGION_UPDATE:
>>>>>>> 
>>>>>>> +               if (data_seg_len != DEV_DATA_SEG_LEN)
>>>>>>> 
>>>>>>> +                       dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
>>>>>>> 
>>>>>>> +                                "%s: data seg length is not
>>>>>>> same.\n",
>>>>>>> 
>>>>>>> +                                __func__);
>>>>>>> 
>>>>>>> +               ufshpb_rsp_req_region_update(hpb, rsp_field);
>>>>>>> 
>>>>>>> +               break;
>>>>>>> 
>>>>>>> +       case HPB_RSP_DEV_RESET:
>>>>>>> 
>>>>>>> +               dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
>>>>>>> 
>>>>>>> +                        "UFS device lost HPB information during
>>>>>>> PM.\n");
>>>>>>> 
>>>>>>> +               break;
>>>>>> 
>>>>>> Hi Deajun,
>>>>>> This series looks good to me. Just here I have one question. You
>>>>>> didn't
>>>>>> handle HPB_RSP_DEV_RESET, just a warning.  Based on your SS UFS, 
>>>>>> how
>>>>>> to
>>>>>> handle HPB_RSP_DEV_RESET from the host side? Do you think we shoud
>>>>>> reset host side HPB entry as well or what else?
>>>>>> 
>>>>>> 
>>>>>> Bean
>>>>> 
>>>>> Same question here - I am still collecting feedbacks from flash
>>>>> vendors
>>>>> about
>>>>> what is recommanded host behavior on reception of HPB Op code 0x2,
>>>>> since it
>>>>> is not cleared defined in HPB2.0 specs.
>>>>> 
>>>>> Can Guo.
>>>> 
>>>> I think the question should be asked in the HPB2.0 patch, since in
>>>> HPB1.0 device
>>>> control mode, a HPB reset in device side does not impact anything in
>>>> host side -
>>>> host is not writing back any HPB entries to device anyways and HPB
>>>> Read
>>>> cmd with
>>>> invalid HPB entries shall be treated as normal Read(10) cmd without
>>>> any
>>>> problems.
>>> 
>>> Yes, UFS device will process read command even the HPB entries are
>>> valid or
>>> not. So it is warning about read performance drop by dev reset.
>> 
>> Yeah, but still I am 100% sure about what should host do in case of
>> HPB2.0
>> when it receives HPB Op code 0x2, I am waiting for feedbacks.
> 
> I think the host has two choices when it receives 0x2.
> One is nothing on host.
> The other is discarding all HPB entries in the host.
> 
> In the JEDEC HPB spec, it as follows:
> When the device is powered off by the host, the device may restore L2P 
> map
> data upon power up or build from the host’s HPB READ command.
> 
> If some UFS builds L2P map data from the host's HPB READ commands, we 
> don't
> have to discard HPB entries in the host.
> 
> So I thinks there is nothing to do when it receives 0x2.

But in HPB2.0, if we do nothing to active regions in host side, host can 
write
HPB entries (which host thinks valid, but actually invalid in device 
side since
reset happened) back to device through HPB Write Buffer cmds (BUFFER ID 
= 0x2).
My question is that are all UFSs OK with this?

Thanks,
Can Guo.

> 
> Thanks,
> Daejun
> 
>> Thanks,
>> Can Guo.
>> 
>>> 
>>> Thanks,
>>> Daejun
>>> 
>>>> Please correct me if I am wrong.
>>> 
>>> 
>>> 
>>>> Thanks,
>>>> Can Guo.
>>>> 
>>>> 
>>>> 
>> 
>> 
>> 
