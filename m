Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B5D3DB6F4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 12:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbhG3KLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 06:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbhG3KLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 06:11:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ED3C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:11:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u3so16824999lff.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77UNgvSXVfiCkvl5HDG3vgOj6Hghqj3H/O+1VotXBfY=;
        b=QYy6nSg7ITGAqKsIoCFxt6yn7C1sv6n+Bq5T4bu9bd+NvaciK3E4ckd7S4VSGsVv7R
         5m1q9yKNH24I6CUPZRDVdHK4jAzrs9ohMs0cQ5skNhWGmCv6tdY7sFdllGA9+eHRDVfz
         Ookj56HvDmt/E8hvks71RtJ1AjtSpZdi/j8fPtp2BMQvvULss+zMjn+0hsRApvyl0Vfl
         yD7FD0eWs3ReJWVPsaohU7z7ou/14guTZnyI/cJ+LQcx1DBSLVQWjWkcowuIfoiKPqos
         s0wWbjtGc3c6e/6lXxx+VFl2YZyXQGkwCp8vFQCI39jXfWgzB3Ks5+uFSLukWBtVXWB5
         CM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77UNgvSXVfiCkvl5HDG3vgOj6Hghqj3H/O+1VotXBfY=;
        b=YrqHandDuG/eTEqOh2akLCS/zQuNk38qtks91aZaMs1Ff5hON/3Hx8tcupk8iNu+ww
         5NNqJ1A6WJL5UyxgPS0vREsWmTMO96+MPFFOG0ge3mQezREa0VGrE/gEIRDe4hmgQzJj
         vc3ZeiruUADAcabzIYRKSPiPzVWyg2mDJcxxJ8+HAV8RnY17DKo5FI7cXVZHY7dEyI/Z
         9X22sG/1EttxHUmj67/dPj36KBvAAbkFM7IMtvDH+UOg3gdYCZf45HaixBIoKWcoikvR
         /K+kfHZyv7DNc0WZV96klxIbtX0Iu+YobrXcK/G9Iy9pDSaL43XIwt0SPiq87P9AtEhG
         Xg3g==
X-Gm-Message-State: AOAM5320swMfGYhhDbaflr6mnv5PH/x6JoooJ2gpRS07CpT81xgevXC6
        QOLFqH+/9dVQ9buFQNLfCXnzYCS5dpDbdbt8b5UzKQ==
X-Google-Smtp-Source: ABdhPJw/qAAEH1w+sT1d57VfVSKhNIM2JLVTCunV0OOprnk8fZkOEl4X6TPRr07xqOR28shrcfjxPv+7UgNuD6MgOOk=
X-Received: by 2002:a19:7b14:: with SMTP id w20mr1358563lfc.29.1627639884190;
 Fri, 30 Jul 2021 03:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210717045627.1739959-1-daniel@0x0f.com> <20210717045627.1739959-6-daniel@0x0f.com>
In-Reply-To: <20210717045627.1739959-6-daniel@0x0f.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 30 Jul 2021 12:11:13 +0200
Message-ID: <CACRpkdaEMeYieH=g+3jveWgPS_8CXSgC-iryzbsoZp7LLrkzKA@mail.gmail.com>
Subject: Re: [PATCH 05/10] ARM: dts: mstar: Set gpio compatible for ssd20xd
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Romain Perier <romain.perier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2021 at 6:56 AM Daniel Palmer <daniel@0x0f.com> wrote:

> Now there is gpio support for ssd20xd set the right compatible in the gpio node.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
