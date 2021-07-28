Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159A03D8A25
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhG1JBh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Jul 2021 05:01:37 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:53321 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1JBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:01:36 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Msqty-1n1rQT2x3o-00t9TF for <linux-kernel@vger.kernel.org>; Wed, 28 Jul
 2021 11:01:33 +0200
Received: by mail-wr1-f44.google.com with SMTP id j2so1553467wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 02:01:33 -0700 (PDT)
X-Gm-Message-State: AOAM533aRJ/Mp5QtMDqwS6jGeLzci7H++HP6XhJ4MzBiKaPPAvX2u/vy
        ilcIzvqI68A9OdpEkQb8MB51MiN2WOs8xOyW9rs=
X-Google-Smtp-Source: ABdhPJzsTaVx3R8Xjt7RmEMRCOEETac71shB32aGf6LsvyM2QcF0PWl6f37f55OVAfeM0QRVKWrKMZbildTjD36IfgI=
X-Received: by 2002:adf:e107:: with SMTP id t7mr28823475wrz.165.1627462893205;
 Wed, 28 Jul 2021 02:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
 <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
 <be29127d-8cec-c7b8-ac96-4da94198dc03@linux.alibaba.com> <CAK8P3a1O02Ho2dM3F+bUXf9Ze8uRKYzY5fFmRGpszUXg_nrH4w@mail.gmail.com>
 <0d03a42b-b46c-408f-17a4-b6c094c0c29e@linux.alibaba.com>
In-Reply-To: <0d03a42b-b46c-408f-17a4-b6c094c0c29e@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 28 Jul 2021 11:01:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Hde16rbUPAwvtY7t+uE7C4jM8_pQCqTLj=-d4=T2MSg@mail.gmail.com>
Message-ID: <CAK8P3a2Hde16rbUPAwvtY7t+uE7C4jM8_pQCqTLj=-d4=T2MSg@mail.gmail.com>
Subject: Re: [PATCH] virtio-console: avoid DMA from vmalloc area
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Omar Sandoval <osandov@fb.com>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:8RsEoH1dALGXgc/gZCqKHaVafV4hlSLyaDiT1KdewUDd9EZXkx7
 qtKhySY1kPmHlSPJDMUHrel7Z9yG+/S+mKENGw7InPWjwfUegjZJELDIKPM0sG551GEvGZ8
 dRGHl5hRPq1RSODz7qgplSISUtaRaMZ8kch9tXo4iyQ1FU0TgOUuNyKDyD2ktCk0vUu1DWK
 JR6b9hKdy1Nghuu+FvdbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z6U7lP844Ao=:LJIq71ndA1meDlkgwZeF6L
 SjVpLKihRcMrySkxvvo5b0e4KpK2yzg0fJ/KlfDU77GnDEhdILnMBSaLhR02+olDyZRQ4FGB6
 waXPZNHU+KFWqBawH8AI758ehcRSiJX+IAODwaEAVAPccWDEVfdOtKSPs+jx1BlSjSy2HBRwi
 yAM/XIX5BA6Lg75jL6n3kwx4na0cDcY66rKG6eqJawPHFzLYLo0U/q7C44HVz24O8QbD2fRi7
 D1qYgmUWzQb/5TGUIP4p3b/uXisi+vX14h4LxN2UGpNV1JDAU7/T7V1k5SO26k8EfMfGIg1wD
 lNADw2y/5Yux2fjInisEdWWBb7z6X2yVjhx5eU1884/teb9B+fbwzxVzW1nur+uU8VCxTnzSw
 npYBeXk1XJVfHqiz0EMD8V+I/BIREe+9rxFcbvs2oYztmt9QP4WhoYKScfjlrLx71KH75tNzU
 IGh2dKL0WfzgeoVD2bANwUkrh5Qn9/HaAkdwaqTukgSv9BB02EKHLx2DYcCBoQolcqVwFmvGU
 VzcSIp5qDYVYwo9ty3rsda5URxUd+OF61TxgwnCJyFxfjtmICowczheUMeHGUJfvI4xuzottR
 /qzTCcfIoNVkwn2X/wQCbcb3cGlPpu0Wt/zFNCMP81+B3j6aMkBl67zlVd3EsLVB1vPgd8ZdN
 DAC/7zpWJNCITudhN3r/p98dmtHo5nzFXFy/LjBTfbnnJFjb+rOMwOfsvzSSIC/2Ix/mZfL44
 r2oZWGbGfJ1wuxxyCV2jI7KpRphe1dovgLUbYVc+a7bFrzdlLAaolJmHfkaZ1dTKtEwUEqG97
 ql1+TBOReW7BNb0kGET+dmC0ncfdu28WrlmVtIjXxuzanncAHM141XNbWbRRddrWLw22JOs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 10:28 AM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
> 在 2021/7/28 下午3:25, Arnd Bergmann 写道:
>
> I checked several hvc backends, like drivers/tty/hvc/hvc_riscv_sbi.c,
> drivers/tty/hvc/hvc_iucv.c, drivers/tty/hvc/hvc_rtas.c, they don't use dma.
>
> I not finished all hvc backends check yet. But I think even if all hvc
> backends don't use dma currently, it is still possible that the hvc
> backend using dma will be added in the furture.
>
> So I agree with you it should better be fixed in the hvc framework,
> solve the issue in the first place.

Ok, sounds good to me, no need to check more backends then.
I see the hvc-console driver is listed as 'Odd Fixes' in the maintainer
list, with nobody assigned other than the ppc kernel list (added to Cc).

Once you come up with a fix in hvc_console.c, please send that to the
tty maintainers, the ppc list and me, and I'll review it.

        Arnd
