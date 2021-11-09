Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6202F44B1D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbhKIRSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:18:39 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32902 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239822AbhKIRSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:18:37 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A9FFaVl017554;
        Tue, 9 Nov 2021 18:15:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=WP56nJUOgV37WP5yVcprpOPdwQe3wKj3NgL3ETog4LU=;
 b=YHwvA0thwO90uBFvXw7tP7KDEpb5DY5n/1ZYpWwlNfQNRKt4taiHz8R0pUCoDc6rdfSd
 U1+InG/846E+PdkTTD34k8wdJC06f4+pFMFAnvvvk6l5Mqd0kWxJVGZ8tKWyGCPtxlMB
 m/B+QiJD/TbKL1ULTCOs+YKIEwR0dmpIEp0/CEpy0CjT69zYFXZZz1nzFyF3nhW5cY9l
 JHAazlAwpkyoe+pKCxS0izTqGuSXZsqUJ2zCANtmUp/uxBOFOLdaVdyWv/H/PUcAUI7I
 RqSFiJ2f0HTTay8Gfo/qVVzceJgiT3LLPx/kDcajEX74x3d8EicUJaqP0x4NUeozWKGT Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3c7ufn8mwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Nov 2021 18:15:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0EA4D10002A;
        Tue,  9 Nov 2021 18:15:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA75C21AFA3;
        Tue,  9 Nov 2021 18:15:45 +0100 (CET)
Received: from lmecxl0993.lme.st.com (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 9 Nov
 2021 18:15:44 +0100
Subject: Re: [PATCH] MAINTAINERS: Update Benjamin Gaignard maintainer status
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        <linux-kernel@vger.kernel.org>,
        Philippe CORNU <philippe.cornu@st.com>
References: <20210706163033.795805-1-benjamin.gaignard@collabora.com>
 <a1df40c2-f414-56e9-2e42-83e28ad54cee@foss.st.com>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
Message-ID: <8a1ecd56-5690-7f0b-9c7f-92ff4ca46120@foss.st.com>
Date:   Tue, 9 Nov 2021 18:15:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a1df40c2-f414-56e9-2e42-83e28ad54cee@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_04,2021-11-08_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/21 5:48 PM, Alexandre TORGUE wrote:
> Hi Arnd
> 
> On 7/6/21 6:30 PM, Benjamin Gaignard wrote:
>> Update Benjamin Gaignard address and remove it from no more maintained
>> drivers.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> 
> How to handle this kind of patch ? Do I take it or do you take it 
> directly through arm-soc tree ?
> 
> regards
> Alex

Hi Arnd & Alexandre,

This is a kind reminder email ;-)

Many thanks for your support,
Philippe :-)


> 
>> ---
>>   MAINTAINERS | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8c5ee008301a6..c6356cd0446a8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5460,7 +5460,7 @@ F:    tools/testing/selftests/dma/
>>   DMA-BUF HEAPS FRAMEWORK
>>   M:    Sumit Semwal <sumit.semwal@linaro.org>
>> -R:    Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> +R:    Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>   R:    Liam Mark <lmark@codeaurora.org>
>>   R:    Laura Abbott <labbott@redhat.com>
>>   R:    Brian Starkey <Brian.Starkey@arm.com>
>> @@ -6141,7 +6141,6 @@ F:    
>> Documentation/devicetree/bindings/display/rockchip/
>>   F:    drivers/gpu/drm/rockchip/
>>   DRM DRIVERS FOR STI
>> -M:    Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>   L:    dri-devel@lists.freedesktop.org
>>   S:    Maintained
>>   T:    git git://anongit.freedesktop.org/drm/drm-misc
>> @@ -6151,7 +6150,6 @@ F:    drivers/gpu/drm/sti
>>   DRM DRIVERS FOR STM
>>   M:    Yannick Fertre <yannick.fertre@foss.st.com>
>>   M:    Philippe Cornu <philippe.cornu@foss.st.com>
>> -M:    Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>   L:    dri-devel@lists.freedesktop.org
>>   S:    Maintained
>>   T:    git git://anongit.freedesktop.org/drm/drm-misc
>> @@ -17453,7 +17451,6 @@ F:    
>> Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
>>   F:    sound/soc/sti/
>>   STI CEC DRIVER
>> -M:    Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>   S:    Maintained
>>   F:    Documentation/devicetree/bindings/media/stih-cec.txt
>>   F:    drivers/media/cec/platform/sti/
>>
> 
> 
> 
