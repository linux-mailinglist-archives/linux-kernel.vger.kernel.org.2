Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D64428190
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 15:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhJJNsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhJJNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 09:48:20 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2278C061570;
        Sun, 10 Oct 2021 06:46:21 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id w11so12076346ilv.6;
        Sun, 10 Oct 2021 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfunRzx8E5DICkyfu69N4Q/cD4jPSalGZ6dHubuJcZo=;
        b=YpDqTbIzorKOpSPDI4JGZwTVHGfRWjt2pX1l80v0IYWgIzia71eSQxW/bUL9KHC8Sv
         sECsGN9JGbwmitDuaDOoTmSpwtpJWB3tbS+FkB8bwgUy+7vwnMfZAc7DVabSPFfKkQDX
         ew6+i9esIdTNzi2NnOjifS7Bf5iCb47M6n6GRVUtTka9EMNncyCioCCWfYorjjPOHEJE
         mlyOM4PnZmj1XT/JuqMVF0Zt2/ZEgEodnGyn4x5/JK3BYv9y4hDs0op4wRjKnW8QymCI
         o/x89762QoR59YN3lZZZ9/3KdHQo6ASCh0c5+kOtL70Grvg4DTUCO5c+gubrWzSQGn2K
         Uxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfunRzx8E5DICkyfu69N4Q/cD4jPSalGZ6dHubuJcZo=;
        b=tm23cohcAAmzsHcjtDH38bLaqDs1uB8aBKZDJonn6stPl/vXz41fR3CzENZioj/UyH
         KHN4PJqo26MngN66EGKPzRFUiMxN0g1smkXlK1n3r8oUmhYZjFjFP/ps5+tXQaTmP/KE
         qOFytG+Zh0LIgAD6d38iP8kT5jLvLRpiM4jc08Qj2USOkBwp293+gDDHc5T8al7EWDXa
         mU+iPu5pOMVCHN/gFdoTay5puHOV6bhwiwov+Z1pTiUASXQi2e99qByr0MIDWmXVi+RZ
         exskPN8HBvS1ShMVdG9vPX8L19d6GbonMz2CbyVDLvVoYjWxlg5RUvfSKBK1sAJGrQ3+
         uDlg==
X-Gm-Message-State: AOAM532CBjfB4fXr0yA5XQIuY5O7uE7UgWs/8MUzI6UBg9efEteSy/O+
        8QFcFSi1aPNTOEdo34cmRFAyBQG45Nq0/Rp+eAc=
X-Google-Smtp-Source: ABdhPJxzZDTZcFaF2eUAc+cRvu0k1XxH2bVmUcxD5okukiXdb3m779uYpq31Z2G3d5tgYpecKeJqdVUmuj7+mMmateU=
X-Received: by 2002:a05:6e02:8a7:: with SMTP id a7mr15990706ilt.246.1633873581175;
 Sun, 10 Oct 2021 06:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20211006222502.645003-1-pauk.denis@gmail.com> <20211006222502.645003-3-pauk.denis@gmail.com>
 <CAB95QARmjTBVRyru=ZDz9Wc5SX9EPFg7dg6vB+S8=pMtpg8FRw@mail.gmail.com>
 <20211007184644.1d042550@penguin.lxd> <CAB95QASYPRZSFnpE5u=SYJ49Hd+=BAZY==Ky8dzjL8h7YZj-CQ@mail.gmail.com>
 <CAB95QAQ+u4DmF0e9Zvy5hDV0mFQDEULtr-newtz5_6y=Bzp+ww@mail.gmail.com> <20211010133921.4277dc79@penguin.lxd>
In-Reply-To: <20211010133921.4277dc79@penguin.lxd>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Sun, 10 Oct 2021 15:46:10 +0200
Message-ID: <CAB95QAQs_PUeTU7d9tg83a8hRepjLfLnxVykU2nvBv3Vn49HBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (asus_wmi_ec_sensors) Support B550 Asus WMI.
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     andy.shevchenko@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

On Sun, 10 Oct 2021 at 12:39, Denis Pauk <pauk.denis@gmail.com> wrote:
>
> Hi Eugene,
>
> As for me, use WMI methods will be more reliable and cover more
> motherboards.

Why do you believe they are more reliable? How does it cover more motherboards?

Thanks,
Eugene

>
> Best regards,
>             Denis.
>
> On Thu, 7 Oct 2021 20:11:33 +0200
> Eugene Shalygin <eugene.shalygin@gmail.com> wrote:
>
> > Denis and All,
> >
> > regarding the asus-wmi-ec-sensors driver: it uses a WMI method to read
> > EC registers, and this method is slow (requires almost a full second
> > for a single call). Maybe I'm doing something wrong, but my impression
> > is that the WMI calls themselves are that slow. I will try to
> > reimplement this driver using direct EC operations and the global ACPI
> > lock with a hope to make it read sensors quicker. If that works out,
> > perhaps the nct6775 may go the same way, as it suffers too from the
> > slow WMI calls. I know next to nothing about the ACPI system and learn
> > from the beginning, so I'm not sure about the result. I know the naive
> > reading from the ACPI EC registers leads to problems (fans get stuck,
> > etc.), and if someone with knowledge can assure me that the idea with
> > the ACPI global lock (as far as I understand it is even implemented in
> > the ec kernel driver already) is correct, I would even request to stop
> > accepting the EC WMI sensors driver, as it is so slow (albeit dead
> > simple and small).
> >
> > Best regards,
> > Eugen
> >
