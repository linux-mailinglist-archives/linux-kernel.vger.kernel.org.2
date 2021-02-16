Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C8431D2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhBPWju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbhBPWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:39:47 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D3BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 14:39:07 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id w1so9989526ejk.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 14:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPv9nnPUm1TtsaIpcziIZ0EFUe5FQcNRA0/EfWprXeY=;
        b=mGOK/Lh9DqKxJSxcLC/cxXGfRCykdF3sEex6bNjqzqqz2wEXNZBz8qBIw/o/GsUdUy
         JqGdAlqK7l8xfqw4n9s7IjyviTTAuGHuBaeb6qCFKidDFjkZ//uchfJYsIGgwHVtr+F5
         5gjY6KulqlRxhZvyySFR+JV5+adv/UPppeptMXju3SPBlKXcZzZ+unOTCVTGvnv+c2ot
         fXRavbbrvHNb7PTxme8yT8CBwFzOcc+7stZvccs1xfXnQKM4yLPDDsEnnEnMxfaI+3Bw
         8uMjxu3dSsu34XskLTm16uo962LYhNuoS6DU4FGoagVodC6dCGiyzDAgW8vA2UrBWvkE
         o/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPv9nnPUm1TtsaIpcziIZ0EFUe5FQcNRA0/EfWprXeY=;
        b=jMmNM4QcXEfdzXzZlXu564ZXsMPESgvfacIqG2jqUS9RRJQX3J3MZJnJ4eKMlPBH6u
         Qbapx0xTmBWgVabFnkBQD967dKOxQ2k0Y22McuIy+b11QVxLpFJ5lV2/VjCmekFs4rOA
         pbz/oKfzQx4p6EFn2diejw/t0kD+AZTKNJcvglLsLHa5P6o78uzH8GGDZPfLdzl02+Wb
         i2sglAwUXS81YuWPfwhIbavqP0Pk+a26Mfe2N1gMUtAv3xTO17L/VVs/KFkhW8Y+E83g
         cA0ZrDllm6QPU+99mt7EzQyLRB56Dqi2Z4CON09+LBXQ0R2241jfjaNUZlEpNXe3HNrr
         ThBw==
X-Gm-Message-State: AOAM53040pXr6x/+Oj8yLomxyEtP7s6ZlkFfX7FTvK1SsEyMDfYUoA6D
        YvuzwVe96tgA1i6cdF8a85IlDt+q5SUhohxpgnvAo2a/4f+mcQ==
X-Google-Smtp-Source: ABdhPJyjE1eb1Bs0azjhOXFMczp7BzdIXSTzhGuiY/xcrO0h9FgGKkON6FHrIIfzEIYcpgRYGzsqpuUaoa9cw1ekQ9c=
X-Received: by 2002:a17:906:5655:: with SMTP id v21mr4481219ejr.264.1613515145917;
 Tue, 16 Feb 2021 14:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20210126021331.1059933-1-ruansy.fnst@cn.fujitsu.com> <b685493f-98f5-9717-f88a-308e96440dcd@oracle.com>
In-Reply-To: <b685493f-98f5-9717-f88a-308e96440dcd@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Feb 2021 14:38:55 -0800
Message-ID: <CAPcyv4gdeg+RfATJx8Ls4E=FE913JuxftdO1vhsoWJh+_bpe1w@mail.gmail.com>
Subject: Re: [PATCH] dax: fix default return code of range_parse()
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Zhang Qilong <zhangqilong3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:19 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> On 1/26/21 2:13 AM, Shiyang Ruan wrote:
> > The return value of range_parse() indicates the size when it is
> > positive.  The error code should be negative.
> >
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>
> Although, FWIW, there was another patch exactly like this a couple
> months ago, albeit it didn't get pulled for some reason:
>
> https://lore.kernel.org/linux-nvdimm/20201026110425.136629-1-zhangqilong3@huawei.com/

Apologies for missing these... applied now.
