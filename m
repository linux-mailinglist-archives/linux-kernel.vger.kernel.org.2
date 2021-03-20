Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CA5342F9D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 22:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCTU7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 16:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhCTU7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 16:59:12 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0021C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:59:11 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z3so9866201ioc.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csdcb39EwOUNY8JAtO80cS70n2uoogIktQSMq1qcSPw=;
        b=fHy6SL5AwnPWxVcrgPSul+YGG9RdVJmy7kdgTGVwFj7mqFb3/9np1l80hG86VSrr2D
         /cVMHvp9tDefmUhQWJfeSgi3FgxvLF71wXMSLG8nqV2YpFN4GvJUXd1JcwLQBZ2dwKwI
         HVBlOBOGKFhlNymWgStCGbz45BkHOTKs7yILFIf++JX8h6xE88KtZx5rS+mHFtgZygWh
         OJ+RZ+88/1ezaZNx22a0rk+8042Icj6KTABWokqYz4iNqWg7CHEwvFAj25vJWVAQ+sSd
         s/n9mHss8ENk906++r7c9UE43RwQ2jQ16mYc0kIPofk+OXP70QZrzRd1U4T81/FQbQTf
         CCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csdcb39EwOUNY8JAtO80cS70n2uoogIktQSMq1qcSPw=;
        b=Rj3qreWD28wIpas5k1qI1e2mEszI/lxV4dl6hc/O4kcROGhdxBuRDv8IPtu8zPcUbM
         m5L4R1EFzvaaZ84dSFDyPtGolTChlkblzh8hB+svPE2kxiElwDh/dDbK7KPT+ZItFg8p
         0xDQLH94jxhEkydz2CxK3sIV514YUjCihQ05PSBgXVLl9wd3/dMVqtD3W1QYGTt0tjEz
         ufzARPzpSYPkdxxTbMHGZ4iaQz8bePjf4oJ3Mppq878pdiey0lFocdGKTinfBRx/7o/Z
         iR6tdPztzn4qtSqh7FVbcF4C7eOM6xmoDqR6/WIq9AwkIyphBsG65ZBifXCutmgNLDB2
         5UyA==
X-Gm-Message-State: AOAM533jNjabRCJUm0Wd5aRyNK7Vwth2Q3bu254pQ7o0iPv86jOy3L6p
        +ZYnc00aYV6KSgRzJXhJ6M63KfFJcZbVOiniWCA=
X-Google-Smtp-Source: ABdhPJwV3ZrZf+hLItxnK6cdd6Q9BV91CJZYfEUlou3wqKc80chbaB8chd6p4Y3Le7lWx0UO/Sxg6Z5OGqUcBLBVN3M=
X-Received: by 2002:a02:c610:: with SMTP id i16mr6127404jan.36.1616273951067;
 Sat, 20 Mar 2021 13:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Sat, 20 Mar 2021 16:59:00 -0400
Message-ID: <CAA5qM4BrCgvQhPcpHG09-_ukt3EUU92QHkGgDk1UXHqOhvWDPw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] mfd: intel_quark_i2c_gpio: revert "Constify static
 struct resources"
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Tong Zhang <ztong0001@gmail.com>
