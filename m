Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461EF40657E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 04:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhIJCBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 22:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhIJCBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 22:01:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4B8C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 19:00:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id k4so839908lfj.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 19:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uum+eXxKl7E8Vfz4IYs1ZYTXVuqCttV8A2hHBap2fOM=;
        b=qSj4q/9yh6h2yl7YEKfiMk4cvNkvdKrqNDYlO7ADJT3RtNf8rmf61v4hUVkMCGHGtm
         rthuMbi3bIlUbpqQA3Oc86W6AoundTNhq/2NQBwlfIgPYq939s9mr9aziER9fyXjtCPC
         L/iBCvXMioWN7Fb24TliD/xMM4VOHXGAz8xg41vopC0rNFS9kn3GZGXdafVX2fVYZDoD
         MZSKhiMwgvIg5u7F+O6lJrWtBI48M3S0BlyKrri95bi6Q94LDodaBnUpH5Exj1U6V/l1
         v15kn6/YhKxyKhXGNtUu1Lloi3WpCk18xkOA0Yk3XHa0iy5lBVrub/SSgaeqRy87aO3x
         1hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uum+eXxKl7E8Vfz4IYs1ZYTXVuqCttV8A2hHBap2fOM=;
        b=ZKN5VrwOe31PsTiIvXlIDdf+lun/yq/R2wtBTA2CuGyAyu0lCmkzm0AGoUHb3pEmp7
         71Rk55B/uRW08dtLfBgzw/NsJPaxWjzA/g66q3L5n8jeac9NCAkIq2G7HdiZryjv9ypm
         4bPSj5I7TrE0A1puorufSNGdtUp9T0j9fDzsN1PUqJs0quCnwglVlyKWnoKtl3saf5aD
         wM/MDMDtU/3SomwhxyicXPX1UgPfxchHs8da1FcQ7igjpqzxu2QhdRVdkpkbS9XZi6c/
         9rDlU4aLHSwSHvI2ZDbc1amZs/AWSkOW5tAWiDpB5N0EaWE5ULR7KzSzAIB3AvKG5kOM
         nysA==
X-Gm-Message-State: AOAM531KFPGH5O6Opgy3+Og8dQlc8HRj8BFNPEtcwrGjQcrtTaDfmBkB
        hXBH0OrFte6Zr4tzWj0B1LlDHOWefhIvgtVBRLBgUg==
X-Google-Smtp-Source: ABdhPJxH2uBdeST0nduzHRbFIGPhvw7XFM2pjJsogidqxTFgzaqyizJgKW+U8VqG0FXj6j4icB+UuBwd5B4iXQaokSc=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr1915757lfa.523.1631239239581;
 Thu, 09 Sep 2021 19:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210908061611.69823-1-mie@igel.co.jp> <CAD=hENcYPRQXB4NVfpm+_R2qn3czW3oSOS6rS=CEKWwhHEfkZA@mail.gmail.com>
In-Reply-To: <CAD=hENcYPRQXB4NVfpm+_R2qn3czW3oSOS6rS=CEKWwhHEfkZA@mail.gmail.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Fri, 10 Sep 2021 11:00:28 +0900
Message-ID: <CANXvt5qv1wyYZnChG3b0s6WVgv0wUEYTJB_aV09ZsYXwCsfKoQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] RDMA/rxe: Add dma-buf support
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>, taki@igel.co.jp,
        etom@igel.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=E5=B9=B49=E6=9C=889=E6=97=A5(=E6=9C=A8) 14:45 Zhu Yanjun <zyjzyj2000@g=
mail.com>:
> After applying the patches, please run rdma-core tests with the patched k=
ernel.
> Then fix all the problems in rdma-core.

I understand. I'd like to do the tests and fix it before posting the next
patches

Regards,
Shunsuke
