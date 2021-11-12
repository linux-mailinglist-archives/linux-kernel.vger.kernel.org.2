Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43BE44E02C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 03:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbhKLCRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 21:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbhKLCQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 21:16:59 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C6EC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 18:14:10 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id a129so19770437yba.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 18:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZY4s5ylz5JjvU9Y/cYs4aSYUkvwJz2HHa2zqFTnNdjE=;
        b=v0sz9GcPwSfnTYLtM+5JLh1gxfthFcIgmtzAYC30bfbnAaP9dwRC3AiirtZSY6ruJH
         DcV/2q/wW+B7rWigVwP+vlNLa9DP4WjIxlgm5Bnc2JUSmYV7Ly+hzNF/SsoJv1I2X871
         0hDwb85bW7A1diBZz4NGWGGWzySwKkEllo5fOfue7fP86KgmyWOKncTzdusoltrAd/it
         nHIt+TTaKBoQqJW8hYJCiG4UzWQ66IZJUj/NRfM1WJ2LtrJVicO3q2mwE+wCYL5Ja+8D
         JwNZBeR0HnXXviFGPmW0NEdu+MrCIaXjNHr9SXN0LRrPq/K3obAXvb7596yfA6COYT+b
         vOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZY4s5ylz5JjvU9Y/cYs4aSYUkvwJz2HHa2zqFTnNdjE=;
        b=kQsFhz5Bigba+D/QbfE2ehbYi+SKqNyO5yS374B98f5E0BKrD1cJweUdDzQ0HzeqKz
         MGOz91fk8L1PNpt+OZ1YwBjszHZRaay4g6hP+Bmwv1QAna7/gbbOd0iuJEejlMRHES8G
         NfdCZrbs4uDf+hISni2cQdEPalkV0L4in9Uv6AHFbcG4u8vpD0ZHzikd71TlYFPUQGdr
         HwT/Hlymy7FlHf/TTFh1UMVT3OYuqJlhjcZ21Z6fMjMkL5ndmwG183e55W2N2aTheOBs
         vsAzln+jum1q8/oK5GvR7XxVX01O08x6Pw464kJ5CWBpsE0jOIf5TEJLuruj6vbTvULm
         HM7w==
X-Gm-Message-State: AOAM530jnSmKi0FoTHDitHU+wcHNkqyu8kQYYCpaK/eVJTlsaM5scO9d
        DMGAk/KS+nm7cjZiiAw2rqupCUSoNJEegLrErxzgFMqwq8tPdIDP
X-Google-Smtp-Source: ABdhPJzcEI6MStXj6WmUYXYaEbmMx3jkPh0h8ToSzLLNPs39oROcyVNELCYG1cAc03tP3lurXbKlfjc8vJat/wo8oA0=
X-Received: by 2002:a05:6902:1342:: with SMTP id g2mr13490640ybu.419.1636683248797;
 Thu, 11 Nov 2021 18:14:08 -0800 (PST)
MIME-Version: 1.0
References: <20211111062445.5236-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20211111062445.5236-1-ligang.bdlg@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 12 Nov 2021 10:13:29 +0800
Message-ID: <CAMZfGtWpfVnOSxjXyJxaeDq_798nLE9SxyBiwPyG7-Yfjf7VcQ@mail.gmail.com>
Subject: Re: [PATCH v1] vmscan: make drop_slab_node static
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 2:25 PM Gang Li <ligang.bdlg@bytedance.com> wrote:
>
> drop_slab_node is only used in drop_slab. So remove it's declaration from
> header file and add keyword static for it's definition.
>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
