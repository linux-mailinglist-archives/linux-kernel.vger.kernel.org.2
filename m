Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079C04383E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhJWOEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 10:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhJWOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 10:04:41 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20EFC061764
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 07:02:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y12so1302410eda.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pNnwWnuwrLOVqUkrEh+5XrEi1C+z0qSzmyNUa+s0Tss=;
        b=Oqgom2CJv0B1fceWK1TvkDsUiJa5R9adYeofvWgpCtsOoqMS0cmCoNhau5XZmlWhOm
         9YSctFmQJYCWnlbvLZwGgugdjapNWgp9u9hyJmr4GiqI7u/j7Xm63Uqn7hw3hNazAts9
         VdzYjS6NOKYwCAVmYXKRmErJpWZktkqtuf7asS8zMXMwSdRFKXudFO4ngl8+qflX0MyW
         /49QLft1c6052rRrsB1vE1GVdHKbqQal7Vs5Sg9bIL+Hj/B2itYq5Vz5zAYoFmXUV174
         13zrekq3q3hXobz84d7Ydx8PaEQi8mTLPhnpzilKrbqn3UQDuX9RLsnGW+/nfAyR+7g0
         iuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNnwWnuwrLOVqUkrEh+5XrEi1C+z0qSzmyNUa+s0Tss=;
        b=m1yx3uGrYSSOCB7ednfSPDTmCzfdlt5+lPwP89kuA4YCWe7EzURbZrr8WnIbzNOpiM
         OxRZgPimRulXKdySO+0lSDmYMEbdPnIrXdQ4Z0//iJS5G9vVG67rYtdAH8sV9QH8kePS
         jwcZiKYm6EVoQoeuy29w+85oynWXgsr6Mczejs5ik6bOh2H0wCMTFannp9wVlb1UgrAR
         sqZLepLnr4j4BWKYiKl312miCwtiRkwwbBvg9SopTWAZeYFiHS6SRi1YfWYJhexU2FVR
         9M9zmjPmTHcdsfm0FtiJ+4MvVhPUFQv0+BMips0nhCU4BsfcSp5566ltzatrW1wLCcnc
         TtMw==
X-Gm-Message-State: AOAM5339fkkXldry2e46guAYTfl9XU64cdfoD42eEFRooP2r+fLwQioa
        KOHXymPkszmjrpoFJX8Y39s=
X-Google-Smtp-Source: ABdhPJwuas/l1kE2wF0WQKBsFQMP0Ixel8AhXKyob3u7hYlDgYEQIlkRLChk2RLvH+tL6I1jUbsOKA==
X-Received: by 2002:a17:906:c301:: with SMTP id s1mr7522232ejz.56.1634997737853;
        Sat, 23 Oct 2021 07:02:17 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.pool80181.interbusiness.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id f3sm5144629ejl.77.2021.10.23.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 07:02:17 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] staging: r8188eu: Use a Mutex instead of a binary Semaphore
Date:   Sat, 23 Oct 2021 16:02:16 +0200
Message-ID: <3394965.k4CYVUhDiD@localhost.localdomain>
In-Reply-To: <0e327ca3-7caa-e904-c3f7-45ae28dea367@lwfinger.net>
References: <20211022171917.24363-1-fmdefrancesco@gmail.com> <0e327ca3-7caa-e904-c3f7-45ae28dea367@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 22, 2021 7:52:33 PM CEST Larry Finger wrote:
> On 10/22/21 12:19, Fabio M. De Francesco wrote:
> > Use a Mutex instead of a binary Semaphore for the purpose of enforcing
> > mutual exclusive access to the "pwrctrl_priv" structure.
> > 
> > Mutexes are sleeping locks similar to Semaphores with a 'count' of one
> > (like binary Semaphores), however they have a simpler interface, more
> > efficient performance, and additional constraints.
> > 
> > There is no change in the logic of the new code; however it is more
> > simple because it gets rid of four unnecessary wrappers:
> > _init_pwrlock(), _enter_pwrlock(),_exit_pwrlock(), _rtw_down_sema().
> > 
> > Actually, there is a change in the state in which the code waits for
> > acquiring locks, because it makes it in an uninterruptible state
> > (instead the old code used down_interruptible()). Interruptible
> > waits are neither required nor wanted in this driver.
> > 
> > Tested with ASUSTek Computer, Inc. Realtek 8188EUS [USB-N10 Nano].
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Well done.
> 
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
Hi Larry, 

Thank you very much for giving your "Acked-by" tag, and, above all, for the 
"Well done".

Best regards,

Fabio



