Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F344AC61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242474AbhKILTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbhKILTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:19:39 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA85C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:16:53 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id q33-20020a056830442100b0055abeab1e9aso30335560otv.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 03:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LvjhM+ndLmfanYgG/PDDwKh3dxV8bwuerw60vON1ncM=;
        b=s1yhnm0HwPkgIjtw26RqFj2IuUGpaWBoCbVm1K6AQrmQmqmSlUe/IoSKKeeprv8l0z
         IqGq+k4qdpb8L0fjjKBfG5aKtdhYAHClomeAaMaxv7rfN/VkdEolXynJyME/zu069O7r
         LshaCL3swso5UT5Ii5GeD2cMgxm7Pn4HG0s3qea18HPjnHn3JEPfCk55W98/Jrj2uPVq
         UgXyUtCqskdjANCkd1ZiJv0okooaAVFEN9tLwhVM3j8rFcOqVmWL8CV7p6abFW7aBbkr
         qhz7J1J5yjadWsjeY3MxXaG1pt0i3+NWLACl13Knv8H8H7K4HIr5cWOcBQZZbv5fVV4m
         f6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LvjhM+ndLmfanYgG/PDDwKh3dxV8bwuerw60vON1ncM=;
        b=bxtii3DVHWNYAY2i4p6o8VLaAV7AoVeMNetS5sDYX1r7Dt8TGzVwxx8PQPYmKrPSFW
         enrYCJKbNw+VxJ5Wtu6pdnlkJ5gaPEdCJBfD1zknWWTp9H+g2F1/fdIFvTOznLF9j7ke
         YGEmCRBaip7zyWfJoi0BWzhtxGlmLroA2ZSRI7JUQ0YcPiOASqVf2r/GFZJ5aMg6OvtJ
         sXIpx5vjWoXH66fbdSnLsgpuQBBRqq7E6kKz+wAvXJKQN3ZE8nUjOCJ8A8ZrCiQCQoVe
         vEwTXa1twptckDIgTBzjkFO6vQ2HTbFWg7k8tU4PobNEBtBbUEwcAhQwTVWa/NJFVMXv
         crSQ==
X-Gm-Message-State: AOAM530NtMkQMaz9V2KhQ19qFuEluOa6WiJsIgUhguu+fqX6crr7gKQw
        pyrcRpRA30lwUSVP0Yz0s29QKQ+zRqkGIMENxq43uw==
X-Google-Smtp-Source: ABdhPJxL4yGMKIse6KkB0n338+xY85MPpqbk2IYWYUX2z/C9P9ZNsESnBroiYEndzQHc/I44v1OTweuuM4r8x74jPeA=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr5304087otk.179.1636456612500;
 Tue, 09 Nov 2021 03:16:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635944413.git.hns@goldelico.com> <e6a52b238af3022b9a3dad7cad29b632fa34c00b.1635944413.git.hns@goldelico.com>
In-Reply-To: <e6a52b238af3022b9a3dad7cad29b632fa34c00b.1635944413.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:16:41 +0100
Message-ID: <CACRpkdaiAd3AE7CEzMMzphL6Oi_KLkZm0V5WDVBquOreQSD3+Q@mail.gmail.com>
Subject: Re: [RFC v3 2/6] mmc: core: allow to match the device tree to apply quirks
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 2:01 PM H. Nikolaus Schaller <hns@goldelico.com> wro=
te:

> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> MMC subsystem provides a way to apply quirks when a device match some
> properties (VID, PID, etc...) Unfortunately, some SDIO devices does not
> comply with the SDIO specification and does not provide reliable VID/PID
> (eg. Silabs WF200).
>
> So, the drivers for these devices rely on device tree to identify the
> device.
>
> This patch allows the MMC to also rely on the device tree to apply a
> quirk.
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

Looks like the right solution.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
