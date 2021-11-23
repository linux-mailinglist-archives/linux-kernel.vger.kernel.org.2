Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF7945A928
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbhKWQrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbhKWQrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:47:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89647C06139E;
        Tue, 23 Nov 2021 08:43:03 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w1so94880762edc.6;
        Tue, 23 Nov 2021 08:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MC5epeKImcx3/KQhLYCZ1HLgX1y87eAw5+H5JNQv9sA=;
        b=lFopLDuY6MPMp7pIgftj6vLLHx6gwKafB2NAA3QebNbR4G8rQoWE+xXn1ZNViGOqPE
         LBILL9hVz83u8+PUceyxvc5xIeneoZ6NfOHgoHtjbeTfWDHnYy0Ug0gn+KsvcyVXY0Ci
         GANzc7vFdpFCe+aCCwqtJSxkIZR+uT4nJYlXxzib+9RLLxPTTaBUYHwXNrwf1gwPKnEv
         sl6oTBhgjLZghpGlIDd0Ztz0iEbRW8HwI7mfY2kcU5yfVWpd6OqqfEuHfYZdzzi7INrn
         hnDJclq9jNI9Eo2FLSym6dpNL2/kUxi32FxPwjR80F6zFDCNuQcH84OZobb5M6ZFm89E
         n50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MC5epeKImcx3/KQhLYCZ1HLgX1y87eAw5+H5JNQv9sA=;
        b=n8YmLudPX+/1tMHSBYyNo08TpVGEcqjqw4qykQhSQczhJTW0Ai4TdEP/+EM/Mpp3SG
         YfRuGekYh6gq2JfUChhRU6IWc8r8KdHGppCHwJZYGQBFpjwQsWqv2Lkx4yf7tk9RxqB/
         aJ1cjmlrw3FhiLhFi+cFcD/Ar5HI9hkmsT3jDg06me34SoIslF/BIka4uQhtjR0uPen0
         H82WOCcrluANtQoCUlg87Wj+UwWx0x87iekI30NMfhOHIekSYLwkidhG5MGVRcejPpzf
         zQEr0QZHu5UVd5J4aCwOZvLmc42y9ZFCS12npduj4fd6zW8LswH6Q58xs5R/4uZrTBtt
         dKqw==
X-Gm-Message-State: AOAM530f/AF+WbgtuBcRY/3MBy5XMABLv9bwnCBsFArru/CJDGaJ+SG5
        bymU5iddtgnv5KFmSpFIgNs=
X-Google-Smtp-Source: ABdhPJw8TCJCwiaCGpqcYo8YHmkWjG3beYZVJAdIgmxdbcP1nkoBberCXFC9tmHu6n1fgwJ+WIwoqQ==
X-Received: by 2002:a17:907:7850:: with SMTP id lb16mr9444354ejc.67.1637685782143;
        Tue, 23 Nov 2021 08:43:02 -0800 (PST)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id d3sm6074046edx.79.2021.11.23.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:43:01 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michael Klein <michael@fossekall.de>
Subject: Re: Re: [PATCH] ARM: dts: sun8i: Adjust power key nodes
Date:   Tue, 23 Nov 2021 17:42:55 +0100
Message-ID: <3138437.aeNJFYEL58@kista>
In-Reply-To: <20211123103219.4y2pjywt2uxunc5s@gilmour>
References: <20211122213637.922088-1-jernej.skrabec@gmail.com> <20211123103219.4y2pjywt2uxunc5s@gilmour>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne torek, 23. november 2021 ob 11:32:19 CET je Maxime Ripard napisal(a):
> Hi,
> 
> On Mon, Nov 22, 2021 at 10:36:37PM +0100, Jernej Skrabec wrote:
> > Several H3 and one H2+ board have power key nodes, which are slightly
> > off. Some are missing wakeup-source property and some have BTN_0 code
> > assigned instead of KEY_POWER.
> > 
> > Adjust them, so they can function as intended by designer.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > [BananaPi M2 Zero changes]
> > Signed-off-by: Michael Klein <michael@fossekall.de>
> 
> This looks a bit weird. If Michael is the author, then his SoB should be
> here first and mentioned either in From or Co-developed-by.
> 
> If you are, I'm not sure why he's mentioned?

I'm main author and Michael just adapted BananaPi M2 Zero DT based on my 
changes. What is preferred way to mark him as co-author?

Best regards,
Jernej

> 
> Maxime
> 


