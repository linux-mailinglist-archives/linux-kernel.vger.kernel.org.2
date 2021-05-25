Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C8038FE00
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhEYJlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:41:24 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:1108 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232557AbhEYJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:41:23 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P9SaKq008627;
        Tue, 25 May 2021 04:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=S4LBE+cK2/3DyOr83rBZxfFQxR2lw4WfocQTuOKqwxU=;
 b=PWPdKYhsji7jBR5xvmrcJbJbPoGJwGFTVW5pZYmQmXFdAu5HwMVv9rYt6pleS0okWw/F
 Qq/kU7x72wj1A0oJA5pN/hVCgvaumS4lWnOmsznMCyZSp2NvuY5kBc4+BTFcm4JalX1a
 pC3T2PogwOsHJcQlbqIRyIGSXpRUDvO4SPurBBYw1ufWwIqYqC0GAoY6z4Inrt2/p8lN
 a94Ym/c331vT0OkQbF4ffsLVSYzJO1W3E6TujAW7JZbYSzwBP1kgW99UuT82p+nh1aF3
 u8FZrolLbyjaUPCHT4QUHGxPT4WnB86vNYF0CSYJpi81bq/81Vzw8O/7M3bBAPs62MPF RQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38r28v1mfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 25 May 2021 04:39:45 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 10:39:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 25 May 2021 10:39:44 +0100
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 940C311CD;
        Tue, 25 May 2021 09:39:43 +0000 (UTC)
Subject: Re: [PATCH] ASoC: Intel: boards: Select SND_SOC_HDAC_HDMI for
 Soundwire machine driver
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <broonie@kernel.org>, <cezary.rojewski@intel.com>,
        <liam.r.girdwood@linux.intel.com>, <yang.jie@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20210520163324.19046-1-rf@opensource.cirrus.com>
 <9ed54875-fe77-f70f-9085-0f3b4c9d576e@linux.intel.com>
 <alpine.DEB.2.22.394.2105251158580.3922722@eliteleevi.tm.intel.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <d7d3b76a-ad3a-85ac-092b-8bc2bab90430@opensource.cirrus.com>
Date:   Tue, 25 May 2021 10:39:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2105251158580.3922722@eliteleevi.tm.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AnmxL3aOzJasMdIr4AhYj2C4iGrC2uhE
X-Proofpoint-GUID: AnmxL3aOzJasMdIr4AhYj2C4iGrC2uhE
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105250063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/2021 10:28, Kai Vehmanen wrote:
> Hi,
> 
> On Mon, 24 May 2021, Pierre-Louis Bossart wrote:
> 
>> On 5/20/21 11:33 AM, Richard Fitzgerald wrote:
>>> Add select of SND_SOC_HDAC_HDMI for SND_SOC_INTEL_SOUNDWIRE_SOF_MACH.
>>> Without this the build results in missing references to
>>> hdac_hdmi_jack_port_init and hdac_hdmi_jack_init.
>> Kai, can you comment on this one? There is nothing specific to HDMI in this
>> driver.
> 
> usage of hdac-hdmi is removed in newer mach drivers (like
> sof_da7219_max98373, sof-pcm512 and ehl_rt5660 -> and there's no select
> for SND_SOC_HDAC_HDMI for these). For older ones, we've kept hdac-hdmi in
> to keep compatibility.
> 
> For sof_sdw, there are still calls to hdac_hdmi_jack_init() and friends
> in sof_sdw_hdmi.c, so this is a real problem.
> 
> I'd say a better fix is that we remove the hdac-hdmi support from sof_sdw.
> I can do a patch for that.
> 

Ok with me. I'm not using the hdmi.

>> Something's inconsistent here, it's not limited to SoundWire I am afraid
> 
> I checked all the related mach drivers and the Kconfig definitions are
> correct for others. So select is done to HDAC_HDMI whenever the mach
> driver uses hdac_hdmi_jack_*().
> 
> Br, Kai
> 
