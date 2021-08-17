Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47043EF31A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhHQUMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhHQUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:12:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80185C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:11:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w20so43673445lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ECUnJRdGhvZQ5vTa9e0gW3gLFpsPXzyagk4LktRcpA=;
        b=DTYC3ua7EePGe9OrsXz3+MkXNeZUErzxrswujVRS1A4/P0Ri3b58vvLqpMBCkEL40Y
         yAcgAAeTGUl3HdER8NO7xg0ji5zrv9uIYE5cvhXecmAMOaUFMxC/XvxiNRyaRUulqKfc
         MwrTek+xPSuQUq5u3qQ8BQ1X/XlHeXk5vqa2acgT+w3FlIFi9XInUc1+LTKnMlCs2KrW
         41u1c55x2SjUzBf5emHA41ryOhhiZLpfqIgxNKwEo778gtRZm7Ks+qaUe4Ofzl4SzIzv
         eNpxJu4jj0muaxLoUuv4WWbbN82Fv8SERSVj+LSSnUA9c3JKafuLABoPe1WKHVIjY13l
         iIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ECUnJRdGhvZQ5vTa9e0gW3gLFpsPXzyagk4LktRcpA=;
        b=Tsx7TEVguSxnAwhAUxIddnVrn3PrAO3WE46iLF9xCmzg8SWaC4onZebaxlD6711Y0A
         b+KiZj2VhabWcPOXwhBcjGo1f68+IZT6HGwdWonNi+uN2607yUmcGy8PWweFzzUWK3f+
         6WzrwiPZI+btmTIixZq+iNteEJTPNv4ruifj0LUt+H9Sexnqg7o/3Nfcd3w76DiEi/u5
         VCmvEbK7k5f0wXZjj4Mb0UV/JDkXVCZAcc29LOBj8vBAQ/GYt9WFgtUUBetStDkl2QA+
         +wjstN+YXcqWpmoOfhhu4yhKNZ/5wx7+1I26KwKhZg0e6ZGo5nexSqYFZbi2ercs227Z
         b/UQ==
X-Gm-Message-State: AOAM531oU1EySMeT4pBEECtHZvEPBF/zWl5FtJ2rUiV9GVCT+JA7n2rQ
        v0QUVTHHEk74/4DZNsX6e23uI+iEzyvBMppdQ8Mu5Q==
X-Google-Smtp-Source: ABdhPJxFwsBPGC+jBiacultIR42jboGDCaeK4IJ7HxVey6ekxIJCHv7HR8bP2YzM0B+ofhdgnZC6Be8jJqpMM39s550=
X-Received: by 2002:a05:6512:3250:: with SMTP id c16mr3551573lfr.465.1629231107903;
 Tue, 17 Aug 2021 13:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210817081330.9645-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20210817081330.9645-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Aug 2021 22:11:36 +0200
Message-ID: <CACRpkdaemTruXS3PTz3z_hpkvBYvi802dF6VBDq+fLEyxZStrQ@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: remove dead config dependencies on INPUT_MPU3050
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:13 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit b1fe0cf06f92 ("Input: delete MPU3050 driver") deletes the superseded
> MPU3050 driver and its corresponding config INPUT_MPU3050.
>
> The dependencies on the superseding driver in ./drivers/iio/gyro/Kconfig
> to ensure that the two drivers are not built into the same kernel is a dead
> dependency and not required anymore.
>
> So, remove those config dependencies on INPUT_MPU3050 for MPU3050_I2C.
>
> This issue was detected with ./scripts/checkkconfigsymbols.py.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Oops my leftover.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
