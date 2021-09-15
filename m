Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A3B40C6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhION6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhION6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:58:00 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CECCC061767
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 06:56:41 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id l19so1401337vst.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mML+2SpaZvN+C4X1Q9Xwc9NyLF8uokM0dm+tKkmfvHs=;
        b=meJOGsdogwgZsB6R11lVk9UtJCTanNRPaTxTcJXCZtls+nrdarVse8YthJXkk97nPr
         oQ0hfwFK4VSPx0YH+urLRnSQgf9qePEBj4IsZ0tg8sRBN4v0uTr3sQ5r6Sq45HdAr72O
         ealcrUYO5/+XPrmWlhHkwbPhBG/K5216R1H20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mML+2SpaZvN+C4X1Q9Xwc9NyLF8uokM0dm+tKkmfvHs=;
        b=YHwrHGfeTfEKygzYyBvZidBBfw5YKokDfOD5fegNd8Ep4OXd6T73fUVtS8zB0EC8BS
         PffLhj22X7xrJ7d11SttiGftKCvRf9RVbK7b38sB2qMflfuByYEFR1HVyCYYF+n/Dqfb
         MsTZX3z9MRjvELWwTVVOc2UPb9gEAcwPwaj7pDR+sDmFto+Wj9KW41sCxMMke3U3okU4
         fH5NyHWe16rgWrdA+LediPSrVS/xZpE4p2CuBFoa/mPvOPWuF++9reIJ5yJ/QSKgbr0x
         lD6CtfEVTnoFe+ZnME9QXgSgsol4ypxFclFxuAXDCvOruicvE29E0lS7X8csqciyyvgo
         XGOA==
X-Gm-Message-State: AOAM531BSAy7Wko9/oURCZqW8a/m2z1cW+DV4cwCqoaEjctejDKAeDlK
        cYtWkFza4LfDID/9VDVYTLzhEXpW0dP3pve5U1qhRA==
X-Google-Smtp-Source: ABdhPJym/MN/iKoDHA5No4vLA0dpAD/NrCewprRlJBvTD4aVKjY6mrkPoRM1VpdXKR8MFqDOsyB9oDk0rQfSxks2Xnk=
X-Received: by 2002:a05:6102:3f12:: with SMTP id k18mr3440411vsv.14.1631714200375;
 Wed, 15 Sep 2021 06:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
In-Reply-To: <2c2eef3c9a2f57e5609100a4864715ccf253d30f.1631713483.git.geert+renesas@glider.be>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 15 Sep 2021 22:58:57 +0900
Message-ID: <CAFr9PXk4baxbfNDwRMBD-++8KkuTn=d1buNwvmMy_zCSdURwEA@mail.gmail.com>
Subject: Re: [PATCH] sh: pgtable-3level: Fix cast to pointer from integer of
 different size
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Linux-sh list <linux-sh@vger.kernel.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, 15 Sept 2021 at 22:52, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Compile-tested only, as the remote Migo-R is MIA.
> Anyone with e.g. a Migo-R or Ecovec to boot-test?

Yes. It's 11pm here right now so I'll do it tomorrow and get back to you.

Cheers,

Daniel
