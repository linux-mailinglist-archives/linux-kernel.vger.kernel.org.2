Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AE1389E37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 08:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhETGuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 02:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETGuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 02:50:18 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 23:48:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so4911377pjt.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=ah9WuIwTVXGma0griLbvLlZl0iobmLFJcW76a34Yh88=;
        b=lBApfxFR50L7SAkrcK7AbLaJRoh9UBHJA+sNi5rrpWwPa618zWTCeInefEEgx/OOL+
         cvTOwaK5LtZqkAaY+l6HTpH/cV8bvOGIvKnppo/ui611+4gOoXTcYFT9zpQNsphdNMt3
         WlUjfD1OHKa/xngtztNx2R3CvTkSpJ6vkAw1Nbt2KQz/Zk38hCVbCbyj/HdwywqF7Qkr
         GMow97u+nEkNmAL31hvaBzW+r3vx56kYMpvQ0WE2hkmiGl36lbRXBkKW/dLEYF5Shzit
         puseaBdpOvmAcCWCdvJ3WVnvZvVz1DGMs09vUruoYyiO5TQnxYbJO5oX9EDvBCRLQKWg
         gkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=ah9WuIwTVXGma0griLbvLlZl0iobmLFJcW76a34Yh88=;
        b=lyexBvaGiH9o+CBeh8mO7rM0KshLCxzZEDJhtX+iaJKnHjuFrnrnY/sDdlgNLudq3H
         tcskymgEbgGYm82K1hlwMvZX+gYO8CDL9C82NV3m9aA0xNpaJaiW8vZmgZ32izxqgKUw
         h5+sSDeLttsM82Obm36KWiZ1zWYqQrqRL/Y81/uDVr5aexYeLJTeH2F6pJZAHCD5oP1W
         +5HfgYkTdke4IZB0evwKAml6W/wWbkEr+gIuipBHD/aT4GNml8Sj8netfoDR1HfV/aOS
         MR7591o0zxd0+fbd5rGMEDAfuLvQCG/DLw5oilbX6SFuSY4DWdkGteiLTYSC/LgPT9SL
         rJsw==
X-Gm-Message-State: AOAM5319X1sgmNceN7cK3gOds4RnW7nS8pcPBeCDUlX/btDdV17Mv+gB
        tmTP7zex/cFHnJbQTn30MlHgOQ==
X-Google-Smtp-Source: ABdhPJx86oszuYO3f5wkZd+NreLIoQY6r7ZAmf4Q5WL7WKAVmQDXITZUJyS300XIHajmOxJomhTZzQ==
X-Received: by 2002:a17:902:7787:b029:f0:a7c0:f9e5 with SMTP id o7-20020a1709027787b02900f0a7c0f9e5mr4021671pll.5.1621493336697;
        Wed, 19 May 2021 23:48:56 -0700 (PDT)
Received: from centos78 (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id s2sm3426348pjz.41.2021.05.19.23.48.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 May 2021 23:48:56 -0700 (PDT)
Message-ID: <61f706e52872255ba4a59613fd6a8b59678ff1e0.camel@areca.com.tw>
Subject: [PATCH 0/2] scsi: arcmsr: fix doorbell status may arrived late on
 ARC-1886
From:   ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 20 May 2021 14:48:55 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against to mkp's 5.14/scsi-queue.

This patch fix the doorbell status coming from IOP may late.
The doorbell status value should not be 0.
---


