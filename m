Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241123C258C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 16:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhGIOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 10:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231857AbhGIOJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 10:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625839589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uLtl/5oDqf8PcrF9UEzAhu9HDJICTavDVle2PbyDR/4=;
        b=Mdc9VT2vEx1NIxuXYr33L1gDYymRixBs5CunJWmy8Dk6KlGYET0ls3c5t5N9Phh5AER0Va
        ch1UU1FYMLZ6zWT9zteFC3HKbK5bqFMzzCrkoWeBo7DWUaqYoWzCnjwZ1PKoEbBVeJ2F5Z
        8u523+wkAyYgtqxEbkNjw9xqHj7iDJA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-nb3E8i1eNgedJPEVt0RucQ-1; Fri, 09 Jul 2021 10:06:26 -0400
X-MC-Unique: nb3E8i1eNgedJPEVt0RucQ-1
Received: by mail-wm1-f69.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so4072551wmh.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 07:06:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uLtl/5oDqf8PcrF9UEzAhu9HDJICTavDVle2PbyDR/4=;
        b=tfaxAQRjiE656nM6Q1BS2ToTpNoRiJ2tU9Yl5JQun2BjWIj7eSKxcl3b8COdzu/2SV
         4GxfHOt/2mGbq/1ctpo3aA40vO7fJHlnikzvOTixy//0RV17dLd1pvwJrRccf7F70rtB
         hw1W/oHzFFIl5OU5BBkmXyPcuTc1BMaSSp6KHD1UXBGxD46DYQeRXQj0mAbuV2uDuYwh
         XGB8KCBTtWZ+jGNH9rdR2cGuFRfMh/0YVeWrO/c7g/gbVOhGEvpsmI9uBqc5xfB2UXsF
         rRQ2sV9JWYJCfkz5E6S3eVS6i8/fT7jbhrb0QqNSEq2LPkSbRAQzTfgWTiHQsmZimUpp
         qXgQ==
X-Gm-Message-State: AOAM533aJI8guDJ7CZZQLlpk6kFTGJ/9DIkQhpH3iX8Ux8jf7KDELgBM
        ruj1UjNcxj63DZEkK7/o6sf6FgOnFoP8bPbxPzreje+UiktdmBjh7OY5W4DE2f/G0Lbd7I6tJt+
        CuBtJfgxmw5KU4JRPV5YAp7tl
X-Received: by 2002:adf:eb43:: with SMTP id u3mr42287717wrn.83.1625839566973;
        Fri, 09 Jul 2021 07:06:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpWcE5dh0IytYK877PjYOYMVLad+vBaNwXr7nhI1jGzSpEVmKBe+hQ/WRrn5DS63kTML60BQ==
X-Received: by 2002:adf:eb43:: with SMTP id u3mr42287698wrn.83.1625839566857;
        Fri, 09 Jul 2021 07:06:06 -0700 (PDT)
Received: from [192.168.1.136] ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id z11sm5410723wru.65.2021.07.09.07.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:06:06 -0700 (PDT)
Message-ID: <f520c8b87f56fcda0158853c5127f0488918503e.camel@redhat.com>
Subject: Re: [PATCH v2] timers: Recalculate next timer interrupt only when
 necessary
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     He Zhe <zhe.he@windriver.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     anna-maria@linutronix.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Date:   Fri, 09 Jul 2021 16:06:05 +0200
In-Reply-To: <11e85cd8-40ac-09fe-e1fe-0eafa351072c@windriver.com>
References: <20200723151641.12236-1-frederic@kernel.org>
         <dfbf752e-91db-b128-76a8-98fde4c5d480@windriver.com>
         <20210708153620.GA6716@lothringen>
         <c7a5015a-2b93-17d2-29bc-cd03e40cc09c@windriver.com>
         <20210709084303.GA17239@lothringen>
         <11e85cd8-40ac-09fe-e1fe-0eafa351072c@windriver.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic, Zhe,

I've stumbled upon an issue on my x86_64 nohz_full setups which looks a lot
like Zhe's.

I've got a potential fix, I'll post it as a reply to this mail.

Regards,
Nicolas

