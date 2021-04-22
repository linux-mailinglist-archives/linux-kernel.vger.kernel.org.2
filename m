Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9984A367D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbhDVJOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhDVJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 05:14:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593EEC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:14:02 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a5so14019218ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 02:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LnlDwDG8Mm/i/R1Un2gm91Gn9a/5exeWb7v9JTuCEHM=;
        b=VY5WxWGmvpograTbio+0S8m8AtujYEXfnO30UP2H0fDE3MB/plRoixPyRogbnSLJSH
         Sw/nLYsKGIsoEer08DcYJjk8mBO/e0YULKVyVPuLHgywXpArOOalJqmG+uY5jTcnQntb
         /CjkEN13IEed8euk+/8SH1byNgbjztcdrYVvy8GqKPIdlqAdOrtzHZdSOFRNHgvO9ZId
         hk4RCOiLEcC/1QCezpYWr/eAn9vyyonwqO3ismhTPt4oL4gxlP1RoOCzC2N7ffWucYTp
         ngkaKooiKhSklbpQp0BKtWtbRwcH2FDp6/C2ZCrZ/tDWdXbYeuNK920LGX3oMgeoW8MH
         ingg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LnlDwDG8Mm/i/R1Un2gm91Gn9a/5exeWb7v9JTuCEHM=;
        b=GYsYkXdn3C0djuBzXo0reZ0U7odaVu/Ni25rbcfDF/+nq+54v85bxlH42Se6el+FeE
         MPBjee4C7qD7cfjdAJEdNxyG+BizXiJLQnCCkyt3kAn9pPksmPFxPLoHxzYq8QnKPHPk
         /5ekMQelJB1pAVqOyp428Umf0YlAmAZsSd9lcx7hihvocXL1an33EDk43EBgevGZxBJT
         65T0VyawIslbU1DG6MXT6dkUk9eq7XiAkiMgjo6924h4OCutC8meNzmD+SJGNcDzT0+s
         7TADsK9nYapQUno5aL9Uo3Fx+rHnrsWTXRxLZ4RSYGMhMkAlYLFeqbhWglxsMGL+UgLQ
         Fbsw==
X-Gm-Message-State: AOAM530M6cZbIf6Jz5zWoUhFGsEezTJUiBNzodCjMI+t5i/tBEbS3qYx
        sE7HIMCo1A2cTSXP4COLmf9IvrBeNSTqqKCoFcHnYw==
X-Google-Smtp-Source: ABdhPJzmterwp+tUWBmWs3aN1UK+xzoVd/9X9cEWiG1ZBkNqcdALRmfaB9Lh1Tw6/0WYboNglZZIJEKTKsXxS1ywotQ=
X-Received: by 2002:a2e:a54c:: with SMTP id e12mr1856840ljn.326.1619082840781;
 Thu, 22 Apr 2021 02:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <1619080202-31924-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
In-Reply-To: <1619080202-31924-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Apr 2021 11:13:50 +0200
Message-ID: <CACRpkdaDP+JnCP+go9hZAObnNgmJyJRDFypX2CZGp-UJBh5wNA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Add ZynqMP pinctrl driver
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        git <git@xilinx.com>, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:30 AM Sai Krishna Potthuri
<lakshmi.sai.krishna.potthuri@xilinx.com> wrote:

> changes in v6:
> - Rebased the patche series on 'devel' branch in pinctrl tree and no
> functional changes.

Remaining patches applied! Thanks for working so hard on this!

Yours,
Linus Walleij
