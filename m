Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23D13C5FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhGLPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:53:39 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:2368 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233384AbhGLPxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:53:38 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CFcD4J013923;
        Mon, 12 Jul 2021 17:50:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : subject : to
 : cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=7wHZiJKHopPjFcSmO2LJg+VmslPpnToK6px9Xl/jPQI=;
 b=A83AvVfhzLWkRvB7KrIISwsXt7QaI27BUJyilJ5P8lkljEFrQdIa/XcwOgQpYZ7voFg7
 067f1Dz22H1309kWFEBXN61a1UVvWXFQF2/WE3pdfgQIxPu5nSUaWVPYLH+DiIAmQ7KP
 GPdzXJAq/4ZDPhTZOmxjnDlOtH7ug6j0c54DYP9BmKtHaE3b8cAiQd9cHrVpU+BUwBDy
 WCQ58T7/IbxEZCDU8CF1y71Qyuxw7uwz5RnzOYG2XYLQPmxv4pCn54LUatdDEhzNnF//
 eIg0XWo4gS6KZXc4m1MzLDEgXmL/xxhkPyUVQ7XRbWXQWRk+qnq2vSjbyY3LO0LDU0QD Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39rk1vhqdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 17:50:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C939910002A;
        Mon, 12 Jul 2021 17:50:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9525E231DFC;
        Mon, 12 Jul 2021 17:50:17 +0200 (CEST)
Received: from lmecxl0557.lme.st.com (10.75.127.46) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Jul
 2021 17:50:16 +0200
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Subject: Re: [PATCH 0/2] Add "BACKGROUND_COLOR" drm property
To:     Simon Ser <contact@emersion.fr>
CC:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Yannick FERTRE - foss <yannick.fertre@foss.st.com>,
        Philippe CORNU - foss <philippe.cornu@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Raphael GALLAIS-POU <raphael.gallais-pou@st.com>,
        Philippe CORNU <philippe.cornu@st.com>
References: <20210707084557.22443-1-raphael.gallais-pou@foss.st.com>
 <31K3xupK1-7HNWorHqIwGwgEJl-1XdFjUQEoNYm6yB-lRoZ8kq5quRji_r3mzPZ0bUayLef6xPfQDiETgZp9lR7vUpDn2nB_37ncSd-J0Wc=@emersion.fr>
 <YOWTCSpOZTGZS2qP@phenom.ffwll.local>
 <a8f02b4c-b1ea-320e-a6b2-952f4e641794@foss.st.com>
 <OMOzHvru0iqQzq7rTSqJtI0P9wKSBLATuflwj10xgHvSgJ49V522CaDkIiZ0wWHJw-F5GPQxeO8cKO5ACMXggtDNlfx5TAa0zRObj7wsHHg=@emersion.fr>
Message-ID: <208def96-ac15-ce4e-7a0a-b555ea314fc5@foss.st.com>
Date:   Mon, 12 Jul 2021 17:50:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <OMOzHvru0iqQzq7rTSqJtI0P9wKSBLATuflwj10xgHvSgJ49V522CaDkIiZ0wWHJw-F5GPQxeO8cKO5ACMXggtDNlfx5TAa0zRObj7wsHHg=@emersion.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_09:2021-07-12,2021-07-12 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/9/21 11:23 AM, Simon Ser wrote:
> On Friday, July 9th, 2021 at 11:09, Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com> wrote:
>
>> We don't usually test with piglit and igt-gpu-tools. Instead, modetest
>> utility of the libdrm is used quite often (as is it the case in order to
>> test this property).
> Just to make it extra clear: regardless of how you bring up your driver
> implementation, without an IGT test and real-world open-source user-space
> patches that make use of the new prop, your patches *cannot* be merged.
>
> If you're planning to add support for the new prop to an open-source KMS
> client, please add a link to the patches in your kernel submission. If
> you don't have plans to use the new prop in an open-source KMS client,
> let us know and we can discuss what the best candidate would be.

Hi,

Thanks for your feedback :)


We do not have any KMS client currently using this property apart from proprietary solutions made by consumers.

This property was originally made to display a logo picture when the screen is in idle (low power/low DDR usage).


Regards,

Raphaël


>> I was also thinking about implementing an option into modetest to ease
>> the use of this drm property (support of hexadecimal values for properties).
> (For the record, modeset doesn't count as a real-world user-space usage: it's
> just a toy implementation, just a test tool.)
>
> Simon
