Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705B543385B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 16:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhJSO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 10:26:17 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50271 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJSO0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:26:15 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N5mSj-1mnNso2I39-017BS8 for <linux-kernel@vger.kernel.org>; Tue, 19 Oct
 2021 16:24:01 +0200
Received: by mail-wm1-f52.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so2901310wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 07:24:01 -0700 (PDT)
X-Gm-Message-State: AOAM5318AaCyK00xaB1JSVDxm4jz0c2Zy8zI7GhPwnTSpqAKkMQyQZeA
        sjUlQr3O3LgmJEATJsQEqZIVOkq0uYftvhrBLhc=
X-Google-Smtp-Source: ABdhPJwKQW7tgBaH6kTW0rrTX50ypr3eK+Ahefc5knwle6M9G57uWXIVrYYyqptMm0i3QO8nZ4vcPCD26aJqtexE85s=
X-Received: by 2002:a1c:4b08:: with SMTP id y8mr6692599wma.98.1634653441129;
 Tue, 19 Oct 2021 07:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <s5h5yu79aab.wl-tiwai@suse.de> <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
 <s5hv9277oux.wl-tiwai@suse.de> <20211008120736.GF7074@brightrain.aerifal.cx>
 <s5hsfx95n99.wl-tiwai@suse.de> <20211018144259.GK7074@brightrain.aerifal.cx>
 <s5hlf2q4byc.wl-tiwai@suse.de> <20211018150824.GL7074@brightrain.aerifal.cx>
 <CAK8P3a1RAk5WRtMjqV6QZ1eHtFu_sxhSBJn0Uv-MhRA5WGiJqQ@mail.gmail.com>
 <20211018204203.GM7074@brightrain.aerifal.cx> <20211019141622.GN7074@brightrain.aerifal.cx>
In-Reply-To: <20211019141622.GN7074@brightrain.aerifal.cx>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Oct 2021 16:23:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Znk6FjUnnMs0KobOBw02f_fwxapeOZH9zrx-h8=Ftqg@mail.gmail.com>
Message-ID: <CAK8P3a0Znk6FjUnnMs0KobOBw02f_fwxapeOZH9zrx-h8=Ftqg@mail.gmail.com>
Subject: Re: [musl] Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit
 layout for snd_pcm_mmap_status/control
To:     musl@lists.openwall.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>,
        Michael Forney <mforney@mforney.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1irHjch2F/mNA9GpXu85IvRzFXMfAVt+FnPaqgOGwDXlHnb8pv3
 JDAXGN/FeNlds4wjApCyYJZ4LvjLvXC/j8B2Rqs8h/qFulrCV1NoIj2PLMXOdEho2mDQJzE
 sKawAaXoWoQSllHlVAYFbCF6GpeiwnztuVuJLd6JTHhetgBunu2S+EyeGE8h7l+nnnGHsL6
 HQWCpVZa+kDm3YDRpYbFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ae2ExS+Eqfg=:VqFY28NcztfJHf675fQiah
 b8e8rr0tUpXnuJg2X/poEoTFiQA4VzuL8IIu9NgH2RLV+w8/7GKa2bAnUL3jtGfZfYBEXDtUa
 35ddvQ6gxaL/RNGhuuisBsDRrd3vySlg8ST1aEuZqxcRSTgrzbpdoodiZKLDnQJ3tVS+7Xc8I
 TVyuvV1ptZG/nuIwxP6vsHuZzTFjTLXTVSZXJ++KW8imvv/T8OfueYWGVj9eLWQVvMTT3cCoI
 F+8Qo4ELVURZ2D++enHA7j5k6muOC/NSp4vTUg+P4jMDbsthPCeJJSPL24atYGph6sEyN2tlb
 qyI6SshK58UAc4Dk4jEUx9gpyvDWX4A6qQc0pE1Wh/ME4ZDZ1QYXUusj68MFn8BWc7QDHcygd
 zS78ClqD3R8lO7RqjizSzOCuiU5a/NQx5Mrlnk2PchSJmA6EbxUQ+a7+BaIPMqLcC7DARynQC
 VpGEhkoIBXL1Ogf9vmmwY8EOx3Cwc/kF9Kt57ZGIJtsFoIafu4OwDUU5WlHKePNr6udrZXS7Z
 P99Nev3qrMkaMI0eT3t/RnrfA/mLNQNHKqjapmLgJUSh9GOamOyw4Zzs4aDrRa8/yEQXV45O1
 vFK5h9ZH/9j7o/bjszyhzzdEjLhaXQi67moYLcBXsv2ss+o2MyPH9No16nJcsR2VB0zNdTrqE
 E1iOEdPXpyVC8U7QnbmHQTsLErx5VoU4YzJmEldTLDNaAFPrpBTqUjtb/Bo6efQffPTifxfsc
 2tZyi45Q2FVsYntxzW2/zYn48Ok0uamF39do1t+dEJ8YShs/blbsHf8b2dewOkcgljzCzfxzC
 qn8Z/KenToyUCcBcj18GtKKLmM+AncWaTTHQFZNKmsI3XG0phtpmeXvH1GTtQ18/3VAq90uyv
 +gMQhWSh1lvP8WUM1JfQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 4:16 PM Rich Felker <dalias@libc.org> wrote:
> On Mon, Oct 18, 2021 at 04:42:04PM -0400, Rich Felker wrote:
> >
> > Well for little endian either would work (because adj is 0 :) but yes
> > there are 3 such paddings before the second member on big endian, so
> > it should be 3.
>
> How about this? It avoids open coding the logic and handles it as 2
> 4-byte substructures with endian-specific offsets.

Looks good to me.

      Arnd
