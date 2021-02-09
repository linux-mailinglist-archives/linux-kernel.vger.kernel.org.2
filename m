Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E72315C03
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhBJBQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhBIWl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:41:59 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC5EC061794
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 13:19:48 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 2so9457048qvd.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E+GwgIRGKbJyN6BMx9osGrabexMLPqEhC8h9yJvwcPI=;
        b=qVg6eWt/p+mtaLHMJ3UMS3pa7cP8tRdSZltmlPVvywtYM1Xz2GgR7lvaILGqsvNc5q
         vYrdlEDpJ6LAExkiYJ+B2vgDJ4ic2ZFx3wDChTDEaZfGBOTtJtLCbFQKoE4/Vk9+CRMe
         /MncFu/kd8cMm7K8t7NNOuyjR2eP2G5CTovSmA03FmKDfH7k80wPNw51QigLDkuqVVoO
         9Jsosv3nlBPAAyWAq3Pt67mVcQfjR5jY5YDPEDWGyqd4Kp1yax1q4OadysJ422FdpCbt
         WX/JTNoTftwxDefcRi52Porkf9IdP/D/O6sbzPHti4g2tYZ9YwaiO2XPK1xOKsZWKK6h
         TUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E+GwgIRGKbJyN6BMx9osGrabexMLPqEhC8h9yJvwcPI=;
        b=RjKGW9UUnI3tpPDzBeARoT21rQ+ayM2cvI9iCXU8hhoLdbbkpovENX6FEGrc4wQRN/
         pgOT27jyHDQDdY2AuJ66N0f7nlUhDyFHT/KkL5SkTH2uimwnMfL2yUbP2QVkSzMU90lW
         FtVrtygc4QfpwTLfaTvZ1hkKQoB/Ubm2A3nRBekYAhy6eJXPM5H23ZYs9Izx2kXQHvMB
         EWgbTaK6gBJklO2RWD5EwxIhxV3ov23x43D8YOBa3GcUj7aQeU4YuXqxsexebIcMac1h
         g0fBM8WFGkQqKmRUwesBC2rTEh/J0Qot078jLH7CX2wG5RxFbxTWacsHQHL6iCjN789w
         6fQw==
X-Gm-Message-State: AOAM531O5AZB8ztWsqWNnPr9ocgIr/+MOrOteesB2fFWlr2igxDZap7z
        fMXBNjeCY4GlqTuV4L8E5wgh5w==
X-Google-Smtp-Source: ABdhPJzC1y781rKFs2oJ/EMXGnR/H0Bxxy1Ep70Zk8iEdT2DuGjbTeRKP6O9dCSwmHzW9pi7dRURgA==
X-Received: by 2002:a05:6214:1643:: with SMTP id f3mr122351qvw.4.1612905588033;
        Tue, 09 Feb 2021 13:19:48 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 199sm20696467qkm.126.2021.02.09.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:19:47 -0800 (PST)
Date:   Tue, 9 Feb 2021 16:19:46 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Michal Hocko <mhocko@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Prakash Gupta <guptap@codeaurora.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH stable 4.9] mm: memcontrol: fix NULL pointer crash in
 test_clear_page_writeback()
Message-ID: <YCL8cnXFtpdnAAUj@cmpxchg.org>
References: <20210209202616.2257512-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209202616.2257512-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 12:26:15PM -0800, Florian Fainelli wrote:
> From: Johannes Weiner <hannes@cmpxchg.org>
> 
> commit 739f79fc9db1b38f96b5a5109b247a650fbebf6d upstream

...

> This patch is present in a downstream Android tree:
> 
> https://source.mcwhirter.io/craige/bluecross/commit/d4a742865c6b69ef931694745ef54965d7c9966c
> 
> and I happened to have stumbled across the same problem too.
> 
> Johannes can you review it for correctness with respect to the 4.9
> kernel? Thanks!

Looks good to me.
