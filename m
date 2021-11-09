Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423A744B8EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 23:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbhKIWsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 17:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346381AbhKIWqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 17:46:13 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ECFC014B1B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 14:20:30 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u74so1401929oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 14:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tM5hwtc8qbA0vJnA/spVuUcAKq7RJsV9X1LvQfoH/k=;
        b=h7vZVQnWosqI2nzh5w/sb5vYzdU1TiyAsKdqbBralIgonWiGEc5UbZidtSleiF0hxK
         zJ+qaZ0+PaAS4lh02MOHHE9xLEDhPIp5BQxA3fx93Lm2208vnCLIj7G657nJ444On2Qo
         j/9VVwemLZGIoyT7NPEAnF7viu+czcGHQtnzxoot7eP1RbAxY/7BMsqntlSfVSTZMeAX
         9X2EOwbTvPS7xZohylFH8EdHRVWLpfu2A38P710onxxQx1QbkeMLPjBEDjcEE5pe978H
         n61UNe1JttQKTk339jLavJ+Y/l+LE/Gqos+i2AV6i3KH/A71sNxsfwvIShZJtWx3kHEJ
         qG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tM5hwtc8qbA0vJnA/spVuUcAKq7RJsV9X1LvQfoH/k=;
        b=2YBxgkhCu2Gyvt9LlU8/h2zZ19oFCn2myP4/y9jJaUhcjSId2c8ys5H6R9Q9NP5pni
         gYacTU+kJxlFwrK34jeEz4ep9wNY4MdDqeRhslzTMzPgYNWKdQ6dd+r4pm48SP8J3lu8
         jkHayoTnO/bS80KgEZFlrEGfv5UUC/x43nkTJnzCHvVja2U6i9TwfluG8Qyyt9WJxwp/
         wN8VRN1vlg2xB6k21XhrCNu0fhfbLyKVRd7udRd2NxdbXMYsSRzNjYxpcp4luMsk8VpS
         0LpCVyK+kGjEhNRnK33+E8A/MkH9xnD4BBfFoGRaK1ZFG6ZZUojsGRDyS78EW/6v30WQ
         /qQQ==
X-Gm-Message-State: AOAM530Yj45cLERqKakXDGtsu4kV0YgQn8t2a31IPD+uOaB4SbxaW0j9
        pGUMcOHslI8/ozo9/mP0oo8wLJcPOdDoug/A3SDKHA==
X-Google-Smtp-Source: ABdhPJwS1A/efTpFOEzGt1pP7H+1n7DSmf2TzXrZeZBd93vSJksHoW0cKUO1zqPxehATkVkot2uor9tquBnaVfR43WM=
X-Received: by 2002:a54:4791:: with SMTP id o17mr9294816oic.114.1636496429410;
 Tue, 09 Nov 2021 14:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20211109164650.2233507-1-robh@kernel.org> <20211109164650.2233507-2-robh@kernel.org>
In-Reply-To: <20211109164650.2233507-2-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 23:20:17 +0100
Message-ID: <CACRpkdZOuhA8w4CYetBKfaZ_wKT4QgKe=bffdYDTB68ihVE3-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: Support using 'mask' in making device bus id
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 5:46 PM Rob Herring <robh@kernel.org> wrote:

> Commit 25b892b583cc ("ARM: dts: arm: Update register-bit-led nodes
> 'reg' and node names") added a 'reg' property to nodes. This change has
> the side effect of changing how the kernel generates the device name.
> The assumption was a translatable 'reg' address is unique. However, in
> the case of the register-bit-led binding (and a few others) that is not
> the case. The 'mask' property must also be used in this case to make a
> unique device name.
>
> Fixes: 25b892b583cc ("ARM: dts: arm: Update register-bit-led nodes 'reg' and node names")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Cc: stable@vger.kernel.org
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
