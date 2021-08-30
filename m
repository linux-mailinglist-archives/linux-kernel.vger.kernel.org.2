Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0944A3FBAAB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbhH3RK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237888AbhH3RKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630343367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/p1OSWm2CX6t/EcjGNpZmpBR9OMpxp/jIg4r2klJBs=;
        b=OmNE37gPnl3l+x6buPivFEmeltpOgrZ/8IaS3CumcRnInN72HOamwcUc0i2LDeFncrMTWM
        2PiFzCYr2MAXz77Dj/8lCv0bIfNevZL7j78w5i7d1ZwzNBtNqsCIt4CMCKGWLrvki5vYFD
        i9ttlRN/gnKW9tPL6hTaAefBRuWdihc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-XF-Qu1pAOsOTPV0wwrJWOg-1; Mon, 30 Aug 2021 13:09:26 -0400
X-MC-Unique: XF-Qu1pAOsOTPV0wwrJWOg-1
Received: by mail-qk1-f198.google.com with SMTP id 70-20020a370b49000000b003d2f5f0dcc6so19510qkl.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=C/p1OSWm2CX6t/EcjGNpZmpBR9OMpxp/jIg4r2klJBs=;
        b=PqSZI1gpTPkfu8vjZWEt4mTLBl1z3HCYizKeqiqxuSBLJ5nRgcyeE86AWzYF/aXbJt
         QcggkbGMg4rzGhPy4l4skefXo19MzKGlxbJpkgdS8UkYc9pvxmaGsXfurAlTw+qxNbpq
         zBOyHC7wyi1W4MrJOLl1uM55EnmE4a8qxcjGTaD0tKFp7IszG6eQamy7MJDfuDO43x3C
         iEA+FHt5hFyaL8x3dVJsuXdGDG+VC6AooI9ieSACxOqlruX1taZ2FrO39ItTICqbqVGt
         eFz+UMN9QaNOnCZILblFgGlKLM1B9iaLrbyXitqy1abOyKluGmw8OcynAf+UXxhVFXsA
         x27g==
X-Gm-Message-State: AOAM530HfYNttmobD+ihlrj4uvnWTbp+n/NfWOrXI2akrKknA6BI7YZi
        rqeM5yVKFW7FwY7TajxSyfM7UCpEafIHP8P+12AVseSGbWipwx5u5C8lmj9GOVAXvPqIGv91VpF
        1qEHB9Le761F/u/jhNYfaGmja
X-Received: by 2002:a37:8f04:: with SMTP id r4mr23370425qkd.351.1630343366113;
        Mon, 30 Aug 2021 10:09:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhvH3r1WkYkyhjkLLonaz0tUVij62Is1SewKkxp8wDoeh+XEGYZJb1rr+7K3QO3YKZJeC6uQ==
X-Received: by 2002:a37:8f04:: with SMTP id r4mr23370410qkd.351.1630343365881;
        Mon, 30 Aug 2021 10:09:25 -0700 (PDT)
Received: from [192.168.8.104] (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id m68sm12047562qkb.105.2021.08.30.10.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 10:09:25 -0700 (PDT)
Message-ID: <0777c34ddbd22ae247d293cf013cb763947b0b50.camel@redhat.com>
Subject: Re: [PATCH AUTOSEL 5.13 20/26] drm/nouveau: recognise GA107
From:   Lyude Paul <lyude@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Mon, 30 Aug 2021 13:09:24 -0400
In-Reply-To: <c0e64fb9332b03c920de05be4c4c27f916ff6534.camel@redhat.com>
References: <20210824005356.630888-1-sashal@kernel.org>
         <20210824005356.630888-20-sashal@kernel.org>
         <6607dde4207eb7ad1666b131c86f60a57a2a193c.camel@redhat.com>
         <YSzMR4FnrnT5gjbe@sashalap>
         <c0e64fb9332b03c920de05be4c4c27f916ff6534.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oops-except for "drm/nouveau: block a bunch of classes from userspace" of
course. the rest are fine though

On Mon, 2021-08-30 at 13:08 -0400, Lyude Paul wrote:
> ahhh-ok, that makes these patchs make a bit more sense then. If Ben doesn't
> have any objections I'd say these are fine to backport then
> 
> On Mon, 2021-08-30 at 08:17 -0400, Sasha Levin wrote:
> > On Tue, Aug 24, 2021 at 01:08:28PM -0400, Lyude Paul wrote:
> > > This is more hardware enablement, I'm not sure this should be going into
> > > stable either. Ben?
> > 
> > We take this sort of hardware enablement patches (where the platform
> > code is already there, and we just add quirks/ids/etc.
> > 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

