Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD73456BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 05:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhCWEXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 00:23:20 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16391 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhCWEWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 00:22:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616473356; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/L/BZBLnsZxKc0CXc2DZzeIu4BfDOTaaxb2U6Ts43Ec=;
 b=a0PEPC25naateZo06s2xL4nx9W1OJK0KzgDzMsHQkf2jBiCaVNHUUeUYCoYo53NT7Y0BhMlt
 oyYgHi18VgFKoI8gLaDjKsDlcPDwqcel0APYQDj+SPD5o3iVYH8J34TRMoM60WDiZGSIOZS4
 JA27eJQdjXn+Roq6KscgyBY+LiY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60596d056dc1045b7d29fa50 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Mar 2021 04:22:29
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6404C433ED; Tue, 23 Mar 2021 04:22:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52051C433CA;
        Tue, 23 Mar 2021 04:22:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Mar 2021 12:22:28 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     daejun7.park@samsung.com, Greg KH <gregkh@linuxfoundation.org>,
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
In-Reply-To: <75df140d2167eadf1089d014f571d711a9aeb6a5.camel@gmail.com>
References: <20210322065127epcms2p5021a61416a6b427c62fcaf5d8b660860@epcms2p5>
 <CGME20210322065127epcms2p5021a61416a6b427c62fcaf5d8b660860@epcms2p4>
 <20210322065410epcms2p431f73262f508e9e3e16bd4995db56a4b@epcms2p4>
 <75df140d2167eadf1089d014f571d711a9aeb6a5.camel@gmail.com>
Message-ID: <d6a032261a642a4afed80188ea4772ee@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-22 17:11, Bean Huo wrote:
> On Mon, 2021-03-22 at 15:54 +0900, Daejun Park wrote:
>> +       switch (rsp_field->hpb_op) {
>> 
>> +       case HPB_RSP_REQ_REGION_UPDATE:
>> 
>> +               if (data_seg_len != DEV_DATA_SEG_LEN)
>> 
>> +                       dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
>> 
>> +                                "%s: data seg length is not
>> same.\n",
>> 
>> +                                __func__);
>> 
>> +               ufshpb_rsp_req_region_update(hpb, rsp_field);
>> 
>> +               break;
>> 
>> +       case HPB_RSP_DEV_RESET:
>> 
>> +               dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
>> 
>> +                        "UFS device lost HPB information during
>> PM.\n");
>> 
>> +               break;
> 
> Hi Deajun,
> This series looks good to me. Just here I have one question. You didn't
> handle HPB_RSP_DEV_RESET, just a warning.  Based on your SS UFS, how to
> handle HPB_RSP_DEV_RESET from the host side? Do you think we shoud
> reset host side HPB entry as well or what else?
> 
> 
> Bean

Same question here - I am still collecting feedbacks from flash vendors 
about
what is recommanded host behavior on reception of HPB Op code 0x2, since 
it
is not cleared defined in HPB2.0 specs.

Can Guo.
