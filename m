Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0C39BE26
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhFDRMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhFDRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:12:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE6EC061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 10:10:43 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x73so7914679pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6UWs4F/LiNKwGVZ1bzmUFbFeuYWDKRTT9nUEK353f64=;
        b=X8aW3XwzqxJ3VlB5j4+rIqIOqPzkjRCkdnbxjki+d+a5Cq0x9jxF1gUJsBQLUE0gEy
         2cfWOEMhcPK5xpu1iDuAUj1OftbYmKAjKv0OwQ1EcwCl3eyg/QhbpsVPdcl3mljdS3qC
         vemheUs8g88K40H8D1gZFIxoW3dXLaor0Lfctiv/50YltLgL7nH1+ns/VPHvQUtdsM1I
         ns6OQI3Csf1STnkSU4E5L+XUJtiTTCh6ZpTsORPGNxWFVwrnhdMfHqCMHRMEDo3nEF3a
         CIIYIZ1wjpombqkNe8z0ZYcVxNyBLqkyfkqo/kz2CX0bTLFByPL49RijZ2Ls9T7jbwqk
         uTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6UWs4F/LiNKwGVZ1bzmUFbFeuYWDKRTT9nUEK353f64=;
        b=dWc5oK3erFjtAzwKchjFQR6Rj39XU2A6clBnWQBcsazI192Aka1JqLmKoDkhXSwCiX
         68dBhvFeytK0MzUIaBbPwazdU/s3m7TkW3+fB6rg8Dlk5lNaEo0Tho8huQnrsqJ3Cx6v
         gOfbm/w0M0S8iEgXUCkYpE2XeI7wlD1qfcqb3NGFtztadeOy4B/kqxge5fnDtlJPtXZ5
         KsofAW9oSngYqSLRJAkQNKmh/XmCd8AJdGnfggg0CKlAcKAo8NtH0rmfhJn3jTIrKsAJ
         U8J8i4vTQIHDlyBAmvNE35uPcQfp4HFCOcou7ZxIJ/RBRYAnJn1B7ZbtCh0BDYLNyeGh
         51lw==
X-Gm-Message-State: AOAM533h+nUY+4PGWUXvC90rqgy9hgDTh2ap8QUuqRuzZb2qRxBp6IT/
        tvNqhF6BPA749quOzhoT8a0=
X-Google-Smtp-Source: ABdhPJwFk/+y0P5mH5oIK9Y8IdN1mPk5DlvowjHPiKeaobmrXB50aIxPGmTdHbHwskDpwsH/DIWAXA==
X-Received: by 2002:a65:6644:: with SMTP id z4mr6048915pgv.101.1622826642633;
        Fri, 04 Jun 2021 10:10:42 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id j7sm800001pjf.0.2021.06.04.10.10.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jun 2021 10:10:42 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2 0/4] iommu/amd: Enable page-selective flushes
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YLpI7tKtsf4l5MlN@8bytes.org>
Date:   Fri, 4 Jun 2021 10:10:40 -0700
Cc:     Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <05098022-1ED6-44BE-931D-D16C2D0B2D09@gmail.com>
References: <20210524224159.32807-1-namit@vmware.com>
 <YLpI7tKtsf4l5MlN@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 4, 2021, at 8:38 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> Hi Nadav,
>=20
> [Adding Robin]
>=20
> On Mon, May 24, 2021 at 03:41:55PM -0700, Nadav Amit wrote:
>> Nadav Amit (4):
>>  iommu/amd: Fix wrong parentheses on page-specific invalidations
>=20
> This patch is already upstream in v5.13-rc4. Please rebase to that
> version.

I guess it would be rc5 by the time I send it.

>=20
>>  iommu/amd: Selective flush on unmap
>>  iommu/amd: Do not sync on page size changes
>>  iommu/amd: Do not use flush-queue when NpCache is on
>=20
> And I think there have been objections from Robin Murphy on Patch 3,
> have those been worked out?

I am still waiting for Robin=E2=80=99s feedback on my proposed changes. =
If he does not respond soon, I will drop this patch for now.

Thanks,
Nadav=
