Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31AB389A04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhESXps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 19:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhESXpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 19:45:43 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB86C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:44:22 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id m1so11976668ilg.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jv6Sw1V79WB30glKJR0nl+lR8QaC1yMGOJy0bSM1IOk=;
        b=xso1mlTcQ9Dv14e3OE+DJYqggXBIjPgXN6xmP/LaoKgJVJgbLwxNg8InxI4yyoMMxS
         yO+H72FjhZb8xhR38gAW9MS+/5Euj50lZbKowVrDLGmJwxVlHgWWCS7rdtzgZ5TUE/mC
         80J6Fq7KvYybfI4CH+JkXJT8taWwgb/ZBWnwvg6RyFGttpmz+bvaCO1zxDLOd+osVnRK
         sSRZqM7fi24pGf9p+CEi7x1mOt+2sFtU+OHr3sUuEIUROuq4dhh9xLzhj9X7u0omjqu3
         kj6I789m/lwcY4yMuThGHTlWybkvxydRXrLLCgv+tPYJOZ+ldPC6+na/xsEYpoW7JqT6
         LinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jv6Sw1V79WB30glKJR0nl+lR8QaC1yMGOJy0bSM1IOk=;
        b=FbVB7uz5RVa9ACiZwejtDctB78qRu0vxiLri8HpZNAEhsda83FOQ3Eru05lQtnw9G5
         KH/RiGu4H2+E7sk5iIF0TavUuPT7NW+ntEo/F1seI8SaDOdQEGZon9VNsdz3bAGKkYuJ
         3K22WZKaMBo9IdO+PFwtwJbvUWK4nsDPEhECI22DsdtE9LfMsZUqgTgpNXS59SbZUSir
         7Z8+DQXRKWN2C+y8/6QSEmVqqQszZlBDegM44dJ9ZHkxUATyVo9BKzIPE1IIsXamsR1H
         JxnGSmx7C2lngVZch8WtNaTWhOQj/ug0Wdpr/xrwjU2WiMbf2SEDFSojr5KBVT0hy2X1
         MW8g==
X-Gm-Message-State: AOAM532dhn/AkawFtLOtjsEP579BwWyGB0dPDjpO9LHb/QB5HgAKugqw
        uQ7tk66KpqJRWw39TUdCDiF85g==
X-Google-Smtp-Source: ABdhPJyeXrPCY/hm4zZQqBWVIYv7zfFq0YrOehJN0kGa+hS4iPOLH9Ddqzn7NqV1gKmuJ/FkYYAY2A==
X-Received: by 2002:a05:6e02:1348:: with SMTP id k8mr1826393ilr.104.1621467861753;
        Wed, 19 May 2021 16:44:21 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id x13sm945415ilo.11.2021.05.19.16.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 16:44:21 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] remoteproc: avoid notification when suspended
Date:   Wed, 19 May 2021 18:44:17 -0500
Message-Id: <20210519234418.1196387-1-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I added a cover page for this single patch to provide a little more
explanation about testing.

I have verified that, when this patch is applied, the IPA driver
receives the desired crash notification after the modem has crashed.
It recovers properly, and functions correctly following the crash.

However I have not tested the specific scenario it is intended to
fix; that is, I have not verified that the crash notification is
delayed if the crash occurs while the IPA driver is suspended.  If I
had a reliable way to do this I would have done so, but I do not.
I can only argue that it *should* work, based on the way the
freezable system workqueue is designed.

My biggest concern about this change is that I don't understand
other remoteproc users well enough to know what impact this change
would have on them.  So I am relying on review (and testing if
possible!) to evaluate that.

And finally, while this is a very simple (one line) change, if there
are other suggestions I'd like to hear them.

					-Alex

Alex Elder (1):
  remoteproc: use freezable workqueue for crash notifications

 drivers/remoteproc/remoteproc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.27.0


