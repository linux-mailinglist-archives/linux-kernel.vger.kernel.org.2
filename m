Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD99C32A39C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378534AbhCBJXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:23:50 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:49189 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837822AbhCBI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:59:04 -0500
Received: from epcas3p3.samsung.com (unknown [182.195.41.21])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210302082803epoutp010b1034c4f960e79660fb110f66f39c80~oeSkbvAVu0518705187epoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:28:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210302082803epoutp010b1034c4f960e79660fb110f66f39c80~oeSkbvAVu0518705187epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614673683;
        bh=7skspc6R+OWIcd2Nt3lRmZny23gnAZ+tKdkuAkGkBi8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=IN3n1geYYkojaEZ4HIYWQIK7tzBMPjOTiq8EX8O7GSjBbTfM0DZHLcWYQA5tKtsI6
         SQ3Sl9EbllgzEra/lXHTesrefInc0Q9CugqmJO0t8bbmacQYN/GZzPhUSfx0pxS+hA
         Mjble6rW9uNAqtsjsld4zuwvpGQpW7xA8oExQy8I=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas3p1.samsung.com (KnoxPortal) with ESMTP id
        20210302082803epcas3p16f4072a14ab5ea91ca477c183e3a9faa~oeSkCjqBo1935019350epcas3p1S;
        Tue,  2 Mar 2021 08:28:03 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp1.localdomain
        (Postfix) with ESMTP id 4DqVcz2zMmz4x9QN; Tue,  2 Mar 2021 08:28:03 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH v4 7/9] scsi: ufshpb: Add "Cold" regions timer
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        Zang Leigang <zangleigang@hisilicon.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20210226083300.30934-8-avri.altman@wdc.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <878274034.81614673683390.JavaMail.epsvc@epcpadp4>
Date:   Tue, 02 Mar 2021 17:26:28 +0900
X-CMS-MailID: 20210302082628epcms2p7d6e8a9b4b119e795ee097b3ec63ce69c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20210226083459epcas2p1862e3e2c18208074336cc9faf14a7139
References: <20210226083300.30934-8-avri.altman@wdc.com>
        <20210226083300.30934-1-avri.altman@wdc.com>
        <CGME20210226083459epcas2p1862e3e2c18208074336cc9faf14a7139@epcms2p7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avri,

> +static void ufshpb_read_to_handler(struct work_struct *work)
> +{
> +        struct delayed_work *dwork = to_delayed_work(work);
> +        struct ufshpb_lu *hpb;
> +        struct victim_select_info *lru_info;
> +        struct ufshpb_region *rgn;
> +        unsigned long flags;
> +        LIST_HEAD(expired_list);
> +
> +        hpb = container_of(dwork, struct ufshpb_lu, ufshpb_read_to_work);
> +
> +        if (test_and_set_bit(TIMEOUT_WORK_PENDING, &hpb->work_data_bits))
> +                return;
> +
> +        spin_lock_irqsave(&hpb->rgn_state_lock, flags);
> +
> +        lru_info = &hpb->lru_info;
> +
> +        list_for_each_entry(rgn, &lru_info->lh_lru_rgn, list_lru_rgn) {
> +                bool timedout = ktime_after(ktime_get(), rgn->read_timeout);
> +
> +                if (timedout) {

It is important not just to check the timeout, but how much time has passed.
If the time exceeded is twice the threshold, the read_timeout_expiries
value should be reduced by 2 instead of 1.

> +                        rgn->read_timeout_expiries--;

Thanks,
Daejun

