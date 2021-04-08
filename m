Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8401A357BC3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhDHFVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhDHFV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:21:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2374C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 22:21:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u17so868941ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 22:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGWRQqNs4FsH45AetKkDEjtm5WFfnPk7zZ0gqFXvhh8=;
        b=Uw0wyDlDkX20XvZ04T5dHZqo5VGShg0gXBPk8VWktFBqbuh8MEOldhu336XT0Jj8qe
         erW3R8ZVjiVRhajwAiA8SXe+QHfkmsEskKtMV5Ic9ct0qKcfMb0IeGPhFJYoA9qG4PNE
         sFn+c5OONjJuFXY4MEBgDV47slIgQAmqs+Zm/rOlq9/jl4eVtNaCBs5pdB44UiyFa/ur
         48mdaV9f84mfoqmEh37U7uo9aLuBzCzGcoDWMs1H2rYV7dVFf9A7lD4Y1vMrSAc4fzfR
         SOdpisPlDqANC9kxZPy69cDbpdlDm6FPgMVva5v2Rv4QpKGq8YzBBKotytK4HauPnjDf
         bKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGWRQqNs4FsH45AetKkDEjtm5WFfnPk7zZ0gqFXvhh8=;
        b=X+9e4QkKm0OuPluaWYiWl3Ocbk0L0PiMRUBGqJRhMWCdMtENtnplinXy8LnK0wZq9A
         zmnAngF0DJ9JedDVhVieDhsgu2CmpJDwnMVXyWsKSi6tTiw8q1kHDjUArbOzA5/zGlQj
         tPPpqZ2/L1cCUOaAfksHMTQ+OAsYiGWgM8HqKhwZvEgEjLmHTyMR/oAp51mzI7NRdj+m
         tt2GzVbpid1kn4dd357OTViIArze+BODhD/P5MIeThHGcE2Vjhi78QxAKYLIaPdeV546
         DXD4pXOrYdGB9WN/mJMIWVvQ8hH/iJzDgtjt5PxrrEAXVkVTfbSmgbBBWwDwjVLeh2vC
         tk2A==
X-Gm-Message-State: AOAM533i2waiq7oOioNFqy3ayAQMc5jRjKuuNlpmDQzKmia1EUDljOzm
        +yNhlOAX08NdGBqQGG9mvga8ERaXdZmNRXF6dqR20w==
X-Google-Smtp-Source: ABdhPJwuJvePArsi0X3BVbiNySrXNJpCSX0975uBH+S9j2G7lCMCRLzU27dIjhNhw3Kxzuk9GAjVnHp7xGCcEBJ+Kfo=
X-Received: by 2002:a17:906:8242:: with SMTP id f2mr7851357ejx.478.1617859277448;
 Wed, 07 Apr 2021 22:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210407135840.494747-1-colin.king@canonical.com> <yq1blaq9fyx.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1blaq9fyx.fsf@ca-mkp.ca.oracle.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 8 Apr 2021 07:21:06 +0200
Message-ID: <CAMGffEmFxJduY71sGzXNMoQzq0PZT1dtELfviZf9CZdkRj=nNQ@mail.gmail.com>
Subject: Re: [PATCH][next] scsi: pm80xx: Fix potential infinite loop
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Viswas G <Viswas.G@microchip.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 7:18 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Hi Colin!
>
> > The for-loop iterates with a u8 loop counter i and compares this with
> > the loop upper limit of pm8001_ha->max_q_num which is a u32 type.
> > There is a potential infinite loop if pm8001_ha->max_q_num is larger
> > than the u8 loop counter. Fix this by making the loop counter the same
> > type as pm8001_ha->max_q_num.
>
> No particular objections to the patch for future-proofing. However, as
> far as I can tell max_q_num is capped at 64 (PM8001_MAX_MSIX_VEC).
Exactly.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
