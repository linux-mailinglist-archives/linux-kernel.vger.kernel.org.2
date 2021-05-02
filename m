Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E62370B30
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 12:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhEBKv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 06:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhEBKv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 06:51:27 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCEDC06174A;
        Sun,  2 May 2021 03:50:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y30so1705057pgl.7;
        Sun, 02 May 2021 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RHhYrc+yOqIE16Q944nr2p+5NkGLSBsNJbA6NDil1nA=;
        b=iXtxsig8WLEvoGjkJd5kU0ijZMj7chindx+lBSe66fh2BVCTN0pU4jO7kkiKQyFLN3
         LOqP/6RjlHypBmcl4R33AqwdP+JtKoj8owoqHB3bUpn0mXq3EyrRs5UmVzLkHbOJGCcI
         8GBTuFJX3v955tQFA12UMJ0RSnCUzKhfwv1aUi83Yq0D/ZSx3j7MGRkj20yW96J38QkZ
         213y1TbD5+dxuYj50q/m34wTXSSyuUajw44BdGPGwvS0Wazpi8qU8491VfwqND1Iev1U
         zD3n9ShRLYTgeByUX1r9AmCdISWN4ttbtI4yux2YzNMCLY6iXSPpnX+jstD4bQe7RvqO
         eTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RHhYrc+yOqIE16Q944nr2p+5NkGLSBsNJbA6NDil1nA=;
        b=jzsHdnEw0lI8Y5B6TXSZBGJkf/VH305dFsDvYAJ6ug+8hN0l+NThNkkTZ3S1F9abBe
         7HpZ6VcGbtwla0wqJz1+9poSpLlFo8MbSPYfcV8oWmStc0Cu3CZ2YYEZpjRYXiTHbQau
         VAUWpe/xFDavolTGEkQZOjPZKOmacz/RtbIJEyAh5lyIUkGjQ1mE1SfVrGFt0r0goEfC
         UPXQLwy+WIuA9S5RJurGhQzO7PXPCpT2hfCfsDceWj3DDpGZ5H0dBoVe9kFWAf2wE4M1
         GAJf+9PjZ1MpNnEuu54hb/SnDBb4LvBcujBuwYCQDhTWsXSi5ceOmcxHFep/Pg85TczJ
         235g==
X-Gm-Message-State: AOAM532ZXdz+xNuADEdZN2/uJkcvKOsk6RDlja507GtE1OIXIRWrp3Rl
        HgoPcUFappyybwfrEvDtWsvfuCWgTO8TGY6UjKM=
X-Google-Smtp-Source: ABdhPJzxkQIxXPzsnyV2kxHxCI4Mvyi2yRYwe0nOgnrmTwpp5nTa/r11RzRr/GaSH7tsZvE6K9RiX6kKC4PBVyPp5kA=
X-Received: by 2002:a62:5c6:0:b029:24d:e97f:1b1d with SMTP id
 189-20020a6205c60000b029024de97f1b1dmr14180635pff.40.1619952635892; Sun, 02
 May 2021 03:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_F8EEB847E2CD8A6813D0BF4863964CDF3508@qq.com> <b787cd95ad7746d9a04e8cd7f6c0b645@ACNMB2.ACN.ADVANTECH.CORP>
In-Reply-To: <b787cd95ad7746d9a04e8cd7f6c0b645@ACNMB2.ACN.ADVANTECH.CORP>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 2 May 2021 13:50:19 +0300
Message-ID: <CAHp75Vce_-m5uXgpyRO300M1Vw8DX2BmnBPsF5OaUK2_hNDb_A@mail.gmail.com>
Subject: Re: [v3,1/1] adv_mix955x is a scheme that multiplexes PCA9554/PCA9555
 into LED and GPIO
To:     =?UTF-8?B?eXVlY2hhby56aGFvKOi1tei2iui2hSk=?= 
        <yuechao.zhao@advantech.com.cn>
Cc:     "345351830@qq.com" <345351830@qq.com>,
        =?UTF-8?B?UmFpbmJvdy5aaGFuZyjlvLXnjokp?= 
        <Rainbow.Zhang@advantech.com.cn>,
        =?UTF-8?B?eXVueGlhLmxpKOadjuS6kemcnik=?= 
        <yunxia.li@advantech.com.cn>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        =?UTF-8?B?SmlhLlN1aSjotL7nnaIp?= <Jia.Sui@advantech.com.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 8:27 AM yuechao.zhao(=E8=B5=B5=E8=B6=8A=E8=B6=85)
<yuechao.zhao@advantech.com.cn> wrote:
>
> From: Yuechao Zhao <yuechao.zhao@advantech.com.cn>
>
> With this driver, we can multiplex PCA9554/PCA9555 into LED and GPIO
> based on the ACPI data of BIOS.

NAK as per v2.

Please, add a proper documentation and show ACPI excerpt, and last but
not least is missing justification.


--=20
With Best Regards,
Andy Shevchenko
