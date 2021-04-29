Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3611836EBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbhD2OHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239617AbhD2OHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:07:04 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29530C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:06:17 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i14so2723311pgk.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=cLQY0MZXd1QKEfU0faEULRDEWzctexT/MNF6ksABMzPMwyirUi2R0YYkah2/fGJ92x
         0V/MMILqgseZcLxuqrtDBt+UJQ0VifmW90U8QFBDZaxejIgjoQqJ7UzH/bRT5AMovCuI
         nZq0Pf4UNAnoagFHyU8MzlCCEM71lEuHcy+Jse6HnnbUaGgijd43KPpTC6+yEvZNvjw1
         nKXVErJ3SBsjp2fMOP7qDWLcHMDJ0T7hiWeG4hgO9gefD0erX3lTTgLZwYY/liJQBdEQ
         3jLoeVcReK6CaJZG7lmZDvzDzWctegdH1CusJQRtJuJB2ijSU8zWcDe8loYRIvVwc44X
         L9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=Q+ptAwxJ3tQyIJmZg11az2Nhg8zJHRPY0wzx9Jr+uLoyFIPt7JViLuALTl4ygQpya1
         bk12Q49RXaFeYGzOrwa8jG7npR50kIHAG68mJxhM0j6X/+gUpaW+ys1us9sILIIOFDlj
         fYbjSrc0FdDKeb11UnDQaFcFCZm88+9FlxzEkF9K+/EW1QQZm/UCYUXpCp+SAlfGqKtT
         0rqWWNd+JjM2bY7NrjT1HPuD2k93nIxHgPNXeHMflft8zspqPwtqgK6JCJ9WHbtu8RgP
         zUezw/3NrIBPckBs/DniymTt/MXpLURljteIRx6l8KTX46U/rKsTk9RHhwfz8emxbxJk
         kvGA==
X-Gm-Message-State: AOAM533oOfc/bZvYZeFecA9p8ayluhlXVMJe1hnjL5pkXh4w8MQymEyI
        cLAE6OuftfIXDeCZoY8hUjR0gJ1Cs0iJ0WjiN48=
X-Google-Smtp-Source: ABdhPJwPUw82+20jm7/4d86OMxIe67wTj+tQT2TshOJWEvzsrgJWhGBy4rVSoVihMoi65UK5v75bjGOX/Fhglor7VYw=
X-Received: by 2002:a62:2cce:0:b029:21d:97da:833e with SMTP id
 s197-20020a622cce0000b029021d97da833emr32777454pfs.40.1619705176781; Thu, 29
 Apr 2021 07:06:16 -0700 (PDT)
MIME-Version: 1.0
Sender: rachellehounssavi@gmail.com
Received: by 2002:a05:6a10:474f:0:0:0:0 with HTTP; Thu, 29 Apr 2021 07:06:16
 -0700 (PDT)
From:   kayla manthey <sgtmanthey1@gmail.com>
Date:   Thu, 29 Apr 2021 14:06:16 +0000
X-Google-Sender-Auth: MW_BRqXGsl3eXbCsn3KKDuFMvMQ
Message-ID: <CAE0ZqBZdUXaE0ukwM_BBW8vTOSxckfKc1K9GE=8iXEBbsdKEtA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K=C3=A9rem, szeretn=C3=A9m tudni, hogy megkapta-e az el=C5=91z=C5=91 =C3=BC=
zeneteimet.
