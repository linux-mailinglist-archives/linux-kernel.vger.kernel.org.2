Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D032A310
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378109AbhCBIq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:46:26 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:48011 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377811AbhCBIaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:30:03 -0500
Received: from epcas3p3.samsung.com (unknown [182.195.41.21])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210302082803epoutp025dc14b8df1ac41aae4daf59c60b97303~oeSjyLmvT0162701627epoutp02e
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 08:28:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210302082803epoutp025dc14b8df1ac41aae4daf59c60b97303~oeSjyLmvT0162701627epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614673683;
        bh=ieAX5F0NNTBKAp0bwMpe/dTphFDtJVxl3rOuhDMWvkw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=UHQ9BCNW2jJZsNVFqTjwqRbTVnt1JEUhawnVmVQYzQyUK6LEeGgFVwWSa7j1zyHJa
         NHgEeaGe6gHYiymcvI2MBuy8OCAo5ms9dvkDX3DMGF4QBeeKJbLbGO5d/BfPut+TMW
         Q3vXo/+oBORwdLEXZyOaQkVwAQa/bUr1x4d4E4EA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas3p3.samsung.com (KnoxPortal) with ESMTP id
        20210302082802epcas3p3ffe8cb231ca2d09f2a0e29bf2dd20ed5~oeSjSh4Al1701117011epcas3p3i;
        Tue,  2 Mar 2021 08:28:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp4.localdomain
        (Postfix) with ESMTP id 4DqVcy4Ljzz4x9Pw; Tue,  2 Mar 2021 08:28:02 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH v4 6/9] scsi: ufshpb: Add hpb dev reset response
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
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
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20210226083300.30934-7-avri.altman@wdc.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <2038148563.21614673682593.JavaMail.epsvc@epcpadp4>
Date:   Tue, 02 Mar 2021 17:20:28 +0900
X-CMS-MailID: 20210302082028epcms2p3516b09d363126e1a7b2113d29fb874a2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20210226083447epcas2p2f68ef00a935d25bd2cfc930d1ef1f4f7
References: <20210226083300.30934-7-avri.altman@wdc.com>
        <20210226083300.30934-1-avri.altman@wdc.com>
        <CGME20210226083447epcas2p2f68ef00a935d25bd2cfc930d1ef1f4f7@epcms2p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Avri,

> diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
> index cf704b82e72a..f33aa28e0a0a 100644
> --- a/drivers/scsi/ufs/ufshpb.c
> +++ b/drivers/scsi/ufs/ufshpb.c
> @@ -642,7 +642,8 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
>                  if (rgn->reads == ACTIVATION_THRESHOLD)
>                          activate = true;
>                  spin_unlock_irqrestore(&rgn->rgn_lock, flags);
> -                if (activate) {
> +                if (activate ||
> +                    test_and_clear_bit(RGN_FLAG_UPDATE, &rgn->rgn_flags)) {

How about merge rgn->rgn_flags to rgn_state?

Thanks,
Daejun
