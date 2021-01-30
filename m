Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6750F309679
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhA3P7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 10:59:02 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:62180 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231535AbhA3Pzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 10:55:37 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10UF6T1S007664;
        Sat, 30 Jan 2021 09:15:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=z6O7qQU4+a8/PrtYDJjwK1tn9hCYDnZdVwKAB86IJtc=;
 b=kNvhE+f7/rZy3o5jKux9b3DY4AGoAEg2JSpjhoydPOlcluZpQNgD5c1yEOUrVidxEAwi
 2WNo/IKauPWxqzQ7MF84HwRfYjrb5BkBzfC9MnZekgxbNQjyUL02MeV0QpPYt6zUCRnw
 WPjXqNk34TKozq3EN84in72Mpgn6FaANz/Y7M+dsiT/nWjlw7q26RCuP28IuHK/6D6O2
 maWq1iCktH6iIDehwnaMTZm3aZ+u+sKavlP8IjtRLU34VpNnXq3tgWg8dyShaIPI6+m+
 JGpF6fIo+5bpoAOVOqg/qHIhUhsZl8rQsr08lrAXo0I7qCVgqIM+dwwawW94DWGwXKFp ng== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36d4rtg5xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 30 Jan 2021 09:15:38 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Sat, 30 Jan
 2021 15:15:37 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Sat, 30 Jan 2021 15:15:37 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E620645;
        Sat, 30 Jan 2021 15:15:36 +0000 (UTC)
Date:   Sat, 30 Jan 2021 15:15:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v4 07/13] ASoC: arizona-jack: Move jack-detect variables
 to struct arizona_priv
Message-ID: <20210130151536.GR106851@ediswmail.ad.cirrus.com>
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210123121313.79530-8-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210123121313.79530-8-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=880 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 01:13:07PM +0100, Hans de Goede wrote:
> Move all the jack-detect variables from struct arizona_extcon_info to
> struct arizona_priv.
> 
> This is part of a patch series converting the arizona extcon driver into
> a helper library for letting the arizona codec-drivers directly report jack
> state through the standard sound/soc/soc-jack.c functions.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
