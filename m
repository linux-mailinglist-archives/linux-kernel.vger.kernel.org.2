Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CEA3F7428
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbhHYLNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbhHYLNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:13:11 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F9CC061757;
        Wed, 25 Aug 2021 04:12:26 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id t1so22736217pgv.3;
        Wed, 25 Aug 2021 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0F6iaDXcOKyU/pgsdS91D2Ie1N9JY978bJ/8n6uXIY=;
        b=I1g2YLn/hnmv7T70rIzmVIGbBd63AuAPeXuL549CFaoX13s4es4rXLOqG2XTKcpuTR
         aCAEqXBa2hX9csDMowkOsqT7XXe2KHtM6Q76wOSuLNivQmRb5i321Weu4d1DBjeJbrnT
         QoM1BGjzr3uEdpdd7nYLYfS7V/h6oN0EWjFCHJHfgZLbH0co2upfemYy5sdSH7ePL0SW
         IN+YONtfRhlPEVlfG4Q2Uccr3PL6bjgK2fPaIz5yexhlNuhpBxaxrh8WhdNK7FvrFPZI
         QZ9cIjHbqaHizG2SgdeeT9S8H1aU9BaLuZOOkJYqi4Qn8fmJCpUnk1/huzJ61cwLlM7c
         gW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0F6iaDXcOKyU/pgsdS91D2Ie1N9JY978bJ/8n6uXIY=;
        b=jQT3K36ytZrZ5hrAU8sbvTwaxMwKm9MjSiNX+XmbQYKjM1eu8zVPPiX7JIgTac2ioH
         SUenf0eDZ8qVd2VL74gFE823faK51iD+n59FFeyG1aqEVxjkzXtnJs0d/LDo5mNs3XQK
         VLaHFMLl4OKGLDuxIN1nldoUgGSqetZLwtAlHqtY/HDv8zmDpH+feY7F+5mJO1A8KgYu
         dqcRg6V+UuL2XzzTAU+LUp2IeZsydu2kCStO/PUPg+nTqqL9iLbUNcJgoJ0qa2SkG+XB
         And6mxrqvFFwX9LmAHaBESuUFPCTPXgCgYALUshEs3kCmk27uSKu16s3IH+fk96eWu39
         ivzA==
X-Gm-Message-State: AOAM531WMAmfFUnf9GiaRl5dbRi7TRUsV8x217/3E0Qqsn7Y9Crm6K/5
        q11YvtJ9iETSKNhg7I/JI1xpxPdHLWyQQxGS66k=
X-Google-Smtp-Source: ABdhPJyeFx80oUz8NgoOS4scmsMrlTtxpkKj93s/4LfwYFNmg7EA3PITg+KB4O5JwDk2w04WALnpSPM1oBCqLL1QyBg=
X-Received: by 2002:a62:6384:0:b0:3eb:13e7:18c with SMTP id
 x126-20020a626384000000b003eb13e7018cmr21415624pfb.73.1629889945850; Wed, 25
 Aug 2021 04:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210823093222.19544-1-andriy.shevchenko@linux.intel.com>
 <20210823093222.19544-3-andriy.shevchenko@linux.intel.com> <CAAd53p6pQcura_tejtW7osiHfSnn6pCcxfm1e13==qmQA8C1bw@mail.gmail.com>
In-Reply-To: <CAAd53p6pQcura_tejtW7osiHfSnn6pCcxfm1e13==qmQA8C1bw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Aug 2021 14:11:46 +0300
Message-ID: <CAHp75VfZaV6WAddmscgTkyfRoq9cvcvL2A6A1kA6uBvZ3F=dgg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/x86: hp_accel: Convert to be a platform driver
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 1:42 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Mon, Aug 23, 2021 at 5:32 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > ACPI core in conjunction with platform driver core provides
> > an infrastructure to enumerate ACPI devices. Use it in order
> > to remove a lot of boilerplate code.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> The lis3lv02d still works with this patch.
>
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thank you, Kai-Heng!

Hans, I think it's good to go.

-- 
With Best Regards,
Andy Shevchenko
