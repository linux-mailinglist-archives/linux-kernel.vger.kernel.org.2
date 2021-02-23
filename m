Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229A73226A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhBWHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhBWHuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:50:50 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0B9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:50:10 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id ba1so9341705plb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 23:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=1D4vAhvj2G8Kc7c6D67wbQPCXJsVm3M9E2tQ2CYNB2o=;
        b=dJrIJ9D+6Iv5KPwX0hIV4hHwcrvvWvAU4lC02WQJXnHDiET5KbD0JyA7ecfF9xZ5hW
         wMWYqD+HLyUOt/DiYeg1R8rPc0CUJutlf1bz8H6ebtF/BeWHScnSyrns1JF/CyDe3BM9
         ZlHjVco/x2mZPIcZBeaYEXfdqdTrzpAxi1t1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=1D4vAhvj2G8Kc7c6D67wbQPCXJsVm3M9E2tQ2CYNB2o=;
        b=XHt3/3LvZYujCN2JJna3Ep3Sw8oDCcBgUwDQnB711SE+HIu1LTYnxNm6AHmRhmgkxH
         z2s6+ATafxvhko9aqN4/0WbBcqUfkgsFWFYDwzILIzHwezGArKLSagy8ja5P8YuKbo7Z
         EtDu2EKIQATWzTeShesKmXc+p9RCxcjc/13flb4RVAAslcLspz8FDlfKMzcdEPX48sIa
         ioqQYEVoeSPtgoedVvPSCj2S+D74EGy1XQpgeEZSF4HFLVFUDsYRtQdrUjEkoWjUkHB4
         tuXQh+CJl5XZh3EJp36vEvdvg2h3ePyIEFlYKCnlVd5do5pxAnB9Sm/9h/hcO+caj43U
         vi1g==
X-Gm-Message-State: AOAM5304EXoy6VCIij5naSPeJlwdEAkyP7Ej+8v6RUCpEWJOBHIZtLtP
        tAoy/gHmlLRINy1op7gXy4gkgQ==
X-Google-Smtp-Source: ABdhPJz7/0rm3sM2c2w5O1iH+FdR4IQ9LwL3+VosSQTl/HPmWDw6XqMLz1+z5wpKPS5tcJ07x9hIJg==
X-Received: by 2002:a17:90a:ad97:: with SMTP id s23mr27990760pjq.212.1614066609682;
        Mon, 22 Feb 2021 23:50:09 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:68e6:d68b:3887:f216])
        by smtp.gmail.com with ESMTPSA id k5sm1992563pjl.50.2021.02.22.23.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 23:50:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1613114930-1661-3-git-send-email-rnayak@codeaurora.org>
References: <1613114930-1661-1-git-send-email-rnayak@codeaurora.org> <1613114930-1661-3-git-send-email-rnayak@codeaurora.org>
Subject: Re: [PATCH 02/13] dt-bindings: firmware: scm: Add SC7280 support
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Date:   Mon, 22 Feb 2021 23:50:07 -0800
Message-ID: <161406660792.1254594.1241141672101768079@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2021-02-11 23:28:39)
> Add compatible for SC7280 SoC
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
