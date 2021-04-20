Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA88364FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 03:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhDTBt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 21:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhDTBt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:49:58 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB32C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 18:49:27 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id a11so1618091vkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 18:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qZjn7BJ930tQuUyc2/FYjSiXsm0RfnjdcY/KS8brw38=;
        b=RdVGFWk4xyjwWK8lDp2fNYt+lZL0h7VD9eMRjRLicNeWKxip3Vte1JCF+U77aq3O1y
         GNTC8p2Xgw7WBHv7h0Cyxg6rxD3hS5AW3Hx0kIEk6AzXZOkSFaab/PDFRgYvZ8S8bZv6
         Cd/3KsDJhSCWrc1nXOyqyMyuX+wFzj6PCy7JkP/5xq86Ky+farmnuHBqUlyLsHjStI9s
         ckcveV0w123J3BDLzve+n4aFbZjvGGJMq7EueTHyqG2t2DUbOxjqVVE0cPs7pzqyP3dz
         rPnqfRF8QZ0+2iWO/Fvzn+7+QGqZgFkReyhNwarAzgGU18hprKVP5JWyzFF8nzshp6PZ
         Q72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qZjn7BJ930tQuUyc2/FYjSiXsm0RfnjdcY/KS8brw38=;
        b=hAHC4JheTAXATbXMTgKPxSxTb1Xb4yo7fbHVDHB3y+T4KnX8fxsqgXGzAp5vD75F7G
         t0ACn6UkOXg0cVoAf/nPuadmZNjLgCXpiKArUHbRIqXkTARal9p9yMVK7+NwppbwX6aI
         InCmgy5GzVt/+TX31bKYyiS2JChLViD3M0NUBxBKfbXp1DOF6092k2sGNmbiZV6r/b+c
         8TIkin+MHiiNGnbcCLDre3EeFOaoAAEbz52UjfOW/UChBlLnFnUxHb1jBAhH2MmO87/Z
         ewEFoZXNGMkPBorjtFjCIW2S/Miv5K8SOTkjMqzm6W2MrvlnNds3w6iKo5h31gSy51N9
         byzg==
X-Gm-Message-State: AOAM533OqJ+S3dloLiGPzAW0/JUBxz9XzwDL8iXJIb4d+xDb4trsvGGB
        V7bf0nTbgKlH/zbx5xCeS94N8y1Rj+g7Kery19Ar4g==
X-Google-Smtp-Source: ABdhPJw0OGcwljAlKeGCi/eOkxnZbDWyQmVwZbTOHj2FcG5ahwl/tLbnnxBNcR+wGK++dIhjaOTk9tNdvXFaYXST+vI=
X-Received: by 2002:a1f:53c7:: with SMTP id h190mr17800273vkb.19.1618883366234;
 Mon, 19 Apr 2021 18:49:26 -0700 (PDT)
MIME-Version: 1.0
From:   Jue Wang <juew@google.com>
Date:   Mon, 19 Apr 2021 18:49:15 -0700
Message-ID: <CAPcxDJ6OAd=qdfxoTQ4cp5vQ6_+phWqX8gJfec48XyAZybBpsw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
To:     nao.horiguchi@gmail.com, "Luck, Tony" <tony.luck@intel.com>
Cc:     akpm@linux-foundation.org, bp@alien8.de, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        naoya.horiguchi@nec.com, osalvador@suse.de, yaoaili@kingsoft.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 07:43:20 +0900, Naoya Horiguchi wrote:
...
> + * This function is intended to handle "Action Required" MCEs on already
> + * hardware poisoned pages. They could happen, for example, when
> + * memory_failure() failed to unmap the error page at the first call, or
> + * when multiple Action Optional MCE events races on different CPUs with
> + * Local MCE enabled.

+Tony Luck

Hey Tony, I thought SRAO MCEs are broadcasted to all cores in the system
as they come without an execution context, is it correct?

If Yes, Naoya, I think we might want to remove the comments about the
"multiple Action Optional MCE racing" part.

Best,
-Jue
