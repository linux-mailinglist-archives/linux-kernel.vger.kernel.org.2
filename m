Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5343D487B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 17:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhGXPRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 11:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGXPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 11:17:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0AAC061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 08:57:43 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so13403347pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 08:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=AxDs9ExYjz7Pb1FuQd7u953/+qBm66B0ao4sjr0lTx4=;
        b=FRVF76tgZDzdkOPRJnbfZJfK5LU344iDV2ymplQf5HeAkjmFTtZPvdK8ZeHGezVIaq
         5UT+nF8ZdVyqWsuuZs1j6J3Gat64VCK7et682DKYuMbgrnEFApHIJWZ7Fac7BJXfYf8F
         W5VbDT+LldPrwHMJICNzH4E7d2T+HiVfRrft3O8LpzfPqmZdXo2ZxjjIzAjDUKQpUPPb
         svbU5nydS2aYEhMqtXkH3SWgmrhmmxcDS9/wq57Q+JZbB1ENuA6hk3VW9Eltg/cbQUuI
         GFeCtVMS20xMXaRD4tdYPQAopHpxUNT1O+IR4l2NUCRo+DQQ0Kh6zCzC7zqWIYp6d/UU
         D+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AxDs9ExYjz7Pb1FuQd7u953/+qBm66B0ao4sjr0lTx4=;
        b=LC0V0EbyUTAIYyAd+MPROPIaImHP7UZtxPKfQL3jgEqSmqWlZOtTyDlbPg4PASRhY+
         n30hirk1a8yqIsCCVoHJx4A+m34w6/BPzfZuVyDoJAKTBmuK5lekik5UOv/8stYVNnFb
         VObiAmDTod18bsY1K7F/0+3sVTbtCVtLLTOaKviqVuMeSLDivnykE5R1B+1/lOvgcdo1
         aVI9lctAWP3RoAQENQIxoqkxV3myhhvB5dTFTbdmiB9huVOFR7LCvwA039Rd1+e3K1ca
         LvA46eSQUfXbXHrD936xS0bzZXf4abTRrFrq5AH69U3XcW6fwf2/0iqKJfK9Z/XtBgAk
         kUbw==
X-Gm-Message-State: AOAM533uJDLjcArd4HG4PHYY6P9qcmS4L55K3RK5hdlqreDu8UlsvC2Y
        IVhl7fj3xy1DbNou2ROnV8vYx0oBOBWBD24t
X-Google-Smtp-Source: ABdhPJyHEVhFBzt0GAdnqTsg9pIiE/4dLyI/1xKguiApFyt6uhZKtrtjqUBpcs/6nSk17eOqk2dFwQ==
X-Received: by 2002:a63:d612:: with SMTP id q18mr10109835pgg.77.1627142263080;
        Sat, 24 Jul 2021 08:57:43 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id d2sm38098630pfa.84.2021.07.24.08.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 08:57:42 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: 5.14-rc failure to resume
Message-ID: <eeab973d-f634-a182-6d76-f3912f8cf887@kernel.dk>
Date:   Sat, 24 Jul 2021 09:57:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ran into this when doing the last bit of testing on pending changes
for this release on the laptop. Outside of running testing on these
changes, I always build and boot current -git and my changes on my
laptop as well.

5.14-rc1 + changes works fine, current -git and changes fail to resume
every single time. I just get a black screen. Tip of tree before merging
fixes is:

commit 704f4cba43d4ed31ef4beb422313f1263d87bc55 (origin/master, origin/HEAD, master)
Merge: 05daae0fb033 0077a5008272
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Jul 23 11:30:12 2021 -0700

    Merge tag 'ceph-for-5.14-rc3' of git://github.com/ceph/ceph-client

Since bisection takes forever on the laptop (gen7 x1 carbon), I
opportunistically reverted some of the most recent git pulls:

- ec6badfbe1cde0eb2bec4a0b8f6e738171156b5b (acpi changes)
- 1d597682d3e669ec7021aa33d088ed3d136a5149 (driver-core changes)
- 74738c556db6c7f780a8b98340937e55b72c896a (usb changes)
- e7562a00c1f54116f5a058e7e3ddd500188f60b2 (sound changes)
- 8baef6386baaefb776bdd09b5c7630cf057c51c6 (drm changes)

as they could potentially be involved, but even with all of those
reverted it still won't resume.

Sending this out in case someone has already reported this and I just
couldn't find it. If this is a new/unknown issues, I'll go ahead and
bisect it.

-- 
Jens Axboe

