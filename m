Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEADD42D840
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhJNLfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhJNLfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:35:18 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78CFC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:33:13 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id w10so3055473ilc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oY5d/R7UW/oDRHgcTKtDThHEm8aGx2JuqS2Sj7syZ5Q=;
        b=aNxXcY5qVytN+++Hhyt6gdk23lSkpovawwdwQXeavBV9sVx00SHm0Tp8qHkCkprnPN
         N+prQI7uRbmlkonp3yTWLG3D0KBJKSgk4QoW09W1Cwu5i1W7tPY9DsxJJYBJSMlbk7Ah
         Tu0x0PGp0edxU90yGDrwjTaEKsZHfOwT3cCeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oY5d/R7UW/oDRHgcTKtDThHEm8aGx2JuqS2Sj7syZ5Q=;
        b=feNh/reaBnAJhJmxCUvVApUWxmC7lQAJliXh/EABGGHahXsL7x53+Tkfmj8dMGFLM+
         CXFPPNRMYnjDnch+UjtYt0KR8T4Rg0nqkQ37FqD070HG4844Bao6i5hgxPa4BTqzzisN
         yEH0irmm8m7TZmkIqZfZWy52mFAULkvZOlk/Ci/5/1JyHhcujFjwZ8TKvIiyJV7TSLEu
         ZnNyUbRHskzNLrMa786DsyNE5Q47f8lJ27JHiPqJGzlueAAYK+wcj/55GJ/YO8D9khlT
         2l37Ljhe4Ld4lHD5HKQduTicPTdUr9OxskUTswI69osWC+9PCZlDRxHq8G2bs0qnpHvC
         4fVA==
X-Gm-Message-State: AOAM532yp6HV9E71MDC/l++UmaNpe2Y0pdFt0APVDYBayZfoyXunHGyC
        O/O4tDilc7WNtt1blKcewQ4TCmFrh6JRwg==
X-Google-Smtp-Source: ABdhPJxZG5uy+3XJKQBnB0t/CYqNCVvN/ldvxoEFG04l+Rz1ZwMLLgHzRIzJLDBX4CamcuU/eB+fGQ==
X-Received: by 2002:a05:6e02:1e02:: with SMTP id g2mr1987905ila.89.1634211192653;
        Thu, 14 Oct 2021 04:33:12 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id a12sm1137125ion.0.2021.10.14.04.33.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 04:33:12 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id z69so179998iof.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:33:11 -0700 (PDT)
X-Received: by 2002:a02:6027:: with SMTP id i39mr3396022jac.91.1634211191475;
 Thu, 14 Oct 2021 04:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211014093112.3852491-1-fshao@chromium.org> <20211014093112.3852491-2-fshao@chromium.org>
 <CA+Px+wUKXJ7a9th1HyxvCgDTQXL9kHtZH+O9z9oRqCfcF8H-sg@mail.gmail.com>
In-Reply-To: <CA+Px+wUKXJ7a9th1HyxvCgDTQXL9kHtZH+O9z9oRqCfcF8H-sg@mail.gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Thu, 14 Oct 2021 19:32:35 +0800
X-Gmail-Original-Message-ID: <CAC=S1ngFY_LMQrzGpKXUt9HOJnoBvBoL7MV9sKSUJd0xOHZtZw@mail.gmail.com>
Message-ID: <CAC=S1ngFY_LMQrzGpKXUt9HOJnoBvBoL7MV9sKSUJd0xOHZtZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Fix local clock ID usage
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 6:47 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Thu, Oct 14, 2021 at 05:31:11PM +0800, Fei Shao wrote:
> > +const char *clk_name = "gce";
> > +const char *clk_names[] = { "gce0", "gce1" };
> Does letting them static make more sense?
Yes, I'll send a v2 later. Thanks!
