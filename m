Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EA638C9CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhEUPLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:11:14 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:38778 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230420AbhEUPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:11:12 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14LF6weW004704;
        Fri, 21 May 2021 10:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=vb3caAt/tKr79nkmDUGEd2unVM3Vh/hFlp4bXuoFTXo=;
 b=NACigRTXcoFNMy5gvvel/FK2kHfv2VsCyXohh12TaHxXFtC8z2LLCL4IwIEmlG5dLykv
 +NrwgP6QjmAtPPDlW5is0TIrdj6DcJjZ5eqYxeYiqvaWqYW5x2MFAP466dF71j7T84zC
 UEUonuQdEDxOJGqqCEyxiKzcy+l3eXA36JOYk+zcv761HYam2sfvmixbkYVu0/W3WS5D
 ippFR0SZItfCITc5GeRuSgkKOWI4wKiZQ7J8Bzde0wmykumx7rC9XqdP8IBOS1wjG0lp
 lrZaL03Fsw/srHyMGBcLm3mybiMO+fIAdexA5w2c4Ruy1/gTwVMtuTq7STWAy6JoKBYG BA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38p6errkag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 21 May 2021 10:09:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 16:09:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 21 May 2021 16:09:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9A1BB11D6;
        Fri, 21 May 2021 15:09:35 +0000 (UTC)
Date:   Fri, 21 May 2021 15:09:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH] mfd: arizona: Allow building arizona MFD-core as module
Message-ID: <20210521150935.GL64205@ediswmail.ad.cirrus.com>
References: <20210521135023.192688-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210521135023.192688-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: _ZjdkWqRT1n5vZnloVNu9f9e3IUvFRPt
X-Proofpoint-ORIG-GUID: _ZjdkWqRT1n5vZnloVNu9f9e3IUvFRPt
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=874 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 03:50:23PM +0200, Hans de Goede wrote:
> There is no reason why the arizona core,irq and codec model specific
> regmap bits cannot be build as a module. All they do is export symbols
> which are used by the arizona-spi/i2c and arizona-codec modules, which
> themselves can be built as module.
> 
> Change the Kconfig and Makefile arizona bits so that the arizona MFD-core
> can be built as a module.
> 
> This is especially useful on x86 platforms with a WM5102 codec, this
> allows the arizona MFD driver necessary for the WM5102 codec to be
> enabled in generic distro-kernels without growing the base kernel-image
> size.
> 
> Note this also adds an explicit "depends on MFD_ARIZONA" to all the
> arizona codec Kconfig options. The codec drivers use functions from mfd
> arizona-core. These new depends are necessary to disallow the codec
> drivers being builtin when the arizona-core is build as a module,
> otherwise we end up with missing symbol errors when building vmlinuz.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
