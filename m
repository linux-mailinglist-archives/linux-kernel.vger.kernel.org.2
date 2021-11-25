Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B920B45DDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356137AbhKYPsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:48:22 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45706 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1356146AbhKYPqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:46:19 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1APEApQ3029076;
        Thu, 25 Nov 2021 16:42:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=0Iz+5s60sQLr6dSevW6pEwhxuRykpii00GdV0s3IDOk=;
 b=iBNLuo5MreCOWwA86U+bhH6QTU+8LqMGmUUoU/coFT5kAZ94faJjjkEpBLExep1l5nHC
 D08a9rPHsoDDC0lmH4rE6YNT5PXgO4Hs3upbz96KWwKcsC8HnN6gYtaZABFnYog+eJMu
 7aSP/vMgTpwvLdI5oiQFc4YGJD+AlANW4PxJRaUys9+Bra34Z6RXPcl5A2ujjxhyLBk6
 XSjThNlJTHU4cjikXrj4VScZR406HKiFLxND4Pk/Ncj0H/VkTaiiYBavr96Mdh1eJNPR
 ijX0fCwdXFgix1LL3ELQqCXXCzvWRiCrCBgmKZc4wJVhHxj+hkox/GGsR/AmslKagElw bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cj24vcm8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 16:42:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8AD6610002A;
        Thu, 25 Nov 2021 16:42:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 82CAC23C256;
        Thu, 25 Nov 2021 16:42:56 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 25 Nov
 2021 16:42:56 +0100
Subject: Re: [PATCH 0/2] tune the HS USB PHYs on stm32mp15 eval and disco
 boards
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
CC:     <robh+dt@kernel.org>, <amelie.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1635175070-28722-1-git-send-email-fabrice.gasnier@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <c101d5eb-00e5-7994-d503-f2a5dad61bf9@foss.st.com>
Date:   Thu, 25 Nov 2021 16:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1635175070-28722-1-git-send-email-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-25_06,2021-11-25_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 10/25/21 5:17 PM, Fabrice Gasnier wrote:
> This series tune the HS USB PHYs on stm32mp15 eval and disco boards, now that
> dt-bindings and drivers have been merged in [1].
> 
> [1] https://lore.kernel.org/all/20211015161427.220784-1-amelie.delaunay@foss.st.com/
> 
> Fabrice Gasnier (2):
>    ARM: dts: stm32: tune the HS USB PHYs on stm32mp15xx-dkx
>    ARM: dts: stm32: tune the HS USB PHYs on stm32mp157c-ev1
> 
>   arch/arm/boot/dts/stm32mp157c-ev1.dts  | 22 ++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 16 ++++++++++++++++
>   2 files changed, 38 insertions(+)
> 

Series applied on stm32-next.

Thanks!
Alex
