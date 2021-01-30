Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0475A309622
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 16:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhA3PHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 10:07:53 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:53344 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232305AbhA3O7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 09:59:44 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10UEs17r024124;
        Sat, 30 Jan 2021 08:58:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=aHgnx8i6ZRGn0eEMAjPDsXTwr9VuhUV7ocqnNxt+tTM=;
 b=bcsJ9IOGZTdR3/T5tA8yu0awkq7KFP7v0ckqibbA4MOzX+5ImFC2oYyq9DwHOmohEP/g
 4C5TN0TKEGbl0abMikkeGJDqKFryLJAbQHTZCh9pHEXFwmpgt3PB15S20Qs4A/k72R36
 wDOXm961WT6Dza8nIPOrLeT4VQfc6WdEHnTEEIz5Axo/QCpse/vJdeXr+ox3va6xY15P
 KcIN3craTxYj1iNkdeP7c7fR+UW/Ql07sInL22wG0M6+xsZVOQ45miiTXzAO3+Oi+F7S
 fU2E5UMRP2rCAkor9xz31hz8HSXR9K3a5ITnj7jbAnIib6Wuru4KV6U6xwqi4LseLIDo fg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36d4rtg5ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 30 Jan 2021 08:58:51 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Sat, 30 Jan
 2021 14:58:49 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Sat, 30 Jan 2021 14:58:49 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E055C45;
        Sat, 30 Jan 2021 14:58:49 +0000 (UTC)
Date:   Sat, 30 Jan 2021 14:58:49 +0000
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
Subject: Re: [PATCH v4 06/13] ASoC/extcon: arizona: Move arizona jack code to
 sound/soc/codecs/arizona-jack.c
Message-ID: <20210130145849.GQ106851@ediswmail.ad.cirrus.com>
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210123121313.79530-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210123121313.79530-7-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=893 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101300082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 01:13:06PM +0100, Hans de Goede wrote:
> The jack handling for arizona codecs is being refactored so that it is
> done directly by the codec drivers, instead of having an extcon-driver
> bind to a separate "arizona-extcon" child-device for this.
> 
> drivers/mfd/arizona-core.c has already been updated to no longer
> instantiate an "arizona-extcon" child-device for the arizona codecs.
> 
> This means that the "arizona-extcon" driver is no longer useful
> (there are no longer any devices for it to bind to).
> 
> This commit drops the extcon Kconfig / Makefile bits and moves
> drivers/extcon/extcon-arizona.c to sound/soc/codecs/arizona-jack.c .
> 
> This is a preparation patch for converting the arizona extcon-driver into
> a helper library for letting the arizona codec-drivers directly report jack
> state through the standard sound/soc/soc-jack.c functions.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
