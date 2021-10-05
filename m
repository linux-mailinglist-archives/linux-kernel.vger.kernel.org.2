Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BCB42274C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhJENE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhJENEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:04:22 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8EBC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 06:02:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l13so18973617qtv.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D8HWDb4ZICpSAAhyFTVNQmZfQ+wJ5IGD+wMcTdKNfXM=;
        b=P/Jclv5Y/srwiwPyQkhmLHT2pM1YOdhaC+EtwSfU4LvAcvEqPcIxHEFYBlqfK0cQRb
         xdJKewVIfaOyBGo7xtxxQCl6DZhq2HBZpjbQ2Fv9F6K4NSsqsxyYOHkcKnWmiCJ11Nsg
         9uEoCpeiLGaxpVViT6MyJCTxzkm51+m9mD6gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8HWDb4ZICpSAAhyFTVNQmZfQ+wJ5IGD+wMcTdKNfXM=;
        b=YwFoMkdDidf1faQe6BSLBJQ/qvUr3ly1vkIx3V9NakxzKGk4Uybyrd/5NxctYVFDHN
         26qORflwaRhox1n8S4CYHFlzh+PeZjYcFpIxNqwR7z8VKb/pZ6K/S0zU9uzTOt1qUD+k
         aijZUDTGV/F74RjBaLfrOPzUXXalDQYxyXweH1b3in7a+QEUbdEeVFEv/C5D9QWTy73i
         +D18IyFl0VXJv1O4/CS25hQH0pSSLhxINfdWeiWsimFVEjnbOnJ+bQVjGtXQI9ZXZyic
         iREw2DT/NBZjACHPZd3ozxGdwm376r7xHnLV0dmbH3WFwLUn3XXkY7ZzXqBh2xDxOJcH
         0+9g==
X-Gm-Message-State: AOAM532NA5VMR7XWFVHxKjh04MeUoTPcaQXUw8wEIdrZsEm41v4Tr9Gq
        NBjgZZu3oey2BX5yMcFBd2zcBA==
X-Google-Smtp-Source: ABdhPJyXYkyZllmkekyzDcS3YgD7p2I9FEX3et19iTec8CjTpO7zNq+uTj1HpyRxzerdG1ZrhGuJUQ==
X-Received: by 2002:a05:622a:1046:: with SMTP id f6mr20007686qte.113.1633438950579;
        Tue, 05 Oct 2021 06:02:30 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id x3sm9275217qkl.107.2021.10.05.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:02:30 -0700 (PDT)
Date:   Tue, 5 Oct 2021 09:02:28 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] kallsyms: strip LTO suffixes from static functions
Message-ID: <20211005130228.4wevxvzl26jjhn24@meerkat.local>
References: <202110020501.RKX4zca7-lkp@intel.com>
 <20211004162936.21961-1-ndesaulniers@google.com>
 <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
 <CAKwvOdm5bBUE0df8jbXq+bSCf9U0AM3Wm4NsZeHu=Nuhi0yd-A@mail.gmail.com>
 <20211004183806.5weyuk554ppe5olb@meerkat.local>
 <CAKwvOdkzviryHByOZj1K6r6HVKcC+4Tc43jXn4Eqk9EXGVpucg@mail.gmail.com>
 <20211004194521.e2syd25qzrgn5mzg@meerkat.local>
 <20211004203754.nvk4aijql7tevbnh@meerkat.local>
 <CAKwvOdm_C4nYW1xWmf6RbjXoV76xZs8OCq6VfSKXKtJXdMta-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdm_C4nYW1xWmf6RbjXoV76xZs8OCq6VfSKXKtJXdMta-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 04:22:47PM -0700, Nick Desaulniers wrote:
> :) LGTM, thanks Konstantin. Did I mention that b4 has significantly
> improved my workflow contributing to the Linux kernel?

Great to hear that, thanks! :)

-K
