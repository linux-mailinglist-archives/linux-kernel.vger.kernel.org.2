Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430343E22AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 06:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242873AbhHFEkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 00:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhHFEkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 00:40:35 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF907C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 21:40:19 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id a201so12913246ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 21:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2ihiTBstu/ghfSxcs1f2+pQV6+vs2bf3Mboq2+GrYs=;
        b=ScQMvNjfYNJSGtjPrCNoRPznDc6d5pMej9Fqm+KRBn8h9amXskzkNXOuipENioI1rq
         /xS8PGVN/aV9AZYVzrwF27cERRrgSF5TDEoeBdgol4/o9JK7Dw5/t6S9KTwF8X/U3wmR
         EoVxxBkvxoJyneBURRl7jbEhutyp0m1JlD6MqZvB4GBDtaQHuf4tcHqUMCG9jdVd5jPx
         wR0HvMaoLS/KFeeOV5MMJm+xwN0TvzgrTtTgMy2Bb1UuH6kDiNbb4crnBddJSO7GTpGL
         w+YGSP7iSbTd2olgPr2U/2PrGSXPdrrBdbnJYtL4j7yISkbn+Xyx6nOirFw7evWXBqtc
         xyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2ihiTBstu/ghfSxcs1f2+pQV6+vs2bf3Mboq2+GrYs=;
        b=mmvNX3ogee2AfH1eYOGQZdHbax/jGVZYwVcnU1yxA2Z1qZptKkA5TMoIYVpVidwXX+
         MajFxzd5quceujfIp+K5f0udXNRiBjU5X3Ay9UuTGoydhP2YZeTnjg+Tx0Xmu01/me/M
         waVN5fIBW96NyqKc5/aIitMc2hhWBYupMRJlf+QwHtPy0/l/aepakYhJ7mZT5dq/RP81
         ubPOQJmWnBWkegb5QpjtkbuT4GHynpZX+3xm/+ikKL970W4W2kEphIjLOw5AHyjoVEtT
         5P7xN1QZi7RqZwYNqRPTTPxnq3JLGgtfCcPlwV9LqsvmfsfSG1K3pW38r/u8oIYCF9xs
         kXMA==
X-Gm-Message-State: AOAM530apPjk1ARntmtkRjVvWzcdY8iIWmhNc1p+F+5EL6uJ7yjl1MOm
        pnAAuJJjGiEt9qPAJAupE/PH+O8PEmemE9Ug6xwEAA==
X-Google-Smtp-Source: ABdhPJwwfzkphKrpb1Q7KfPDzSz4SSbIQ8eSjOWjUnLgCAhafTdZDlZKO6z/PKhjmUf+ShlBNIq223ptUqDafbp7E/Q=
X-Received: by 2002:a25:53c9:: with SMTP id h192mr9792706ybb.310.1628224819006;
 Thu, 05 Aug 2021 21:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210803113538.560277-1-fido_max@inbox.ru> <CAGETcx8QC+AMXvmk4RB=LGp00QLVVX4uCeeruAjFnGq_irMh4Q@mail.gmail.com>
 <dff603dc-9038-71cb-bfcb-5abc24f17109@inbox.ru>
In-Reply-To: <dff603dc-9038-71cb-bfcb-5abc24f17109@inbox.ru>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 5 Aug 2021 21:39:42 -0700
Message-ID: <CAGETcx-evuv-A+A5v3-ubFZNvn_i+QSvg+tSW0OOgAd82-pytg@mail.gmail.com>
Subject: Re: [PATCH v4] soc: fsl: qe: convert QE interrupt controller to platform_device
To:     Maxim Kochetkov <fido_max@inbox.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, qiang.zhao@nxp.com,
        leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 9:35 PM Maxim Kochetkov <fido_max@inbox.ru> wrote:
>
> 03.08.2021 20:51, Saravana Kannan wrote:
> >> So lets convert this driver to simple platform_device with probe().
> >> Also use platform_get_ and devm_ family function to get/allocate
> >> resources and drop unused .compatible = "qeic".
> > Yes, please!
>
> Should I totally drop { .type = "qeic"}, or keep?

Sorry for the confusion. My "Yes, please"!" was a show of support for
switching this to a proper platform driver. Not a response to that
specific question.

I didn't look at the code/DT close enough to know/care about the "type" part.

-Saravana
