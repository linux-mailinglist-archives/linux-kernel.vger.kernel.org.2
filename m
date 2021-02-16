Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6731C700
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 08:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBPHw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 02:52:26 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35848 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229695AbhBPHwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 02:52:17 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11G7joHH004321;
        Tue, 16 Feb 2021 08:51:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=LPtaGRUyWC02QXhqpxIHZK7eZrIwHlrsUNhwHvFXhSg=;
 b=Anmg3nHz9JISQSgQmEFJ3vkx09l6XINTj4DdnIkrL4S3bFYOvVo913Qf8zjJ8rRkwfIB
 ZcTdsFOwlxbAEKtMGANYz8fZ0ikL2mW/74KiKPLNMTLRRFLZ7RFcKmT7RmEpvQyu5VVD
 b5I52wQeoZ6oPUkVRSFwd5X/BOz0awAieQvh7VYJ0asxfWNAY2tHzamDDj1zLQ0Z7CSO
 8F5JXAbYn7Y4XfkLjw3MAYYrPQ5oX9QTATjW+cfh+49DNDSsL1f5gw76/eybRbpGHkud
 c/7BARQY0ysKE7zRAQzijkBuej1rNyzLyfrlFOXXfqpNHRjsu55PJISg3K4KQCbt7z9b qQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36p706e690-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Feb 2021 08:51:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D15C10002A;
        Tue, 16 Feb 2021 08:51:29 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6B61D21CA93;
        Tue, 16 Feb 2021 08:51:29 +0100 (CET)
Received: from lmecxl0573.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Feb
 2021 08:51:28 +0100
Subject: Re: [PATCH 0/3] MAINTAINERS: update STMicroelectronics email
To:     Arnd Bergmann <arnd@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
References: <20210201100023.10985-1-patrice.chotard@foss.st.com>
 <800f8dfa-0949-ddf8-1635-15311c2c9623@foss.st.com>
 <CAK8P3a1Xqd0LijMhoms8vdS8zNDP-r=d7i1XL=kOk606Quo-xg@mail.gmail.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <f4275e08-0385-5316-8e46-f97bfb2b0f65@foss.st.com>
Date:   Tue, 16 Feb 2021 08:51:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1Xqd0LijMhoms8vdS8zNDP-r=d7i1XL=kOk606Quo-xg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_16:2021-02-12,2021-02-15 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd

On 2/15/21 3:19 PM, Arnd Bergmann wrote:
> On Mon, Feb 15, 2021 at 2:17 PM Patrice CHOTARD
> <patrice.chotard@foss.st.com> wrote:
>>
>> Hi Arnd, Olof, Kevin
>>
>> What is the best way to get this series merged ?
>> Do you pick it and apply it directly, or do we integrate it in the next STM32 pull request ?
> 
> I usually pick up updates to the MAINTAINERS file as bugfixes, so
> either send them as part of the fixes pull request, or forward them
> to soc@kernel.org to apply directly.
> 
> If you cc me on patches for a particular platform, I usually just ignore them,
> unless they get sent to soc@kernel.org, and in that case I will either apply
> them or ask back if they were meant for us.
> 
>       Arnd
> 

Ok, i will resend this series to soc@kernel.org.
Thanks
Patrice
