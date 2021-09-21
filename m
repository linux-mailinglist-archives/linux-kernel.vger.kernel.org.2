Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D301413A18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhIUSbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbhIUSa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:30:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAE2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:29:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g41so1353929lfv.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8Wo2U3fZZPbINkKPHgF5f7NF214eZln9lkI6++RKwQ=;
        b=EIj/r7YAOR4TxSFqtc0XezwotcPykhRbz8ISMtniL5l072qU1Z+ERmN3lveAjpoBK0
         vSgcUkbcqqBXAZCFZNe3AVHSJwdMknvcYAjd2iAijfzGnKDG2GUJZZjDgZg9jD4mpEB0
         lNvDtdHeZPcdYBwgF++ZjBvmBuxqm3SANvk/lvAZ4/NpGHCaGQ3eFo4x181/HgQUJEs5
         FIzysxC6YjCspxjPwnernK1SypdP416uUtU369zSvSiJsTFYVGFGJYCXxHYX9OBbfCVd
         nZt7hJD7RE6HLgXfXiVRneeBxZQ7Afw06UDaMBDrmRvi1cQz2SLpZg28DdCBRgO+mE3Y
         1cZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8Wo2U3fZZPbINkKPHgF5f7NF214eZln9lkI6++RKwQ=;
        b=tDj3jf0QjYC31L8W3AYw+S+mCEwGvo0NO6387meYOs2KzT5lZxbDCLBOiROJAim4rq
         fMuTefc/SsYPxKUZCG4aEOO8JIUSVTbmmy4R3GWIUiHZb8tqYrRHdCQaregHTbZDKax7
         LLyyQ+2NRVi5PCZl+T0hFNeyYaqU3sfiu+wbbGiSUiyh03iMGHGPfVAh/afBPyc634aA
         Ce1MnJN3sS/d0G5QL2xp5oVsHIklLYEmN1JUSQB5G07TOl2sQhRRQ4Lie3iskCsHYfn3
         BVuDKyAks8IgZ+DE9KchqTOzDJHrioTiSGnMlIAhNrzm9j1yNN7K5+9JOjVXfN+H93AV
         hCJw==
X-Gm-Message-State: AOAM530GXESsBcjarfZEBPl2ZZ/77MhhcU5kQU+4Lq+dBuB2ZtZGeBRk
        qFleYH7DCSuZLo0O42cbVxZqjKZ5ZcyC+i/jIj8HJovk4KI=
X-Google-Smtp-Source: ABdhPJxiJW0IlyMzcIpmX7lPi/2jCIPM5++vLf0SHJS3hopPHH2k7+Pp1sHDHM2f5OBfm+DHHjqBilrIupGH3UYqDkY=
X-Received: by 2002:a05:6512:3c92:: with SMTP id h18mr23624483lfv.656.1632248969067;
 Tue, 21 Sep 2021 11:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210920103335.243-1-caihuoqing@baidu.com>
In-Reply-To: <20210920103335.243-1-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Sep 2021 20:29:18 +0200
Message-ID: <CACRpkdZHUpHj8eWc21tYPFwA7BpWdj-dS-sbzxgoi=n02jctbA@mail.gmail.com>
Subject: Re: [PATCH v2] Input: cyttsp - Make use of the helper function dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linux Input <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 12:33 PM Cai Huoqing <caihuoqing@baidu.com> wrote:

> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
