Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5A3B9BAE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 06:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhGBEz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 00:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233455AbhGBEzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 00:55:22 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C5C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 21:52:50 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s19so8647651ilj.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 21:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTnzHjgvCB7+prnqrgvMcjjG1MNUBAUB+vPqpckmDcQ=;
        b=rN5k2yEgnRx9zB2epWCUB+oEitM0fhGltBcekUy79X1JPOgF6S6GKplw7zuHtBtQWh
         hSWc6HaFoyYdgXwFiAWrXqAg/bSReCOcVWDgVIrBi9VA0fOQkhCbArxlXB+r1TncqExr
         yts6rr8EPA3L2uk8AIQoOVFQuTeb6MGPY/vMK1ewx3J9Ib9/WNBSzqhSNkjs0TF07Rov
         KDKMS5rUYExBpxgDD9R0i0p/7xXZSsWHMhQxYhFH1dECnSFE++hw2aJ7BpT7YdE2+gWt
         PxQw7GtftdOx0u74EhQY/XAiwu5Bz2lOyi66eoetaWw7pstB6dX5pzKZ5/9N9kkWpW2v
         VGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTnzHjgvCB7+prnqrgvMcjjG1MNUBAUB+vPqpckmDcQ=;
        b=qGi7chxo9r+rqZgQDISujPjkg1maiPEVCOQLYUElA+CIrTrNZ+ycsscsue9eQcW7fO
         TU/sJ4a7ze2NnhgID9V4DKM5bSvP1JKDWAK/9aim6gDq7eXi+dYDf1Now46ZDk9sddYG
         njDrtWc9UX8vkorlxsQfE5zGEx95GXJgDRy7jL+dtBfMHd4OKUUwzouKFhsrvTcV2iQJ
         L3/gHsmo+nXxFVTxENnyox5fDkU6/OYsEBghoQ5ukHTlz6SM6SHd8mC7GRI6oCpHLCVy
         9wmHm1RxofqwDz4Pm06AexV31KbSGOh9DqFxJVCA2GS6wzY6mXvLwnlIwkpSPxZ8WvqS
         pR3w==
X-Gm-Message-State: AOAM531iaxNJw0pvJ2SnnaZ2ALyZx1auJPnSyc2/UgntWbM2Z82KGja5
        t8de7ERI5+Xi3dXcov646ejAsT5QyHOyQIJHY5KR4g==
X-Google-Smtp-Source: ABdhPJwhXP/ufyVIDmgCSp6rO2H9xUUw+CPophC6XtJ+N/YZdTspTb7mwnqiEnIGiTPbRNVfGEfuB4wHDIzK4cjbBy0=
X-Received: by 2002:a05:6e02:528:: with SMTP id h8mr2094954ils.127.1625201569685;
 Thu, 01 Jul 2021 21:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210629094339.874120-1-fshao@chromium.org>
In-Reply-To: <20210629094339.874120-1-fshao@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 2 Jul 2021 12:52:38 +0800
Message-ID: <CA+Px+wW2Vi0=+E+oAE4--At5wapn15t+TVxZXdNR03-iNrruPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: mt6360: Sort regulator resources
To:     Fei Shao <fshao@chromium.org>
Cc:     lee.jones@linaro.org, Gene Chen <gene_chen@richtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 5:44 PM Fei Shao <fshao@chromium.org> wrote:
> Reorder the regulator resources.
Would be better to mention the list is sorted by their IRQ number.

> Fixes: 4ee06e10dd26 ("mfd: mt6360: Combine mt6360 pmic/ldo resources
> into mt6360 regulator resources")
It doesn't need to be a fixup for 4ee06e10dd26 but a follow up cleanup.
