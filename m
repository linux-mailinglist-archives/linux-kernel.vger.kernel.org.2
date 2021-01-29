Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109F4308628
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhA2HDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhA2HDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:03:13 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643AFC061573;
        Thu, 28 Jan 2021 23:02:33 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o10so6425236wmc.1;
        Thu, 28 Jan 2021 23:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eJkj1V1MkLzif7cX7fwiDSMfGoJ2Oh2DLNZ/fCE/Z3o=;
        b=lPQHzs2oYkC3CFAEdZuyjl14P5w+IWZ1HGPJCGdN1ZqGxq//dyTY7g3BhrkShLae/c
         cJFflHbNBGsfWzzFZPVg1KGDNSxIggg3gJFyBVRhJy/6u3ROj1/FDOJV5g9jEEFY3M9u
         t0RQSCKmsOX25UvuWyHZCEKx8xb+rfhbkp4NGg3TCPdqlcily4QjD9Jrpa5rB12lELY2
         Cpv9sOJG6UjQjmzBoFSu+1lfXuW/2B5t4xXcFS28RPGQw0+yOXJnk/r/MM+hLwVABkXM
         +xGsFbPFQYC1Zi+4iB7quLZDL9NCZXflJmPgSg975sSGWFseVWvtklVJyLKjDaweMO7d
         d2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eJkj1V1MkLzif7cX7fwiDSMfGoJ2Oh2DLNZ/fCE/Z3o=;
        b=XC09qLFin4Idw2lzhQdambhaeU9dekMWf7UZRfru0x5uXKN1eNcxoyp6CUs34iYeZ1
         nUFqjzRqoMoa3rDMaQLWzsNDGlhTE+O2mERojxh4+k4RcAW0NnvPYEV4AcU8K/2XzoPZ
         Yovpw8lBZDIqiJQZZ4vzchUtcrZdSwLrF7woQ9vMW88kjAwTVW3R6QpYQc2Qdr808sKu
         n996vb2JEOpqZVy5Xqe2nCDf3FcvFhqkJVi22aPq0Lgt1xFQdCS8GYQQ9THd1pECw8/T
         jxgg8hmpFGV1v0qZHprH2zLgpioNtWZ+oUuiAgxxYpfhAmYuKxUIr0l/AjrHMBbUxcBB
         d8Tg==
X-Gm-Message-State: AOAM532emeftcsXuCI80G/X0BXxminS0swY56g0RQT/lz9uW53lHR6GN
        bF3H5RAGgoEWIP0LvOX+Rw8=
X-Google-Smtp-Source: ABdhPJxWE4Ozi699IpCCBMsLQSWXjJHZiDIf9lvepp7VIDJb3CSXA6F/5VIsb7x7Y3TnGi+jjySCmQ==
X-Received: by 2002:a05:600c:3591:: with SMTP id p17mr2408906wmq.153.1611903752141;
        Thu, 28 Jan 2021 23:02:32 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b13sm10151655wrt.31.2021.01.28.23.02.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2021 23:02:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.17\))
Subject: Re: [PATCH 5/5] arm64: dts: meson: add initial device-tree for
 ODROID-HC4
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20210129065137.5473-6-christianshewitt@gmail.com>
Date:   Fri, 29 Jan 2021 11:02:28 +0400
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1508520A-3693-46C9-A48A-2C3502DB8390@gmail.com>
References: <20210129065137.5473-1-christianshewitt@gmail.com>
 <20210129065137.5473-6-christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.104.17)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 29 Jan 2021, at 10:51 am, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>=20
> ODROID-HC4 is a derivative of the C4 with minor differences:
>=20
> - 128MB SPI-NOR flash

^ should be 16MB, I forgot to amend. I can send a v2 series if needed.

HC4:~ # dmesg | grep spi
[    0.453235] spi-nor spi0.0: xt25f128b (16384 Kbytes)

Christian

