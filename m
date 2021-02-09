Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05E6314DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 12:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhBILEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 06:04:35 -0500
Received: from mx01-sz.bfs.de ([194.94.69.67]:34556 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232080AbhBIK6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:58:50 -0500
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id DABFE2076E;
        Tue,  9 Feb 2021 11:57:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1612868252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1DfsCqs88iiQXx9DWuj57ZejBv/iB8OwGlMzxeON1g=;
        b=L+XB+9cKSQKPGfxZSR9SZuyPfdtlbofqolBjxsYSYkQtzW0FtR5MScz8D3qZ3c2xRn/0sV
        +Ej7sWzVqYbx+Qc/bHWjYvIKEozDvX6Sm9kIQ1u43f/Noc2sATXR09ggbiSnDsZ8EADFm+
        Tcn5Rsec2RYzMpPYc1gduwH6C5LyRb9PowHLp26kqTTv49t2ACE3UoyB/PdljEC6QevGff
        FxT5qN+DSAtEwUfgWW+IKU7eiE/GWXik59pkL0zsEazLhb+2dyWpkKlxlTPKHusnOu/1CZ
        3MZQFWfi+SWgvmG6Mv75oKtr4QHuocgfg+6B8zCkbTZf6ENFBVHyP1AKVZhLyg==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.2; Tue, 9 Feb 2021
 11:57:32 +0100
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%13]) with mapi id
 15.01.2176.002; Tue, 9 Feb 2021 11:57:32 +0100
From:   Walter Harms <wharms@bfs.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Will Deacon <will@kernel.org>
CC:     Colin King <colin.king@canonical.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Anan sun <anan.sun@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison with
 less than zero
Thread-Topic: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison with
 less than zero
Thread-Index: AQHW+jVw6vQF7iLM7kGMzk6JKLJ0oqpHqk8AgAfZ0YCAACsEgg==
Date:   Tue, 9 Feb 2021 10:57:32 +0000
Message-ID: <c6b3b6beeb1e439f881bc3ff4d39f27a@bfs.de>
References: <20210203135936.23016-1-colin.king@canonical.com>
 <20210204092558.GA20244@willie-the-truck>,<20210209091923.GO2696@kadam>
In-Reply-To: <20210209091923.GO2696@kadam>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.39]
x-tm-as-product-ver: SMEX-14.0.0.3080-8.6.1012-25962.007
x-tm-as-result: No-10--7.431600-5.000000
x-tmase-matchedrid: qqoVTVjx6YDRubRCcrbc5grcxrzwsv5u3dCmvEa6IiHgYNP0+4v1nizy
        bVqWyY2NjrJzIoPQuMw+otRoIV3vSHVgBjkrax/H52zh+cq/0JuQBbTqDF++CmOMyb1Ixq8VUDG
        dbyXu/ma30GP8pin5GSKkzMT7+4ooN9rojbjxBkzXA3LnlKuVLMqFE6gRdROb+nlefiwGml8hlG
        9iTcYtaqNIXC+Evb2D1qIE4CfpJ4zBm5Pnp+5TT/SG/+sPtZVkJih/yo+OvlXk6Qbi+9i6D0MmJ
        6dGmSIy2JDeaNwtlNBVVkf0bJfBjyxppiUy9o4cGjzBgnFZvQ4vV5f7P0HVDETqq9Xa45y5XJvT
        MgAKYypb2hQcAFTn3WnsfYyMrTTf6Ne/nacGH0HM0ihsfYPMYdFTR6mnbN4LvGAx/1ATZ5sJetz
        2R9zIsefqkkwronku/Sj/WnCM/LO/WXZS/HqJ2gtuKBGekqUpbGVEmIfjf3vt19sHZWTQhkfEDy
        E6wbBxQsEUiq7rfWGPfhLI9kH4wx7PLpUeWnT+
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--7.431600-5.000000
x-tmase-version: SMEX-14.0.0.3080-8.6.1012-25962.007
x-tm-snts-smtp: 8C502E7B3B6532B6AC707D8C4AE56DFF89CE4B2F07035BEC56FE6C2324B7857A2000:9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=0.82
X-Spamd-Result: default: False [0.82 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_MATCH_FROM(0.00)[];
         DKIM_SIGNED(0.00)[bfs.de:s=dkim201901];
         BAYES_HAM(-0.68)[83.00%];
         RCPT_COUNT_TWELVE(0.00)[14];
         NEURAL_HAM(-0.00)[-1.000];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[canonical.com,8bytes.org,gmail.com,mediatek.com,chromium.org,lists.linux-foundation.org,lists.infradead.org,vger.kernel.org];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: mx01-sz.bfs.de;
        none
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I second that ...

Having i unsigned violates the rule of "least surprise".
If you need it unsigned make it clearly visible, also adding
a simple comment may help.

jm2c,
 wh
________________________________________
Von: Dan Carpenter <dan.carpenter@oracle.com>
Gesendet: Dienstag, 9. Februar 2021 10:19:23
An: Will Deacon
Cc: Colin King; Joerg Roedel; Matthias Brugger; Anan sun; Yong Wu; Chao Hao=
; Tomasz Figa; iommu@lists.linux-foundation.org; linux-arm-kernel@lists.inf=
radead.org; linux-mediatek@lists.infradead.org; kernel-janitors@vger.kernel=
.org; linux-kernel@vger.kernel.org
Betreff: Re: [PATCH][next] iommu/mediatek: Fix unsigned domid comparison wi=
th less than zero

On Thu, Feb 04, 2021 at 09:25:58AM +0000, Will Deacon wrote:
> On Wed, Feb 03, 2021 at 01:59:36PM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently the check for domid < 0 is always false because domid
> > is unsigned.  Fix this by making it signed.
> >
> > Addresses-CoverityL ("Unsigned comparison against 0")
>
> Typo here ('L' instead of ':')
>
> > Fixes: ab1d5281a62b ("iommu/mediatek: Add iova reserved function")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/iommu/mtk_iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 0ad14a7604b1..823d719945b2 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -640,7 +640,7 @@ static void mtk_iommu_get_resv_regions(struct devic=
e *dev,
> >                                    struct list_head *head)
> >  {
> >     struct mtk_iommu_data *data =3D dev_iommu_priv_get(dev);
> > -   unsigned int domid =3D mtk_iommu_get_domain_id(dev, data->plat_data=
), i;
> > +   int domid =3D mtk_iommu_get_domain_id(dev, data->plat_data), i;
>
> Not sure if it's intentional, but this also makes 'i' signed. It probably
> should remain 'unsigned' to match 'iova_region_nr' in
> 'struct mtk_iommu_plat_data'.


iova_region_nr is either 1 or 5 so unsigned doesn't matter.

I once almost introduced a bug where the iterator was supposed to be
size_t.  I fixed a bug by making it signed but I ended up introducing a
new bug.  But generally that's pretty rare.  The more common case is
that making iterators unsigned introduces bugs.

It's better to default to "int i;" and if more complicated types are
required that should stand out.  "size_t pg_idx;" or whatever.

regards,
dan carpenter
