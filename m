Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129B845DBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349836AbhKYOD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344097AbhKYOB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:01:56 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E850BC0613FF;
        Thu, 25 Nov 2021 05:54:41 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i9so5964409ilu.1;
        Thu, 25 Nov 2021 05:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfz94yGj2qP/Q0BYpg1q/IaqhYYE248T5+zyBIuCBVw=;
        b=IAFv+RQRv6T4XOW7hcmZSGAKK7COo3OvKvyJYT7ZxI4OHe8mtzMtMEdMHIy4qLQWfi
         mU2ypxupjBpZmJGBImC2/WJ8LcvvGLOXw2uFx1cYAK0XOeMYliZELrNc3UA0CE42V+ld
         FqxdpS1uAYcFW8Swc/EJBkvJNwqIpHJu1dnGUwkFcKFzJxLqHstXXYI6YsFN5b28cgjw
         e+NdIWh3CoKSbZHPbJQCc1W8IIrK7jZ6jxBve6Qz7djZDrRX6aMnQu0egRoLp/YRdywd
         KxJvynrFbdoT7gjypJ1ufDb1hJBGAWPVoOAt+VKm4HEfX4E47YRmtAkMa1KiN1uWZ7Tx
         kzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfz94yGj2qP/Q0BYpg1q/IaqhYYE248T5+zyBIuCBVw=;
        b=aSx7SuTPf8K52X/H6TrsYp3s4l9WttsfoL6ehrr1dJEp9LhGtOqJR9LOVt4qaejvNZ
         L1TPe3ftlCiG6GmJL4pFyY8ExGtE36Lwecz1HTVrTS0oAsWFvhe/xIXqrpWp1fnx3cdv
         LrKjW43llBrCWjvyot4hWvkIrEK7qe4ZYna9VNORo/ZiabHDS7dH9hZ3uZiu8taMpApn
         hoE222fax1Y2hnR1pCyaR3yFaR+IP3MPcz79Tf5ANmHFrL6tv50IHv1KazmFi2V2Db+N
         YJjlbAaLHRqsEkeRPR741aIlCfjZiuegOj9p0DGYmaFnVrC+87uT0z7mfH2Y77IhLGut
         B/pQ==
X-Gm-Message-State: AOAM532RlGz5/AEZ6jKtNYW09yL7B0lT3VvpVrD2elw/uJGFSSPrn/dS
        sfk6LKxxPZWqyDugUwXECD/CMBJIcbhiYPUwTa0=
X-Google-Smtp-Source: ABdhPJyiAwOE9QIjl0HH+LFAswWcFyQYJuQmCatDkCqw36Wse+LTCfVHLw1UpwUBymh+AEUPjaU/o7ZrU5Nw2S6C4y8=
X-Received: by 2002:a05:6e02:1445:: with SMTP id p5mr919473ilo.164.1637848481350;
 Thu, 25 Nov 2021 05:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
 <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com> <4b00cd7e-4d40-8220-b313-6a5f8381b5af@roeck-us.net>
In-Reply-To: <4b00cd7e-4d40-8220-b313-6a5f8381b5af@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 25 Nov 2021 14:54:30 +0100
Message-ID: <CAB95QAQWYk598hzLuso=psZbFSmgqKK5b5MR83f01zOrPxQLeA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Two drivers with the same functionality ? What would be the benefit of that ?
> Why not drop the current one entirely instead ?

Exactly that: I want to replace the WMI one with the new one, which
relies on ACPI lock and directly talks to the EC, and I want to keep
the driver name unchanged. Thus asking to rename the WMI driver before
the 5.16 release.
