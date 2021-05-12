Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F6E37B974
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhELJnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhELJnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:43:11 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D619C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:42:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w3so34052245ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l67ByTuTDoxE8yyQ8qcNrrbIp/HYHnBIsJgxG8dbjrI=;
        b=VB9h/9qWvHCD1s8q/hkPC/FNEHZNZrvAVjNYXTEvbyL0YZYhdSlLIp0fqLuIpoAw2V
         YAtX8WW1yq9KV1c7fqhLQkRj/bR8gBVyjbTvUfKVXc6dN/Tq2+PhiUxdZ75i28ssV3N8
         oRCmPhULFyZzRNQzYevfoV/IqbKMxBGNyjuGGwa74A6HWjOZlSKIcqHKYriLnluVCA3g
         KFHZU/2kqqQ8Swy/RJHg67lhuqY6nr6EEyjO79YYRVFY5h0CJFJOj9jWUGoeVjYRfder
         bB5NwJzovXwvSqSCXBR3SjDkPoHGqo5uBqQkvBgRlrKd303CXrgYWGvV1z3ibdf6+gTJ
         Cxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l67ByTuTDoxE8yyQ8qcNrrbIp/HYHnBIsJgxG8dbjrI=;
        b=mzM7pQcQ3gX++TL7274x3zAbD1XRA9CN1uaRsNk/GTxGuKjBwm4mKFcwx7NM0ia1r7
         sixhIAGsRrkgjPMkpeXPjn5vFtj4edYoAz48IzHwefsyYhblyx63zMiW9oOTdDjhalAo
         15KJQ4urVnFv2eZKEZQm6Sv83nvbt/uCuuR9pVFC+wpC+O8gdDZ5YlelKFEJ4L1CKZOu
         ExBnaldk72lrw/10E2jVj8hkeikQgrTptAhj9cdps9XbYzsackzEYN4HOuGMTHw5WIHC
         En04AGhTcAyNU650R34LNcipYIgISuBVKXEP28bs0227z1jEqGxsHJIEnI7/BWXVScww
         78Ng==
X-Gm-Message-State: AOAM5331BXaPljTGXgHeBkr1q5TGMCGpt2QQRAe6S0Mkj7FtHIbiMHSX
        YSjWXH1U3wbhq6IM5QjjY/QiftuDgduObi4P
X-Google-Smtp-Source: ABdhPJwA/wyTJH2N1EhbJuFMeD0itT6fZEu7ZC6i1v9R/3IFDDjXAZRFolYivRZ28QLfDFgNNpXSnw==
X-Received: by 2002:a17:906:7ac9:: with SMTP id k9mr37393045ejo.229.1620812521113;
        Wed, 12 May 2021 02:42:01 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id p22sm17068261edr.4.2021.05.12.02.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 02:42:00 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@redhat.com, Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/1] block, bfq: a bugfix for stable merge
Date:   Wed, 12 May 2021 11:43:51 +0200
Message-Id: <20210512094352.85545-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this patch fixes a bug I've found while debugging a failure reported
by Yi Zhang [1].

This patch seems to make that failure disappear [1]. Yet it was tested
only together with other debug patches (which add logs and invariant
checks), so I don't know whether the other patches influenced the
outcome as well. At any rate, this patch does fix a bug.

Thanks,
Paolo

[1] https://www.spinics.net/lists/linux-block/msg67840.html


Paolo Valente (1):
  block, bfq: avoid circular stable merges

 block/bfq-iosched.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

--
2.20.1
