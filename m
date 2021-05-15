Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55F1381993
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 17:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhEOPfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhEOPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 11:34:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695B3C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 08:33:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id df21so1873344edb.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aQBg6T7d9Y0+Xn06ivGBtdjETmzJrfo4DD7Uy3V5ikU=;
        b=DRbNvSfKgW7wWtguAL+RxF7O56fKmVFhWoka97yCLnnKqAFTdsPnQQpp0SkDq0lHSt
         legr+bRzSV8Uab51GrQrScomILgWMDQ4VUOoBSxngt4JR2QUKJIdJJvzFz9cenQvdCCX
         OYsFtNsrAB29fXqkJ6oFND6+seB06/wLir3rXG5VX58upevML/D/uRuxz31Qv1ugSEVw
         NOhedLuA2m1Q2fom5jp5FYJNGzEzvmmzsH0kOpct+Xt0gSELZ8urO7N1WG9pHzrFfUSw
         v/HFfosdmc6MnYRsWzGyBY9S/gu3yg53BpNE88/C/s7Ibu84aMZLLbnKGcek1Zwu2zCz
         IG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aQBg6T7d9Y0+Xn06ivGBtdjETmzJrfo4DD7Uy3V5ikU=;
        b=sMNFhZYrPE2ejSwIa0uGtQZmHe7K5eGVde5t8H5ytLJacfRuzqAAypsbbK+y2NKpwM
         ef5ATj8JYJWuiDf6F6k58v+UJ3zRVxGgUzdkAtoc6nD7OgmqhkMUCAXyWgKJ9XlQYO+s
         gs+LfAKP2mw3SlsBNZR3GPRhH7t2064Z+KYUBIjETfri4BFs9bjg4eiOmMC0dZk1fO7c
         GuiPydJ61PlaiY1CEMBxudk3Fek9XhOmwAIrLCro5CNl/TKOpnNHAch82I80xeoSETsh
         wyssD4pkyKQLKzwyX2oIhMgJ3D3LpG7PJgLb3z/3qK5mpLrcfXh2Pil2g5TfA+LYc5eW
         X5gA==
X-Gm-Message-State: AOAM530Lcz4/MoG+PIFi0Uu9EgfB+/fKn7Kg8MhkavS/6Kcnkn+fqSVF
        Nyome5hUU+zlZNZMD8Po6vFVn2t6WY914veYwPceOpuRfZNUKg==
X-Google-Smtp-Source: ABdhPJyG8U4pWNq3N7MOMr/g7XDUGtoXONhaMNiF4i2L9BOLCdLQGGXSQ1KNs01Mc13/nvZvO2PwVzXy3avS5gD3C/M=
X-Received: by 2002:a50:f388:: with SMTP id g8mr4040008edm.236.1621092821757;
 Sat, 15 May 2021 08:33:41 -0700 (PDT)
MIME-Version: 1.0
From:   yong w <yongw.pur@gmail.com>
Date:   Sat, 15 May 2021 23:33:29 +0800
Message-ID: <CAOH5QeCyxtnZ8UYci2XM9hTnDb7KDy+L2RWaG3u_KMEaNzV8Bg@mail.gmail.com>
Subject: How to calculate available memory when zram is used?
To:     linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How to calculate available memory when zram is used?
Available+Swap free memeory is obviously bigger than I actually can
use, because zram can compress memory by compression algorithm and
zram compressed data will occupy memeory too.
Is there any way to calculate available memory accurately?

I think of a way is to count the compression rate of zram in the
kernel. The available memory  is calculated as follows:
available + swapfree - swapfree * compress ratio
Is it reasonable?
