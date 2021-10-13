Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918F242C1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhJMOCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:02:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36844 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230324AbhJMOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:02:33 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DDN6eM011490;
        Wed, 13 Oct 2021 16:00:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=fCSqyNLZi/i47QTIlxvDJ8Eee5KYsx+MfdTqMt9Kdc0=;
 b=iC+84/nFPw5V7xCloQvvjVfvnEuuEi+MWBmN7CJBEaOdVE2Fhwwywv2YL+ZfzFUB7uuX
 kcc1sxjSFVMzuZvTR28I4m74NMF4gKWaJMAATsKRvRmCvrhJdb0RaZObMgc5+u2QhV5x
 AX77qWrBywxeqr+QLeJ1zazZf6ShbLF7+7zxDgdPhw3DIUP1cX8zr52Yrtpgi6gNZum8
 jQTmMhLa1Kkpc8mkDGXRobG1MuKUgKHIJ+fFLOQ4mOErOgo1ktBZQl58OBQ2qpxKZ3bw
 razL6Z7oALDJxHL6OTczsiwDxq+76GkHQEhFJXceSiXyA8f96lPwyX7bLnCCeP/3MOVJ vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bnuxttbaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:00:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F8EB10002A;
        Wed, 13 Oct 2021 16:00:24 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0799622F7D6;
        Wed, 13 Oct 2021 16:00:24 +0200 (CEST)
Received: from [10.211.0.59] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 13 Oct
 2021 16:00:22 +0200
Subject: Re: [PATCH v2 0/2] usb: dwc2: fill in gadget caps, configure it for
 stm32mp15
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>
References: <1633679589-16021-1-git-send-email-fabrice.gasnier@foss.st.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <1000e62a-26e2-90d3-afee-a4166bb4ff79@foss.st.com>
Date:   Wed, 13 Oct 2021 16:00:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1633679589-16021-1-git-send-email-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/21 9:53 AM, Fabrice Gasnier wrote:
> This patchset fills in 'otg_caps' of the usb_gadget structure, and
> configures it on stm32mp15.
> 
> When dwc2 is configured as dual role (OTG), the USB gadget descriptors
> (device mode) are configured via configfs. This lead in calling
> usb_otg_descriptor_init().
> In usb_otg_descriptor_init() (drivers/usb/gadget/config.c):
> - If otg caps structure is provided -> use it
> - If otg caps structure isn't provided -> HNP and SRP are enabled by default
> 
> This could lead to a configuration mismatch beetween:
> - OTG controller: HNP and SRP aren't enabled
> - gadget descriptors: HNP and SRP are advertised
> 
> ---

Hi All, I just sent a v3 of this series, to add the dt-bindings.

Please rather review the v3.

Thanks in advance,
Fabrice


> Changes in v2:
> - replace otg_cap bit field by otg_caps structure.
> - Fix build issue when HOST only mode is selected [1]
> - DT patch for stm32mp151 merged in v1, so not resent
> 
> [1] https://syzkaller.appspot.com/bug?extid=7af597ce2b38596c16ea
> 
> Fabrice Gasnier (2):
>   usb: dwc2: add otg_rev and otg_caps information for gadget driver
>   usb: dwc2: stm32mp15: set otg_rev
> 
>  drivers/usb/dwc2/core.h    | 19 ++++++------
>  drivers/usb/dwc2/debugfs.c |  4 ++-
>  drivers/usb/dwc2/gadget.c  |  1 +
>  drivers/usb/dwc2/hcd.c     | 12 +++-----
>  drivers/usb/dwc2/params.c  | 75 ++++++++++++++++++++++++++--------------------
>  5 files changed, 59 insertions(+), 52 deletions(-)
> 
