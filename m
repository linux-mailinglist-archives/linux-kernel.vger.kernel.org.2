Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902D337203B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhECTQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhECTQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:16:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4C0C06138E
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 12:15:16 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u13so4924768edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=fyFJP735XQXj4LkTnGwzm4qSEE25PUlvsZ5m+5XoeTg=;
        b=R5TKedJKe8jFlf9lMHC2G4AqVWRJE0dTCT/4m3gzvsre1icWgKAlqnQ/n8OCP5qBu6
         OD201KjlWSPNGB7YCWZ0BEgT0iiYzJnMY8R9kBq7QxnWO5Ec69yWP5imZDzfjfI87Icq
         Vu9mz6P83IjWi+hHed0zvq1mo7iSp7BFBiuFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=fyFJP735XQXj4LkTnGwzm4qSEE25PUlvsZ5m+5XoeTg=;
        b=TQcqNvglAoosVXGwOztw6N6c2qFqD6S6EARMb+wUzR8Lx7PPK8Mk5Ss0quTOq71Jxe
         LLAhV1RCGaE4jYS7Xjny162N1qq+jVK5mzhCQYDSsa9ADuBQu3JFU6gtzNoO2n9LScL8
         xW16EUNa5FKNsgxaApOfhf92HsLJW1JMs+0RjlWeL2JnuPM6+GbfGr77gIcm87D8TPFk
         nZRIEgj6fd/eGOR5RiRInTtOS83OVQMn48WZRiYW3pGnnr9kOVOtFNJCvzL4jhGAPpP9
         xoOQ/1q99PA4H1BUQ7G5uMy4YFRIufkqv8Iyo+gKN0qUsQBWtJ/WNdlnJPgp0lSQFk8w
         CMLw==
X-Gm-Message-State: AOAM531vBNqeBbHJV/ndH2S6Wmlxf2mCysZHN1+O+rYZWzuFf1SotU+o
        mK/F9Er4kAuhT2dSHbxaTRN3sw==
X-Google-Smtp-Source: ABdhPJwHjMUFJwM40ARD1fhW9cBMZs1N9ixtJyT4oagDjJlQdPziQznBELdraes2Gu2qzngLQrV4Pw==
X-Received: by 2002:a05:6402:c8:: with SMTP id i8mr22275371edu.57.1620069315093;
        Mon, 03 May 2021 12:15:15 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id sb20sm255703ejb.100.2021.05.03.12.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 12:15:14 -0700 (PDT)
Date:   Mon, 3 May 2021 21:15:08 +0200
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PULL] topic/iomem-mmap-vs-gup
Message-ID: <YJBHiRiCGzojk25U@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

It's still the same topic branch as last merge window, but the name isn't
fitting all that well anymore :-)

Anyway here's a small pull for you to ponder, now that the big ones are
all through. It's been in -next almost the entire cycle, I've only done
some non-code rebases due to the -rc1 fumble and to fix some commit
message typos.

Christoph Hellwig also looked at these and aside from wanting to outright
remove it all didn't have objections.

topic/iomem-mmap-vs-gup-2021-05-03:
unexport follow_pfn

Follow-up to my pull from last merge window: kvm and vfio lost their
very unsafe use of follow_pfn, this appropriately marks up the very
last user for some userptr-as-buffer use-cases in media. There was
some resistance to outright removing it, maybe we can do this in a few
releases.

Cheers, Daniel

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/topic/iomem-mmap-vs-gup-2021-05-03

for you to fetch changes up to ac8b8400620a4b0d9ca903ee9ad440bec736f5fa:

  mm: unexport follow_pfn (2021-04-08 16:54:38 +0200)

----------------------------------------------------------------
unexport follow_pfn

Follow-up to my pull from last merge window: kvm and vfio lost their
very unsafe use of follow_pfn, this appropriately marks up the very
last user for some userptr-as-buffer use-cases in media. There was
some resistance to outright removing it, maybe we can do this in a few
releases.

----------------------------------------------------------------
Daniel Vetter (3):
      mm: Add unsafe_follow_pfn
      media/videobuf1|2: Mark follow_pfn usage as unsafe
      mm: unexport follow_pfn

 drivers/media/common/videobuf2/frame_vector.c |  2 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c |  2 +-
 include/linux/mm.h                            |  4 +--
 mm/memory.c                                   | 46 +++++++++++++++++----------
 mm/nommu.c                                    | 28 ++++++++++++----
 security/Kconfig                              | 13 ++++++++
 6 files changed, 68 insertions(+), 27 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
