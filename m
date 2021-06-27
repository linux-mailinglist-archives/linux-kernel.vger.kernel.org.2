Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CB73B5349
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 14:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhF0NAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 09:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhF0NA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 09:00:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5C3C061574;
        Sun, 27 Jun 2021 05:58:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 13-20020a17090a08cdb029016eed209ca4so8556339pjn.1;
        Sun, 27 Jun 2021 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KQTa84jZIOQ8yL/8YRmIAzfc0ITGIa9SbPo6GWgEdt4=;
        b=V0sbwnvBOmQ9LjJAFbJ6cgUEN3ySV2Cck14T4PW6UgGeyGLn8GY6iGokqsVCM/5gLz
         zsMpHuho9tgn1FLhXlk4MXDLawcVO6bn/8EQp8qYJ5Co9/WQpj8tVqs1XD0DdnrSZPKN
         Jkie7lJbndsx8SDruROjMZD/s6xj1o3wK0ITvca3jhPqMeh2mv0XFO9VFMHW8qdWfcvy
         08dM/CkZ5VE8ShLQUzQneNKi6+cCYcUipEuBM5kdTr0hlqzohH00XAEazkqJFd4osgT4
         mK1REdnMZRrj+pzw4Z8jJVxfutcKHZxMRPQNN0D6RZVlDsIu6lvmGz1+VSw/WozkIggv
         cuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KQTa84jZIOQ8yL/8YRmIAzfc0ITGIa9SbPo6GWgEdt4=;
        b=YcL9StBBwdvIzCmp+tPCdMnRMgsVpMnec+mc1fN5hc5znWruJIvPEHP0P9bdMYvw4n
         kZxNpXUE95shBQCZSeCoEYGrI9CqxCvqMtvbr/YRNtTKVxpmW7gCYFTAIP6S41tlyD5V
         yguuUOfe9G+VMQcHPkoLt2z8BFeNSmesd8fMRH3ShFe94Z5qzRjxAWaoScyV0ZSCbCDG
         0xgFAHISL6dbIzVuRZ5jr1G2zQecK244gwET3yq8UWhvVyp+5+OnnxUcqvXM41xIDhJh
         8plDLa7bAoGPX2EsET2H66mhCd6zpz12ImsAbXu1sJB6IZSr8FxcYxGSB/V4XBDlgGF/
         gQQQ==
X-Gm-Message-State: AOAM533oJ95Jk1q0FeOnfezYjMitNcbARQPUdSDsN/+14ll1P9QtqlNr
        ZadDP2Ycre79wI52sWZd0jG51GUYU5L/Qij6
X-Google-Smtp-Source: ABdhPJyin0kHMQ5dsHkcg1EoDffBzL8iyhzN+4/4kMa9OUQuD3d9kFeLz3IS1wKjP9s/GQpGp6ImDA==
X-Received: by 2002:a17:902:f20c:b029:11a:b005:acf7 with SMTP id m12-20020a170902f20cb029011ab005acf7mr18057550plc.26.1624798683975;
        Sun, 27 Jun 2021 05:58:03 -0700 (PDT)
Received: from localhost.localdomain ([113.76.110.29])
        by smtp.googlemail.com with ESMTPSA id c5sm11270260pfi.81.2021.06.27.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:58:03 -0700 (PDT)
From:   Kelly Devilliv <kelly.devilliv@gmail.com>
To:     gregkh@linuxfoundation.org, shubhankarvk@gmail.com,
        lee.jones@linaro.org, gustavoars@kernel.org,
        chunfeng.yun@mediatek.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kelly Devilliv <kelly.devilliv@gmail.com>
Subject: [PATCH 0/3] usb: host: fotg210: fix malfunctions in usb camera scenario
Date:   Sun, 27 Jun 2021 20:57:44 +0800
Message-Id: <20210627125747.127646-1-kelly.devilliv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi :-)

Currently, I tried to support usb camera on the fotg210 host
controller but came across a few issues, for example system
crash, video streaming error, etc. As fotg210 is an ehci-like
controller, I borrowed some ideas from the ehci-hcd driver,
and at least the usb camera can work now.

By the way, the fotg210-hcd driver seems a bit out of date,
is there any plan to update it based on the latest ehci-hcd
driver?

Thank you!

Kelly Devilliv (3):
  Revert "usb: host: fotg210: Use dma_pool_zalloc"
  usb: host: fotg210: fix the endpoint's transactional opportunities
    calculation
  usb: host: fotg210: fix the actual_length of an iso packet

 drivers/usb/host/fotg210-hcd.c | 48 +++++++++++++++++-----------------
 drivers/usb/host/fotg210.h     |  5 ----
 2 files changed, 24 insertions(+), 29 deletions(-)

-- 
2.25.1

