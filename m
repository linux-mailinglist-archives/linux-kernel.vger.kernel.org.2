Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B793A78F6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhFOIWX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Jun 2021 04:22:23 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51865 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhFOIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:22:20 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MVJZv-1lm5ta1kud-00SK5Z for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021
 10:20:13 +0200
Received: by mail-wm1-f53.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso1131528wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 01:20:13 -0700 (PDT)
X-Gm-Message-State: AOAM531S49saALBdgqyYnw8amIV22WqPXf4ybCMrsrJGfRR5kVKBIq7x
        eBZqGpEL4ZKoIfsv40orZioDz88loXI/MGLnWR8=
X-Google-Smtp-Source: ABdhPJzknn/wAJB2XqaT3EVDJsrn6Qqah7F4ZEXQeGy3QtlhDK7hDwIGPQwgesZTjjCaBAU6WLgbMpnOXihkPAGPoi8=
X-Received: by 2002:a1c:7210:: with SMTP id n16mr3675673wmc.75.1623745213164;
 Tue, 15 Jun 2021 01:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210601085319.140461-1-libaokun1@huawei.com>
In-Reply-To: <20210601085319.140461-1-libaokun1@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Jun 2021 10:18:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2eAcyATVtzo7djRkkuTuS_b3gshCTyboV6oUzoqHnt-A@mail.gmail.com>
Message-ID: <CAK8P3a2eAcyATVtzo7djRkkuTuS_b3gshCTyboV6oUzoqHnt-A@mail.gmail.com>
Subject: Re: [PATCH -next] powerpc/spider-pci: Remove set but not used
 variable 'val'
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, yangjihong1@huawei.com,
        Yu Kuai <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:2lrQIgMTUfHyLWSiw4yW0Am8c5SE7dVlHt51ICFVdIhwNtubY8d
 aRKfRoG2lpjwUInIqsMpJRTUFLA5DnK2+OREbXP0Mc8GFkq4H3LEpsn/j0vV1RSAeMRI1F/
 mgctG89SFzYq6WUvjg3UVf8LcSnXZBh2fTGdEt4/CxahK8BIdjZKs4MznhyypIN7rIkUILc
 Xy+IUs9pJet6m2c02VlDg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/DbYj8uXV34=:Fiu354hDYf5GnGr2c0rMPe
 R3GZ0ZkWctQvv8zDN4JdzSNFmMd+pLipDBdE4xo+528O85AvFktA9XpOIqN71aDsKpOC/Ev2p
 IhSor/gEm45DUoAmmsTpdnLqMqkj4MVu4joZ/pjQGFoWFlj4NYN9CL+iXtAJwxZg3rPZMlVnA
 2nON2IQnmW2SX2o9PQKaJC9yuB/Ru6v7p1QPE2b9oVaTZWj9CEv3ir0JFSjERtgSBuoKy3gMM
 uEOLNexSP2HdyVBnWKGYeRINvYXxi9vz3v0VRMOHd5CDb3mXWMGe0DfOWqaxfokod/+ua354r
 N1bMhW9if6jSNK9XQeN0RoI6/F0t1SynQbbFv/AGOQqu2wPaDScmyhaYxCTyoLmCu7x8uMMIU
 1kjoZ5ptGTPVux8IZLseiUeTNLLrtMp8Rb4He6LFuoRNJshxHH/ij+D/nZo5I3nbpLDBECcr5
 ELVNrRRSk1hCAH/ganvesxhvDer4WmnjhxWSohAWTfjZLycXwu8ox11/jAwO2fjAwhDPi92xH
 6hVA335pnLg5CvAkwjc+/I=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 1, 2021 at 10:53 AM Baokun Li <libaokun1@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> arch/powerpc/platforms/cell/spider-pci.c: In function 'spiderpci_io_flush':
> arch/powerpc/platforms/cell/spider-pci.c:28:6: warning:
> variable ‘val’ set but not used [-Wunused-but-set-variable]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

LGTM

Acked-by: Arnd Bergmann <arnd@arndb.de>
