Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1028B3D8BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 12:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhG1KfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 06:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhG1KfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 06:35:16 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB24C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 03:35:15 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 506D13FC25;
        Wed, 28 Jul 2021 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1627468513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NxU06HLhrl9+rLyaZWdBMl0a7U1akRA+tjgjOr6pMYU=;
        b=LIT9It63QvpF3ZFNFDrvNEFGugyOiUgFtR6AvRUGkvR3zsWvUmhuvWsn0kr6EaaKe5iD8m
        zRmGZD17fkL/vKmYQKW+5LPpi5yY4bc0ni3NuK0HPfYULxPZlVzmvwOmG44gwyBhFswbW9
        n5FKE5/VryVSVQSKxjhUpFhfk5T7Eu8=
Received: from frank-s9 (fttx-pool-217.61.145.245.bambit.de [217.61.145.245])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 98E7C1007DD;
        Wed, 28 Jul 2021 10:35:12 +0000 (UTC)
Date:   Wed, 28 Jul 2021 12:35:07 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <YO/hpPpu6Z526+Ia@8bytes.org>
References: <20210715071150.82157-1-linux@fw-web.de> <YO/hpPpu6Z526+Ia@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iommu: check if group is NULL before remove device
To:     Joerg Roedel <joro@8bytes.org>
CC:     iommu@lists.linux-foundation.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com
From:   Frank Wunderlich <linux@fw-web.de>
Message-ID: <F2ABC95E-D39F-4713-8959-91366DE4ECB8@fw-web.de>
X-Mail-ID: c5da2f25-14af-4163-bd01-1aee1eb1c340
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Sorry for late reply, somehow i marked message as read without answering i=
t=2E

Am 15=2E Juli 2021 09:20:04 MESZ schrieb Joerg Roedel <joro@8bytes=2Eorg>:
>On Thu, Jul 15, 2021 at 09:11:50AM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> if probe is failing, iommu_group may be not initialized,
>
>Sentences start with capital letters=2E
>
>IOMMU patch subjects too, after the 'iommu:' prefix=2E

Will fix these in v2

>> so freeing it will result in NULL pointer access
>
>Please describe in more detail how this NULL-ptr dereference is
>triggered=2E

I had this by testing this series:=20
https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/list/?series=3D515=
129

Initialization in mtk driver was failed (i guess the iommu group was not y=
et created), cleanup was started and so this function is called with a NULL=
 group pointer=2E I can try to find my debug-trace if you need a kind of ba=
cktrace=2E

regards Frank
