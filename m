Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F513D3BE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhGWN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbhGWN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 09:58:21 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933E0C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 07:38:54 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h11so1926124ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBMlZo2NEl/gxSzw8IHzbfdpOczdi1Ixw5O5Fimdx2w=;
        b=yPxQzoAsDhSCds/T7hkjlevgxkcy89/Pzg7nGdpSquh5BI/L0e6OnIguLz0fXOdOWH
         ynHLOmqMAYw4CxOTdYRrMFLEDCk0qztAMfMxfytNscxr6JCfHXJ5PnffC+dfd5BBQlhM
         p7WcK/sK+DEVm/zeqZITFhMioToa0vVnNfxDdZkXj3n9fYnKyH4cZ1fG+PxxOkr+SaeY
         53jvdco8QfG73Dqhhg7817XCBE5hLwzvdhGjbrWES9P+KISsUdkcRrhByE0G4jKJaVFe
         pZYYkKI7/3/1Q1cSdNrbneLkaIDiltXmSFWMHUny3BVkf1OeyT3VSJzyzPh0yM9i9fhM
         dzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBMlZo2NEl/gxSzw8IHzbfdpOczdi1Ixw5O5Fimdx2w=;
        b=IGC45eLJcVYzcMLt1+VEr9+VN31VdhnKVOVy3lwn7UYsRyoi54K8E+hzPDhUKYLGJn
         SeKWg9WT0styD8kDowpWsUa0i9MkgNbNmgDWvDAXbkqms8bMxzdXnW7VK2RRMSUQ2V+a
         Ar+iDO4iT1b8kRYmZm7MzarJNQvCdol8eIo2TBltFtvomaLaKVa6zpmYJMXQu+VPFBZD
         OqmO+rMY2iyaAMMUi0rrPmtzPkU/eyK3HNfe+dBVYDoqxecz2LCeyqPXQlYwu0nl0DqC
         5ODokkvJQAacaHlw9+Q+23zopTFbhzSfE9K9ycxVX4RmPJG8D+HpMy+HfAeJB0gSRMhj
         LIYA==
X-Gm-Message-State: AOAM531w6PlyWyOLEfur8tu5UOIRgOa1laaGbckz/LEO4XnKKs/MBkDk
        JZBbRTs9CgXwnsw9ovWwZu/L9xF8nS+HVPVIXqL6Ew==
X-Google-Smtp-Source: ABdhPJxVCvTxQBa9uUkgNRPwtGwCa67w4SJn7w+sIh0OhCpseqwOTHMZwKQSHTeXAO/HtWHKbMJyqx60H37P7zFsfWE=
X-Received: by 2002:a2e:950:: with SMTP id 77mr3504963ljj.438.1627051132515;
 Fri, 23 Jul 2021 07:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626947923.git.mchehab+huawei@kernel.org> <a8e0e3227480fa8a5a045ec1ee06a08183a0a8b6.1626947923.git.mchehab+huawei@kernel.org>
In-Reply-To: <a8e0e3227480fa8a5a045ec1ee06a08183a0a8b6.1626947923.git.mchehab+huawei@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 16:38:41 +0200
Message-ID: <CACRpkdbh5Ef_oqC+i97UhhPzYPEZ3rdUskMf8yKZdiANjVZ-yw@mail.gmail.com>
Subject: Re: [PATCH 07/15] MAINTAINERS: update faraday,ftrtc010.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:00 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> Changeset 8df65d4adca6 ("dt-bindings: convert rtc/faraday,ftrtc01 to yaml")
> renamed: Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
> to: Documentation/devicetree/bindings/rtc/faraday,ftrtc010.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: 8df65d4adca6 ("dt-bindings: convert rtc/faraday,ftrtc01 to yaml")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
