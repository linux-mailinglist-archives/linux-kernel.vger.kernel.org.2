Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38FC4548F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhKQOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhKQOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:40:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D162C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:37:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k4so2326609plx.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 06:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SOLXibsYhAQoMaZe/qoyBx3ypKaHwuZlNuup2u9BzBs=;
        b=O1BnWiUr1yp/whuX1LGG8LUP2djb9jIguh10A9Qg3K72HdKD3Y9aagRhNGVtaouWQ1
         PjYAo8q+YCr8FCGPr47ZLsJOOIn6drPIP7wwqXHSuoskPYqCkYUGY1e1/+2kVcCCuPYb
         03wRXP+KhqIN/Raq5jsYLoHyi12LmgBTp//GGjOnBLpugIf+/xPyhaxDWHA1yHbT7TBN
         3SQ9z70B6ld4IJaF/Cu0ubtsz208WCsF8qy7q+0e1PqTEXBAf6WVAHk9P7Xe2cAaatFt
         moXuNVcBC14M2ifvitadRf9mmmHsR8cHQ9P6pc32K1imfEHxxyNi8/GOUtY68/tdoN+Q
         DDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SOLXibsYhAQoMaZe/qoyBx3ypKaHwuZlNuup2u9BzBs=;
        b=aOHWhYOq37MQWwVmXKefAjYYmI2w57h/j4uMjaP+ltv0SlseiATvpmy+pPyxr6t6C6
         MDj9otsv5/7xbekTF7zZGC76rcVT2eegwD2ggKYESKVYc5mBeCSiUNdKFdzOVUjZ16Pl
         I4jbqlltIahIpa9L7NQ/1ezmXWjiWRg6T4ClMD3MquWB5UEwpJZbh8le+3Qd86LlJK6e
         NUXV30OkXueMNZ1T9upVw3+H6G8jE01WNW8FKHGx0M20z3yhauaNCnvI5xzIRFUQJkcl
         9nvy3ePZYBBv2/LcmR0VtBCtEmFPpTqIJwcPHVGA72RjX1oJrpYtcNoTKyDcATfpjoGY
         4rXg==
X-Gm-Message-State: AOAM533rsN7uiKYaRb52E1c98IVkPTrfflXAoLPvTe1Fc6vL9ys2p79P
        o0cGXSvvb4PIPy0dQWcbPMByttR63PauXr2DAOs=
X-Google-Smtp-Source: ABdhPJwMW4uzrY9HxW0uAzYOMh/uq7SZRlqOQypnIQe7VHoIq9zU/M56rUIM2F1HZCXIufRnfNRtUB9TbMucclhfzoU=
X-Received: by 2002:a17:902:7b8d:b0:143:95e3:7dc0 with SMTP id
 w13-20020a1709027b8d00b0014395e37dc0mr56548201pll.21.1637159834900; Wed, 17
 Nov 2021 06:37:14 -0800 (PST)
MIME-Version: 1.0
From:   Tim Lewis <elatllat@gmail.com>
Date:   Wed, 17 Nov 2021 09:37:03 -0500
Message-ID: <CA+3zgmtHdCE3TZn3Hc8+nsYc+mHHvACNgFY_Z_Z4nCAmhSnQPg@mail.gmail.com>
Subject: Re: Re: [PATCH 5.10 000/578] 5.10.80-rc2 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No regressions on arm64, arm, x86_64, and i386.

I got
proc-uptime-001: proc-uptime-001.c:39: main: Assertion `i1 >= i0' failed.

I don't see proc-uptime-001 on
https://github.com/Linaro/test-definitions/blob/master/automated/linux/kselftest/skipfile-lkft.yaml

my proc-uptime-001 history
5.10.80-rc2-dirty:not ok 10 selftests: proc: proc-uptime-001 # exit=134
5.10.80-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.79-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.78-rc2-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.77-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.76-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.75-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.74-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.73-rc3-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.73-rc2-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.72-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.71-rc2-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.71-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.70-rc2-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.70-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.69-rc2-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.69-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.68-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.67-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.65-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.63-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.62-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.60-rc2-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.59-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.58-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.57-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.56-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.54-rc2-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.53-rc2-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.52-rc2-dirty:ok 10 selftests: proc: proc-uptime-001
5.10.51-rc1-dirty:ok 10 selftests: proc: proc-uptime-001
