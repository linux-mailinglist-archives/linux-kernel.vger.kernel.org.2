Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891E1319161
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhBKRol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 12:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhBKQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 11:57:35 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47363C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 08:56:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l17so4633296wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 08:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:to:cc:subject:from:date
         :message-id:in-reply-to;
        bh=RaaB3Jkzo+yQ+e/2ibVN63mU1UEh4se1oCH6ILUrCb4=;
        b=WEuKBYgLotIPM5/ZYwHT1cwEkXlEpWLkWPYPzNQU3rDPuKygP455iCE57+dKRSRzoT
         iAcXxzx+ExX2iaiQoVWotxOtc2Oy4a0PjMWc+Jhf+7MlYm91ctesPadlNQ3l7jEwUg5y
         MKZib62Y8JY6aW1T2f5GUqjRStxsCbfjKc3v8e3zw2aWm8ZsBIoJq+nKl+uS5KfDMxEt
         p1vzUQxbNHK4J5wXmHTkEW9mgMHQaB490OzQOPZ+9Id6PdizAoAf2LSxZkZYHf5By4Lo
         yMTnAHKwWO6KpTbU6v4hmyClfNK36z7Hvi35c9TZP7Yqg1Yi6ee8XtxADObKtDPFSlf1
         YCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:cc
         :subject:from:date:message-id:in-reply-to;
        bh=RaaB3Jkzo+yQ+e/2ibVN63mU1UEh4se1oCH6ILUrCb4=;
        b=BFnZ3BHVvnGvEhY0dfakPB1j5LJg87efQiejsrFmBarysaVi8V1cLBP25RcVvPavJ8
         TQ0p1+Xn8x5Kf9Bf6bmXszmzDw3OLoGApSHsMUSgynl8F9QfoEKzqiblach0TkE4x/bO
         ZBDGKhGIRVMdlrg+hpOo0bOMjMtXtprPJyWML0jpiKJziGe9jJomEK627rM7oY+wgvF+
         Xb3VYZ+WxHqlHJSb4Lgzxxx6vY77snGEqJaNnZDHnYkGCdKlmPK3lfwC7nEAcoWHYqTP
         UAOUnE9l8cVKSSR78s28U2WJS80hpQoSbXvgUjDYoc/dBOpGMlc9x9Qag9UpSqBC+6/Z
         fC7g==
X-Gm-Message-State: AOAM532afvBeQbacIqrWwDrmgRKOYrtiJ71H0p4q6x8EfvgcmK/Np4ep
        Lm8VzgiNVJtTp65sE4ircU7ybGwNsF+XfA==
X-Google-Smtp-Source: ABdhPJz4VWefUIAXXR+3xgZv7fIUmv90cM2APiqaCMbWrWNm/HrD6RlJPk+GLvvfPtwuxRja+iR9OA==
X-Received: by 2002:a1c:ab88:: with SMTP id u130mr6253629wme.185.1613062612922;
        Thu, 11 Feb 2021 08:56:52 -0800 (PST)
Received: from localhost ([154.72.150.57])
        by smtp.gmail.com with ESMTPSA id t74sm174450wmt.45.2021.02.11.08.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 08:56:52 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     <devel@driverdev.osuosl.org>, <trivial@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wlan-ng: Fix comments typos
From:   "Mairo P. Rufus" <akoudanilo@gmail.com>
Date:   Thu, 11 Feb 2021 17:55:18 +0100
Message-Id: <C96UXUQZSWD6.1BZ2DYOVBDNYL@uncertain>
In-Reply-To: <YCQSKNYU7zhcKHHl@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
>
> This is the friendly patch-bot of Greg Kroah-Hartman. You have sent him
> a patch that has triggered this response. He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created. Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>
> You are receiving this message because of the following common error(s)
> as indicated below:
>
> - You did not specify a description of why the patch is needed, or
> possibly, any description at all, in the email body. Please read the
> section entitled "The canonical patch format" in the kernel file,
> Documentation/SubmittingPatches for what is needed in order to
> properly describe the change.
>
> - You did not write a descriptive Subject: for the patch, allowing Greg,
> and everyone else, to know what this patch is all about. Please read
> the section entitled "The canonical patch format" in the kernel file,
> Documentation/SubmittingPatches for what a proper Subject: line should
> look like.
>
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
> thanks,
>
> greg k-h's patch email bot

After double checking, I still can't figure out what I did wrong. I'm
sorry for abusing your time, but can you help me on this one?

