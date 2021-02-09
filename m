Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EC93153C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhBIQ0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhBIQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:25:29 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DFCC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 08:24:49 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id b24so3588594qtp.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 08:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WAvcbe90u/Sk2hKwNc4NT+yMPbtvqWizeUPK15paqhE=;
        b=o3su8ZUKZnc93qTfjkoIhgkFZB6+E/ONif1lXzM7/H5up7fG74+TRVf9LbJ5FdWoUV
         UCDlzgwJ7/nPBqfHoK5S5zZX1LufjBmC7NaVt6hcJ1Om0wHa8qedk5bVU2CEo7CWZPTG
         +UPJQEiDLN1pA6Eodk8s8AU7Bzt/5iy0fAYH9zZb/dOcwwCSE8UE8dIn8WT8b4ajSD8e
         99STx9n8SABe411AWSarJioVXmERaupHCGyuXHCi6lRzuFt1lHBIDvQMPwOt6CmJo122
         7x1bW8iVmFiCZ0Ps2WHn8dQLjiG+WOIdvuWVnHFEf5C2LY8FLUFQaVqmDCMGIUD4GvsT
         fuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WAvcbe90u/Sk2hKwNc4NT+yMPbtvqWizeUPK15paqhE=;
        b=YH+djoJWs5VEEU4+cgdeOikxiVELfpp44XP60F2Z6LBns7ITPNdehNjgK9Fsogv4yN
         /xxmUsX8bXWmJ69/vViZY7j7JxZkBQwa5oPT146aXDL6czUUnq3UqmG8f36erSpnYrrk
         IedYzY88U6ebcsR37H+a/iMn987Zi8rSfWyxLl2A6yzfD1klLejQQzMG93sdI78YWEx6
         q+3GzI5VN9BARs0ZEa3yWRESPkuQfutLfezZ4HCIoCkPSqFGO0PTgeSWzfsvm2uAwnMA
         ZwPiyjrpN9315y3OniDnhg4CLEX6qq3rDQvItApSwzxt9XX2nOC5rXC6MpCnqykmuZlj
         +ZlQ==
X-Gm-Message-State: AOAM530nIhqDjzv1n74NvXM6wmPiedhSn+T1apNPOdp/zxTn7qIUNYtC
        vacLexrD1runZHV5vUXUoR8=
X-Google-Smtp-Source: ABdhPJy157lVLQqlscIEGVM7nSm1diSussGJ8QKoOqtK8ib/sPtGN86HtLgQnt7VgOEOw7L6vqPE3g==
X-Received: by 2002:ac8:4e14:: with SMTP id c20mr10841148qtw.206.1612887888676;
        Tue, 09 Feb 2021 08:24:48 -0800 (PST)
Received: from ?IPv6:2601:5c0:c200:27c6:a82e:f46a:9884:895d? ([2601:5c0:c200:27c6:a82e:f46a:9884:895d])
        by smtp.gmail.com with ESMTPSA id j5sm16641832qth.80.2021.02.09.08.24.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 08:24:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] drm/qxl: properly handle device init failures
From:   Tong Zhang <ztong0001@gmail.com>
In-Reply-To: <20210209121629.vb3yu6zkr4npnskz@sirius.home.kraxel.org>
Date:   Tue, 9 Feb 2021 11:24:47 -0500
Cc:     dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FB53E26-5686-410F-B92F-5658BAF411C1@gmail.com>
References: <20210208104149.423758-1-kraxel@redhat.com>
 <E07153A4-9B42-4050-903E-8BBB99D8ED8E@gmail.com>
 <20210209121629.vb3yu6zkr4npnskz@sirius.home.kraxel.org>
To:     Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,
I tested the patch on drm-misc-next and it fixed the issue.
Thanks,
- Tong

> On Feb 9, 2021, at 7:16 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
> On Mon, Feb 08, 2021 at 12:07:01PM -0500, Tong Zhang wrote:
>> Does this patch fix an issue raised previously? Or should they be =
used together?
>> =
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2466541.html=20=

>>=20
>> IMHO using this patch alone won=E2=80=99t fix the issue
>=20
> This patch on top of drm-misc-next fixes the initialization error =
issue
> reported by you in my testing.
>=20
> take care,
>  Gerd
>=20

