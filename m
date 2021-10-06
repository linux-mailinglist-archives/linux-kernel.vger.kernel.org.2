Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E6424395
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbhJFRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhJFRBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:01:18 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C32C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 09:59:25 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ls18so2677566pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 09:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqaPyN17NjXVoG/gNUtKAvMoZ8+ulh+88z1SV9+12xE=;
        b=BYKN2VHaAmXZLVgq1UN36v7yVsoFefS8C8VigcuoqiYVw+F/O+VpFMRN2/tmiGKsHz
         GA4i5CaAQatPZ5+/aeltZMrsMXPipQ/AL/prvV34hRIlomT4vOw9Xhpz5yhRwNCt7ccQ
         +B0z0UdV8Wxiiph7VBpjxKg3uWIiChl39E6wk+MR/kEEEHiu1NhMp5YzvLUBcsbo6Qx3
         X1EPp23TGFE63ERTq5VXTGuv30SR3UYucP4aghl/kkMnWlj0J/+8jIGKphG2YWdlFQWc
         P9Fe9fJ8wSTPY37w0Qed1R2qpFP/XLNrmiaLTziUWqeP6sfWJw5I62EWiE3fNAWefWLR
         r4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqaPyN17NjXVoG/gNUtKAvMoZ8+ulh+88z1SV9+12xE=;
        b=Kzd+j51OdaF4pxrEE2hkjWPHas7jA+S/rWDOkcK6XkpAVfaf648QxrH9UoNG2gBCIz
         hLObnMFq2CGnQMsekISAYny/ZUsW7S0/10hh4tSAwPMnY98F88fcRHbVEx6ek8cWOZyl
         5gOaSjigtvSIfeLUGBv9UumVgIN4fE0vYxDj+nzQb6JKZCR5fgKmOuCf6mEcnoFbZYxX
         cz3jqzOnrGz8etbUauF/G4cfnThED2l3im1pPW1/33G4qqg9WRlZWBAOOnRFWpu6P1i+
         yDP5SvurGX6rpDlkvpFtoK4PIOw9uK7tFwq/JWtaYAFvUZxoGJMeHq2bq9DwhBEcTz6t
         4kVA==
X-Gm-Message-State: AOAM530n989Mi8ikldj4UbJspDzeuqtIeyd2iI/VgpmqAsYHsqQWsFFp
        mVdQ9wop631jycykmIieuWbNvtT60pvA/Vbgwkyuvw==
X-Google-Smtp-Source: ABdhPJyHGmwPIdRFgzcCHHwheumGZW4Dy27xvfU+aHThaSx5TrF4zqts49YF0ybB2RoAH0EbKWQOvdCrSQkJcTTQCdo=
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr11974176pjb.95.1633539565107;
 Wed, 06 Oct 2021 09:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com> <20210930222048.1692635-3-dlatypov@google.com>
In-Reply-To: <20210930222048.1692635-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Oct 2021 09:59:14 -0700
Message-ID: <CAFd5g44YUDhGaskMFGi5-LyQ5bzgArZSSwvLUcg+GgA1ssA6kQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kunit: tool: factor exec + parse steps into a function
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 3:20 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Currently this code is copy-pasted between the normal "run" subcommand
> and the "exec" subcommand.
>
> Given we don't have any interest in just executing the tests without
> giving the user any indication what happened (i.e. parsing the output),
> make a function that does both this things and can be reused.
>
> This will be useful when we allow more complicated ways of running
> tests, e.g. invoking the kernel multiple times instead of just once,
> etc.
>
> We remove input_data from the ParseRequest so the callers don't have to
> pass in a dummy value for this field. Named tuples are also immutable,
> so if they did pass in a dummy, exec_tests() would need to make a copy
> to call parse_tests().
>
> Removing it also makes KunitParseRequest match the other *Request types,
> as they only contain user arguments/flags, not data.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
