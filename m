Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92D35A4B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 19:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhDIRev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhDIRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 13:34:51 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A701FC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 10:34:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so5318085pji.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ykf0tN0fWsKekEr13nX5aHTUFQwxAERXijWEaE3zFI4=;
        b=J6nBuEDwyCmL5qm1axZCHQCds7sgBxerm5CHGcBTHAD6EgEopdHJRprsxdzmy+DDbI
         UH8GQs5X+I8ITbPYaB7KFFcbZTD5xrQ06a42MBGwDKYCGCYOLcMqyubaUr5Y7r7iH0KL
         97jLe+v3bb3J1FkmhfYGyNMZLxQNgY6+KSq18mXy6XMEP6KhtWIIB+3lj+rTl31EGd7L
         9V4Hdz2aK9R0uBieFpp3lWqROkwDdrnYxOmpcwoUxbOVp60gv4+yITHHuntqW/TCwGUR
         OZM4bj7FjhAyu8opsaWmTocQ9STSO2KZOwPgOux8ggJmoLjDpTV1r78/hWPxynkloT07
         sm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ykf0tN0fWsKekEr13nX5aHTUFQwxAERXijWEaE3zFI4=;
        b=deylQIX2Ur2/pktUMt5LCK463oZz+FngPIGMgr3RWLIzi+SFiCTb7C/B4O1hqkcFFA
         UB3J/HJnyMQop9h0onoN63Y/XjnXLcTEhxttcKM+q0o+DvJCXS86mTzVpaPSZgh9LgZC
         Zr6FLQGlHBH4kTovmFlYlGmKI9jAcyqwRSydiI994s295WYsbu9MVtkQ/5h5JMHD6VyS
         L6kFU5x0EWdFHKA9Buds40BhLh/mq3rnNrbQHt0gjnZyjOV9angZO+crbMPMrV1fMZ/E
         jgDDzqlpvdQLZJPQTiuq24Rnbz357d4UJ+JXmTDaNrAkA/O+RuRk3R2JpFGbK/hKAuRe
         +//w==
X-Gm-Message-State: AOAM531DUQGBBQSUTwXf4b9eWVsE782mYz6P02fhvbrxfnsdhXCHW7OT
        w6Jli1C4rqjB7PNyuggXYaU=
X-Google-Smtp-Source: ABdhPJz+gqjEQDOUKJ/CuBIonQGc0M8HQ/gKNUJl1WFcOCYIsvCEay+nUk0EF3JhTe72LXihwM1ttQ==
X-Received: by 2002:a17:902:9304:b029:e6:8d24:b5ce with SMTP id bc4-20020a1709029304b02900e68d24b5cemr13617759plb.27.1617989676222;
        Fri, 09 Apr 2021 10:34:36 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b1sm3486646pgf.84.2021.04.09.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 10:34:35 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     phil@raspberrypi.com, stefan.wahren@i2se.com
Subject: Re: [PATCH] MAINTAINERS: Update BCM2711/BCM2335 maintainer's mail
Date:   Fri,  9 Apr 2021 10:34:34 -0700
Message-Id: <20210409173434.3036128-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409104448.12259-1-nsaenz@kernel.org>
References: <20210409104448.12259-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Apr 2021 12:44:47 +0200, Nicolas Saenz Julienne <nsaenz@kernel.org> wrote:
> The @kernel.org e-mail address is likely to last longer than the current
> one, so use it.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> ---

Applied to maintainers/next, thanks!
--
Florian
