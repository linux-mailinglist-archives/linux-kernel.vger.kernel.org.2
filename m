Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E053345DBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352815AbhKYOH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240255AbhKYOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:05:56 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB02C061763;
        Thu, 25 Nov 2021 06:01:06 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id w4so5900932ilv.12;
        Thu, 25 Nov 2021 06:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCr8cEbiqbrqQ9HAwPRp4+Y1KfhodpUIEhtcV1dJm3c=;
        b=DU0bINKQ4aXtmPNed7uqfcdTgB1HSygpeozOmEvD1UD75jstk6+9NSf3jfuCNVzrs4
         TnUYCVjkfWFQw1ms7Pot/dkSFtUhB1A69hbbUVIvaXNmnwV0VJzFW2kMB9UgzueHGGqI
         8gb8F/PBBIm4hj/obL2BID055DZ1ZQal8oY3ZwF4zdKK0Md0BX/13KdT3bmHixuCraTc
         3yNYv1Ps5VsRWvk0OZJ3e4ITmN6wlBZgNgPE+L0/2GcDVBZectS6JuCBay4VDqOtvoZ/
         BTR9g98PvtQ1rfvMNsAk3wJEh3D+thGNrnoh5nzMmLog2Jqxq7RfTW3uS46uidL7KuA1
         89rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCr8cEbiqbrqQ9HAwPRp4+Y1KfhodpUIEhtcV1dJm3c=;
        b=VssYcoU5cGJyPsCOAelObvILNLeaz2U4/2n3o83uVlfF1Qt95q3/ugerfD8l4ySr8P
         XfYfFR4lQKtOHyMqNtGr8eqcE/bK/Y+lT8PcLrYiOsA5JewIseJRgqklLU2NQzddG8zF
         shpBndAu520xWiCaIOxcU7wLpsgyVC6F13uYX72sP4Qa5EIMWdfJvi9mUiN8MbJG/GYf
         LzXaqmokB8y18yXuI3wYcGwvgi1Plja5YxjZkX2H9hIMRaS9ZlEg3PUsQoBGYNilvB3a
         8LtJtyxVoQ7uS1ZEY0W8abqM+HD3KAaVE2V9idCDwj7rm1nDljPgMJQPNGDG25MRvylB
         6Djw==
X-Gm-Message-State: AOAM532rUEZ1WF7Zv5lDt1SH8VTHCERlj56r5Pe2P6+92+YbkZZKGjjk
        G8WNrMY+K9P+BBNOfg6/cty28P2Ar4RWTSSAnocELppe3Dk=
X-Google-Smtp-Source: ABdhPJy5D7qohbbXZo9zAz2iFy4+Ql+8vdUIov/AEYqhTptx7l9qZbL6FiItEjZnjHY14+YoTV10asFl5/aEo1GpQc0=
X-Received: by 2002:a05:6e02:1445:: with SMTP id p5mr960063ilo.164.1637848865782;
 Thu, 25 Nov 2021 06:01:05 -0800 (PST)
MIME-Version: 1.0
References: <20211122212850.321542-1-pauk.denis@gmail.com> <20211122212850.321542-3-pauk.denis@gmail.com>
 <CAHp75Vfg7LKX-21+b6f5c34G4Y=ZUqrWRbfDt_quCiJe+By-Ww@mail.gmail.com>
 <CAB95QASDiwM+-AwPgGfc7dP=Ctm0s2WP4xrapJzNHJ22B9foAw@mail.gmail.com> <CAHp75VeO2mz7wJpuKdrErnYcw-dUOBs9W4FzA6MkgCQLr0eQUg@mail.gmail.com>
In-Reply-To: <CAHp75VeO2mz7wJpuKdrErnYcw-dUOBs9W4FzA6MkgCQLr0eQUg@mail.gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 25 Nov 2021 15:00:54 +0100
Message-ID: <CAB95QAT_b8Wef+4wN-H8dKZXxgnznqOk5J0fMuL2XJLhob7d9Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (nct6775) Implement custom lock by ACPI mutex.
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please, do not top post in the mailing lists!

Well, it was almost a new topic...

> I'm not sure I have got the above correctly, do you mean that the just
> submitted asus_wmi_sensors HWMON driver will be replaced by your
> changes? If so, you guys, need a lot to improve communication between
> each other before submitting anything upstream.

Yes, you get it right. Sorry for that, it was a long story and I
worked on the subject
only occasionally, so that when Denis took the code and submitted it
to the mainline
I was not sure which approach is better, and so I did not stop him.

Best regards,
Eugene
