Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB4A39B8F8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 14:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFDM0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 08:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230039AbhFDM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622809505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=T1WL3P0Jah1FRVj8EdxTUun4/hVMeybsNLS0++AfbT0=;
        b=D3VABfUUepIQpkGzBNNtoCxgF9w6jX5wGmxab+XTFwco2KchhvHzsahZF8QO3ftCaLI210
        QBdEkDLsga3+h++dWYiUsvkkKjCeZtgvrQyZU2gcHcN3pF7UzNLkxs28FIpi3L/CoUFvrx
        Dtk65n0cEte+dTj7rDwAMH+tWzoebJQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-5y0vgUK4MBuKE3KqTXzXzw-1; Fri, 04 Jun 2021 08:25:04 -0400
X-MC-Unique: 5y0vgUK4MBuKE3KqTXzXzw-1
Received: by mail-ed1-f71.google.com with SMTP id s18-20020a0564020372b029038febc2d475so4906187edw.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 05:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
        bh=T1WL3P0Jah1FRVj8EdxTUun4/hVMeybsNLS0++AfbT0=;
        b=fEVXNJdkhUDgM20URNsHvz0iJbXWVKMXWY4hBR74BPmya7rBJSYIKErcemrOqctqOd
         6g7HtbDy3stTFySTRpcAagmbh3ObTW5PEKRntXv12m8Axpt1XCRbIsB4JLtEPd2n2P7S
         jL5KDA/v0DNrgMltC5/09zqlu91xqQFkjid1urkFNKKpZxJiRT/QQGrj7gg/Csx/PBZM
         KaaVYlowNwkQT5m9Uo9RKHO+WWDVG+pkulJNS8wOnHTzndmbRbY5LCT3m/VS7rquZB8t
         sCViYerEpABia9J7VebJthI5zQVPdqz2zjTaXpnQQgfqvuPFD2FWiQYWsw2VoxsdtUJy
         3Etw==
X-Gm-Message-State: AOAM5333r5sWzRBZatwrDYfxc4W2+4qpwXgY5O/6/ci9Ug14mo48x+ax
        RuMhxmDsNRx6Mh1WYvVyliManqGV/6t73NjCpwj0s/zrS6QOswJtzA4sEINMvQNoMyumhvGoZfz
        TjntKRsDVynDQshDJBzl0EV2j
X-Received: by 2002:a17:906:a294:: with SMTP id i20mr3970586ejz.330.1622809503414;
        Fri, 04 Jun 2021 05:25:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfBZrM0jIbqGlvYiCojcZlu9rkqXCZiG0w6fufb5vpo1LYyrvNtiveJmLUv90tBUtvyXi0ew==
X-Received: by 2002:a17:906:a294:: with SMTP id i20mr3970577ejz.330.1622809503266;
        Fri, 04 Jun 2021 05:25:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id e22sm3207492edv.57.2021.06.04.05.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 05:25:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Matthew Wilcox (Oracle) <willy@infradead.org>,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>, wei.liu@kernel.org,
        Dexuan Cui <decui@microsoft.com>
Subject: [bug report] Commit ccf953d8f3d6 ("fb_defio: Remove custom
 address_space_operations") breaks Hyper-V FB driver
Date:   Fri, 04 Jun 2021 14:25:01 +0200
Message-ID: <87v96tzujm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Commit ccf953d8f3d6 ("fb_defio: Remove custom address_space_operations")
seems to be breaking Hyper-V framebuffer
(drivers/video/fbdev/hyperv_fb.c) driver for me: Hyper-V guest boots
well and plymouth even works but when I try starting Gnome, virtual
screen just goes black. Reverting the above mentioned commit on top of
5.13-rc4 saves the day. The behavior is 100% reproducible. I'm using
Gen2 guest runing on Hyper-V 2019. It was also reported that Gen1 guests
are equally broken.

Is this something known?

-- 
Vitaly

