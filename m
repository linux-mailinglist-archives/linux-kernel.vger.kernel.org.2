Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03AF43F32F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 01:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhJ1Wv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhJ1WvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:51:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3B5C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:48:55 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n11so2420486oig.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=zM8uiZ/0fig4c43d46Pk2wkrmm7GRfhsBgHoOi3NfxI=;
        b=ScpnGW2MPkDkWmvvW9XYdpwZsleLGo4e4MfIHMSN47Wq1ZcmGQx/lo0h17j6e9Q85H
         xKhgTn/ycXpv0hKkkbWsfsfDryAbEP+k+Ye9fHlhDHFPyBsPYNzId9hJBkVc1oZD1/GO
         mYTqVUlbL4Me+ZceH4J09lRlIHq09eDLvHJp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=zM8uiZ/0fig4c43d46Pk2wkrmm7GRfhsBgHoOi3NfxI=;
        b=LKNxJ4ryAsWEB0SFQjs/zbUAWqx7vCwneaUQ6j6ATU8npVa/7J+MO1WpQFa5wt8Tk9
         YRGlgiYukjOWrOIY0sgIWjBipb/JFgSYaoNFDE/dqxC7yVfHmxAqxOECXkski6ksPQs3
         wpCRl/mxBtbiZw6rVlB5jSluEYuUsnobkcF8vX4gN6pa0OSKyX3mW4q0qGfMXpdNqZ1Y
         YYV2G0O8eDpPzM7axbwW7dedU+vXsB7fLW64/giIwCZNPQR1U5e6h+LzED3yjlFVnXKr
         dBZChdXG5+qUxd/K4muy51bqNTp5GUaNDenwJ0Ey+SW7tapGKUc6CMTx6g8Wds9hSuT5
         5YDw==
X-Gm-Message-State: AOAM531QpvzHJCnAHsMY5MaM/Xy6ISFret02rg6oY4p2bAaoL+nHhMPX
        eHvlr4MwWFCizO9LSzlG2dyPRz5QzjgRbvnP/0sI5w==
X-Google-Smtp-Source: ABdhPJzW1asRv8vFGbtuYb3nZrKzGbZSUQuvTUAAaEr626YwTRXyVexGGswyk+k+FCu9k8P2w7sZowcd++Xk7iiaSuQ=
X-Received: by 2002:a05:6808:2128:: with SMTP id r40mr3601576oiw.164.1635461335081;
 Thu, 28 Oct 2021 15:48:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Oct 2021 15:48:54 -0700
MIME-Version: 1.0
In-Reply-To: <20211028151120.v2.1.Ie6bd5a232f770acd8c9ffae487a02170bad3e963@changeid>
References: <20211028151120.v2.1.Ie6bd5a232f770acd8c9ffae487a02170bad3e963@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 28 Oct 2021 15:48:54 -0700
Message-ID: <CAE-0n52HuVGXWeiJj6VSFxYqPWgnTzh17t06v4KAfmM5pf5EgQ@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/gdb: Handle split debug for vmlinux
To:     Douglas Anderson <dianders@chromium.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-10-28 15:11:38)
> This is related to two previous changes. Commit dfe4529ee4d3
> ("scripts/gdb: find vmlinux where it was before") and commit
> da036ae14762 ("scripts/gdb: handle split debug").
>
> Although Chrome OS has been using the debug suffix for modules for a
> while, it has just recently started using it for vmlinux as well. That
> means we've now got to improve the detection of "vmlinux" to also
> handle that it might end with ".debug".
>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
