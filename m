Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662D23FCDC9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240622AbhHaTZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhHaTZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:25:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34195C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:24:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m28so1113798lfj.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWFkkvCODPs1gGNFlhWX69S2LvyhHBIDjA0U78R4gZE=;
        b=KyVEPAeFlFYKw8eOIQf+cBSy0IlRFlLGUygecieBHi+cVJ2lx2b55OKPscQWoTpbJB
         SqjuGsh6ATL3hxaod7W4Hm8M5G3oc+/tnxgVBjrWbXnWSzGHYwV8thb2+YZZk/AdKCG/
         EQMxhNZtcKP/5TRpSsHTTuoLn2E/7H2RWdPAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWFkkvCODPs1gGNFlhWX69S2LvyhHBIDjA0U78R4gZE=;
        b=lEBN4on2k4kfb9pRISG94lgkR5GtE/Rv3wcOEbsJUR/xkkMJZOzYaiaRJu1lzWD2fp
         xm+36D9CUkwe99A9BaT5i7PSxQ8rUqPA76RwwhHjsfb9iiI2w2/09Gaaq4/09dsPSAzW
         Tb5Z0ZhaHsf0IOSX0mT6egwN8gGiSVk52/yCNQwQB6o2M38YbntykVQ3fx1sS6CWr7lv
         P+UuCHv4LSXEQ+S4POlROpkGxErIqO09xprrVtOF1iLypTrRwc3juzCGWfL19ENCX+hC
         2/2ngMFx+E/8uiZNAkTd97+g2DUX3jgttv0i4XIYpVNpHxmndde635e0Tr4OnUh5B2hM
         G1dw==
X-Gm-Message-State: AOAM530LOM5pZWmKWNCC/hdLfNtT7Dyq1oh+nlBBlY1cWOys52slK6+8
        /G+t2fih3ZIdWB+jS/itF5HfVCY8fBUvMYJ8vkg=
X-Google-Smtp-Source: ABdhPJzmmgTOOHy0ZphtlRGlSXmeyd2UjhgSVmizNd7rgSPSl/idzU/GgI/qnAZBPbWQTafFUaglVQ==
X-Received: by 2002:a05:6512:1394:: with SMTP id p20mr21596263lfa.189.1630437854035;
        Tue, 31 Aug 2021 12:24:14 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id a13sm1433071ljk.92.2021.08.31.12.24.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 12:24:13 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id m18so1057393lfl.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:24:13 -0700 (PDT)
X-Received: by 2002:a05:6512:230b:: with SMTP id o11mr14286247lfu.377.1630437853221;
 Tue, 31 Aug 2021 12:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210831100326.2298176-1-christian.brauner@ubuntu.com>
In-Reply-To: <20210831100326.2298176-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Aug 2021 12:23:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg557LzOM7Hg29UhVMn3FOpXs0yUwPGHgF7JxMA7gqOew@mail.gmail.com>
Message-ID: <CAHk-=wg557LzOM7Hg29UhVMn3FOpXs0yUwPGHgF7JxMA7gqOew@mail.gmail.com>
Subject: Re: [GIT PULL] sys fixes
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 3:03 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> This contains a single fix to set_user() which aligns permission checks with
> the corresponding fork() codepath.

Pulled.

That single commit is odd, though. It has strange formatting, it got
the first-line summary rule wrong, and it has the "cc:" list
corruption that should just have been fixed up.

Not any real problems, but sloppy editing that I started looking at
because the one-liner shortlog didn't make sense.

           Linus
