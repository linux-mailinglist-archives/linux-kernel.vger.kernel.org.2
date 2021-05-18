Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA069386FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 04:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbhERCfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 22:35:55 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:40257 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhERCfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 22:35:53 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210518023434epoutp0215582af665a63ae877565cac6e987d64~ACI6anNG_1985819858epoutp02-
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:34:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210518023434epoutp0215582af665a63ae877565cac6e987d64~ACI6anNG_1985819858epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621305274;
        bh=kwVY0w5ghYheMv4Tcly+CPmTc9SqQ00Ru/Vb1zkcDOk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=W/o3c282+B8+ZxM3Ci3QZYLcwfw88R+jkG6QNLFla7YE9CbClM2V42LoOOTJEeSY4
         5bllmIKfqaBWb7Gw4OEGS+k1hcOyn5VTsXAvaY7GbwnYRMtDajK2o8E/T852M9cudU
         dM60ePKEtO9A6Af70uQOcDNFMeJLAIw2oZ/F5mNE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210518023433epcas1p4b32a9b0fc0c8b24bc30ec3b9723b3705~ACI5spLpQ0673106731epcas1p4-;
        Tue, 18 May 2021 02:34:33 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Fkg7V0H25z4x9Px; Tue, 18 May
        2021 02:34:30 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.14.09578.3B723A06; Tue, 18 May 2021 11:34:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210518023427epcas1p335882bac2e663dbd8ffbf077b64dd316~ACIzxHxET1385313853epcas1p3c;
        Tue, 18 May 2021 02:34:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210518023427epsmtrp19c4ff6305aca1e2a303745f5e95ef315~ACIzwg6fj0315903159epsmtrp1x;
        Tue, 18 May 2021 02:34:27 +0000 (GMT)
X-AuditID: b6c32a35-fb9ff7000000256a-1b-60a327b3594c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.9C.08637.3B723A06; Tue, 18 May 2021 11:34:27 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210518023427epsmtip1484ca1087b07e7de829a1f9597ee281e~ACIzk6cSt2029120291epsmtip1d;
        Tue, 18 May 2021 02:34:27 +0000 (GMT)
Subject: Re: [PATCH v1 1/1] extcon-intel-mrfld: initialize mrfld_extcon
 status
To:     Ferry Toth <ftoth@exalondelft.nl>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d83c8a54-5db8-e1e5-2aa3-6d3065fbeef4@samsung.com>
Date:   Tue, 18 May 2021 11:52:57 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20210424174138.175889-1-ftoth@exalondelft.nl>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTT3ez+uIEg1kfTCx6m6YzWXy+JWZx
        edccNovbjSvYHFg8ejbfZ/SYdzLQo2/LKkaPz5vkAliism0yUhNTUosUUvOS81My89JtlbyD
        453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgBYqKZQl5pQChQISi4uV9O1sivJLS1IVMvKL
        S2yVUgtScgosC/SKE3OLS/PS9ZLzc60MDQyMTIEKE7Iz9tydw1jwW6Dif1MzUwPjW94uRg4O
        CQETiY+7E7oYuTiEBHYwSvxo3M0K4XxilNiz5QYbhPONUeJDy3/GLkZOsI77u09BJfYySix6
        95gJwnnPKHHsDkSVsECAxIMdW8BsEQFniV1H97GB2MwCSRKn918Gs9kEtCT2v7gBZvMLKEpc
        /fEYrJ5XwE7i486PYDaLgKrEs7NtzCC2qECYxMltLVA1ghInZz5hAbE5Bawl7j6/wwoxX1zi
        1pP5TBC2vMT2t3OYIa7+yS5xa6kihO0isW7ZK1YIW1ji1fEt7BC2lMTL/jYou1pi5ckjYF9K
        CHQwSmzZfwGqwVhi/9LJTKDAYxbQlFi/Sx8irCix8/dcRoi9fBLvvvawQsKXV6KjTQiiRFni
        8oO7TBC2pMTi9k62CYxKs5B8MwvJB7OQfDALYdkCRpZVjGKpBcW56anFhgWGyJG9iRGcFrVM
        dzBOfPtB7xAjEwfjIUYJDmYlEd5PYfMThHhTEiurUovy44tKc1KLDzGaAsN3IrOUaHI+MDHn
        lcQbmhoZGxtbmBiamRoaKonzpjtXJwgJpCeWpGanphakFsH0MXFwSjUwHa2qrFu1oU5eeImJ
        qhzTveJ1PaqXA82lrd+EzOhoN5h3O+5hQmtS1QyO7OOxP8r+Zn66xFlZeJfzlV7pF8FAuRc+
        03Wmb+y5NeNV957d732TjBxvTu2e/mRr1WOfY+wngzYznglv//hH/ueSabUzmFIuSW9Tt2ZS
        Sv0nKFjyRzT15tRJZkqWPY/Odl5U8siQ+X3W46qOE3vT6pinT+ZUnd1jtuNeo3Lz0RjDUO6K
        h4oc/AvszJtYL0+dl5HD/an7fxfriXsSQjL2W/kmq31jlhAJl2O8OleH4+Gz1YkXmCTklBb8
        ET7gHHGSRf5+kUJv05Hwv0VuVg+4AxLW8SVx/Jbbev67ybRyBsUdn8WVWIozEg21mIuKEwFz
        cTU0FAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSnO5m9cUJBlvfc1n0Nk1nsvh8S8zi
        8q45bBa3G1ewObB49Gy+z+gx72SgR9+WVYwenzfJBbBEcdmkpOZklqUW6dslcGXsuTuHseC3
        QMX/pmamBsa3vF2MnBwSAiYS93efYuti5OIQEtjNKDFpzX0miISkxLSLR5m7GDmAbGGJw4eL
        IWreMkpM33eIDaRGWMBP4s2EZawgtoiAs8Suo/vA4swCSRKPmhZBDe1jlNi6fA5Ygk1AS2L/
        ixtgNr+AosTVH48ZQWxeATuJjzs/gtksAqoSz862MYPYogJhEjuXPGaCqBGUODnzCQuIzSlg
        LXH3+R1WiGXqEn/mXWKGsMUlbj2ZzwRhy0tsfzuHeQKj8Cwk7bOQtMxC0jILScsCRpZVjJKp
        BcW56bnFhgWGeanlesWJucWleel6yfm5mxjBMaKluYNx+6oPeocYmTgYDzFKcDArifB+Cpuf
        IMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOT/KGpcSuc
        A62WbLY2vHbmEeM1g55Ssd6vR16FSGy6EnLiQ9EkkdMx4eZ5P8zKs9sLQz0b1LQ2y/27orPb
        fLPDlVIr7f2C/Se1VjHvSzwUeLmUedOGeKOPJaqPuq/lJfaYTDFrCedkC1kdOk1tw+ab2p1R
        7m73jG9uVX+c28e+Qu/i9ETp88zHcl83OHCuEygP81wp777noVCtTLin3K2uVN0NH15PNdzA
        pukafIQ784+Cus+8CF6mL2dfRtRVy5pJmhX/Oa7cG/b+q+J/9X/lCRe9j9zxO337Thd3teP5
        acdLl+RkLdL2PvDAPSY542h62juuaclrj+nN8wqOfl29cPeyU29/vN6hvTGrNUOJpTgj0VCL
        uag4EQDHfJ/ZAAMAAA==
