Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C4434E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhJTOy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhJTOyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:54:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A6C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:52:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so15650114lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uF9hWW3HRUf/pq/5JlaNIpHT0L4GbqCbpiYbDrZSHOA=;
        b=0rQGLB9YZvEkHvK2gZzkK/wXAshQ/85L4jcpnYTn/ZXKOUozcal+MHq8WwbHBllJ/n
         bBhmmBhdYW3pchY/eHmwbgkO+eCnMnP/yygJY6Vygqo9ypWELyqpAa/6esI4rE5QR97j
         k5k+RO5/XNlSP9bzowUY4wEmKd6fkztxB2AOq1MOoFLTE/yVe9rZe69DN1meqlbLLyEF
         8KvC2hK/OP/gWiHtVpZ4Kx97+PEKx9bpipD138oGEVd0cEadzRHZ4/yFG1cujSwWN6Ku
         tnJs3hCq2ImnBErlD9yQYGzg3GC/FBNBd6mO/i2yCZ5e6qiKKsNjyaAM6oTNHI4NqjJ2
         QJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uF9hWW3HRUf/pq/5JlaNIpHT0L4GbqCbpiYbDrZSHOA=;
        b=QrE6kxOH1KS0bvdu7wrhtfgjTGjh1aRSlARoLA9o7bb3OB1WisCfClKFPpo9JKEQKR
         LhCrVL+Aol8i4y3L4jWLyzTnI4TJm4u/8U2YwTlvvXvnMbbaMV3vt6TEQw6NWRAXl/09
         Q1cUPV1TJQWw2ZJITtcA+24ZXLmFn27YlRrji0C7k8/7xYHO81sD6KV+18CgCciwtie5
         OzBkTI/xcW72hkjOZPSx8VmQH8wGbi3TMLaW/pwL8KooNJwjMF56GgzMhvmYGxT5GrXM
         Dj5UKWNq73xbHc5h+15jgLy94aVPYuGE8YIrvYoxk9N4MbHdtU644hopFfvIATyOOwg8
         kPvA==
X-Gm-Message-State: AOAM532QO+JSd8kYF52TYziLF19HNJhFcFqI4r6wiU/B/08BjYXda/Bc
        hgDPZYb5VJqe+yp2ZJNq5BZd6zv90iX/UOWT2n9Spg==
X-Google-Smtp-Source: ABdhPJxpXDFarFNfEzRY7wsOM/9m/aFfKd6h5mqPvuRmjwEt9qei7dVsoAhUSKaOcnD8t59mJNjsNOJJ1O+LDQVLYbY=
X-Received: by 2002:a19:c201:: with SMTP id l1mr252650lfc.92.1634741557199;
 Wed, 20 Oct 2021 07:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211019141228.1271617-1-pan@semihalf.com> <20211019141228.1271617-2-pan@semihalf.com>
 <CAK8P3a0g82DoivaADueeOcKOjNVDiutZLAAWAROzgvuYt83Z3w@mail.gmail.com>
In-Reply-To: <CAK8P3a0g82DoivaADueeOcKOjNVDiutZLAAWAROzgvuYt83Z3w@mail.gmail.com>
From:   =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>
Date:   Wed, 20 Oct 2021 17:52:28 +0200
Message-ID: <CAF9_jYQt6ObUcaA0_aKHnQDoKuYPAYT48jfA3_RKE=q1OkCang@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] socfpga: dts: move arria10 aliases to socfpga_arria10.dtsi
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        upstream@semihalf.com, Marcin Wojtas <mw@semihalf.com>,
        Jacek Majkowski <jam@semihalf.com>,
        Konrad Adamczyk <ka@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Alexandru Stan <amstan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 3:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 19, 2021 at 4:12 PM Pawe=C5=82 Anikiel <pan@semihalf.com> wro=
te:
> >
> > socfpga_arria10_socdk.dtsi declares aliases which will most likely
> > be used by other arria10 boards in the exact same way. move these
> > aliases to the parent file.
> >
> > Signed-off-by: Pawe=C5=82 Anikiel <pan@semihalf.com>
>
> No, please move them into the .dts files instead for consistency.
>
> Each board may use a different subset of them, or have them
> numbered differently, so keep it out of the .dtsi file.
>
>      Arnd

Thank you for your remark. The aliases per .dts file were in the v3
patch, however this change was explicitly requested. I will bring that
back and resubmit.

Thanks, Pawe=C5=82.
