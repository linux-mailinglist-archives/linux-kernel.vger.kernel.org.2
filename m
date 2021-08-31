Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180743FBFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 02:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbhHaAas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 20:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhHaAas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 20:30:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6492C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:29:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g184so15080637pgc.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 17:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z7t2trHohKRljUAy8EElwDU1qFOlxkYQyBAMS3eRrms=;
        b=bpQFipTAYuUqHfkOkxyWTzIqI/NmWCfe7T+h2qJ3bc+3hXdQI1599rx2zZo5SYByOo
         hMXXB3mmwwQo7f0SLX+pBTRhzQ051hMehaKauKITzxY2HpsNa3RtzOvAmbAGKprI/p6Q
         ZHQaNkxdr+5cs6puooAH8eFJOzaQR7Y+nFNJATT4NEtGDN+WiUjqsL0KFEgI+YQleWG8
         GEVW6IHq8PPqHhh9uhvMe9WIV42EWBucRKCJypq7Sn/gfMNkUT18UKoHABRZAysc/zW3
         R9umsAsERZaPaIcAdXoJYwbNJIrxW+FRIDR4DOtoOZkBctsiXJ1vOa9Y5P3ODXhzkFas
         tNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z7t2trHohKRljUAy8EElwDU1qFOlxkYQyBAMS3eRrms=;
        b=RoqV6LEKqjbgseodVKS9SsIldPU1NrBu+eadp0f46wf31b9cTAy8q7KkhBsMS/T3i7
         eZzso8OJ+/gREb5EXdW5etj9y2F2JhyeJiou/swuctSXuCxT9U7Ts/dDSjtgYFWkoa40
         M9yDK9aUsOesp8hNSNnElTGljb4Uuy1YOBJ2qIh0b2Tb5f3kbsluaXtxSmt5Uhn+Rc7K
         NjNC0HZJTM7LILAc1zfL2BKWxjhtYK8XhVAS64zYwlkW0Ly5MT+aZSk1Gfe3uIRIb9rf
         +Qo/0LF6HU6kiYnuVFs/+tfg8gRhUPIGDvGM8o1VLgfZzB4aLxZaCHEwfJ2OPN+T2Iba
         cKaA==
X-Gm-Message-State: AOAM532UPnbsdldNNiGHD4T39HrsXYJgFnbu4FUJOut9p2Lt4fgGERsL
        FJxyby4IFUrEgHPCFchf9JRhSw==
X-Google-Smtp-Source: ABdhPJw99INV458XzJrWDNLfNMw5o5IlxfrnFU+kMPaSJS1/SCUCWbpANVHWxdE8zHbmc6w9NHA3aA==
X-Received: by 2002:a62:6447:0:b0:3fa:bce4:c78e with SMTP id y68-20020a626447000000b003fabce4c78emr13863085pfb.15.1630369792731;
        Mon, 30 Aug 2021 17:29:52 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:d2dc:2a51:77c9:8407])
        by smtp.gmail.com with ESMTPSA id g37sm17350992pgl.94.2021.08.30.17.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 17:29:51 -0700 (PDT)
Date:   Mon, 30 Aug 2021 17:29:45 -0700
From:   Benson Leung <bleung@google.com>
To:     Gwendal Grignou <gwendal@chromium.org>,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org
Subject: Re: [PATCH] platform/chrome: cros_ec_trace: Fix format warnings
Message-ID: <YS13+XuZxGP2xAnZ@google.com>
References: <20210823200132.2006257-1-gwendal@chromium.org>
 <163036877941.809543.752509524579579884.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MUHmdAPqyeUfA1gW"
Content-Disposition: inline
In-Reply-To: <163036877941.809543.752509524579579884.b4-ty@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MUHmdAPqyeUfA1gW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gwendal,

On Mon, Aug 30, 2021 at 05:13:54PM -0700, Benson Leung wrote:
> Hi Gwendal,
>=20
> On Mon, 23 Aug 2021 13:01:32 -0700, Gwendal Grignou wrote:
> > Fix printf format issues in new tracing events.
> >=20
> > Fixes: 814318242 ("platform/chrome: cros_ec_trace: Add fields to comman=
d traces")
>=20
> Applied, thanks!
>=20
> [1/1] platform/chrome: cros_ec_trace: Fix format warnings
>       commit: 5a51bdb0ae26cac8764bfb59839a34ea13155a47
>=20
> Best regards,
> --=20
> Benson Leung
> Staff Software Engineer
> Chrome OS Kernel
> Google Inc.
> bleung@google.com
> Chromium OS Project
> bleung@chromium.org

Sorry about this, I merged v1 incorrectly, so I've repushed v3. Disregard t=
his
thank you.

Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--MUHmdAPqyeUfA1gW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYS13+QAKCRBzbaomhzOw
wlREAP92JQXa5NACeLUYY8oYVy//93Myt0la4AIq0YSMkLlZvgEAxbxkXWHIpXlZ
PvOv2BjRl3LhwNv+kNY5VgAJt89ubQg=
=/d8t
-----END PGP SIGNATURE-----

--MUHmdAPqyeUfA1gW--
