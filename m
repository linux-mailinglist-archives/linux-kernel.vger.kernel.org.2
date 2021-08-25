Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641A63F7F26
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 01:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhHYXqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 19:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 19:46:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D47C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:45:51 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u14so1934446ejf.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kv1+3PF8NoBjdGENhso7cF1mXXZBYI7ik/JgLEIWEFY=;
        b=I9g8+mQ5rKWvAzdrQlNKi/je8uoX4tqgS0TbgFbhvZ4T97rLTo2hFzqVn3SmxREX4Y
         S++l3DYcSCuyaf1cK83t/nuMCHI6S85HPv5MQToG2zNIol9k/oKTwkndE6wNUDGnHVct
         2Sj+gXedYg4s1atCrUZYrJLkB1mwBNiv9MhylJkZifxFP5F7MhZ1+efByjvYIkyWrpQU
         1D8AP76CpkjRAj7Gc5J3umyH8BwCMIyIwGUUZFWfYW6DqC+HSxkprQzO4ewaRunBh+Xa
         BwCdN0mhaMu76d7F3MlKoHE6q20CndzLGeGYGU2siHrn4oeDAoYBKQ8NQ1Zh/hCPHifm
         odIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kv1+3PF8NoBjdGENhso7cF1mXXZBYI7ik/JgLEIWEFY=;
        b=h1/9TAl6lL+ESiE8hc8TZ4PqhmAFFPc744xzJcDoNPS9h4IMlXON0uHaZbuFV2b+Sn
         ELIa5dDp4ME3TLr93JGkHVJysVq/YvA0irt0FILIjcBDubXLeslXOLzWWrN6JQ3xm+TV
         8GWoxJPCEwXfspJvjoB+dXFoeRIIBT7AhDgTpQSYnu0xZ2okEnpZdHdNhOddgV5o4Mh0
         orpiYRp4yrdrYG9IgMnP+0x6ntov1lMMHy6gH5+fL8aQVY68n/JBOh5p2PxIEkUEY9LI
         5k4KYRG+CE4SdXEZM99AA39AOitH87v2lXD/liZjcqlug5zS3zDnojofCKHMmaLGGYpf
         RAeg==
X-Gm-Message-State: AOAM533X1WbHqOV9Lh2oeGa4VPsL50h8xF070kSv5G5iehkRwJH7VMc+
        ebBMoMSxE/nV7nvcj8RdLSw=
X-Google-Smtp-Source: ABdhPJxADK5L+azPcbkWSGJuU3YC9SPUcS4q3XWCss7G/UGZ3RFuy4PW/J6QsImPpB8WY2dU1GnJvw==
X-Received: by 2002:a17:906:9401:: with SMTP id q1mr1183144ejx.313.1629935150013;
        Wed, 25 Aug 2021 16:45:50 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id x9sm649417edj.95.2021.08.25.16.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:45:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of rtw_read8
Date:   Thu, 26 Aug 2021 01:45:47 +0200
Message-ID: <3591772.nrefL38gfN@localhost.localdomain>
In-Reply-To: <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
References: <cover.1629789580.git.paskripkin@gmail.com> <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 24, 2021 9:27:27 AM CEST Pavel Skripkin wrote:
> _rtw_read8 function can fail in case of usb transfer failure. But
> previous function prototype wasn't designed to return an error to
> caller. It can cause a lot uninit value bugs all across the driver code,
> since rtw_read8() returns local stack variable to caller.
>=20
> Fix it by changing the prototype of this function. Now it returns an
> int: 0 on success, negative error value on failure and callers should pass
> the pointer to storage location for register value.
>=20
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>

Dear Pavel,

I have to inform you that building patch v3 3/6 with gcc (version 11.1.1 20=
210721=20
[revision 076930b9690ac3564638636f6b13bbb6bc608aea] (SUSE Linux)), gives
the following warning:

drivers/staging/r8188eu/os_dep/ioctl_linux.c:2258:13: warning: variable =E2=
=80=98error=E2=80=99 set but not used [-Wunused-but-set-variable]
 2258 |         int error;
      |             ^~~~~

I'm sorry, but I guess that for some reason previously I had only built v2 =
of your patch=20
which had no warnings at all.=20

Unfortunately, introducing warnings is not allowed.

While we are at this, I can also confirm that GCC 11.1.1 _does_ _not_ emit =
the warning=20
that has been reported by the kernel test robot.=20

Regards,

=46abio

=20


