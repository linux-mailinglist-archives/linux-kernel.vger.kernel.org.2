Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089E739C2FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFDVye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:54:34 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38521 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:54:32 -0400
Received: by mail-ot1-f50.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so10493520otk.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dyM/pGSjOHd50Vg44ExyUz7raaakuo5RxeNcX2qCcbo=;
        b=Xp2syEfwS8n5MownjsGHoZZPEL0o7Dt/L3jsFzKaiqFI6dfI0YUJaNMM0JyW10GRbA
         NsxoUIr9alS+PHpSJnqfeth3/b7nJvJC3/0ctEMe5WWntY8qblH7oewDYynk30P3IPCD
         fPOqVBNxF9vNW9W6r6vcqXtod1x3Dl1gEMMK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dyM/pGSjOHd50Vg44ExyUz7raaakuo5RxeNcX2qCcbo=;
        b=fAwYzATu8ko651Bs93yvcxBQBtE57lMq2VDKucQh7LsaowjmKSP2P1/qM3qgckyb50
         hQka1HsSXpZfGbJFWDDOEqyRxGqJwS24zz8VD7DnQmg3gSVvqqEyJYZ8dnbWK2IPQIhx
         UzdKCiSB803GXuHkoRpVO4CCZaqQCI5bGuh/SD7LCLlc7Z4tpEJiUDu5GpqNPz2nynU0
         Jc6eSW1OUqZGL88HORLZJkL8270D8v0GxtMRHz6vWLuTekdkUDEfGBS4CIDXdisMYSbT
         f05g7PAQ0qSAfQezI5JwFkEu9qxUCWs6Knj+UJ04IKBtcea3EI+rJvoZiqYqtXcEVY5B
         Nhdg==
X-Gm-Message-State: AOAM530r1OdDvMpAOEu9b4/UZ3tEus6HH0Eas0FFUXE58YVCG5Oa2Pog
        OfL/NLEjo/TVZOareEq9IPcQ4D5GtTp7RyTzBtouoO4ntFU=
X-Google-Smtp-Source: ABdhPJzlROhW5qRUQJy+duE/Z3VHQar2kQt9G1VpCb+njSOjmrPV/nmcHDyQbIGDhGpVqYm3LL2bxveZ6eGMFMa1JW4=
X-Received: by 2002:a9d:18e:: with SMTP id e14mr5304003ote.34.1622843491053;
 Fri, 04 Jun 2021 14:51:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jun 2021 21:51:30 +0000
MIME-Version: 1.0
In-Reply-To: <20210603081215.v2.1.Id4510e9e4baaa3f6c9fdd5cdf4d8606e63c262e3@changeid>
References: <20210603081215.v2.1.Id4510e9e4baaa3f6c9fdd5cdf4d8606e63c262e3@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 4 Jun 2021 21:51:30 +0000
Message-ID: <CAE-0n50uU=zuU0KLY2XUvB2cH_MUvXo231wj4T6JdQDbda=TnA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: pm6150: Add thermal zone for PMIC
 on-die temperature
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-06-03 08:12:34)
> Add a thermal zone for the pm6150 on-die temperature. The system should
> try to shut down orderly when the temperature reaches the critical trip
> point at 115=C2=B0C, otherwise the PMIC will perform a HW power off at 14=
5=C2=B0C.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
