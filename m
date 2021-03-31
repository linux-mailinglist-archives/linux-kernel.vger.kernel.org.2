Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD35F34FAAF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhCaHqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbhCaHqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:46:40 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17892C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:46:40 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id z1so20214132ybf.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bzw+Iamq+L8wcNS2TuH2WO84pZPHjJ1C5dF15DavXes=;
        b=ZOdhA7CzBBPNhqiDl9BW6VxbTac4bMFAuCOULAwiiEg1I76dbXiVW7pEFaydDYYZVX
         0+VwlDf98S6L8p8CPaA/AgdwdYPtJjaOrm4oi745W33pv1EjDi40aagYJAIo4sdYNnbR
         GWq8KAtQGijZ2TGbmL3lfH7dsVAxIVgjrm4t3rx+t6zCeqrNI+u5EVQ/HwHBrs/Vtyvf
         IuVqNUg2Kz2J+jenmDS1Gjs6tbxMfq/iDSqbadBQ9sh3YbwdQ+TK+Np6wD0048poV/Y3
         uOO1pjnKLQCReLhPVlfVbxUk8j+YiX/CXd4Y57Sj5o2JaArhn/r5uF0lXXSkZccSRyRi
         qWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bzw+Iamq+L8wcNS2TuH2WO84pZPHjJ1C5dF15DavXes=;
        b=lg3fJC7P/wz81Dw9qjRyAkakcKCJLSg+OC90boAP9cbKVVgyMJJqFlFO1obE0mvZIs
         qrPESWRpIlXzuCxceGtkMQegCJopm5JXHzX/JurqREE821Bj3KPksnFalvtFvVyqXKZj
         NEAlbuDCB+4qi1r/X0Osykd1EfPWBUu/rJ2VNJNT++FaPK3VfNlEiEjRv+p2bl/t1iSy
         7kkAZzrn2NDO/BSrX6MwQplPbr7XEWK6q41zpf+2i0jRrZbU7MAJ2YUYzFhYx2cuNAM9
         FavgZ80qR9Krio6Ee9HYIBB0wbIPdWqUX6bMeUOcOdWmJLCtAJDJq5W/2bLUboJIWaAt
         qGWg==
X-Gm-Message-State: AOAM531zR5RyEgNaqGpASiV534lluje7CgPAmsllrB+6c52fNnLswNA4
        WouQEthkwZJxPmfUdk4wKGyv4EYIK+jkAdrNYuhTSg==
X-Google-Smtp-Source: ABdhPJx2IqJ/3Vt2Rx6Eaqve8yugtHCch4r8Ri5ovhSRwM4olGCIdBnWdCUsJJY2p1mhr5Eg67Y+cNogjSABtCZg1LY=
X-Received: by 2002:a5b:ac9:: with SMTP id a9mr2860418ybr.23.1617176799492;
 Wed, 31 Mar 2021 00:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210329111648.7969-1-ada@thorsis.com> <20210329111648.7969-3-ada@thorsis.com>
In-Reply-To: <20210329111648.7969-3-ada@thorsis.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 31 Mar 2021 09:46:28 +0200
Message-ID: <CAMpxmJXRz=oqQunQS1HjMuqgWjNAxQ5o0CZiZNnGjZLpuWmPcw@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs: kernel-parameters: Move gpio-mockup for
 alphabetic order
To:     Alexander Dahl <ada@thorsis.com>
Cc:     linux-doc <linux-doc@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 1:17 PM Alexander Dahl <ada@thorsis.com> wrote:
>
> Fixes: commit 0f98dd1b27d2 ("gpio/mockup: add virtual gpio device")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---

Applied, thanks!

Bartosz
