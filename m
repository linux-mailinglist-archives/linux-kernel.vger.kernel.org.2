Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1264430A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhKBOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhKBOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:44:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDBFC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 07:41:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 5so75711267edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 07:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FF8jR9JitnCig9VnunCX29ewFvlXaWyZMFCWEguaeA=;
        b=nArB1Nrhs2SbOzEfjE38IUIeV3dhZyemOj94lZbsJRmCGZRFU13JewIkkwii7MGaVJ
         4rq7Bzbyi+hmQaqkYma7tF1IRspVlQO50nQ4XdoQwkEQKunBkTuvQXJu3QZDaKdxHyBZ
         6rUOvij/84JucsYWhyhYVjQMIElOPhf9l3RLeBFFyfLgjW0amaHIe290Zm6Tr2/vfAA3
         F52Upn0Wope2AX0d4hLtHI53Vxg1lSU1SvTRPuqzUcvV3JStzP+EmQE/+CFgfazGJsp2
         WLJBBZGtZUHVoa5tDBpzl/WCIQk7s3demcYJNPxbXCGJT/YsgO37LuCakQ3SoUvzVDSn
         lA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FF8jR9JitnCig9VnunCX29ewFvlXaWyZMFCWEguaeA=;
        b=nolA1LWtElerVlkJbDEjP/apWyVuFuyJs92o6ttJBwaYgUgf12FLhv0fEXOJz6jPZb
         pwLhX0hbjDyosRs99TK+ejJ5zf9lRqOBb8jN2y2n2Jnr0VTx9cilhTMj41M4loRgdSAo
         dTD+f1zapnZcDZCDwM9z2a6GLfMpuYgnsqdgb9Ehix8z820C6yhZ7hFsSulerVbZ5+6h
         rDkeiVHz84ugxMwYGgYyiWHJaGX66h3GNMEpbPyyNMN8g7Rwg3le3I6U7l0R7HrgqIRV
         63eIdyc9tB1gWXmA82r99SwJD1n0ADnPgINPwv24PpaJcoe4V7hi57DsM5UbGFV6JXaK
         6Q8A==
X-Gm-Message-State: AOAM532InDUCthQFt3U+bpt1FnQJQiDxXkVo5iIQweoWQU/E9DtnUd6w
        p4uC9y1NkkmqgMAwsAEs5CFi9xXA0Pc+qHxqdkY=
X-Google-Smtp-Source: ABdhPJxrTKOObGIIbLYUKK51UYSGVt7N/kTC4rW9o43bam+T5THfRwhLL3E5mlKqK/2lGMbxdlfaLGE004xK4pJUJhI=
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr44607792ejd.425.1635864088862;
 Tue, 02 Nov 2021 07:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211025135148.53944-1-andriy.shevchenko@linux.intel.com> <ef2cca2f-8566-ad3c-3ab2-cf0a4439faa0@foss.st.com>
In-Reply-To: <ef2cca2f-8566-ad3c-3ab2-cf0a4439faa0@foss.st.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Nov 2021 16:40:39 +0200
Message-ID: <CAHp75VdBd0LORz+DX-1QUaXfEiC+iiev4dY4-mPG+rsUxcupyw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] tty: rpmsg: Assign returned id to a local variable
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 3:21 PM Arnaud POULIQUEN
<arnaud.pouliquen@foss.st.com> wrote:
> On 10/25/21 3:51 PM, Andy Shevchenko wrote:

...

> > +     cport->id = err;
>
> Set the cport->id to the err variable on success doesn't seem completely clean
> to me either.

I totally agree with you, that's why the
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/commit/?id=408a507996e4
 changed it.

-- 
With Best Regards,
Andy Shevchenko
