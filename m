Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC593E4C22
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhHISa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhHISa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:30:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181FAC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 11:30:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso629955pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=733Ug3Zv1xSkb+QZa8CrMGU92FF4Eg5kRF8wbQ2GHY8=;
        b=oScxm7UGz7fXFnDQQwpkOXLlRAwlZsvKuoeCy+8HEjntR55F0TaTqTDwjDE7RQfCvx
         WtPu3418DrHStDY5EmaYmC0tT8mn3D+t/Bad4wfRpAJOlyUCb814moN8VfyDlMhYOTbW
         Z5pBXMplklYpa14BtvzWpBefz+e4q1ErHtHPl2YRU9thHRN5t47WzQZPEQ3xqT5toDmh
         jB4+/spyZa1qivAc+bfvARS6Xp0i7uFiLugg3llKYUanZc5+CNszMLp0pd4WuEOOPVuO
         DZ6Ohf8U/8zWAth6neke6tgpHXRahMs/AUA30yq1jiAKvtiw9/q8miOaKJ2NGog9LJAh
         gtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=733Ug3Zv1xSkb+QZa8CrMGU92FF4Eg5kRF8wbQ2GHY8=;
        b=Xz96xcCq8kfw+996Y6uRY7We+DyHtqbt/dEzxRPjR3lJo+l0k/uLekQqD0m3f4Tx8M
         ebywvhhZWHaa8ZILZ7QladnQHotKEfctaso5I2tG9bG+DXMuHyH5aov8TvlzPcyDkhHr
         qy829Z+svwjfAlKKHLZSlK3U/QEkfB4X6XRKt+cu1LIQfaZFKV2QUa+UGAJVm/ZzM9Si
         mbyzE+kV5Gvi0n9i0kXS0c1JiEx84ltgn7szY1AL+d4LfFsNQb6oBCQhSqCBR4r7nKhs
         3JZV+zUFPo6tbMljYxivZmNmHdTohacUTRvtKDlWF2RJZ46PbkM7wnochHS2t048MM1h
         NVcQ==
X-Gm-Message-State: AOAM5303EffXsG9qCMip2eLklsIKY+yBdxaKXUVnVyq3qD7izNkUR/g2
        01YzcXJVDBTRsT0MXBGnKqF3aaat6/7ihITQjGY=
X-Google-Smtp-Source: ABdhPJxeS6wzIIMwCwuIjClQQq1qspecS7QAC8oEfD8nWF4HR1JGLD6QvTsiCJZXFij24kBunhlEXPtpw2w9AU4/V+o=
X-Received: by 2002:a17:90b:33c5:: with SMTP id lk5mr457148pjb.129.1628533806512;
 Mon, 09 Aug 2021 11:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com> <20210809143049.3531188-3-mudongliangabcd@gmail.com>
In-Reply-To: <20210809143049.3531188-3-mudongliangabcd@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Aug 2021 21:29:30 +0300
Message-ID: <CAHp75VeO31R+oYSwoFLnxtz8naK+9OrDgHagVGLrv7ARJjWfwg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ipack: tpci200: change pci_iounmap to iounmap
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Aditya Srivastava <yashsri421@gmail.com>,
        industrypack-devel@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 5:42 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> The deallocation api for ioremap should be iounmap, other than

API
ioremap()
iounmap()

> pci_iounmap.

pci_iounmap()

Since you haven't compiled this, for the next version consider to
switch to devm_*() and pcim_*() APIs.

-- 
With Best Regards,
Andy Shevchenko
