Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293D74083C7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbhIMFZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhIMFZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:25:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB0FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 22:23:56 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id q3so10490106iot.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 22:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=z3gD2xdewsgbM3N4TOPz93GOXr7vhVRaV13eoRS88WQ=;
        b=Jjp7auxdkWiQtjIdVZ5LKiaJ2AhM3o+gy/l33H2ybkVEcJQLWmtdCzDy8zxDPF74l2
         LE71Tq3/6mbqf28xMOTiGHwMfv627Wv9rJs8dW46tvNrfPjbHSiKL4Zot+NQQnw3KSOq
         vvxSLFpjS14AfPFgxWyfcF7HqgYD5WIeyV5Tgys3EdVWQZpDsIxdMXzv3ZuU9zeCZTJD
         6AIj4caOUkN/5RMUm5i9QkZiWSIlAhheXt6ff7TOExHFt+yPIvVR4NJVpEKFI/Hq+LlG
         D8+srxu0rD/SukhO1ApKTGmf5FWM4D+cT7zDyuXJpaSsBjJKKKJ/9cTIOikSp15TnGwY
         E+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=z3gD2xdewsgbM3N4TOPz93GOXr7vhVRaV13eoRS88WQ=;
        b=rCxTD4gvWyZOKAwmLZJMnc2udmcuSiYKlyhdeZ8mA88Tj1lF3Je11PX9yLUWx8TEtJ
         bnN9hNT+E2vkbmbsvPHX1q1AgErhCBma2uRqFfgqGwUfkMR46WOqfdOkUKVFsyaz4xNh
         bo9no4GDmZhQjvXcejwR0FIWm7gFxqVXOT/zxqCn/D6YBdACHGuqryugEQ3K6J4ivWE+
         DTsDBOSjv1JuTqELq4Qq2GjU8PX2IsH0MEwNs9r1MsmjkPi4RhX9fSzBOx0il1SIvA2g
         geRpCuOLmYFvuFWLAseyUO1DZTr2KSOnYitLMSa0uGXS5lsTCSDIit/++sB85aQ1fcjB
         8exQ==
X-Gm-Message-State: AOAM532v7hEV/Xx5NsMVKLkUEvGzTo90lALP8APl82igf65ZFlZ+SglX
        LvyQzDWkdeCEICRm8fzYtjdB89YDJq3neaePFeuFM6oxif4=
X-Google-Smtp-Source: ABdhPJy1rYwkM+7EyIb0RHC/IwqxEof0sZS/JWBM0VDsIeJMfm23fn4PKRfuT+F+L90Ujf4eEkGXmI2W8yYOcr7jQlQ=
X-Received: by 2002:a02:95ee:: with SMTP id b101mr8042027jai.96.1631510636042;
 Sun, 12 Sep 2021 22:23:56 -0700 (PDT)
MIME-Version: 1.0
From:   zhao xc <xinchao.zhao.kernelz@gmail.com>
Date:   Mon, 13 Sep 2021 13:23:45 +0800
Message-ID: <CAP7CzPc7-WAifJ=pyQjiPzruKm50bPVuQM0_Jg1Bx1HeqyPA5A@mail.gmail.com>
Subject: 
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        nathan@kernel.org, ndesaulniers@google.com, mpe@ellerman.id.au,
        dan.j.williams@intel.com, tony.luck@intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi maintainer:
        This is a patch fix the unused macro definition
Thanks!
