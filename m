Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB803E5B56
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbhHJNY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239647AbhHJNY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:24:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35323C0613D3;
        Tue, 10 Aug 2021 06:24:35 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id oa17so8242925pjb.1;
        Tue, 10 Aug 2021 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTld1j5C9iELzw+HFUUgfHK9dJLHFW+XXXF2zLVUiLA=;
        b=tSO1nPziwxj96S2vnyuQnRLStktazMPl8UWjSQKZHIyj2QP+G/xmukbn3zEUSkWb5D
         pFXTuD4PMcnj5eCPz46pYIc9DLiqy7mSQ4JrS6dnbrGU3pXyyhPd3xLf9WGo/z5SgG1S
         sZqwF7+c9tF9EKOD04Q/kTHs9GvrGpfndEaG/iCVgWgUQlCRgzYgIYMxB3syVzrXYVax
         OHVoJzVQg4Haa/m7WI1cjuehuL92Q98JknJ4xUkbBlJQdDNe+UppxSV5/PI2UglHPxl/
         Qmrj0fdl5m+mEv7zhd4GRSP49YPevvhmYACJ/oLMmkpNmDtY68B4KcgBHvJ6i9URZaOx
         DiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTld1j5C9iELzw+HFUUgfHK9dJLHFW+XXXF2zLVUiLA=;
        b=Zp/tWOlqpxktUGCt6aYU3xSUOnpeA5sElxgTKbTimSU8wVveoV2iC7sqmG3p1zNRUr
         wiEhn1LA7y8AX3VFM94VPEJj2cZ7aCch42jtIWTgeQOoBCw4rqUpYInAoymLXUFrMKZQ
         7eYXnLJYwaGFdYQui2iABeb/VBbC8fKAXAnFm+IRmy/jFpNx9NhoLkLag2OhDVxUFOdk
         u/5LsATGo9nW2qE31hl2quOe0b3OzDo3YG+xY0GSp3s1PeLuCd3Q18Qh+ggv2FRqUi0d
         +n3uYI7p2fRMybyBahwt0nNg9iDJNA5+bGemMy7c/ADhOMf6rFUC03k9gwuxs0kXfQqD
         ABoQ==
X-Gm-Message-State: AOAM531ZkwZFInFwCayDMDP3Ncy3+E5yPB//sbKU8yjhbZOvID02Xrau
        AkoMd3+yZ/r1d7ylNSpjnuyKKDYZkUoU4mYuoN0=
X-Google-Smtp-Source: ABdhPJxitYE9+0tmGCAfQKTa9uqO6ddpD9sAYGpZvTGHHVKcT9ZzQhtVkQ9L+yySQvH/nXDP8d1mLVGVC9IT+iRsxRo=
X-Received: by 2002:aa7:860e:0:b029:3bd:7e49:7a14 with SMTP id
 p14-20020aa7860e0000b02903bd7e497a14mr29575198pfn.40.1628601874568; Tue, 10
 Aug 2021 06:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210810095832.4234-1-hpa@redhat.com>
In-Reply-To: <20210810095832.4234-1-hpa@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 10 Aug 2021 16:23:57 +0300
Message-ID: <CAHp75Vde0yWoKh4KOP46iwXK6SBAcw1Y7Snw4PWoi1HRspHJDQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] Move Intel platform drivers to intel directory to
 improve readability.
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 4:20 PM Kate Hsuan <hpa@redhat.com> wrote:
>
> All the intel platform specific drivers are moved to intel/.
> It makes more clear file structure to improve the readability.

Thanks for doing this!
I'll review it later on (this or next week), meanwhile can you rebase
it on top of PDx86 for-next?


-- 
With Best Regards,
Andy Shevchenko