X-CMS-MailID: 20210518023427epcas1p335882bac2e663dbd8ffbf077b64dd316
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210424174208epcas1p2aa4ad71d4450b9995a79e2d378c78865
References: <CGME20210424174208epcas1p2aa4ad71d4450b9995a79e2d378c78865@epcas1p2.samsung.com>
        <20210424174138.175889-1-ftoth@exalondelft.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/21 2:41 AM, Ferry Toth wrote:
> extcon driver for Basin Cove PMIC shadows the switch status used for dwc3
> DRD to detect a change in the switch position. This change initializes the
> status at probe time.
> 
> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 492929c54791 ("extcon: mrfld: Introduce extcon driver for Basin Cove PMIC")
> ---
>  drivers/extcon/extcon-intel-mrfld.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-intel-mrfld.c b/drivers/extcon/extcon-intel-mrfld.c
> index f47016fb28a8..cd1a5f230077 100644
> --- a/drivers/extcon/extcon-intel-mrfld.c
> +++ b/drivers/extcon/extcon-intel-mrfld.c
> @@ -197,6 +197,7 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
>  	struct intel_soc_pmic *pmic = dev_get_drvdata(dev->parent);
>  	struct regmap *regmap = pmic->regmap;
>  	struct mrfld_extcon_data *data;
> +	unsigned int status;
>  	unsigned int id;
>  	int irq, ret;
>  
> @@ -244,6 +245,14 @@ static int mrfld_extcon_probe(struct platform_device *pdev)
>  	/* Get initial state */
>  	mrfld_extcon_role_detect(data);
>  
> +	/*
> +	 * Cached status value is used for cable detection, see comments
> +	 * in mrfld_extcon_cable_detect(), we need to sync cached value
> +	 * with a real state of the hardware.
> +	 */
> +	regmap_read(regmap, BCOVE_SCHGRIRQ1, &status);
> +	data->status = status;
> +
>  	mrfld_extcon_clear(data, BCOVE_MIRQLVL1, BCOVE_LVL1_CHGR);
>  	mrfld_extcon_clear(data, BCOVE_MCHGRIRQ1, BCOVE_CHGRIRQ_ALL);
>  
> 

Looks good. But need to change the patch title as following:
I can change the patch title before merge. But, this fixes patch
should be applied to both extcon tree and stable tree.
So that the author better to change the patch title to keep
the consistent patch title naming as following:

If possible, need to specify what to fix on title for the readability.
IMO, this patch title doesn't seems the fix patch.

- before : extcon-intel-mrfld: initialize mrfld_extcon status
- after : extcon: intel-mrfld: Initialize mrfld_extcon status

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
