Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2839A9CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFCSMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFCSMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:12:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06536C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 11:10:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id cb9so8216626edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SE1zlIceHLCl5jI7mNY25NCNQlJC62i47aZuFqzl7rc=;
        b=UR4He1sXM5Lp8KMcxtsiwOJlceX9Xld54cezhwcAWOCarc0Kar90QAKZO6xOgFnsh1
         OBe63VLRf29HCr+WRwb4hMCmTtMJxcPvn+NNIocpfm5EWBwuxXokWxyKUL2QTh33FQx0
         14nv9sL8j1z0YlR7KrVx8s2mMla9zawtbx1nU+k5K16Fdxx3VzzKqb80pCoytdc8RcKa
         M5+StLcvAq64Icdib3NIDAabJBKtSAJ3+YqVx7Yozv1vQKZeqj3/b2JWjLdDlgEUxb6C
         wHK+MxWfS1nz6r6WNOWfkdzh+kign4zXHfRCSuJ6p7tWsQfxu1Ml1eBM2/1HDYG6XVbv
         sFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SE1zlIceHLCl5jI7mNY25NCNQlJC62i47aZuFqzl7rc=;
        b=k80sgmuFJCWrhJTyuMyDlAEo/eS71Xbthnf5TVTFy69LtV4cT5MZtLM/t7CTHKt/8y
         KgVdWOP0si79yCFRc5AeVqkN/gQvAVSSwtRPiWQYWtBNyJyIhZRfK6osv4DbZ7/q3WR8
         lGFFaEsrF/ifO4FRXVbNZbfgma8k3XxtBw+F8u/peg5ld0OtFbU5xnJp7CWE3jbGNt3Y
         RnKml/vW4Z66OtLj9arqXbd2Fkj/RIs4zeGe0VFRcqrzZTqXq8blK8zXlw3D8EV60wa/
         gLjNhmYBJRse/egCotYN6MrN+tuj7Q8hJzfrlmM8Fma1qx47hr7hCSHCIo91YAComDLS
         r9zg==
X-Gm-Message-State: AOAM533AEC+5/M4dD7TLpMrt+O3w4nz6siM+GHNldgU5WD6JZeTptAbt
        f6hIg9NqfuJjtDQNxSOmq4ULGz4XfLkbZ7G4alM=
X-Google-Smtp-Source: ABdhPJzFRZjiVsi6h5d4nalkgiWmRLjstOEkoIMEHKV/xoI+FxYsF7bgdCGgD5mX5a5ke3pKmvVVMfSUsUDzMBvVHQE=
X-Received: by 2002:aa7:d755:: with SMTP id a21mr782716eds.146.1622743836618;
 Thu, 03 Jun 2021 11:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210601090140.261768-1-narmstrong@baylibre.com> <20210601090140.261768-5-narmstrong@baylibre.com>
In-Reply-To: <20210601090140.261768-5-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 3 Jun 2021 20:10:25 +0200
Message-ID: <CAFBinCD8XzrFJxxvJeLsz+5MqTqcQD6df_x8YVcPzmo-eMuVfw@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: meson-sm1-odroid-hc4: disable unused USB PHY0
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 11:01 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> As described in the HC4 schematics, only the USB port B is used,
> port A is left unconnected. Thus disable PHY0 and remove it from PHYs list.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
