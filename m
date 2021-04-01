Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586FE352161
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhDAVOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhDAVON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:14:13 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC742C061788
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 14:14:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bt4so1788495pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AbomE8ky01qR1Z9SBdGuAWnmdVOm7eL8+7fxREb+Hlc=;
        b=enGK1gWTmqo4sAFtbviKEU1c5trz7yPEAkvErUrGPfI4DPYCNFXKC6IN9cJQe34kP8
         kg/pFklYyLZmOx3F/Qejag4gScfEwSzUjq259VRfJOQcYd8fCbHSkUZqmTNNRrpssQXK
         +n4xOpP/rsmMY7TFbzrNgmCUfmMoO+kkUKJ4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbomE8ky01qR1Z9SBdGuAWnmdVOm7eL8+7fxREb+Hlc=;
        b=GTYnj6xR1d1KRsVpdNmR0IEwz79FP+6PdPvBn36/mD+sTGQ6VPIjBcJ1Cy0+3gmmQv
         QtN2J2qSYuBRqt9RPh+IGiATUL5SGGk0DTZDiJay4342cCuY3iD3ywLzlvtd6U/SrdFw
         eDDFuGGrA6zxH/2fqBuZoRuVYsj3gk1TqA82TsQqPouIC4sPVEbclQ5tj1YsMU889xy8
         dG15f/gHIlDWxbqn3UrgEh/32RGYLiLOwngjT0rVv4+0/hPC5tjPw9/xujMHatwpSfnY
         jBMA3/rBKfH7ddOa9tjS40sYzL6iSJSxx5qrm+ksqVK+Rj7lJkFwPcsP/JCQdwoITvMV
         ZZUQ==
X-Gm-Message-State: AOAM531AgSOLHbbBRFU6ahyZ6E+ra+Y0aMhAxZP4yfcRLrCT9AqD3lxr
        y5tFxfVq2HeyfNDJFVjVF9NkvLcyMYkX7g==
X-Google-Smtp-Source: ABdhPJwvgkBm7CXEZUJfc+NWLeNWZkU2qdyMAmmNlz1d3AmgDsda4RYuAdQCQr/tZty/+HOCHY4+yw==
X-Received: by 2002:a17:90a:6708:: with SMTP id n8mr11098340pjj.174.1617311650543;
        Thu, 01 Apr 2021 14:14:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x4sm5952907pfn.134.2021.04.01.14.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:14:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] overflow: improve check_shl_overflow comment
Date:   Thu,  1 Apr 2021 14:13:24 -0700
Message-Id: <161731160130.2687418.11028495096127465037.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401160629.1941787-1-kbusch@kernel.org>
References: <20210401160629.1941787-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2021 09:06:29 -0700, Keith Busch wrote:
> A 'false' return means the value was safely set, so the comment should
> say 'true' for when it is not considered safe.

Oops, yes; too many inverse negatives. ;) Applied to for-next/overflow, thanks!

[1/1] overflow: Correct check_shl_overflow() comment
      https://git.kernel.org/kees/c/4578be130a64

-- 
Kees Cook

