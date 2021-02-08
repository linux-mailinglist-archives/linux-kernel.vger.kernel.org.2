Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAA7313331
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhBHNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBHNV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:21:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BA4C061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 05:21:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o24so5532437wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 05:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/j7p/US0+NqzqBFdEXGg5t/+VEYJ8Ie/dDJTmC1ksfM=;
        b=msatjmHXDaOEevAtvgoLlshg2SK4HWE9F+DDAnKeF8wmuNdMkXO3pb2FxZ+puo/2tX
         bOEbptCv0QPjDcZS6rN7qiiuBvxbNgnITMm3rgh3k1eQhfrMC/+tvLdeHCNl9sV1CSYt
         Vglxmp9fm1ENYcPWF6NVuHooNCBIpHgg6E1Gi1Tr2wyr3p+1N3WOG0C787duGLGD18Tv
         Aqyq0cb8PbmzLvyeogYx+ZCWC9B1bvRxZUr4dcqeNu3TuL8qIsm03X+b+8cbi0BtlemS
         Ylc9vOTC8h/aXGyxtnwWsKUKJlrwuzTK/5omfRNsh5FjlkOjOQmBon73HBrVKJf5fd5F
         XBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/j7p/US0+NqzqBFdEXGg5t/+VEYJ8Ie/dDJTmC1ksfM=;
        b=Rp805pO695mnlifoz8uGKVHSrcrHj7OiqAn55NbIvA2fqlFOSs2KmW5IhvcQa2/aFs
         OF8Rdzro894xuzKehctD5H2w3vw9JK7OmhQX3UxCEGA1LwWWK1YtAX8+UHePyWRB2tbX
         rP2r4T7Gsp6JsKfffnuyWd74kwD5T9m1Mh3ua5seOYxEzTkOoIX+SR9hsxJbSrdEV4Tm
         0cm+yuM/BSiKoHDiD5CjZlSP6R3K1t77pudeDBPZoxurZ7nZg0Ekp2+DCYeQzd+K9+41
         uhBv1w8V93tzyn1xKyvEdY6FZ9sDE7SuOdemcOKjHfsqBxQgFYlDyjYf8rkPKgZiuyWX
         u9fA==
X-Gm-Message-State: AOAM530t3dvPED3Iyob06rujjaYJvT4zBLa5GrEvM42myPKIekHo7RDz
        es7l+EaA3QXaCbCIxt/qjxfIVHLvFkwwe3Y3GJRwXnxw4FU=
X-Google-Smtp-Source: ABdhPJx5Cp7IP7l7os9vRt0yqXNRtYCu4Q8Bn4DDmkqmHj4tjYxVIcvdJi+pju7EAQ/72C9dClthdT5C1BsaC48CqUc=
X-Received: by 2002:a1c:b684:: with SMTP id g126mr14458121wmf.94.1612790476846;
 Mon, 08 Feb 2021 05:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20210207202501.9494-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20210207202501.9494-1-rikard.falkeborn@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 8 Feb 2021 08:21:05 -0500
Message-ID: <CAGngYiWV43EGDDPU7K6qjFTMmniVY0eOY_BmVP5iJRdtm=-H0g@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: arcx-anybus: constify static structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rikard, thank you for the contribution.

On Sun, Feb 7, 2021 at 3:25 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Constify two static structs which are never modified, to allow the
> compiler to put them in read-only memory.
>
> The only usage of controller_attribute_group is to put its address in an
> array of pointers to const struct attribute_group, and the only usage of
> can_power_ops is to assign its address to the 'ops' field in the
> regulator_desc struct, which is a pointer to const struct regulator_ops.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
