Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD8831951A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 22:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhBKVYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 16:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBKVXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 16:23:45 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F797C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 13:23:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a24so2095112plm.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 13:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=tEgoT0HmRbuE6e4JpCgygnrE9cpBJTWQ7+JXH3WQuhg=;
        b=pmKbVGEnOb4Ywu5FegPl/J+kZMXoepkFLg+XUhZ6122zrqf5kj4Cl5qcCS7bx1s3Ak
         b4zFBCeO/2fz9V+EIv+sUb1ognSCaCe7gv6OjT5H7Kjs+I4ThpYwOtGsYDx3aOXRwbmX
         jMcJ9er93ns0ymcO6c9y10+itXJN4VGHFsSJwvzo+VVC24X6XLlMDK2eKHcyKYa3haGR
         ys1vrVHudYiLbC+cUfPKGAOvsS3t4bpYhJ0pVhomruxlu5KbCY/+40NciogcyfwSziMK
         Pf3v65uBX8SYpK6uNghd8VrZXLe/d5J/GeKikxwt1VdCMGn7VO5H8lr2v/l9I2k5NAm7
         iu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=tEgoT0HmRbuE6e4JpCgygnrE9cpBJTWQ7+JXH3WQuhg=;
        b=IiTXAjRfUPkBvzNFBUCOrgLiJzS+tP2V+lZpIVeNJHNyjXVULLjd54+iJstv8TkvPj
         LAXU8k2ZmxGqSWE1FrPJ+l3gvIig5qBUExaxR1Px1PuXz2JmVEfyN1Mh3+uz6co0aGAC
         mUSmamyoZv1SX/PmaGD/FIwZjG2HWagyzigFknngwFhgTzmB0k4Zxy51/0fZuMtconcl
         oR6F93KhsQZHujH55aSmVqBKOSrp0ppv3veeFt4muJ7+bJNzigQfHpqnJmyZDiJRNf/b
         1Cnh7HYx2K1qzyruUStIFbFHzsgUYxz4lGe+xnRdiJVklXP1bk61bhNaGYZ6W5i1P5FW
         oPzg==
X-Gm-Message-State: AOAM532rZjy8vdFcZEJMraUyD20dif9Qo7ZQ2h2ikd87UoIHf+xI1uPw
        YwlAqKD8+6CSmFAg93vJqts3cI8krP+u+w==
X-Google-Smtp-Source: ABdhPJxgxkg7Mlsrjuo4O42YpdvpTfA7wQ96Lna8fWxDUaA+0e0duJYccLCZVML19VtFnf6bTi0VLw==
X-Received: by 2002:a17:902:8608:b029:e2:d2e2:6347 with SMTP id f8-20020a1709028608b02900e2d2e26347mr57463plo.43.1613078583770;
        Thu, 11 Feb 2021 13:23:03 -0800 (PST)
Received: from google.com ([2620:15c:202:201:5020:12d3:4f90:14c0])
        by smtp.gmail.com with ESMTPSA id h15sm6669023pfo.84.2021.02.11.13.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 13:23:02 -0800 (PST)
Date:   Thu, 11 Feb 2021 13:22:55 -0800
From:   Benson Leung <bleung@google.com>
To:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        bleung@chromium.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Flush pending work
Message-ID: <161307851868.412883.1950690663022260067.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dd5pyPPjUmn0agZW"
Content-Disposition: inline
In-Reply-To: <20210211193221.610867-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dd5pyPPjUmn0agZW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Feb 2021 11:32:21 -0800, Prashant Malani wrote:
> When a PD notifier event arrives, a new work event won't be enqueued if
> the current one hasn't completed. This could lead to dropped events.
>=20
> So, flush any pending work before scheduling the new instance.

Applied, thanks!

[1/1] platform/chrome: cros_ec_typec: Flush pending work
      commit: a59e12218c4f5498d5669a0ee0c725101ca89d52

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--Dd5pyPPjUmn0agZW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYCWgLwAKCRBzbaomhzOw
wu8GAP9QRz8Hg3vpV23RSUMT30r58xlzOmLloaY6P1ieGMVn3gEA+xv6mTM7vR/N
zrfndUXCFAa39vA0h4wrxKdj5AaBowQ=
=LuN/
-----END PGP SIGNATURE-----

--Dd5pyPPjUmn0agZW--
