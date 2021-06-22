Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4213B0571
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhFVNHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFVNHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:07:17 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B124C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:05:00 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d2so30060182ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jtJ/PpWosUWKo9N81UZmZyqeDEJHdOfHRjcctVezzbk=;
        b=eKzTIy26AtakD56NIBxhuUgcUiQTkUNTXyIzAWRUQm95eXokirCQKgb9dL334GREiv
         eAVqp2Gz3FB0fbdN9E5iw0JvZInbFplh2qmcQ45PiCcXfkcq/FL0vXOB1oY62wx9YfTg
         t+59CWR0Ac5ssBIMzVb3nZEHknMeyrxbAjDq3MyYhZ2ofy9AY0yT+7nIlxqgiEwYSQxI
         WHF+ImfF0IZ2dWDJ5TH5Tke9A6z/4vjAQJOpv53AM3cOqYlMyipg0O2gTcYrIUw2tb22
         B9izBM/yMCS/1br0A+ld2/S9/T9BNwBdEt/kJ/ftBEgO1kjM8AiIgWmAJI0WeeppZCqW
         07jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jtJ/PpWosUWKo9N81UZmZyqeDEJHdOfHRjcctVezzbk=;
        b=gMbMjhpN3PVwtmOtohlnkVg7jSqi9k3bEZhqyWHtd6M+tBLQUj4o8yrRNcSaMtcFKA
         g0j0m3tW7WbIFsOZTuwHzMAnNYZiI+9CLK2Oux8ceynJEYYun2JUkK5Zsk/g1kCm3kYR
         o+IZUn+BhHexn+OQ6Cqw0NnSUPTyrILoBmOG8GebeaDX69J3YyvXPH8Nxl7F5tpSTLrA
         i/SU3HpBpDVk5V5oOLK03HYNvzoeDg1Nbu3jmbNRHuxmBZ7/oqA4E6ANp8N3oF0Gz/ru
         /at8IXDbj6Vbhx0KF7GH0ykJNNxflE+PKRFN/gUJKvYTqc+h98+UR6WBN4HSh52KuG9T
         2XAw==
X-Gm-Message-State: AOAM533dDdRCH05PE4Yv6lcD3K8S0BdhMAqCz2r6n+x+Ufkqe7/a6XtE
        GgRqJnlZ7rkBCIqVP7AXTE+Ilw==
X-Google-Smtp-Source: ABdhPJwqtjgiYlFpJtbIhAGYBnmYGr/K1P6uQeS1+VZflSi3wN/oQxXrINtgCULZAFXy5r8rRmyWjQ==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr3103960ljk.447.1624367097162;
        Tue, 22 Jun 2021 06:04:57 -0700 (PDT)
Received: from jade (h-79-136-85-3.A175.priv.bahnhof.se. [79.136.85.3])
        by smtp.gmail.com with ESMTPSA id j16sm2501090ljh.66.2021.06.22.06.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:04:56 -0700 (PDT)
Date:   Tue, 22 Jun 2021 15:04:54 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [GIT PULL] TEE reviewer for v5.13
Message-ID: <20210622130454.GA2196996@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this patch which adds Sumit Garg as TEE subsystem reviewer.

Thanks,
Jens

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-reviewer-for-v5.13

for you to fetch changes up to 9600948a2e919cabc18f196373e9f60c32bdb44e:

  MAINTAINERS: Add myself as TEE subsystem reviewer (2021-06-22 14:42:58 +0200)

----------------------------------------------------------------
Add Sumit Garg as TEE reviewer

----------------------------------------------------------------
Sumit Garg (1):
      MAINTAINERS: Add myself as TEE subsystem reviewer

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)
