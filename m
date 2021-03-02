Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D2D32B6BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 11:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbhCCKfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443754AbhCBW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:56:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C4DC06178C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:55:36 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d8so2491740plg.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pM6mjp7Djg5f4SfTpdFFbjFAr1aFF/cRYCS7fpxDU34=;
        b=FC2EN+w/cXbE1L5iUZKDDMVf/ajqnUFTPcgwXMyPPNXEisxojZOeWN7kI0PcCrDfl6
         DnmHKfwqg1mNdwfVn/hxeNTQzLD/KtbPCyYfuU3gsMwMd+bJEEnrDT3cwWIVHDzz1S2M
         VLtUVgDXio9VHYft98UzqJuc3DyDrhGVuYI7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pM6mjp7Djg5f4SfTpdFFbjFAr1aFF/cRYCS7fpxDU34=;
        b=Ydm06OPa4jkhrRFug0VaE2QwM3uutIOmP61p0Gr8aYO4mO58ODY5kzXlG7jOFOQbot
         +NLk8Z1PZAqQb2L6k8NCXwyGW4WEYm1jWTMGTDi30ONeVDgxJR1oFGZs+nOZ3o9TC1fW
         syl379Y9L1Lrm4enZ4y0R0iBZ9/3CEr7QGcWxll4MjI1kGD9jzySsceJafPiWiMWJ/Uq
         7NubgaxI70MrlbQgHMkYK1rpHnIQq2yHCUic5eOiDifEdbY0MNX0IyIoTPcZnB6kYfxy
         cxY4s5/Fns58VkTFQ00+VTqCbMX5cFfG4ebW6wQsE1y9SWWn8j/Vo1Rlbg1SYI6nzz70
         qULw==
X-Gm-Message-State: AOAM531MxUggtS2bSxl04EBMYY5lNVHBSB3C23XMzN1ldkXeGEsi2ixL
        C8QbrNAvnDJaQ2Kzhx6u0P9g6A==
X-Google-Smtp-Source: ABdhPJzx1XXVtj2bqsB5LrqzwDcX+R2r7mCiMlPMpiva5NGwceFqxpHsSETbyRK9dWNkX3ZA3qqFnQ==
X-Received: by 2002:a17:90a:8d84:: with SMTP id d4mr6628292pjo.56.1614725735845;
        Tue, 02 Mar 2021 14:55:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p23sm21587294pfn.204.2021.03.02.14.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:55:35 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Yan <yanaijie@huawei.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] gcc-plugins: structleak: remove unneeded variable 'ret'
Date:   Tue,  2 Mar 2021 14:54:20 -0800
Message-Id: <161472564886.3871405.3468382493884029994.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418070505.10715-1-yanaijie@huawei.com>
References: <20200418070505.10715-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 15:05:05 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> scripts/gcc-plugins/structleak_plugin.c:177:14-17: Unneeded variable:
> "ret". Return "0" on line 207

Applied to for-next/gcc-plugins, thanks!

[1/1] gcc-plugins: structleak: remove unneeded variable 'ret'
      https://git.kernel.org/kees/c/b924a8197ac7

-- 
Kees Cook

