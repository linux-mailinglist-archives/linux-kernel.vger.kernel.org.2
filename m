Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C9C311F51
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 19:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhBFSSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 13:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhBFSSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 13:18:33 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB811C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 10:17:52 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e18so11260916lja.12
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C3kW/OiocyuN5yeAHAEJeasO9MZwA+lBdOwDSAKHBuc=;
        b=SE7/tuijX1BBe8zH/TW7teE8Ptqy7ye54UMQbg1MHpWv/aBf7Q/fFl3UFmEAwx/gtG
         oFCJndgqgYYyGR7pe0TfpxBHORxejgq3O7mIKBMSE57RHgi6jrZhtlE4NASYh1HtvHLy
         5l7iz82kZkRERsNQlKf1jdctFP3erN2/GtO5zkHfgGFtta9lnVy2Yw47j6OBfqqyGC1j
         obgXGSQ3PwDnxgg+NMNV3OGncp2Jdcu0tNgR3bXR7uR+uR7DzqmfJwfuH4LqaD2SyP23
         s3bcstrMKsry8QkalfOrV6ICOB3PSmGCmxQHNkGRSfbCVKaatwZGxr8o5Hiv/TIHC7+q
         Ln1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C3kW/OiocyuN5yeAHAEJeasO9MZwA+lBdOwDSAKHBuc=;
        b=jCwkkwe26kVbxGX+PrajQ/hHuqb2YlAuC1DHV1sARSZcIlyrH6jhaVhiq2bLIcymGa
         iExgYXerEYa0YzpcrJrnX60UtpZP2LHZB+Io2wZUEM59cIHcpk2wFY+e26L3WVOalzTC
         NbKnxQsE6+iXO2v59TvPbqSgjQ4nH21zm4TsdhWtNU10ewl/zFkSBfngWIEhvo0d4wqQ
         BiqWd1LYV3hGgUeOkOawfet1YE3g3JnPFG0Y8MsdZTW6W9B6pDyxadY7HvkJqPX6P5dr
         jWL4F+INVpcAKbeSQo5qLd0cvFSmABnESbUi2jLbOAaueASSNEfDNqLmE3AqTyk0wZOD
         tfWQ==
X-Gm-Message-State: AOAM5335wTfr4Ig4yMYxIn4r59ZryV5aJVnZr/0jcRRfUW6fkOuKG0UX
        0D+YivsSH+21cNSANskjcg4+YPtq+AlYQtCUV2Q=
X-Google-Smtp-Source: ABdhPJwllXfo1tC3xj9MM7zF5DWer57G6Byon2hOX+uVkyl1vsYZEr681ocSwQFwny/3uUsEmmuC0wYHTpqRqZBggCI=
X-Received: by 2002:a2e:b165:: with SMTP id a5mr1728142ljm.81.1612635471207;
 Sat, 06 Feb 2021 10:17:51 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNazWZQGfSnFgQ_K5_H9uBQ=8gBdFORXrU1FEMGMohO2w@mail.gmail.com>
 <4ce29a7e-f58a-aeb4-bef-34a7eada70d0@google.com> <e0c2c823-5f-efe8-cd87-6dd6cc33a33@google.com>
 <7a677c89-1974-0676-ba7d-b057ad2cab3f@gmail.com>
In-Reply-To: <7a677c89-1974-0676-ba7d-b057ad2cab3f@gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 6 Feb 2021 23:17:40 +0500
Message-ID: <CABXGCsPnGVAGWETYD-dfrqxhciHA0NKBG2EWueOtFzL5xF9z3g@mail.gmail.com>
Subject: Re: [bug] 5.11-rc5 brought page allocation failure issue [ttm][amdgpu]
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     David Rientjes <rientjes@google.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jan 2021 at 22:22, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
>
> Yeah, known issue. I already pushed Michel's fix to drm-misc-fixes.
> Should land in the next -rc by the weekend.
>
> Regards,
> Christian.

I checked this patch [1] for several days.
And I can confirm that the reported issue was gone.

[1] https://lore.kernel.org/lkml/20210128095346.2421-1-michel@daenzer.net/

--=20
Best Regards,
Mike Gavrilov.
