Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43967438C41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 00:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhJXWKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 18:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhJXWKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 18:10:49 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FBBC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 15:08:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l5so9863968lja.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8kIvvEhKum1ywgv+3tY8SIChEwJdC5TWn28Ac2GrFuk=;
        b=pNpAUHWwRO6+G6C0zrKOSUrJJJGo51qvYJ4g6w73CDOpvDbxbn8NjdrCSk7QkXDNei
         Fzua9e/+HoESqEDzQKrOaPFOZOe2OfUs7QgYAbKleqxvTm2vhSvReTCue3MXiwtwXwIB
         F5Rvj2ZgPVW/OlQuqt7B0cLIWu9OoLgybVLjDN6ldiAl1xlVWlcWSRlkoqxBPiqjkH8D
         B3Mq8dHMMd0KdI60DFFt4JSYitiZn75KySwbL/55y73Db9CMZemcgXsK167imyWi7jk6
         UPCYdXklrQ1tG6ItQIMeLh/zed9k5jHFfv+X1iiaBU6GeVnG3Dop1lHWzUkY4j5WE0cW
         wB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8kIvvEhKum1ywgv+3tY8SIChEwJdC5TWn28Ac2GrFuk=;
        b=G6O5ZDbmotwFHUbYTMd9W30u9/+xQjDhp9z3mI3tSfvE2slGgcwi3iz0FoOQh07pEr
         +m8ShdY9/lqFhztlyirzETRdpxw/FyDtCOmTQJ71k8/rao2XRhGCWuZqps9rC6uhlWJg
         fUq2kmSQJFASV5Zvf+GX0hN5+TEFviTnzVGaVz3AHeiN8jILsaFz9krzype4fI28KhnK
         /KqC8INOPKkrFuUfl4n5mHmgZeJ0FuB7uTFdSBDtx8D5Ipg1Yn5yR1mBzF84t56gzXEp
         aiNUhYaLyjCtItd5+RwOFd2Xcf/Dc5nnpJo/BoaSMpU2HoBbkYv4coUQ9BrlYoWIQIOM
         3jeA==
X-Gm-Message-State: AOAM531byfeTuhJmWJQjGBwuBEVdpbii+E8kp0k1Fw8PmSptAV/bREyD
        m7ulf4KnWIffRU7+0lSekTU4+WhD9KJ3UUTGhLCEfRnWw//Chw==
X-Google-Smtp-Source: ABdhPJyfkCusDTMQwPI0B6mAHJxEV7u5zpWtXUN4E9KRw0d7rZdlpy2GooLTeUqHzrtswf841yqhK/E33Qe9Gq8V0n0=
X-Received: by 2002:a05:651c:a05:: with SMTP id k5mr14932298ljq.288.1635113306156;
 Sun, 24 Oct 2021 15:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634630485.git.mchehab+huawei@kernel.org> <ec54d0aa65a3b98ae425721663f196b499a59513.1634630485.git.mchehab+huawei@kernel.org>
In-Reply-To: <ec54d0aa65a3b98ae425721663f196b499a59513.1634630485.git.mchehab+huawei@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Oct 2021 00:08:15 +0200
Message-ID: <CACRpkdZMSsCmJhsNsP_aTvT7xanOQQkDRk6gK9PAEAnTgTU3qw@mail.gmail.com>
Subject: Re: [PATCH v3 04/23] MAINTAINERS: update arm,vic.yaml reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:04 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:

> Changeset b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> renamed: Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
> to: Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml.
>
> Update its cross-reference accordingly.
>
> Fixes: b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

I suppose Marc Z could merge this into the irqchips tree?

Yours,
Linus Walleij
