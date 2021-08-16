Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE393EDE72
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhHPUKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhHPUKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:10:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D0AC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:09:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d6so28252832edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eoqcCHvcgFjYOwCf/rRzWn/RIeAjZ2LdPjbgucACr2k=;
        b=l4fkPsSkbvhdAWPUaxEovtAuFsvKk8qqwIS1BRiysxH1Bj0yc9D+pNJNd4f8rRDSJL
         rIJ5RAlV1mw90U3WVwRBIGDDXz4Z7DGZQyTZzXGPw6gjrjlJQLAvnLRMMYRXSd9o+3mw
         1lA5USWdCSvMZcaGxALf5/tfOpY22LtECnpTQ4xMI1fApK6DGjD0nVMVXlnvoo0ea1pe
         ARRu+qfg6F8ZUZvKVYl/MPdl3Jp00KzirpORqJ7ZUM+sBXEiaCRAY2BqDjGZ6PrVW37d
         SROq16Wrn/bCQa8R2GfbSI+l2ipJ0hEK+RUJBLW/lenEhAP77eA9FxoEaEOx09H+0Q+Y
         MjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eoqcCHvcgFjYOwCf/rRzWn/RIeAjZ2LdPjbgucACr2k=;
        b=n3PkdNaZQ7Qjv0QQHa+3higYOyxMLHTZT9Pyyur81ekX6o6BfFatm17kRyQqqEO42B
         glacYFFyeY4L6UN45EHjKbVvkyVBhfqReTxS6b2BZyXyna5YYldXxSDbRst6ZuceCFYC
         MNOJLd4CpS8TRiEjNc2ymBsoSyaoqUF9jmCnqX3MtBoCnxK+47tsX2tTC8iPhmV4pduG
         jsxDsAipoE1uwuotxN0n+E0ZTQIVYV6hEWgukWlNwp5BNrpqqlJmHRxHqjAFZCOVtXXH
         /ojbgjsHw5PBUFnqKRXyrrme3wC5oKE8xKFuTrlz3SedlUiLi2pz/fRF4CktK4pR2r0n
         CUpQ==
X-Gm-Message-State: AOAM533dosawBjiRdJmNB8UsuImgiKi9zwFGsix6WaDNOWOf+Yux3OJ6
        nKRXMG4Y/+GmMqXcCarnxRU=
X-Google-Smtp-Source: ABdhPJyi0eg88s7YYQlUZB20e5s7OeQLsiLpWO9toBIT/tHKeoGWYR1pxwxb6+4WmWIbjZah7n1Mbw==
X-Received: by 2002:a50:ef11:: with SMTP id m17mr330830eds.233.1629144575808;
        Mon, 16 Aug 2021 13:09:35 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id i6sm90106ejd.57.2021.08.16.13.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 13:09:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: refactor rtw_is_cckrates{only}_included()
Date:   Mon, 16 Aug 2021 22:09:33 +0200
Message-ID: <1730270.0mlKN7IZV0@localhost.localdomain>
In-Reply-To: <20210816193125.15700-1-straube.linux@gmail.com>
References: <20210816193125.15700-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 16, 2021 9:31:25 PM CEST Michael Straube wrote:
> Refactor functions rtw_is_cckrates_included() and
> rtw_is_cckratesonly_included(). Add new helper function rtw_is_cckrate()
> that allows to make the code more compact. Improves readability and
> slightly reduces object file size. Change the return type to bool to
> reflect that the functions return boolean values.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_ieee80211.c | 27 +++++++++++---------
>  drivers/staging/r8188eu/include/ieee80211.h  |  5 ++--
>  2 files changed, 17 insertions(+), 15 deletions(-)

Now that you took into account also the second of the two suggestions by Joe 
Perches (with a further enhancement he added later), I think that this is 
really a good work. Since the first series is gone, here it is a new...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio



