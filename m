Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7227F3CAF92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 01:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhGOXQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 19:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhGOXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 19:15:59 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A4C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:13:04 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id x10so8446476ion.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 16:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+9xGJ0gIy2Z2rbv99prQ/BVOYy4VH7Dy90xsx1aVD8=;
        b=gex58ETE/ebd4/upXl9v0kX1j0RDVXMyH2tDWLPghQ9EilbSdtcy+tj8uMiLjYVoEI
         wPmyFFsj5RV7amVMRT1/wsITXtWDqzds4LlL4UiQ4ieW8RClQm2+AU5NCsJFArZiiKSi
         MNDYm2I7xwzk4jgmC94A/G7yOj1STuepSPiLjyYDoF/fy9dHtbmPeWAjibHdIqFZSVgi
         yxo1Pa/Bzk6KM3xdrGr3tBbc7OT5xd4AgM9vgdxuKdctx4GabVBJ3qpnvEJ774jkRoIz
         dNNE7j2fwuWEg8/k/Qkcv+kweDaa1xIJ7PH9UTHkJFDesRxmrsxfCArbdeR2eyIpwNCN
         Ml/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+9xGJ0gIy2Z2rbv99prQ/BVOYy4VH7Dy90xsx1aVD8=;
        b=I6kk0CudvVmdW5Mc2rKrTpOGB3yAkk7OJ/wfHWNWc8ue7TrZxm6ky8nPyAx5wlRD3s
         hRGKCQ5sW2OIIcNcgBkxCzeqG9JXxIcamHuPW/79dM8xYQJOu5krGqQ8Q/UFi/zIDIPw
         KIPsr6y3AQIZJftWfgUBgTLr33hB+zcyxmkt4EGKyzfecAs9OfnyKU04TSrw2DvvI+PY
         sen5f4aqdaWT7RimwntHQj5kMypnlHN9nlQPy5ezALPJQj+BcnHWqkzZzL5xiAEV1iEd
         J6dsnV9VdvDC6QwAKjT3/pUWQLlC1DHGBIqa7R9QzG+y+SUg9oLFtu8bLXdtoEXf+nWF
         fXjA==
X-Gm-Message-State: AOAM530oL+2cKs6X1IeaG1WXyfCL0YoCpzf4GVK6c/6PM0rporV341n2
        HxTUR9AR96ozIJ26892zm11F0YkT6gtFIjpaXI02vFmo
X-Google-Smtp-Source: ABdhPJzphxFFKU51bd+s5IlA1FkUpKvTXM9vgCb9/nJ9e22kxVrS1kPWrNGyrKPOrXIE9f1H1koH/3O05ojIxhhqFis=
X-Received: by 2002:a5d:8c9a:: with SMTP id g26mr5043891ion.121.1626390783721;
 Thu, 15 Jul 2021 16:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210714150159.2866321-1-elver@google.com> <CANiq72kV7KOKcWCQ6p9LdMGmO+KV1ssnADmT_PAHALtLu=t53w@mail.gmail.com>
In-Reply-To: <CANiq72kV7KOKcWCQ6p9LdMGmO+KV1ssnADmT_PAHALtLu=t53w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Jul 2021 01:12:52 +0200
Message-ID: <CANiq72nfgkKuXXz-CTeiFgx+UAyLRffcREtN2ZBQWzbSzXkYGQ@mail.gmail.com>
Subject: Re: [PATCH] compiler_attributes: fix __has_attribute(__no_sanitize_coverage__)
 for gcc 4
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 7:05 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Looks good, thanks -- I will pick it up tomorrow.

Queued.

Cheers,
Miguel
