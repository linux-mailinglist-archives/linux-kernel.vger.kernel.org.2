Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A24D39A9D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFCSNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:13:02 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:46886 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhFCSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:13:02 -0400
Received: by mail-ed1-f41.google.com with SMTP id r11so8140143edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6RALmKD2yVq/FoZ/OILeCcvSzeQF2hgf1qHU4lzCbE=;
        b=E4ABkttKaL1zsTSMippEd6bDMVq124HB0LTZVlj/e6B2N8V08roGJpo7/dkPP8FIhj
         gc/JZtNWDMbgnC4xZ5gnYz5Xd56uTnxBIaQsNXGaUNIwRVV15hE2CqsgUh2Fi7pvb87l
         R8WlUFPGT2uajzRXo5Yi22zgZZJSOqeyVJVnDqjlxb68Fi5rrR5j01gnkZ0v7iMKxSdW
         c7AyJU2uN/RgekcGswX/XBsFTLeVICwhedhjSsAUIa4hG/MwEF3O0p+jH0n9D43kMdPj
         Lf8/80lFIZbjrK3Y/uJjazoyZz/xxsiN8QWiNYCVZMAre5zWz7cMdR2bMxiwQA4MHMGc
         Oj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6RALmKD2yVq/FoZ/OILeCcvSzeQF2hgf1qHU4lzCbE=;
        b=LqkvnKSOQxqnho3fdysb+EESzy646ljc+fq2SJptP0KTTmyZZMQCQeOXRzySj7OnbV
         zvCMbRSkDsFZ95cDz0m7ZhroTjJ4JIDOG0QKUv8voIKHH4YxB11fjKqRiXDdDnVP7pP6
         dz9Vt9ftWc1pZlpGhJt9Q4iCeDWoRLppMA/tiHKNnLYU2+W+461O1xlc5rkyJiaQj5pi
         /TkwhA1wWWGSetXxI/yO5fGELM3DcOIxmj2gkqqluk/+y59ad9ePdJC2e/sZgQuJDQ1i
         OyWdcZtC19pDJ81o3b62bmky133LFJz9j8/tZOwNg8NxkRtVf4LZOR5FcbtcIRVpjKQX
         m4pA==
X-Gm-Message-State: AOAM531ZLNZDI7kJ8SxWfrvrCgbvAJHwFED4H1oCD2B5Kk6oe7rcp9Ss
        GXJ6mRFnjd8vfwlfr3QhTptZ/7bOmJVkokMRN1A=
X-Google-Smtp-Source: ABdhPJyOJotBoCgnipCoMvpMsGKOTPoCHAuAMEmpd7uRsodtC0oGXEqdnoSe0q1hTkfzMH55eCzP2DPLpZ5L4LLpypY=
X-Received: by 2002:a50:9346:: with SMTP id n6mr695165eda.365.1622743816608;
 Thu, 03 Jun 2021 11:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210601090140.261768-1-narmstrong@baylibre.com> <20210601090140.261768-7-narmstrong@baylibre.com>
In-Reply-To: <20210601090140.261768-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 3 Jun 2021 20:10:05 +0200
Message-ID: <CAFBinCDsqbg33adF5Xkn70xDmfM_rFdwwAoe7X_exw7_KnPbvw@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: meson-sm1-odroid-hc4: add spifc node to ODROID-HC4
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tobetter@gmail.com, Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 11:01 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Christian Hewitt <christianshewitt@gmail.com>
>
> Add a node for the XT25F128B SPI-NOR flash to make it accessible
> from Linux.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
