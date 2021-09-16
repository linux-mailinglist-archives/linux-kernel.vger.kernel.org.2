Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2710940D9C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbhIPMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:22:21 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59958 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235810AbhIPMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:22:20 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18G8MpNh022854;
        Thu, 16 Sep 2021 07:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=q6dExioO+J19BjFinwum6GtiF8XvkmD9lJV/6rlFdGQ=;
 b=J0NsI7VF+iRuVXfyDEbT5od2Qnq8dayRZoeVGJroEu8USY4/JH8M3PP0vUgW7C50Mf4N
 hWW2y7hM1oc/xZ2jUpfCkfWt7xmwoELmLrLn0S9kEvUxErhDhfowadkRZuYYieoQURBo
 MoPRdlcclF3vno5y6zVwBE2DLsKHCR3YNlrABrp97VG10IehNukHvMSYSHH/AbTvuzMM
 Z8rlnR8TD9EpEsdIxZkzKiQwtvPiKkF8I3VpzGgg76cIEEkdh7lUmNMt+zkPpc5ywrxa
 RfywH/9sk1ogI0o9VDOV97/WC3ojSCLwPm6OnhpiaHEvXKTgCvz/CzOkHfpyQQAwRCG9 QQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3b42c3g7e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Sep 2021 07:20:47 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 16 Sep
 2021 13:20:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 16 Sep 2021 13:20:45 +0100
Received: from [198.90.238.230] (unknown [198.90.238.230])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 61870B2F;
        Thu, 16 Sep 2021 12:20:45 +0000 (UTC)
Subject: Re: [PATCH v1 0/1] ASoC: cs42l42: Implement Manual Type detection as
 fallback
To:     Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
        <patches@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>,
        "James Schulman" <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        <linux-kernel@vger.kernel.org>
References: <20210916102750.9212-1-vitalyr@opensource.cirrus.com>
 <20210916111916.GA5048@sirena.org.uk>
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <cb5662fd-ce43-99cb-410d-9ceefff731d2@opensource.cirrus.com>
Date:   Thu, 16 Sep 2021 13:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916111916.GA5048@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-GUID: b-5XEZ05MugAmExJ1dfSv-B4zTmzWgAI
X-Proofpoint-ORIG-GUID: b-5XEZ05MugAmExJ1dfSv-B4zTmzWgAI
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2021 12:19 pm, Mark Brown wrote:
> On Thu, Sep 16, 2021 at 11:27:49AM +0100, Vitaly Rodionov wrote:
>> For some headsets CS42L42 autodetect mode is not working correctly.
>> They will be detected as unknown types or as headphones. According
>> to the CS42L42 datasheet, if the headset autodetect failed,
>> then the driver should switch to manual mode and perform a manual steps sequence.
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that
> any important information is recorded in the changelog rather than being
> lost.

Hi Mark,

Got it.  Thanks


