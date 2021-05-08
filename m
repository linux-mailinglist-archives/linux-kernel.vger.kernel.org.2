Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A073770B7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 10:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEHIrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 04:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhEHIrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 04:47:43 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0028DC061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 01:46:41 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso10010042otg.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bf+5azIpNWanXXRSeQo4/lOG18bGwqj/1u27OCylOk=;
        b=rcNfdulbXK0kvOjXJmkEvMAhyNXiCOVWWisbCipHfhmI4CvdHhTDGAUU0ryXiY8D1T
         NwgImXjXyV6lX1IM0I9z6mWpbL0g+1hXKFdACVjnYm/VOExaFCKdK0ulOhbx2KNU3Ku2
         OGJUVvW9SANDZDQqfq5SefOrQn6qYw/8speoJYvrUugI2LLbfvIR/tJ0KuPietglZLMu
         Rw0e4IcYz9rlgIfX9jWx4dw/FJbre1xZZNzE1RPLgke2pEXRyQS5kTLbue4ESMjDBiuI
         0yVYpsAY4myuhToSFhIkzfbC8rPREBpbUwLNXmJVgHmhEacT26VJsOjpEnJ0gYVfCsfV
         bH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bf+5azIpNWanXXRSeQo4/lOG18bGwqj/1u27OCylOk=;
        b=tD0n+x1DkadwKRStO47Fl+68dSn7jlIoB+ulAfr9IF6lA/ta+J+KcvU6Jpf5q+4m8N
         FqQ9R0QEr1HjEuFLiB3Vq8R89s5afhoCAc6vXdrQ4FuH3VatHf9dbbsglNd/Ie40OJ6r
         10dM/RizsjXHGWjk05m4sv2+vvxe0vE01AXjX6JCl4Ry/7lBDJo0LYiVrIHqd24fkPbV
         an7rd0VFXXY37Wyo+YYZpAHOsrWhG5ajEBwFHOoweDlFm2KXosrYEXt4o6kArZGwX0RJ
         nWOrIyA5w9QmYYq2A0ucinMCbc0+dyX4AmBpcPhwDgDkNuHmqIQjJitz1iOFbJlSieHN
         MLrw==
X-Gm-Message-State: AOAM5338q1f3KtZop8Zx4Ayus3mDuGXnfkgi4/hrwZUVlAAj9Lxk+mmR
        VG0Hk3VH/AiZRW/LxoplvOibg/Tf6xrWhICUvh0=
X-Google-Smtp-Source: ABdhPJwzqXcw+uYkYEhf/9G2Ztmh6N0urZDRvljvibBdLRv6qQcSJj0Va1ISoG6b02z91gADfWtXAC8SgnlaamBcyEE=
X-Received: by 2002:a05:6830:45a:: with SMTP id d26mr2637596otc.339.1620463601384;
 Sat, 08 May 2021 01:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210508083931.GA21544@CORE.localdomain> <YJZPCMnB7/sktOF1@kroah.com>
In-Reply-To: <YJZPCMnB7/sktOF1@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 8 May 2021 11:46:14 +0300
Message-ID: <CAFCwf11uA7PscSpkQ7BD+FW7+dFy1_GoeaPJSLDS_VnQKhoa6g@mail.gmail.com>
Subject: Re: [git pull] habanalabs fixes for 5.13-rc2
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Oded Gabbay <ogabbay@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 8, 2021 at 11:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 08, 2021 at 11:39:31AM +0300, Oded Gabbay wrote:
> > Hi Greg,
> >
> > This pull request contains a number of important fixes for 5.13-rc2.
> > Mainly fixes to support our new F/W with enhanced security features,
> > but also additional bugs.
> > See details in the tag message below.
>
> Does this include the stuff in your previous pull request?  Should I
> drop that one from my queue or do both?
>
> I will be waiting until after 5.13-rc1 before I can take any of these...
>
> thanks,
>
> greg k-h

Yes, it includes that one. For some reason, lkml didn't show me that
the previous email was sent so I thought there was again a problem in
the mail server.
And therefore, I've sent this one again with 1 additional fix compared
to the previous one.
So you can drop the previous one.

Thanks,
Oded
