Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF64C314DA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhBIKzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhBIKwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 05:52:37 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0DEC061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 02:51:57 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id e15so12567955qte.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 02:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0Zy9zy1mqYJNW3MaYOV2YR579JFXDa4r1wK7boolLw=;
        b=R2bqc2P9d3MCrDxyDqTkXkuLtWzGFBcALgvlccAlLKyU8fqvW7pYeH86O0im3TCfwP
         j/Q2qeZNh/ZZ8sIpfs852lIm/RTVEE8aAQ5mUSy4V3fHSt5NV+oaXsuSBYuip/yvThLk
         OGrl0z4ecVHbXe8fjvv2reuEQ1ipwYus81pwRqbSPEl3hb6RPui6pCViTWscBGHQoGwK
         yQTIyFglK0wjV7r0qC3K+RIsKbqy7zdmVyHPj1zwjZ+3dqJFz8lUl7wVjCSMmQG/CgMb
         yOfYBR2hnYXDSpypmVOosn0F6UabM2dVB73udXmFiKOwAqFJSZJva0/CoeaW17P04KyH
         P1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0Zy9zy1mqYJNW3MaYOV2YR579JFXDa4r1wK7boolLw=;
        b=bWKaSz8JVLcX1vitPo9kQdR+t0mj493lcyZKROdwyxHBTJNv3blcIt4/iPgnzWbgG3
         NRZpVJFLvAxWP3tHiUV+523eYjr23K07+iLVIAsrFcEYwXe8tKbFmcfJQAOAUiDja53N
         ki9s9110RlPYbQp6+H4cOGvCFz0lGUR2qFIxnxbluawBqORjoylGhhfrtn97cLNzK2XO
         8OEz1ItA4e7Zq1FW+Prkx2/YNx0MKvdavJPewEyq9itQW0GDZY7g1P9Mkx9XM+/YVgQT
         b0d6YDPsRsySXpf11oWj9KlwtCxqxzZ8KKezuXKlqnpHObwW9np9xmBaSGtcaPEO9WCH
         oiJw==
X-Gm-Message-State: AOAM533Rf1JvTp74pWOLElUrZwR8Xi+iQ71bgKGuwlFZXJOiT3o/dpsX
        hLOyVTBDmckWseupf327bL1Pp1cO18vyewysDwzUeUza
X-Google-Smtp-Source: ABdhPJyUpq1zwAu4OmW7EOmc2O3ggiF/nHROY3YjMvhAPWBBhkP4NTWKYuK28z+UNE6AyptUwYTNcu/fbhDebecbiDM=
X-Received: by 2002:ac8:2231:: with SMTP id o46mr16394793qto.245.1612867916978;
 Tue, 09 Feb 2021 02:51:56 -0800 (PST)
MIME-Version: 1.0
References: <1612684327-115106-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1612684327-115106-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 9 Feb 2021 11:51:45 +0100
Message-ID: <CAFLxGvxC4KtvtU2rza_aGx2RPONxr7XygUwXCDriYiCr8qN3qg@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: convert sysfs sprintf/snprintf family to sysfs_emit
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 8:54 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> convert sysfs snprintf family to sysfs_emit in 'mtdcore.c'.

The patch still does not explain why this is needed and what it fixes. :-(
"A bot told me to change that line of code" is not a valid patch description.

-- 
Thanks,
//richard
