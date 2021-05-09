Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3880377760
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbhEIPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhEIPkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 11:40:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC56C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 08:39:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 69so3320810plc.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fex-emu.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oj0cxtHt4k2QsOXZJ1mqPuS+LtZjL33yvcuTzOU4i9s=;
        b=iPAkYy0A4N8s4fD0pZoq7FzyT0D+8DjZXwCk6RYtKFLK7vSjHvVnOIk+ObDRKyOj50
         tSp4hbp0MFDRo4U5V5RjC0lJEhqmUhidM34nw1H7TTDHJR3lsbgzdrb86iUWYsekbGoA
         IjlqnNTtyNj3z2m3qndB7GPdKpB6Uirek398l58yxQdH667l3ySPwwKs+ER37NXLZtqC
         f2Xyzakp4dd+55nb7onMffwEfH1/NxuCWefIj3hJ+u6HLcVBWxZKEuHI+/5txKXomSz4
         wo3ORaUiHQ/DnKM8g+YJfNB0mQx3KRG9yKYxbgcP3Z4l2e75E5edYfzZyz6SyM8G5RmA
         Pj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oj0cxtHt4k2QsOXZJ1mqPuS+LtZjL33yvcuTzOU4i9s=;
        b=TMeDA9t7GR+OW+S08KvGznSfJ+71xsivUV/JEFrpYJAap6g1HZWhBUHvwaLrduUlTx
         ZH1rw9PZRUvreQmxRCyWtv1srexzDyE8cCK1duhsEt23FXK42ajH70UU2fn8ICZ827r3
         8cks/lpOppctVc05RvgRqZSQ/9Ogi3KyKVnc9RcRdPil/w50EzNLQA2bcL3Bkxd/47nD
         LvS55ougg7bPB3DLPnvstZjQqJFdxBwySl4gI+cqd9/avWOuQXHcUpnyluy7LqxaC48h
         5y0mhUciwm1i8YEd3gQv99XK/GjksmrdSJt7XNkx/XNOLhCMC2R+R495D04EibqHZFO/
         rgXA==
X-Gm-Message-State: AOAM533KoAWz2/8NdI4N6rHoacuviaWZQnqg1m1b9oHSfinZEnzcCrEF
        oD2989H0QlYkScK1etYhQ/doDg==
X-Google-Smtp-Source: ABdhPJzuLvXgVXIw+/LHFTPK/5u6YP6h1gj2+taNgTrrzE8i9b7+EhMUEJXEeJqGgSCKFtZKjzuPGg==
X-Received: by 2002:a17:902:7c94:b029:e6:e1d7:62b7 with SMTP id y20-20020a1709027c94b02900e6e1d762b7mr20240359pll.29.1620574750226;
        Sun, 09 May 2021 08:39:10 -0700 (PDT)
Received: from localhost.localdomain (76-242-91-105.lightspeed.sntcca.sbcglobal.net. [76.242.91.105])
        by smtp.gmail.com with ESMTPSA id x27sm9505403pfo.216.2021.05.09.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 08:39:09 -0700 (PDT)
From:   houdek.ryan@fex-emu.org
X-Google-Original-From: Houdek.Ryan@fex-emu.org
To:     robdclark@gmail.com
Cc:     abhinavk@codeaurora.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        kalyan_t@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, maxime@cerno.tech,
        miaoqinglang@huawei.com, robdclark@chromium.org, sean@poorly.run,
        swboyd@chromium.org, yaohongbo@huawei.com,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>
Subject: Tested
Date:   Sun,  9 May 2021 08:38:42 -0700
Message-Id: <20210509153842.124974-1-Houdek.Ryan@fex-emu.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210508195641.397198-3-robdclark@gmail.com>
References: <20210508195641.397198-3-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested this on my end and it resolves the 120hz problem.

Tested-By: Ryan Houdek <Houdek.Ryan@fex-emu.org>
