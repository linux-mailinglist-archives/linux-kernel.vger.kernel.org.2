Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC79364D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhDSV3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhDSV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:29:10 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A142C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 14:28:40 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id k19so5283211vsg.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cleXv1yhEvw46D0B1rWUk84bkqfi6fu+rLFkY44zfmA=;
        b=nFxMjeD7AmL56ZhtH0sR2t2h7TfuthJSJf+NdlIHx+BF+rvuPuW+9ovFUuKyRUugmU
         5ixLO8gPKjq6UVc5V5pfdCx6dNJrgjM3CFYkFzydSknQDAIC1J6js1PAojit5MKN22VA
         ZxkLNb1VytJc7oPeiLqe2FjWVjqzn7xN1Xns1m3EqZLCYGnu0H3JJfR1rgsONcrK3z37
         jqOfT+SxLbwPp+xXEFnlV0Im1dE5ZybrdHuMBIWBnzFd5bvZzsGUMncwJSt7veOL1cQ4
         tY7+dDnz/af2xD6z9juc1lPZPwulI6IyB4ofLszl5N0QSyNOw6pDf2IT+/iLbjiUVhwm
         fa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cleXv1yhEvw46D0B1rWUk84bkqfi6fu+rLFkY44zfmA=;
        b=FzfWR4kGQADN4Ywv+z7Wi7KpZDMho1ViGiRMV5EeUOe84HIq9IcqEQjTJLQB/uxFUp
         no3J7zXoUzblM7FgVvttehhvLDzKNwE3eKp5KWJkRiGv/52Dep/MOg/Umi4u3zy/LJVj
         i9BbkP8rK+zxfXU2WlsXp06t9eJqC7qioYBQvZbxWhZMUz9ujVR9diyw3g0thpz53bVu
         546TFSyOq9Soh/6INVeIXYO70weAYiEp6LY9QZNF4bl14Zn8sn3BdhFU00DuXvt4LJZZ
         9wjAZDcGUn/+INsSM0yem0q4BclS/MCtxeipfCoPJAc37crMtNzCPJGtRl8Vdl0bmT/Y
         0f1A==
X-Gm-Message-State: AOAM533fz19NLmHEdzp74mRFvuKBDTnXMymAu3Rhq6tRZ4VNnYWSVfcW
        V3mnwOd+EiR27Hs1GFE7oqkXtvPhRSMSEzJsBz+pN5dJG6CQRA==
X-Google-Smtp-Source: ABdhPJxNiGs2dJnnST4zN1cMW6O+xsLEhgR0c+AVVrpW9tSV5gP3SQbLZdVI0yl9kXQ7k/wrb/xo4kT2tgRD4dGCV8A=
X-Received: by 2002:a67:7d42:: with SMTP id y63mr17685526vsc.5.1618867719441;
 Mon, 19 Apr 2021 14:28:39 -0700 (PDT)
MIME-Version: 1.0
From:   Jue Wang <juew@google.com>
Date:   Mon, 19 Apr 2021 14:28:28 -0700
Message-ID: <CAPcxDJ6SgSagJrF7u576WUb6p7Hg7+beYVoCpJ86Ocsb-mCHmQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/mce: Avoid infinite loop for copy from user recovery
To:     tony.luck@intel.com
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        luto@kernel.org, naoya.horiguchi@nec.com, x86@kernel.org,
        yaoaili@kingsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 17:02:35 -0700, Tony Luck wrote:
...

> But there are places in the kernel where the code assumes that this
> EFAULT return was simply because of a page fault. The code takes some
> action to fix that, and then retries the access. This results in a second
> machine check.

What about return EHWPOISON instead of EFAULT and update the callers
to handle EHWPOISON explicitly: i.e., not retry but give up on the page?

My main concern is that the strong assumptions that the kernel can't hit more
than a fixed number of poisoned cache lines before turning to user space
may simply not be true.

When DIMM goes bad, it can easily affect an entire bank or entire ram device
chip. Even with memory interleaving, it's possible that a kernel control path
touches lots of poisoned cache lines in the buffer it is working through.
