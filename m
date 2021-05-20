Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1738B2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbhETPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbhETPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:22:59 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A09C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:21:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i22so24960109lfl.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wXtqm14Wbu6rfbbtrQdMFuhBEzsDRjQL4crStL4YEg=;
        b=DB9QPQRuBpRsNARyN51Fm2bzdCuEY3PF4tDqklHdMs+JmfDMNS3xwDAPOAMVWA3NMa
         zrU4dXoE9kzMGnXhrBku3RO4+gaVQvwgLYtc9zDQx12qTivqV1meRIGIqnmnJDSNC7vv
         7w8qT5pd4OVTSJMWn72xZ5Le8JkjvEgojHfRyTtYJCort1L9T2Qp7+LZkJs/zD6Ajorx
         IS+yFCw7eVbuptb1LCfigkNsEtaIHsiX4d3KGNBofS18UiwyusmFySW6+fio7atfIFFi
         tP3Tqmh+aqLhl124QTmKvmo7w0cW5EXCRIeklFqCy4k67xZ7a16EtQyLIT6H6QyccXb3
         vuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wXtqm14Wbu6rfbbtrQdMFuhBEzsDRjQL4crStL4YEg=;
        b=S+MceU3dnTyStkm4AFPEuyhV/GnLf0KAjkNJN5H9gOtW0EjZ1M5AJ2VhPfmXuLSW2O
         uqWhVy/oNGLPbaCZ4+dyeEPKF301fT36IUZUK6Wh77EU0uA+hzDz/ynW/SMmpIl3CRno
         Dsr9p75BFQkVHXEySKXm+7/KY1Tzl+n/RjblCqPRFW6CHniVFJNwta6G5Z11ckseCN79
         qwAsBATVCF7syKgJfGCFB2zVjj/rhHh3rJmb+smOtKZuVF3e2fIzGjPqneVWYl+tSDs9
         FwYUGoLrNlu2OxKfuJ8G1nzREcKplw1ru+R+mrZcWd7gvnOCCqGLBJkl+NHiQs0gtsrI
         bRJg==
X-Gm-Message-State: AOAM532Qdc7HlU+c1jfuH/jtXfAPiRpPHhBbDMZ6JKwaXCKakW6Z3M0r
        0ao0YusitACgy8quca8zeULHLaFni5NA+77TgiPmJg==
X-Google-Smtp-Source: ABdhPJzslU04TJeolVlaOp+ZuFB9uo/a8ecihYI20CmBibMH2Igfeq53XkdEw+y+JwhX/G8F/XxqEdbA/nlrW7J9TPI=
X-Received: by 2002:ac2:544f:: with SMTP id d15mr3633913lfn.465.1621524095168;
 Thu, 20 May 2021 08:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210520114851.1274609-1-clabbe@baylibre.com>
In-Reply-To: <20210520114851.1274609-1-clabbe@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 May 2021 17:21:24 +0200
Message-ID: <CACRpkdZPZedyuCjXN6C6NF6y8xh-fC40JQSbnqZK1EEoUNUDMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: partitions: redboot: seek fis-index-block in the
 right node
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 1:49 PM Corentin Labbe <clabbe@baylibre.com> wrote:

> fis-index-block is seeked in the master node and not in the partitions node.
> For following binding and current usage, the driver need to check the
> partitions subnode.
>
> Fixes: c0e118c8a1a3 ("mtd: partitions: Add OF support to RedBoot partitions")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
