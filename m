Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92988359EEE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhDIMkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 08:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 08:40:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63865C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 05:40:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bx20so5225855edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 05:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qM2/IEN+AkA2uS3y4nQykwtyhpicukZG09T/lUhejA=;
        b=EFvfa7U5cFR3alwiybhEPjfgtDFCgIClKD+30qf2LTaGFVrBfvylJStcoAaPeoBtku
         nc8dLfRXwVWTO0eFAdK1UUSKfzUDAqwksimAweIKd3CM5jwWqcWv100XdddfaImxITKA
         ETYc7CrGxUsyfMk/chA99zG8gzjsWAGMOcDvjyaHybaNFuI/MeGc7KEbyhNHQUW7258W
         1zCcSrzt6bwC/L4+KzlfNnyABANhSBbESOdFdeHdUSNxq5X5HCidp64cyNrRQpdXX1oI
         m150sU+GnM7iI5J0EZORZRBN5eCw8D+Cnojztv3ktoAMjjnLAJhpWrZkXTCzxMNANVx5
         THrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0qM2/IEN+AkA2uS3y4nQykwtyhpicukZG09T/lUhejA=;
        b=SH1r9zusTVu5jJ0KXyOb8CV4sieByLueee1UlO0uvI+o+npWv3dVU8wNEwR7KjUil8
         RLdQk+rZBErwXDfW9BPNquVb3mQBqGd5To5Idn343pt1pFz8kfu9fh/cuJ77P52/r+rY
         V79/VU32muXQItsYDgeSIjIRomZcJnY0hXbvyqb1XmV09yVw4UgKQE1yBv2PDOMYG6kS
         TZSF+xM0g+pf6JLIQLdKSz2vbvcYFweG08nyAC0p3LBQoAfRSwnAYKeUihmnMrOKi2zc
         +o7ajrcpKgpK8+wJL7lV15q9PqiXG+Qp7zoqnsp/U3HM67bXd/0xsTIb94Tw22lGoSFc
         ctPw==
X-Gm-Message-State: AOAM533TL5GsjzrGYJ3mcKvJcSL71Xaq/1o/AZXqCl7TJfTOGB4r0kw4
        FuTM8noi+v2XLwuFa+4p5BW1wgXd0wJOXA==
X-Google-Smtp-Source: ABdhPJxTaBjOSB9vWQ1708QBNB4+vYEGBm6HcYGzW0A2a2nN/Nr6T0GnQ44DX8tgMokH+QXEdGFg3Q==
X-Received: by 2002:a50:e607:: with SMTP id y7mr17608650edm.18.1617972007229;
        Fri, 09 Apr 2021 05:40:07 -0700 (PDT)
Received: from agape ([151.43.204.41])
        by smtp.gmail.com with ESMTPSA id f10sm1349546edd.29.2021.04.09.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 05:40:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 0/3] staging: rtl8723bs: remove MGS_8192C trace logs
Date:   Fri,  9 Apr 2021 14:40:00 +0200
Message-Id: <cover.1617971592.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes the tracing private macro MSG_8192C.

This macro belongs to a redundant driver specific tracing
macro family.

Moreover the default behaviour is _do nothing_ as to
activate it, it's necessary to hardcode a DEBUG symbol
definition.

Fabio Aiuto (3):
  staging: rtl8723bs: remove all MSG_8192C logs
  staging: rtl8723bs: remove commented out MSG_8192C log
  staging: rtl8723bs: remove MSG_8192C macro definitions

 drivers/staging/rtl8723bs/hal/odm.c               | 3 ---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 4 ----
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      | 4 ----
 drivers/staging/rtl8723bs/include/rtw_debug.h     | 6 ------
 4 files changed, 17 deletions(-)

-- 
2.20.1

