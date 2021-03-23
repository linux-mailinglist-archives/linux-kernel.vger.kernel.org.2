Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCD9346B28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbhCWVez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbhCWVed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:34:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98706C061574;
        Tue, 23 Mar 2021 14:34:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so29501043ejc.4;
        Tue, 23 Mar 2021 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vI1hw8A60Svwko1G2zPHBamlOLbkGHLt0wNrUy16zmE=;
        b=G8uGWYQzUpbBGIctDNPg81KNVrRjA2Nzc80EGw2su91df70CACfNGZe4ROznncT8qX
         D34aIBLw++cD7dNbh9QkTXwb/TaZFZECpv2/tbMVex+GYjYHKB3+NC3i71uAWZ+Lwg9m
         lF4aYtT2acX3POgzCG5ZY2U4kclCadkO3Df1+ljvXeqv7u46hfSsZGiF7SHd9mZcheLJ
         6jjom4ctWnecWfVLS8p0HZ7bggk74g/rUCpUR1XI2OVZ6rPPNS83WjxzU5RIsEirSONH
         kEfp8x4yiTmyFzmFUjvAvo97P1ymVQ/Yl65DiOx3vHR4THMgpebIsE+CxdKB2XbSDhhl
         bP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vI1hw8A60Svwko1G2zPHBamlOLbkGHLt0wNrUy16zmE=;
        b=BI+TBVNVp+B6rY98CQxBOgzOMUWz1hzf6aDIKdZ3dmhXv9Y82JkA07YBTCdiefhHcl
         nkygyqth4i9n/rP8CHcZxrrugDLdEL5/Tqn+F4BBQ3VNdEXPnM8ppqbVq6kLnS625ulk
         opjXugSRnRYghWe+wfQNGO+e8823Fym79qBat6Jbkr3oAPqV+lvs3jmFUrPx3ckXGQh5
         NW93Lq5C+IJy9VthcNXeEiiwNuYKfVWXj2L4rIwxTmpGfdv0rFnV84jJsnriBgTmrrYs
         vABaYjBdOdrmExinMB00XPBED7BKg6TEN6ldn2RZOgCWVgozn9IQm0SlQBifjK5Mzsna
         r7mA==
X-Gm-Message-State: AOAM532RFhh4P5ONP3O5zRAIEpWv4uq4A1c39JhwjYr9BpQErH4vw8vs
        10a+lEKpkD/tSUfNtulY/M47uePoEslfhzLPGZDRTewCFlk=
X-Google-Smtp-Source: ABdhPJxuc35t8ZMihNgaL/Yf6oo4kgpFO9wPGbnR4Zwpswvv/uagH5C6iyR1p7LTIIfbtCKjhtKvUJRw6k52m9hS3aw=
X-Received: by 2002:a17:906:52d0:: with SMTP id w16mr246003ejn.172.1616535271362;
 Tue, 23 Mar 2021 14:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210315083459.359773-1-narmstrong@baylibre.com> <20210315083459.359773-3-narmstrong@baylibre.com>
In-Reply-To: <20210315083459.359773-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 23 Mar 2021 22:34:20 +0100
Message-ID: <CAFBinCC5t_xhqa7J3K-SYyV+b0hnqZq0nG1fkG=qQxe5Hj_v+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] tty: serial: meson: retrieve port FIFO size from DT
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 9:37 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Now the DT bindings has a property to get the FIFO size for a particular port,
> retrieve it and use to setup the FIFO interrupts threshold.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
