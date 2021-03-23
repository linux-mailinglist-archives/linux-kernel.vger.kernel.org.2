Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27558345FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhCWNlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhCWNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:40:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEDFC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:40:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id w3so27167726ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZGkiGKYA9UnQezkNRP1eOoZgt6WZ7BXwgSa/zEhxao=;
        b=K4wSpV+JwtX2hLAPqtmQIRGPrAXazv+ZI2F0KH5RLVDI0aIcYNwjxsaATw9f51XcIy
         TSZaACQ4uyGeQpXi2QI4FfCpGQa0L4zkwFmW9DR2J/08LSZ7rRySGduXlO6crl1bXJgA
         c3XD3kWR0mH1M/cO6X40B2CTrDuo9f4iqdvv9tPUCoxaOo/ob0+1NlHH0qY0SoZUrq4R
         p0JRcJAWEvxOPlX3NhNaA8cffrZMS/LrrWneFgPTGmjL+MetY2OFYGQPLbZvqXN5j/5E
         pMQnloWXrd7y1jrp713Eun/yZcCdRe3kc4cxwXQmGZ9zFCitcDg61FWV1cu/hcv6xBzs
         +evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZGkiGKYA9UnQezkNRP1eOoZgt6WZ7BXwgSa/zEhxao=;
        b=tqLDlBMcoHDDNoWOo4upeQBc53UZZnqM67isznkj2EBYyQja56QWMwlv+F4Vlpvogb
         u+uh+SrBanZ0JyyJYu0jbay1vWuaR+TG12VlFChrX7IptvFVxGQtqTtxXYOu00u9N/MW
         KZ/hGaLiObLtmPXQnuSVQho9axrGu/W7Y/vllEr3CM+l9OkQ+HERotPQ3qnym0gPsCqr
         4zECeTc3ffDl9EXeY0FNgjZupATcoyAvwJ/B/fTxj3tFyTw9nf7Glku9ieEUhalrIQGS
         7XoTNnReK4NTINHbe1DLjiXDhqmZs8gtUdOO5tEA5ywQq8o+8pjer5PlbKpP1aXfz3+Q
         rboQ==
X-Gm-Message-State: AOAM533FZWC5iLeYEuxHn2jbGKcxicyr/7ko+0WV+rj20hLjXomutiyV
        C6jMrWaP/1WZ2TzxDB0KX7SQVQ==
X-Google-Smtp-Source: ABdhPJxF31ITiySO5RmhXqWHsxzWsRM0pct2TbtSvn5qDWPEYLuZaXvnQVr5HZtySfkkLPRvUu/FPA==
X-Received: by 2002:a17:906:558:: with SMTP id k24mr5043834eja.387.1616506854739;
        Tue, 23 Mar 2021 06:40:54 -0700 (PDT)
Received: from localhost.localdomain (hst-221-13.medicom.bg. [84.238.221.13])
        by smtp.gmail.com with ESMTPSA id r10sm11207317eju.66.2021.03.23.06.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 06:40:54 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, ezequiel@collabora.com,
        nicolas.dufresne@collabora.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v6 0/5] HDR10 static metadata
Date:   Tue, 23 Mar 2021 15:40:35 +0200
Message-Id: <20210323134040.943757-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Changes since v5:
 * added Reviewed-by tags
 * 3/5 - added a comment (Hans)
 * 4/5 - drop "coded" word in documentation (Hans)

regards,
Stan

Stanimir Varbanov (5):
  v4l: Add new Colorimetry Class
  docs: Document colorimetry class
  v4l: Add HDR10 static metadata controls
  docs: Document CLL and Mastering display colorimetry controls
  venus: venc: Add support for CLL and Mastering display controls

 .../userspace-api/media/v4l/common.rst        |  1 +
 .../media/v4l/ext-ctrls-colorimetry.rst       | 93 +++++++++++++++++++
 .../media/v4l/vidioc-g-ext-ctrls.rst          | 12 +++
 .../media/videodev2.h.rst.exceptions          |  2 +
 drivers/media/platform/qcom/venus/core.h      |  2 +
 drivers/media/platform/qcom/venus/hfi_cmds.c  |  8 ++
 .../media/platform/qcom/venus/hfi_helper.h    | 20 ++++
 drivers/media/platform/qcom/venus/venc.c      | 29 ++++++
 .../media/platform/qcom/venus/venc_ctrls.c    | 16 +++-
 drivers/media/v4l2-core/v4l2-ctrls.c          | 75 ++++++++++++++-
 include/media/v4l2-ctrls.h                    |  4 +
 include/uapi/linux/v4l2-controls.h            | 35 +++++++
 include/uapi/linux/videodev2.h                |  3 +
 13 files changed, 298 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-colorimetry.rst

-- 
2.25.1

