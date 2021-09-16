Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E7240ED55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbhIPW3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240826AbhIPW3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:29:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630BAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:27:54 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b18so22979806lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWXkBi7iY7atu68gT71ZZEaVf2W0kM1WsfKKAtmYUFA=;
        b=AopwVjCCPIGZ1r8vZaX1wkBl4BenfCnJiGN3pnowbFamFiXCYBQiniP2FDA45DZXKK
         e57L/a0KWLcKqPskoX13b8te/WxC60Ip8r7V6iF/tGE5T8ogbRE0q7+onwdx8yfdpz7k
         Kjy1vWxiE8fvxFj5qWrfAJEX0M82XHIjXwFB1PLSlqr5CGbDqgtW67RaXoDo8O0PFzGo
         18v3/cuMiBVZjpeohh07jQLJBhiaaFdogZWNb1Kpdkwh4pJQq+Ycyiyaw5viC5sHkkAo
         JzD2PJAOS+nwpOFsmYCRNI9S0/iCXI6wgJ4+8cunq8JDU9D8Fy3AFscbM2g40LjryirL
         l1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWXkBi7iY7atu68gT71ZZEaVf2W0kM1WsfKKAtmYUFA=;
        b=LZE7ktsJSOJTikBbPt2ywtb/E/NfnwG9sJrptNTzHIhcbTyWJRrDmN3MIr0maW1mrd
         iImjZktrbQCpkbx425xaplhRD8iqaOMPpHh5D612mxSr7hHF4xMQ+o/miSSeuk7iZ2ql
         JUOOFn5OT3HGIl0SXGcY0vTY9ZRvGqRe1Yc2bfsbY1qTfApXRHpt592dtqQrzT4m+HnL
         wcSOU0Of/3krYqjTGgrw06x+FEmUWzSWG7z72iCh4MSOLJi51EL5pwzH8wJXCNQZZclB
         XnsH9CRsVdEgRbNpHdIx6NLKURZkfRef5VQQc2YF+W/qMVQwXsrOXN5uDLBvTHRz3rbn
         VAsQ==
X-Gm-Message-State: AOAM530wGKz7jjnFpgtkfJIR6UAM1axwYZLFWAfMz4dkPYyC33VyFZDf
        Tqv9F6KkRg3SvXBUSq8c4oNbDI2c0tOEJPDL/WBF/A==
X-Google-Smtp-Source: ABdhPJxKXtIOidEmaWHCX/zod07OcGynK0tXF1rBtyFqK0cUDFLBboUEyUTmFZnMcybZdcVgrn1MRaeuUS42qDdDBUQ=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr5728985lfu.291.1631831272820;
 Thu, 16 Sep 2021 15:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210916170528.138275-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210916170528.138275-1-krzysztof.kozlowski@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 00:27:41 +0200
Message-ID: <CACRpkdbNfXGfK8Z0nhMjMfnp4UqJV2p=eVjNyH8VdguGu9Ea5w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_bcm: remove duplicated brcm,bcm4330-bt compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 7:05 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:

> brcm,bcm4330-bt is already on the list.
>
> Fixes: 81534d4835de ("Bluetooth: btbcm: Add BCM4330 and BCM4334 compatibles")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Ooops.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
