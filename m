Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937E5401142
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhIETBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhIETBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:01:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B1BC061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 12:00:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so2476735pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JRVcS/e3uTa82chQ+txpdCU0rg1KC4KMdsr476tU/+I=;
        b=o2WCrP+2j2Fjd0Hmil68XB8u07nFOSg9O8QyWhCqLC5m+n3wbXQZ3TBDtZ5zXaP/Pq
         5+Nt1OWZ8aWEiERhaL8c9c1ApT7xHdLN6hiEQc15OBO+DXT5qdG8zRkfGzEeIzKVm+/5
         cYcCMXnpHw5f22rXuU6+8jfN+j0uvrOkuI3bR+6zfTOIEhDtsJ5lxFTFqQSWaoios0fB
         doQ16KGswVr4yBy8CuV6nD6H/nm4BNOnmAGTJb28Bd1Zyp9vydN/LLbtKxl7VUOpHfwC
         N76hGt/BFIhHw5GXusKDWIRro/nPTiS0erVuc9vY1m2nooM6rbwJjjW9fBeaA5gTs3Fv
         aG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JRVcS/e3uTa82chQ+txpdCU0rg1KC4KMdsr476tU/+I=;
        b=FdicYqn4rAjzyS8lYPgNvdqHtL09rO6Y0rBIaQ6NxC28zkY925n3ol3cRU64cK9AGc
         3EfCcS6Ezqi2Ou9xOQgMLo7z9s8RyYtypDDOEq8RRKIT0CxdGEwk5QOiN276BM7Np1gT
         ufUDXRe4lIZveRkJEJnvPVRxlH816cp07pLdmPrWVZW/r2jpGv1KlRF6xWHoC+tYiCmy
         DII5bQXgmkGGuElZG1HY2c89y+ig3XrW4lUu/qVpn8sVfGKQ5XMtsaUePxzIDnLi69wD
         KZlE3yao2sQyW1yLIMAa1Zk1K7LmEifg9uTucFe32VfcUGbS//hPfc6REjGKY+9vfAsu
         tFjA==
X-Gm-Message-State: AOAM5325n2invlJv8C5YzUEnqQbeQAK94XMfMy0uX2B4GzA/UcAOYn/u
        za/DyRfrvBlygOQXfl39CcyXZ9gWT9TDUw==
X-Google-Smtp-Source: ABdhPJxvKv8G0Wci9Bw55r4IbV73DLNKY4Mz7aJJ6OOv2kPsg11QrCVVB6PLmTCahu5+tQihsGEAXA==
X-Received: by 2002:a17:90a:890f:: with SMTP id u15mr10142676pjn.149.1630868433149;
        Sun, 05 Sep 2021 12:00:33 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id v7sm5126057pjg.34.2021.09.05.12.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 12:00:32 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Phillip Potter <phil@philpotter.co.uk>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] CDROM maintainer update
Message-ID: <d5bb414c-e0e1-ff06-ab4d-f96f706be4b2@kernel.dk>
Date:   Sun, 5 Sep 2021 13:00:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

It's been about 22 years since I originally started maintaining the
CDROM code, and I just haven't been able to even get reviews done in a
timely fashion the last handful of years. Time to pass it on, and
Phillip has volunteered take over these duties. I'll be helping as
needed for the foreseeable future.

Please pull!


The following changes since commit f1583cb1be35c23df60b1c39e3e7e6704d749d0b:

  Merge tag 'linux-kselftest-next-5.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2021-09-03 15:55:41 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/misc-5.15-2021-09-05

for you to fetch changes up to 55d1308bdff7341b778e5cf36220616a0dd6ab8f:

  cdrom: update uniform CD-ROM maintainership in MAINTAINERS file (2021-09-04 11:47:41 -0600)

----------------------------------------------------------------
misc-5.15-2021-09-05

----------------------------------------------------------------
Phillip Potter (1):
      cdrom: update uniform CD-ROM maintainership in MAINTAINERS file

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
Jens Axboe

