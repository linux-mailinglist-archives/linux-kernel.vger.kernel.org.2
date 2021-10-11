Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB48428A35
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 11:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbhJKJzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 05:55:02 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48784
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235522AbhJKJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 05:55:01 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5D5E93FFD9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 09:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633945981;
        bh=x+ebBDbVVXbydAVIXajg3Ac0CDuAQFka9vVAII+KcTQ=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=pab4lT/n9n/AWs3QXPRw9fVihJFQzRImHNmnTfhft6hS4SlrHRAzeVR8zDGrCdsVG
         wRszltynxpf33rWsAeuhq2dMX0vLmYjH36KsZ8z4hlN0Klg8dv35wV43Yhlk3Yep1l
         XyayoJnqQIOfzsfQ1rLDTbjm4JoCJAEl6UWDn6VxZr9oa+/POg6iRg1Otcxr1eaNPY
         9rUK3TGu06Eej1Ok2YLP/nsp/wyiBeYSEY32D92ZCBnj/Xsc5zgD7tMAoshX8vBqou
         rom6fX7nwGF+6Pu2RL+kG9wwkm5+FmY1QmLpxXZOSIGMLqe159Vd4/Hs+cvhm+R1i2
         FJ3mDLyTf51tQ==
Received: by mail-ed1-f69.google.com with SMTP id d11-20020a50cd4b000000b003da63711a8aso15335388edj.20
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 02:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x+ebBDbVVXbydAVIXajg3Ac0CDuAQFka9vVAII+KcTQ=;
        b=gTrX9UGW7dFWmLNslhHIEmvwClvEkmkoa5X5ZgN82UyOXsTgpDmjKGhB1ki7OzJhJ2
         vb/t85cDAJOvy8yzbyhc3TpQYtKmyb58d8rzMpPcv0BO3D+U+cQDnmkb7bCKH+wLbS6S
         /2rhWLfh9b3rwvT0CrOEX5UGGLj5D1P5QxEcTVuQEafcVH7twtSZnVE+HT2vkG6PhgC9
         qoRB0g7c4X9c2Cur/HizMPOwCQtLu5/MbjjoDNBlAp9kXRrpmJjRx5SuJgMC3YEa79+Y
         G2kxfOz6lWEqnV5wy1/vZDRN5pHuhh6r0Yuz05F4TqOYtESJsn0X9CM5T1XuR7wgowsE
         VEuQ==
X-Gm-Message-State: AOAM531lCDEDf57Qewju905xwsBBN4SbZprJGZMo2jEFMWR8f3wN1Sk/
        IE/fNAUTYeuj/NLtNzoPY34hcdCBjdB1tzAX7oLO1LuRjTUKAalwn/Iya3rnW4PRrq4nbz5g8nK
        kdouJDPGa0ule2aw3X5iLYJ358reVfpN5eJrbmE3lbw==
X-Received: by 2002:a17:906:5d5:: with SMTP id t21mr25107362ejt.160.1633945981071;
        Mon, 11 Oct 2021 02:53:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxE3fAq+I3dMmD03BBhqJ9YsxjaReEjo4L044THoSNYQRpEsnsClapd0A8H3a911zE+4WU7XQ==
X-Received: by 2002:a17:906:5d5:: with SMTP id t21mr25107343ejt.160.1633945980885;
        Mon, 11 Oct 2021 02:53:00 -0700 (PDT)
Received: from localhost ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id p7sm3955215edr.6.2021.10.11.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 02:53:00 -0700 (PDT)
Date:   Mon, 11 Oct 2021 11:52:59 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: soft lockup in __kmalloc_node() with KFENCE enabled
Message-ID: <YWQJe1ccZ72FZkLB@arighi-desktop>
References: <YWLwUUNuRrO7AxtM@arighi-desktop>
 <CANpmjNOw--ZNyhmn-GjuqU+aH5T98HMmBoCM4z=JFvajC913Qg@mail.gmail.com>
 <YWPaZSX4WyOwilW+@arighi-desktop>
 <CANpmjNMFFFa=6toZJXqo_9hzv05zoD0aXA4D_K93rfw58cEw3w@mail.gmail.com>
 <YWPjZv7ClDOE66iI@arighi-desktop>
 <CACT4Y+b4Xmev7uLhASpHnELcteadhaXCBkkD5hO2YNP5M2451g@mail.gmail.com>
 <YWQCknwPcGlOBfUi@arighi-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWQCknwPcGlOBfUi@arighi-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:23:32AM +0200, Andrea Righi wrote:
...
> > You seem to use the default 20s stall timeout. FWIW syzbot uses 160
> > secs timeout for TCG emulation to avoid false positive warnings:
> > https://github.com/google/syzkaller/blob/838e7e2cd9228583ca33c49a39aea4d863d3e36d/dashboard/config/linux/upstream-arm64-kasan.config#L509
> > There are a number of other timeouts raised as well, some as high as
> > 420 seconds.
> 
> I see, I'll try with these settings and see if I can still hit the soft
> lockup messages.

Still getting soft lockup messages even with the new timeout settings:

[  462.663766] watchdog: BUG: soft lockup - CPU#2 stuck for 430s! [systemd-udevd:168]
[  462.755758] watchdog: BUG: soft lockup - CPU#3 stuck for 430s! [systemd-udevd:171]
[  924.663765] watchdog: BUG: soft lockup - CPU#2 stuck for 861s! [systemd-udevd:168]
[  924.755767] watchdog: BUG: soft lockup - CPU#3 stuck for 861s! [systemd-udevd:171]

-Andrea
