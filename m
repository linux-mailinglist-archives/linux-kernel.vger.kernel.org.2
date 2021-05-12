Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA9537B9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhELJ6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230253AbhELJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620813427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6e6lrv4EFX1ClsmLlH8VajL1NpbF1vS30ceHQh0Res8=;
        b=PS3+okN29goPepJMgLmOraAOIqCKf2mJMFxpEw+STJw/tcb889GbiUOmvm3n8jc6IZXV31
        CVhllrB2Hsy/3zC5v+EAH2mfY5iSnHGy/xoUwXJOXEurlZQS8xuhC1M1jWTjBx3LgKRI9T
        wfRH+NeiN2oCN5vN5IWQrqsPIPoigJA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-kauP21D6MgitOG0WT0B6lQ-1; Wed, 12 May 2021 05:57:05 -0400
X-MC-Unique: kauP21D6MgitOG0WT0B6lQ-1
Received: by mail-ed1-f70.google.com with SMTP id d18-20020aa7d6920000b0290388b4c7ee24so12630942edr.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6e6lrv4EFX1ClsmLlH8VajL1NpbF1vS30ceHQh0Res8=;
        b=JoWM+0ZFJGptjlTKvqvZgpdlhsSyUDsIJwGswRT+KPVl1CPMFXMilE/H14ifsWHxNq
         qVC7GmN/ia1je7w2F41ajMvULQF6K+PpbOyx7Q+VqC6GbjIvreHCqe7ytoroZYVlSz8U
         Z4E+396duV6dbSqC+Xy5rtnAQK0nQQ3UKDObwnQ2TeE09NoleR347jEYeVubWUy21OQj
         fNKQm3FhksZVyX1s/amqm3gLqBozJ6TSV8S7yv0w7vM6OMQ/V80iIhhQwcZRcSGjoWX6
         /OVknXLBEpVqA+p8PSaOLBArpsKOqZA5opz8r+ErEdZqDUu3tBY2prCpYrz0GUtxh3gW
         WSww==
X-Gm-Message-State: AOAM530JdrPTo2kwQX94pRDozS2YU0aPklwD5PH/H3ODTNzF5OWt4Kxs
        ntAQe+EUbcTnlAXAYGSB2pwxh2+qe5q+mmfI0FTUfKTKn+S6fJgh/T2rkqMphebzxQgYwAbc0Yj
        se5GdU+nJa3ZWBmL7tHS0OkKJ
X-Received: by 2002:a17:907:161e:: with SMTP id hb30mr35921526ejc.360.1620813423462;
        Wed, 12 May 2021 02:57:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrxmcJPsjqx53dOgzOCXnxighYSre3movdMRw3u56m86siQvmLGKutpPfmJTuLtQSBjvqMiA==
X-Received: by 2002:a17:907:161e:: with SMTP id hb30mr35921512ejc.360.1620813423329;
        Wed, 12 May 2021 02:57:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id j22sm14488928ejt.11.2021.05.12.02.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 02:57:02 -0700 (PDT)
To:     intel-gfx@lists.freedesktop.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
From:   Hans de Goede <hdegoede@redhat.com>
Subject: 5.13 i915/PAT regression on Brasswell, adding nopat to the kernel
 commandline worksaround this
Message-ID: <b6b61cf0-5874-f4c0-1fcc-4b3848451c31@redhat.com>
Date:   Wed, 12 May 2021 11:57:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm not sure if this is a i915 bug, or caused by changes elsewhere in the kernel,
so I thought it would be best to just send out an email and then see from there.

With 5.13-rc1 gdm fails to show and dmesg contains:

[   38.504613] x86/PAT: Xwayland:683 map pfn RAM range req write-combining for [mem 0x23883000-0x23883fff], got write-back
<repeated lots of times for different ranges>
[   39.484766] x86/PAT: gnome-shell:632 map pfn RAM range req write-combining for [mem 0x1c6a3000-0x1c6a3fff], got write-back
<repeated lots of times for different ranges>
[   54.314858] Asynchronous wait on fence 0000:00:02.0:gnome-shell[632]:a timed out (hint:intel_cursor_plane_create [i915])
[   58.339769] i915 0000:00:02.0: [drm] GPU HANG: ecode 8:1:86dfdffb, in gnome-shell [632]
[   58.341161] i915 0000:00:02.0: [drm] Resetting rcs0 for stopped heartbeat on rcs0
[   58.341267] i915 0000:00:02.0: [drm] gnome-shell[632] context reset due to GPU hang

Because of the PAT errors I tried adding "nopat" to the kernel commandline
and I'm happy to report that that works around this.

Any hints on how to debug this further (without doing a full git bisect) would be
appreciated.

Regards,

Hans

