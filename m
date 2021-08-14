Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F54C3EC2D8
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhHNNba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 09:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhHNNb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 09:31:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA09C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 06:31:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so6639953pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=+7uqaVHQOTYqCZbxpWMJpz3Ww8v4S5eeajCqJn1wsWk=;
        b=HSyoa8EpN3VcmfMyUXJSFbdzaUxaDR/HvlnepO6yo12ABpQx9FP47a/UKYZsLK6fTg
         jyRQ221hnGpxjH2CXQ2H6DqQnSpxp7ALT+YDn7Gw3tHBvINdkegaSuzOPkKdtG/81j3z
         nRwryvxPiZC1c/BdXRY/wlbMYhVcZqBsMSqH1a5VNe3JjuWgF2ZWmBF+lBuOIU6KbfU2
         IOjaZpUneHueMLG/mw9r3GBitXTIRaAvbd0gNCUsC0v6UyEhMFW9ZZ88s9PV9wHSufKa
         hJ1wot5VUF34Ak+V/WU1sOorL4tyLlIFg1hd6as6sq9IVftzzYONgLhwY0DENALcD5yP
         4RUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=+7uqaVHQOTYqCZbxpWMJpz3Ww8v4S5eeajCqJn1wsWk=;
        b=Wxmn5uRBG5E79CeIu25LjcuVdZT220T1wioxuK5/CG9ChZmPvQz1IuBkjAbzZ2H0sz
         PfO13kML72eFPLewHXkqj4Bfd9Dvy02qukogOBc/DiUZv3d6tp8+P1Uw/TVJ8nlRIAR0
         w+atQLQhk6CI23HtwKD0Ia+IM1N04JBCgv6CEvqlqm9IrjLn4x36xh/V6mmY043jSnTU
         mg1JkDRnRSPmkTSEjlM3t3JqyzXs2Bf0mFZh00/XWbGLoTswQAP22Pf1pk3a/CTuL6M2
         Nf7SDIFfBd9bqwLLG3K9R15uQkmkQKBqO4qhXSMA0tweCmG3bujw9b4UwrF4Nxqeg/cb
         WIVA==
X-Gm-Message-State: AOAM531P3lpsKdej4Ti4iHSJ9u2zMRw7VsbZltTRZHyjkKt4Q/wiAu2v
        8Ulsg2xyw4QU7khZXaV3JCL5Ocx5iXHJiH3PW+s=
X-Google-Smtp-Source: ABdhPJyUdPw0m/cAC4fPLuPwPICrb8NUQfWqGx2K2nvFUTRfVqk5/gYP1Cn7fWHhcPBcoxTnLDwMXWRjZ401yFsuIAI=
X-Received: by 2002:a63:86c8:: with SMTP id x191mr6944954pgd.166.1628947859677;
 Sat, 14 Aug 2021 06:30:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:3941:b029:51:5d73:f6db with HTTP; Sat, 14 Aug 2021
 06:30:59 -0700 (PDT)
Reply-To: j8108477@gmail.com
In-Reply-To: <CABAL+x=QdV241R+HzsMxZyQAiDLasu76X7Xw4nrU63VnVcJhng@mail.gmail.com>
References: <CABAL+x=QdV241R+HzsMxZyQAiDLasu76X7Xw4nrU63VnVcJhng@mail.gmail.com>
From:   MR NORAH JANE <adelasarah82@gmail.com>
Date:   Sat, 14 Aug 2021 15:30:59 +0200
Message-ID: <CABAL+xk4qVuVB4-a5QSJ=ZJv+CihHrmSF1JY2dvbj602EWx1Og@mail.gmail.com>
Subject: Fwd:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
From: MR NORAH JANE <adelasarah82@gmail.com>
Date: Sat, 14 Aug 2021 15:30:32 +0200
Subject:
To: adelasarah82@gmail.com

HI, DID YOU RECEIVE MY MAIL?
