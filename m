Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4391369882
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 19:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243364AbhDWRe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 13:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243123AbhDWRe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 13:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619199259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ktUbwIWTJ14trqUM1JPFPbDz0iRRWU7hILTLbA82a8=;
        b=GgfTu/lEqR9G9wmTQ2YZajxZTcDQ79V6d4/AEzrT4Ux76DcZ8L5VZAv6XxcpECnZZeZavo
        lm6Zq4EFQLNAE2XMk3EFzhz0GnBmzZsoTO5UzHqjK1uFTF2fhoxjhT047mAKuYULE9f4Ed
        0iqWHB8zipAp87wap8U4G8uATyGFQ0M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-FLhU6C76OfmnePVU158Brg-1; Fri, 23 Apr 2021 13:34:17 -0400
X-MC-Unique: FLhU6C76OfmnePVU158Brg-1
Received: by mail-wr1-f71.google.com with SMTP id 88-20020adf95610000b029010758d8d7e2so3728364wrs.19
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 10:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2ktUbwIWTJ14trqUM1JPFPbDz0iRRWU7hILTLbA82a8=;
        b=n6vTWHtoN+KrOG538SxufNTnY9cJvCCt3usx2/BDKIvdyKm/T/cfM5P/U4p6bVytL0
         dm5OT+JY828HIg66dwHV6q9kdpJj8VQen/Nt8+b8MUi+Eeh6u4bif0B7zeM8mAwRqblp
         oyWGjax1/SHzoaY5SvK0z+SsaQID2gt/jNOUUETKdazsLlNZOEIsfGCwFhx9D3f4vZcV
         2Cimu4wWIS8GgBKmKqcv47wX8whWnMsVuATcadHqN40eDBZHh/Z4CPmv1x1qJohS/O4T
         yh+VkHtJ4bRuhknFFLWp0dCChMdt+tw77nwV1Jey+tbBXz3vE8kls2HhFVgZit7Umtg3
         Pbng==
X-Gm-Message-State: AOAM530bvidxLm82V0htWCfUnTUj6r2zoVxMJK1s6WBIPuUkRvupTvG9
        ewXwfqTof1tdlz/FmuCGvtEQh+yxRRSuLxpDAr7GUot3w6m7Lfc6w4M6S1zavKLLf1rfnhNyWSI
        +Fl9DgXHe4aqkse6Lj+V3ea3x
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr6555916wml.113.1619199256170;
        Fri, 23 Apr 2021 10:34:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh+EjNZzglFda5j+WRJWaTK/VWXhlD03BlaQaBpPs6h5L2iYZBz1lgQWscsMuEMh4laCiLXg==
X-Received: by 2002:a7b:c8ce:: with SMTP id f14mr6555895wml.113.1619199256037;
        Fri, 23 Apr 2021 10:34:16 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3108:4700:8d94:f633:2343:f95c? ([2a0c:5a80:3108:4700:8d94:f633:2343:f95c])
        by smtp.gmail.com with ESMTPSA id o17sm7767902wmq.47.2021.04.23.10.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 10:34:15 -0700 (PDT)
Message-ID: <84cafe48637fd1deed7da2cd15eb2f7679545416.camel@redhat.com>
Subject: Re: [PATCH] spi: bcm2835: Fix buffer overflow with CS able to go
 beyond limit.
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mark Brown <broonie@kernel.org>,
        Joe Burmeister <joe.burmeister@devtank.co.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 23 Apr 2021 19:34:14 +0200
In-Reply-To: <20210423162055.GE5507@sirena.org.uk>
References: <20210420083402.6950-1-joe.burmeister@devtank.co.uk>
         <c087ba2c-7839-02d1-a522-b104d8ffb8d2@gmail.com>
         <7c9f9376-1a80-b624-7b9e-0f6d04437c02@devtank.co.uk>
         <271ad212-a606-620e-3f0c-d6bff272be3c@gmail.com>
         <380624c4-82f3-0e6e-8cdb-8a9732636db8@devtank.co.uk>
         <20210423115724.GB5507@sirena.org.uk>
         <672e8d77-ee5c-f10f-0bd3-f8708dfc24c8@devtank.co.uk>
         <20210423162055.GE5507@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-04-23 at 17:20 +0100, Mark Brown wrote:
> On Fri, Apr 23, 2021 at 03:12:11PM +0100, Joe Burmeister wrote:
> > Of course we could just raise BCM2835_SPI_NUM_CS to 8 or more if that is
> > preferred. Does seams like the dynamic solution is less favoured.
> 
> The best thing would be to have it not have a single array of chip
> select specific data and instead store everything in the controller_data
> that's there per-device.

+1

All in all, it would make for a cleaner driver.

-- 
Nicolás Sáenz

