Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872333A892E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFOTHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOTHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:07:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654E7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 12:05:13 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h12so196110pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bedgGZfvHTDG3utqka5ZC/z/HrI2g7jOruJT77//JN4=;
        b=KGNhS2wRptJPNS3Sx2q5hBAcAv0CPqiiJ6J5Bw69bIfK4C0hwP8h9atByP2SirnvvU
         gfdLjLt2ESmDYtkrkTP2rALRPhsjy+5iVG0x6NoYX6xvUiV6UZ6fj6I6FnTqkcV7/JOt
         OHTduTztQOKd2TPZHLTJT11mg/nVZdJ2iti7JsJey/cyTPBDxHTrmo4MS6bun7hkVpHH
         khDkXT4B9dTL/CJjUkiLF0VvWej712DS3tTM5Ygt8C+uoZ8JHju5IyO8f++8qyTqxH/+
         2EJf9PMLMReZ1OejYnQvcqDyew+mYBbO/USajmPsrGemzluGtyKyZ1eRUSwr9DWnRfzO
         iHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bedgGZfvHTDG3utqka5ZC/z/HrI2g7jOruJT77//JN4=;
        b=mkOG/Cg1P7SProwHYuf8cSU9FMsqBXeByBDPWbciRWcDQ3zvO9+9QNFmbQC1hVYTEE
         YmgAJgVB8/zErqzIlpjj3s6wwsPc1VuMpoyU7SsGMm3XGLKN+ynok2jeg9s2+dDJJRel
         IrgTAhY9WNgMZS+w8xI1dHAiXuvN0ovDxrQfwOMMu9vnC6Bz7Z2ODiOH5y6SVoSOZ7TM
         KFIM0yXt9d39FrouLq0vGoExkLTNTiHK0lozl9mT3PIiAxK8WSn4CrAZNZRePR7VXejQ
         0E8DZbcbD/DRlssYKEu0/bwKVeBemuXjkW6OAt6XBvHSZFKEPWUMqScYLJnBJUD3FT5R
         oBxQ==
X-Gm-Message-State: AOAM533tuysgc+PryycGYSng/TicqZ+3BhjdhBPlrxqCwhUzQGMWep7n
        1yeeOCVLYbvrcFzhK2fHb2A=
X-Google-Smtp-Source: ABdhPJw+kc1wTNNf1KoBk7ErUKM1wCKsgTlMM/yOOKbvzqGiE1ia/ImVwyXo4iPcUxKiP6iLflMfxg==
X-Received: by 2002:a05:6a00:1a88:b029:2ea:548:5ed4 with SMTP id e8-20020a056a001a88b02902ea05485ed4mr4345549pfv.47.1623783912769;
        Tue, 15 Jun 2021 12:05:12 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id d12sm15829068pfo.113.2021.06.15.12.05.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 12:05:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 3/6] iommu: Improve iommu_iotlb_gather helpers
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <07969028-d807-cad1-2a01-8efc87390157@arm.com>
Date:   Tue, 15 Jun 2021 12:05:11 -0700
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <25B4DBA5-72A3-4122-8678-AF3500F5023E@gmail.com>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-4-namit@vmware.com>
 <07969028-d807-cad1-2a01-8efc87390157@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 15, 2021, at 3:42 AM, Robin Murphy <robin.murphy@arm.com> =
wrote:
>=20
> On 2021-06-07 19:25, Nadav Amit wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>> The Mediatek driver is not the only one which might want a basic
>> address-based gathering behaviour, so although it's arguably simple
>> enough to open-code, let's factor it out for the sake of cleanliness.
>> Let's also take this opportunity to document the intent of these
>> helpers for clarity.
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jiajun Cao <caojiajun@vmware.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>=20
> Nit: missing your signoff.
>=20
>> ---
>> Changes from Robin's version:
>> * Added iommu_iotlb_gather_add_range() stub !CONFIG_IOMMU_API
>=20
> Out of curiosity, is there any config in which a stub is actually =
needed? Unlike iommu_iotlb_gather_init(), I would have thought that =
these helpers should only ever be called by driver code which already =
depends on IOMMU_API.

Indeed, this was only done as a defensive step.

I will remove it. I see no reason for it. Sorry for ruining your patch.

