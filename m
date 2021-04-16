Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0682F36290D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244640AbhDPUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbhDPUIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:08:43 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36ADC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:08:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id e14so43801305ejz.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/7RWfCnT+MFSVYzAj6rhZv/Tp/5lHV7PIZVXaikxkA=;
        b=TgBtkKhTKA/3SO+uKkjRq5/DlYpoEltcTRr/ImpSWzE3QS2RpSo2qNzUXnGLTWKx5j
         +BCpYvYl1lU1xiocJDtfK5t8hacvcJbVhYhi7bRPPO3Gv9/8fUmOYV8Hn/m11Zh8M2b3
         V/SY4P4YrIAvVa/3bmH+XrxlSrOGHYv3+1VfA/7eAwBawvXf/o5djAsP34AuffTpSEF9
         YwqXst09X24mWgfR+xyQZbbWroVHZ8+A8VGVqEHz59RX9atw6F6tdOLuqTLstQ2lgZz8
         2gmDCCOfKeWJxZrTK+R5XDUncpuMfrZnnoxiu7edHVr3nSFpwcUSmxhWV121Pyhd+aXE
         e6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/7RWfCnT+MFSVYzAj6rhZv/Tp/5lHV7PIZVXaikxkA=;
        b=jIkujOziFX4NR2XyefLkmIe+JT4hAtJRpnN+ihnKUo5yKFWFrvu0ypqaWfOpC7V27P
         XuWiD9BNQQe3oZOEx0XJVE/FQvxe2bgZOMlUC63iW5zsVEc+TCT19uDnCQDxcqef+y8V
         HCWb5XfAIvBgiWAKvwQAMlzUjIOjiO5E85bpx5bJ1uow+JXCue5Te1O8lCv22CoTJSGz
         WCvbcS6cstRUvMDj6L+KedrIWVBgWhLugfMFYOcSF0QSizYM4WbR4djyHPT1Uy26rle5
         TL5cQEUzCuO4nXUITXGgB7HLlvYFKIo51c800Wiag2C5Y+SeNcfSTvKNuIb8EjqZJdeN
         gVYQ==
X-Gm-Message-State: AOAM5307kbSTRT0tbde/RkMT7gQdQAAzKCojDXko0Dh9/88Cm5pQ0cQq
        DPF24yxTSpwBdgScyx8f2/B5jRy84C+7Agq1wu1fM1cdS34=
X-Google-Smtp-Source: ABdhPJxLbYFLHe3hs9wcNWM4Ah9JtxOJIsqYpHQn3AKLBkjhJfWEajDnBKN3ne+6r6z2JZwn9ZUv8rMczHUp+Op2Ljc=
X-Received: by 2002:a17:907:7631:: with SMTP id jy17mr9998196ejc.418.1618603696603;
 Fri, 16 Apr 2021 13:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210415143754.16553-1-andriy.shevchenko@linux.intel.com> <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
In-Reply-To: <YHnLCoeBDn3BcRx1@smile.fi.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Apr 2021 13:08:06 -0700
Message-ID: <CAPcyv4iwiJwwgiisZTqk6F=A8hLJCGkK-4suqDMPYYiLzuLwFA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] libnvdimm: Don't use GUID APIs against raw buffer
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ add Erik ]

On Fri, Apr 16, 2021 at 10:36 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Apr 15, 2021 at 05:37:54PM +0300, Andy Shevchenko wrote:
> > Strictly speaking the comparison between guid_t and raw buffer
> > is not correct. Return to plain memcmp() since the data structures
> > haven't changed to use uuid_t / guid_t the current state of affairs
> > is inconsistent. Either it should be changed altogether or left
> > as is.
>
> Dan, please review this one as well. I think here you may agree with me.

You know, this is all a problem because ACPICA is using a raw buffer.

Erik, would it be possible to use the guid_t type in ACPICA? That
would allow NFIT to drop some ugly casts.
