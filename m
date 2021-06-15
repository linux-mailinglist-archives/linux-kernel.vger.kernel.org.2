Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E193A893F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhFOTKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhFOTKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:10:08 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE94C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 12:08:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id k6so156237pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ae2/0o2p9fobjBqxoALkWF9ywdZR2o4+z7dG1T9hhvE=;
        b=moY+w+3zlJRsSka3cuNrk2elDxNyX22Y35XGmV3sRiUREDA6f+mUH5aAMNsLGxeBXK
         cyWH9PFKzteJ+Jaa4tfHvtwKk9LwZR2mCKQflJtVinv54C55HPdUYiaRE0/an29biLPY
         pSqOoLvNqmzsbrdrl4WBEmVM4jgTzvr2GPLhWb3D1vPm244t267/9iqSVzIdGthF9vw7
         ljBcEkhs9E/L1/rHlZGe30WNqszF91HgJg9hZVFyeJXZVs00FS95FhJRkXwxPb3GSNej
         mdVVeuAfiA4DqpLsx1YOn/+OuxbgvIvGnXeTaegW6oaC/uJhOiA4korg2mf/ZLB0yvVS
         E0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ae2/0o2p9fobjBqxoALkWF9ywdZR2o4+z7dG1T9hhvE=;
        b=iGer+RScYKFTPmBPN6yQeZRDTWq1eu0vE7gCmi5QLGG9dCIhRZQFCleYRDRspnTxP3
         tpwPoeacsLQJsDr3hC7I11764eTYUsWmLAlytvtwGARHdOYGUa0sCS7tpuNiaUJVH94H
         BcuE6HBPDIoaLz4lLUrQR2rCPninj07413F4R0AbX0WxuehSKOlKyOE86WKl8o2m3cDN
         RYYyIagfMz+/sOvyUeArrsPSGCPTA3qlg9wdjfX8/io2js070VMvlmMqtkh6R6tXJ/6F
         UTW5y2i03h42AA6NVglEmT+zfX6Tzbed7wI2TqNYC8wf/grNjUlSvhac6LbApNO817r2
         Djcg==
X-Gm-Message-State: AOAM533KsEBPBGEG1JDUWbql0VJWAY3nHxJKLEftuBUj51BwH9wzEhv1
        apcWHRGd7i1eb1ezPZRfEFc=
X-Google-Smtp-Source: ABdhPJw1d3tMIQI/wuINu5AHxD+9mToBQ4BW24+YNRZuTnOA+mnPEjVM9l0q6fLHB8lV4asimjsgOw==
X-Received: by 2002:a63:4c09:: with SMTP id z9mr957538pga.283.1623784082619;
        Tue, 15 Jun 2021 12:08:02 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id a11sm15589026pjq.45.2021.06.15.12.08.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 12:08:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 3/6] iommu: Improve iommu_iotlb_gather helpers
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <25B4DBA5-72A3-4122-8678-AF3500F5023E@gmail.com>
Date:   Tue, 15 Jun 2021 12:07:58 -0700
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7A15BB6B-B115-4167-A6AF-E96D71FE9E9E@gmail.com>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-4-namit@vmware.com>
 <07969028-d807-cad1-2a01-8efc87390157@arm.com>
 <25B4DBA5-72A3-4122-8678-AF3500F5023E@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 15, 2021, at 12:05 PM, Nadav Amit <nadav.amit@gmail.com> wrote:
>=20
>=20
>=20
>> On Jun 15, 2021, at 3:42 AM, Robin Murphy <robin.murphy@arm.com> =
wrote:
>>=20
>> On 2021-06-07 19:25, Nadav Amit wrote:
>>> From: Robin Murphy <robin.murphy@arm.com>
>>> The Mediatek driver is not the only one which might want a basic
>>> address-based gathering behaviour, so although it's arguably simple
>>> enough to open-code, let's factor it out for the sake of =
cleanliness.
>>> Let's also take this opportunity to document the intent of these
>>> helpers for clarity.
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Jiajun Cao <caojiajun@vmware.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>> Cc: iommu@lists.linux-foundation.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>=20
>> Nit: missing your signoff.
>>=20
>>> ---
>>> Changes from Robin's version:
>>> * Added iommu_iotlb_gather_add_range() stub !CONFIG_IOMMU_API
>>=20
>> Out of curiosity, is there any config in which a stub is actually =
needed? Unlike iommu_iotlb_gather_init(), I would have thought that =
these helpers should only ever be called by driver code which already =
depends on IOMMU_API.
>=20
> Indeed, this was only done as a defensive step.
>=20
> I will remove it. I see no reason for it. Sorry for ruining your =
patch.

And remove the stub for iommu_iotlb_gather_is_disjoint() as well.=
