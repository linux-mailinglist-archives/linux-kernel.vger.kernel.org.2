Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522FB3A5157
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 01:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhFLXUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 19:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhFLXUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 19:20:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 16:17:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v22so14453859lfa.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCXFlg8KkH0YKYOZIBIMSHdr8CfV4JWzrS9dLDGVBxo=;
        b=dLDO/VGC6YswxkFdvFcUk5ES7JnBBc3Mj8q+86vqS87AjRGXro0lsFDiO0luLahj7J
         BqAA9KMbZ39boWQ+0udyuI9TUKrKRnVEWs/kYVN7LBKrURQQOVEof149ZJvcwJgi1qV6
         wExPOZYH175hphRL2jfOO6+D17FTOnnzO7610=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCXFlg8KkH0YKYOZIBIMSHdr8CfV4JWzrS9dLDGVBxo=;
        b=KbonDsBDZUWAYXETHZ20+XXwfL+bezPBAe3tiCiSo/HdUHfa8tnZUuYTdfjUgk6AJ/
         YrQLlUIYz51fm1xVQRf1c48+1vV3AYM/JJc3heoxdd60cDO3X/NU9DwfKzGSrDpR4PYz
         2S75KFNHOWm3qwn9l100n5DfOjX9NpJyhxN8HfjZWQA900RHUVCecJ4MU8wF4Nun96Vm
         RtLnAYnAl2vQgwgiwZkMAWMhn8KqEVEFFQbrwp8VNVMFMjhvzx+w83n9m1i91eTAQ/LU
         zFTlzuZ3k8hjGKux326mPxGMo0m1tflJQLUuM9s/yQa48FUaVaZBWdqcGebgDuRflfJj
         SYhw==
X-Gm-Message-State: AOAM530BNKKtpl5u3JcZTzOPz0TOYPJj5cxZBO0ILyImsEvt+AUIOga7
        s7wximtzATE3upZDoghgYUWYNER/DauOTY+txfQ=
X-Google-Smtp-Source: ABdhPJwjJscsBVt6cVOCUJARxAeMRSNvHptZ1YxzLEzisyu7oqZUvIGU6eiLFSUoK8+HHDW0h68Hfw==
X-Received: by 2002:ac2:43b2:: with SMTP id t18mr6912357lfl.133.1623539866830;
        Sat, 12 Jun 2021 16:17:46 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id r15sm1009305lfr.245.2021.06.12.16.17.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Jun 2021 16:17:46 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id bp38so14506792lfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 16:17:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr6860791lfa.421.1623539865998;
 Sat, 12 Jun 2021 16:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210531170123.243771-1-agruenba@redhat.com> <20210531170123.243771-6-agruenba@redhat.com>
 <YLUY/7pcFMibDnRn@zeniv-ca.linux.org.uk> <YMUjQYtBCIxHvsYV@zeniv-ca.linux.org.uk>
 <CAHk-=whcnziOWqVESWKJ6Y1_sG2S2AOa1vv5yKzUGs5gM7qYpQ@mail.gmail.com> <YMUrcUXS5jprfGPF@zeniv-ca.linux.org.uk>
In-Reply-To: <YMUrcUXS5jprfGPF@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 12 Jun 2021 16:17:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoBx_GzTQMj_HQGAR+f+7VRJ6JbU9UBfuPHKLfTVMPGQ@mail.gmail.com>
Message-ID: <CAHk-=wgoBx_GzTQMj_HQGAR+f+7VRJ6JbU9UBfuPHKLfTVMPGQ@mail.gmail.com>
Subject: Re: [RFC 5/9] iov_iter: Add iov_iter_fault_in_writeable()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 12, 2021 at 2:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         O_DIRECT case is a PITA - there we use GUP and there's no way
> to tell GUP that in the current situation we do *NOT* want to hit
> ->fault()/->page_mkwrite()/etc.  pagefault_disable() won't be even
> noticed there...

Well, we could change that.

And we do have get_user_pages_fast_only() these days.

              Linus
