Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB403E2E48
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhHFQVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhHFQVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 12:21:35 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CC0C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 09:21:18 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 3so5171127qvd.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Jc4nUp8w7EGypjYo/FnADm5r4YmqkOFcB5Z5iHZ7THE=;
        b=BZn8KRijkXSNqebl3EjTZM4KxblYh99nt1DCldxPFtLXoAfXMSjY6DxECcT++HgO7k
         rRFAA4Mw63pCZLnvJqLapPp5As7DS3gr996sHPJ0iz6bNOOz1xL3pgUQSSFMd876U8rP
         4DI1brvCkH/GgFYbfazhNeWYoI2I4x4PFYXYQNL5O/7D4+tP9qrLacv17hxhTimRyAX+
         G7Q4xLR6/6WHIUsDRNb2roTllF/yFWnQsMNocSvUWkFcRodg7hEKu3wSy08B/AsCF/pD
         xeFngtFxeKyKKUn9z2+CI/HnGzVc9/nOrLt/fcpJOB/DITJv7mXrmnW9TyoGFkj4tjb2
         vz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Jc4nUp8w7EGypjYo/FnADm5r4YmqkOFcB5Z5iHZ7THE=;
        b=fQS7olx9OHpatIxLvY/qoqAvjdQRDNCwHXZZDst0wucYHlv78S6m1pIZLPS9aN+nrw
         VxnlJMgd58sxZUUa2XwUflErT0oNi85vieijOmZ/Ocvijs50Ax1hAaFd75mqLN9CKL6d
         saI166/9kVVOYqWTUL502M+2Fn64HMtirYW4P3EMxM3ki6wbkb4xtKE+gBynSAhY5HIq
         OF+t+D9kjFgATRTaNCi9ce+HhcxoDbBUwcw7PNqXRNGHGTfhf94WOOBuKKSh8mW/UYB4
         m4+4jKXLmSkhT8jP1X83DPy7VtK3cx5HxfvtonRyqpT6FVNYBBYL1s4eAPwlc/Jc8HrZ
         4xDw==
X-Gm-Message-State: AOAM532VW/0/Uy/XTXxWADBn8usMs5e9YoTLGvL3P1yAfB0SwVS7aqjz
        dJuutpCR6NvZc/nmXFZz3mEy44Wi+PGdlLSRcbc=
X-Google-Smtp-Source: ABdhPJwxlj/8H5KpuDhkKt4e8CqDiJP5YDWdh1So3tD4Z64otgnEcUP/yOsuaSyaLPrrynJhFK7ayKpU7V4uHjwdSi8=
X-Received: by 2002:a05:6214:948:: with SMTP id dn8mr12061515qvb.30.1628266878110;
 Fri, 06 Aug 2021 09:21:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c248:0:0:0:0:0 with HTTP; Fri, 6 Aug 2021 09:21:17 -0700 (PDT)
Reply-To: frankedwardjnr100@gmail.com
From:   Frank Edwardjnr <donadcurtis229@gmail.com>
Date:   Fri, 6 Aug 2021 17:21:17 +0100
Message-ID: <CAMCWrXGZvx00u7hxHs0RggC8kq8BO7paBYMqSObSfPeOzaECig@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SEksDQpHb29kIGRheS4NCktpbmRseSBjb25maXJtIHRvIG1lIGlmIHRoaXMgaXMgeW91ciBjb3Jy
ZWN0IGVtYWlsIEFkZHJlc3MgYW5kIGdldA0KYmFjayB0byBtZSBmb3Igb3VyIGludGVyZXN0Lg0K
U2luY2VyZWx5LA0KRnJhbmsNCg0K7JWI64WVDQrsoovsnYAg7ZWY66OoLg0K7J20IOyYrOuwlOul
uCDsnbTrqZTsnbwg7KO87IaM7J24IOqyveyasCDsuZzsoIjtlZjqsowg64KY7JeQ6rKMIO2Zleyd
uO2VmOqzoCDsmrDrpqzsnZgg7J207J217J2EIOychO2VtCDrgpjsl5Dqsowg64uk7IucIOyWu+yd
hC4NCuyGlOynge2eiA0K7IaU7KeB7ZWY64ukYw0K
