Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D8D3451A6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhCVVRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhCVVQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:16:37 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A15C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:16:36 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id j26so15483162iog.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ayECeS81HT5a5qmHE9lDWqj1EoaigC/VfKD/r0GEF18=;
        b=mTGY90QqYvQA+ppZtYyFoO/HHOQizhHsaVVXuxxYS+CCLb4mhg6WkoTbCRU43OI2iM
         WbPjfBD9HYGAA8izueL2BJXEGvJHFPHwD1zvgb+12vjgnIR/JW/pSmB60D40tNWlPfqZ
         o63IH25jn8WJLZGsCLqmdSujLqajDu2+YPovNvFbOac2wWk/4YkE+4ZkaXWBLjATu2/x
         kmm57TLHLA6tnhiyGKDMElPRVYMEFGQPcIQaaIwtzpjyd5P8ZpmzrQ5T7NotJ+8Nv+S8
         1dXr+wk1HmAHv1EBxY77XYynq5RuOImzNfeJ4oDxIxBxykP2GtxblF3CSMJPQQ7dSB0g
         8mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ayECeS81HT5a5qmHE9lDWqj1EoaigC/VfKD/r0GEF18=;
        b=dC3ch1aIgQlnFmUnh1X6+rVQb4AyIR0b5WQJVcuo1aiBDN2VxYn0KGXyI/FfOlg+YV
         yez4mKDlX8oPT7WALcK/5VxGXuS8uUEGzhVmVC0JP0YOf4xu4GgpVGvJyD7GKHgG0k1p
         4FmYMJKTqhHHlTl0LLSOG9R2cWCe13bgBRAzo/bbIUKIPzOQRsYXHYilGTFYL1YVQGYl
         OMYaWmQ5FQ2flXcA0qo1UzmmSls8cE/7zAWfcesoM2Sr6+IKrR9Ag9x4Nh8MHd7sUgvC
         apqWsCFTkkLaryRfb46CRwfIxq7lILF/4JhLLMbp5wzQO/UKAbMaYVDVWKWRsKK2LJ9g
         KYmw==
X-Gm-Message-State: AOAM532FdF8sXx40oIWHpEDpvqh/sRWuNUbsNdQvvp/r8p1CUzc3Be4E
        /K+0uu3+/S0Nk5yB5QjFm1wxpFIlQcCLn4rOb/Q=
X-Google-Smtp-Source: ABdhPJw6G59xfgQX9hwTqrA3u+du6z2ErIPJxYBxb7h+GyWPp1omkc+nnY+oitoI+0+CcvYSoEqrNKpghGMEBWsPfWE=
X-Received: by 2002:a6b:d20e:: with SMTP id q14mr1486822iob.200.1616447795859;
 Mon, 22 Mar 2021 14:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhAz+jC7kJfJRT6AB15xFBTSGpQs6VmufN8J9=gRZuwxZPpjA@mail.gmail.com>
In-Reply-To: <CAHhAz+jC7kJfJRT6AB15xFBTSGpQs6VmufN8J9=gRZuwxZPpjA@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 22 Mar 2021 17:16:08 -0400
Message-ID: <CAH8yC8m5C3E9BNK+4UX307GsAoGH7T6ehJ=6acrO9whJXbRc0Q@mail.gmail.com>
Subject: Re: kernel projects for students
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 11:37 AM Muni Sekhar <munisekharrms@gmail.com> wrote:
>
> What are some good Linux projects in kernel space for final year
> computer.science engineering students?
> Could someone help and share your ideas on this please.

Hedging deployed cryptography.

Hedging can be used to keep the state of a machine unique and the
rng's in good working order to minimize/eliminate the risk associated
with low entropy devices and virtual machine resets.

You would hook the network stack and look for the other party's random
secret, like ClientHello.random in SSL/TLS [RFC 5246]. When the data
arrives you add it to the machine's entropy pools.

In addition to SSL/TLS, you also have SSH and IPsec to grab another
party's entropy. I am sure there are others, but SSH, SSL/TLS and
IPsec are the ones I would focus on.

Also see "When Virtual is Harder than Real: Resource Allocation
Challenges in Virtual Machine Based IT Environments,"
http://static.usenix.org/event/hotos05/final_papers/full_papers/garfinkel/garfinkel.pdf
; and "When Good Randomness Goes Bad: Virtual Machine Reset
Vulnerabilities and Hedging Deployed Cryptography,"
http://www.isoc.org/isoc/conferences/ndss/10/pdf/15.pdf .

Jeff
