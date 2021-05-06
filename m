Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C27375875
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhEFQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbhEFQat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:30:49 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A903C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 09:29:51 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id l7so8137164ybf.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qTFwtA2XDXxNaj7Uvk5c//7Kigj5G2j2Vg7lc+7nk8=;
        b=gQgbA4RAs50NFYkXr8ipLSjMGKRZv3FTELBC/dnV4LIfT8Vj6mIcLancGiin7OCbCV
         IELF6hLtuvocn2dfiMjlsYgYX2rUcRAxNjr4EowjCddVQBK6xPIHgH3M2vcN5NZqLrBn
         Fb4tonfwBXVpeoMDYdCk/aW0z8zPL9EgCsO6hMQkIIOXMC95ibvku3kkAYK0Dg2F0Vo2
         vd+htUmQI1KN3ERYnU966Xb4gUoLQrlloSBO5tgn/RVgdd1063n5z9qZLdL49R2i3+uq
         NEPqwWu3PO/oLZPcEgj7zgnzHKvBKF2axRREnqZCpsCcFQafj1CzWBNJ2WmWHzESdeQZ
         FvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qTFwtA2XDXxNaj7Uvk5c//7Kigj5G2j2Vg7lc+7nk8=;
        b=ZvfQL43mlLUOf4gq04iG38Yu3yNDBJtVOptDEE642vUUYmzhIxKssYp4fY87lBzyOU
         b7UieJNNnp8W6xCbY3OU/zMRaI4R9Krof6Vfx1WpV0CgktKp9nLhn/2N2kLnDUEzhzZ4
         pAQ/WNFJguenGYSTgPEryvR1VXw6Li/JCUSf+ZyRS4yutqBSYlHIiCwIhpFfxUvIsfIG
         fhSdYv2+lonvxQcsInkifDu292SWNxWHL7/1xAQUItiyc2WqTGTLRpA+KJJBBw+vlwru
         trqLqq6pjsS1P05iLqRzUgAXKTRcDfYTXo56s7gyCt8g0f2cluRCK0Pyr6wu5wT7gZSU
         I3kg==
X-Gm-Message-State: AOAM5334Iz9I6S721YnLpeYC1laL+/PHUKmLHFFdxFvT1IhTI52CvHG1
        FI7+/BQBz0fEvFKO3JrxBky8OxDOAePON9PGM44=
X-Google-Smtp-Source: ABdhPJyKsrabSaPpr5A6bzEwLLoYV6KfgzG6O1Mcytz4bjdNFnQGZ21z+mEtefaJ0XyanOV3n5p5GlrQkPatCG5rnNk=
X-Received: by 2002:a25:bc8b:: with SMTP id e11mr7177209ybk.115.1620318590865;
 Thu, 06 May 2021 09:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210506123051.7414-1-jj251510319013@gmail.com>
In-Reply-To: <20210506123051.7414-1-jj251510319013@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 May 2021 18:29:39 +0200
Message-ID: <CANiq72=s=BeroPjTNSeZsj+qq8gYiZtEQPJHgMxMopTy9Zk10A@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Add continue in comment
To:     Wei Ming Chen <jj251510319013@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 2:31 PM Wei Ming Chen <jj251510319013@gmail.com> wrote:
>
> Add "continue;" for switch/case block according to Doc[1]
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>

Thanks, queuing it!

Cheers,
Miguel
