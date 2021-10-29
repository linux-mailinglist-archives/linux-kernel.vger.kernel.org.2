Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA8D43FBE2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 13:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhJ2L5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 07:57:41 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:34658 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230134AbhJ2L5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:57:40 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19T9dXwP027028;
        Fri, 29 Oct 2021 06:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=kEDTtI4Kmg97IJO2WoQYdCw1XIYOjOxgPMAGQLirbPc=;
 b=p8RLolHRjCEpyfhksh07E2LR3dbEr4IZn13OqlX5t247kcqz/I3m2b47Y6cM6MKNlBQf
 V0H57S1tYPiYUeUiZ0DzHxyt9uxlatqUUxJdZip3FqNyskcZ8VuHEb4OONK539Pj6iL/
 8ph8K8K2+VboJMW0cLD8Ul1RzGaEnxlpmv89shlXizowGwL/sMRuxzaOJQoYErw8b0ZR
 dQVfJf1m7SmRWEqgpEf/Y0MfNfxLZ49R/uS34HbgGImQxtOKhjyhzkwYUJVJWKm/fIhn
 l3zKICucUxtPI/XZ+gGVriqke5Pyne0jwN6KM+HhwZrKlAN+gESh+C7YShHyrkj/+JrJ Pw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3c0egyr48q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Oct 2021 06:54:53 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 29 Oct
 2021 12:54:51 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 29 Oct 2021 12:54:51 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 805B711CB;
        Fri, 29 Oct 2021 11:54:50 +0000 (UTC)
Date:   Fri, 29 Oct 2021 11:54:50 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     David Heidelberg <david@ixit.cz>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        - <patches@opensource.cirrus.com>,
        <~okias/devicetree@lists.sr.ht>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: sound: wlf,wm8903: Convert txt bindings
 to yaml
Message-ID: <20211029115450.GH28292@ediswmail.ad.cirrus.com>
References: <20211028124639.38420-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211028124639.38420-1-david@ixit.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: AFVpuzUCs6QToA3GPdZe_C-FWua-QtNg
X-Proofpoint-ORIG-GUID: AFVpuzUCs6QToA3GPdZe_C-FWua-QtNg
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 02:46:38PM +0200, David Heidelberg wrote:
> Convert the Wolfson WM8903 Ultra-Low Power Stereo CODEC Device Tree
> binding documentation to json-schema.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
