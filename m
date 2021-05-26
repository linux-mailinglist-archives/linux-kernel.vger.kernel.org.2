Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09133392094
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 21:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhEZTLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbhEZTK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 15:10:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC8BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 12:09:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ss26so3903301ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7UJSGwD9lnK9l786rIna3VQ26Hi9EAibdCrU1lXiE0=;
        b=bb2vHWiMn35eXjAuD7O7woerwJfzVHiUsjmI5V7ctIeSEw07Yf+WtsSUowOFhzUhDQ
         d9kdLWvURcZBpCzgFtKaXXGVHEdjFBiezYQuvq5XP6ilBq8OzEhSQONCu1FRg+bSvf9w
         mUwgMq7kCOPmNa+dNi4d+oO2zOme+1Ux8NMoiEmiiMc+6qZJVkubG2J0jTlG7A6O+h14
         UU43xeAPcvcOqJZ1K3Z8t2x1ehcXe+a7ikFuVqwlx4gCYgVPPLtHx5ko5ef8zPB3zVzh
         9JDbfD3qmlyM7RvIqashCJYk1yjpHBNM8P7ZBS1sVQuEFZedQyx21aH2bKI2W8mPjul7
         4cJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7UJSGwD9lnK9l786rIna3VQ26Hi9EAibdCrU1lXiE0=;
        b=G9aaaIVMWJAGNNUDmjc7uuHPHfGA+1warqDOvQadRaUGZJlHNy7UXMKuC46kC+4c0a
         /GX53dqtGe0IHivGH+X5MyH0VAPpZrK4L2bCMWyZcAcMCpMQJa9t6vyHBcTKBVWL7Fpo
         tdcTpoOTihVui7tont5gtCQYXTtFwQr5OVkw4glZERoP2RtvX9LVfh4XkPV0zQK1t3l2
         QK6Nt1rPvwTNiTYl8eVEn7QiVDavFJRnR5INWdbY/KxQ2fH7qNEdgpi+nAlAePNQIl6j
         afo/mxUHZtWd20ttA1pnpw+MpMADQM5ZNmBakkwrqz6MXk5MMF2bbLfx9QYeP/FcnKnY
         uHwA==
X-Gm-Message-State: AOAM530Dwo4hPgkh8VqoudKYYnc9vHch6rpFZF/wZ/7mamGtbnkO3u+m
        PTVWdCd6toVtIGbETpMI1Mo2jLtUfXt7MjjCy/A=
X-Google-Smtp-Source: ABdhPJyu4Opqxcw8hexGclIYW1L19l4ZfPYdYbCNcAm+SkpMvZtG0HbMpP7FLdb5o2yxq/HOS+4OqJ1/TZOPkABuzak=
X-Received: by 2002:a17:906:fc0c:: with SMTP id ov12mr34979125ejb.301.1622056156513;
 Wed, 26 May 2021 12:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210525233519.343068-1-tpiepho@gmail.com> <YK4BDmPDuXfxEDn7@smile.fi.intel.com>
In-Reply-To: <YK4BDmPDuXfxEDn7@smile.fi.intel.com>
From:   Trent Piepho <tpiepho@gmail.com>
Date:   Wed, 26 May 2021 12:09:05 -0700
Message-ID: <CA+7tXigdWjifG6DApXd1308tM8vNw7-x+mzSRAsd-PtWj4VJjA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lib/math/rational.c: Fix divide by zero
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Oskar Schirmer <oskar@scara.com>,
        Daniel Latypov <dlatypov@google.com>,
        Yiyuan Guo <yguoaz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 1:04 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> What has been changed that you haven't applied my Rb tag?

I think I thought that was for patch 2, which changed (slightly).
Patch 1 is unchanged and should have collected Rb.
