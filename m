Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A12320B62
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 16:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhBUPbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 10:31:39 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:55558 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhBUPbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 10:31:36 -0500
Received: by mail-pj1-f43.google.com with SMTP id t9so1882945pjl.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 07:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YApQnQq4jiP2ASaiw6ZTwSKXh8LQuBtsU7vVCi+HrJA=;
        b=dmDrw1keFev0snvjBFr/ARENj+FVlij0cvmYqEfbX9HZVwEixbBmJTe652VM61Txq6
         UNXx+YGWZID7Vydts+0pbo8ssUgyYsoRSZNrau2L9/5B0qTufHsgrqnRCRMoCuvibR76
         EIJZ6VNcWG7d+3HBlRuN7Fbd4kSxBwlrD7h5JKbxikYOvGSHMHZj63oqeUrD0l3Knti2
         vLcOGjsTjBF0L0mvd5wCxpg6nRp+G1tUVV8lSNiwdCFqqnwV6luSRzkc59R97cMUjVLU
         T/W2c6wxtS5q3L8DUIvTn8UCl0yANwgkyPQgBmQ6nvXjRHNgeQQ8hBHG4mATL4n7YnZb
         IdAg==
X-Gm-Message-State: AOAM531onmg+Pm2XTl8ryq5H4WHOLTqn1VaGB1Yvx0DEquAgNLWNPoMY
        jEUV1q4OGtzbJxqx79XT0vw=
X-Google-Smtp-Source: ABdhPJzDJXDoRP8iS4a2MCWZu8YbK7Y5dl0VlrYMyHe8CY2rkMcLsSmS2TGNDTJN57YZ/AM/bzGF+Q==
X-Received: by 2002:a17:902:be12:b029:e3:8245:f16c with SMTP id r18-20020a170902be12b02900e38245f16cmr10642401pls.57.1613921454757;
        Sun, 21 Feb 2021 07:30:54 -0800 (PST)
Received: from karthik-strix-linux.karthek.com ([192.140.154.12])
        by smtp.gmail.com with ESMTPSA id gq15sm2633915pjb.9.2021.02.21.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 07:30:54 -0800 (PST)
Date:   Sun, 21 Feb 2021 21:00:48 +0530
From:   karthik alapati <mail@karthek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fix sparse warnings
Message-ID: <cover.1613921277.git.mail@karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the following patches fixes two  byte-order issues
and fixes these sparse warnings


drivers/staging//wimax/i2400m/op-rfkill.c:89:25: warning: incorrect type in assignment (different base types)
drivers/staging//wimax/i2400m/op-rfkill.c:89:25:    expected restricted __le16 [usertype] length
drivers/staging//wimax/i2400m/op-rfkill.c:89:25:    got unsigned long
.
drivers/staging//wimax/i2400m/fw.c:514:27: warning: restricted __le32 degrades to integer


karthik alapati (2):
  staging: wimax/i2400m: fix byte-order issue
  staging: wimax/i2400m: convert __le32 type to host byte-order

 drivers/staging/wimax/i2400m/fw.c        | 2 +-
 drivers/staging/wimax/i2400m/op-rfkill.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.30.1

