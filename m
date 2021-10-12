Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBB342AE0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhJLUoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:44:24 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbhJLUoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:44:22 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MS3zP-1mCNI82qB1-00TY4k for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021
 22:42:19 +0200
Received: by mail-wr1-f44.google.com with SMTP id u18so1154151wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 13:42:19 -0700 (PDT)
X-Gm-Message-State: AOAM530DMosKuZ36EWK/83Tz9EkFlMd3Ptt0yOeZa2VN4BLBwsAb+Mgr
        ZuIIok1JgRi0Bf32KueqjlJb/DRoWEO2Ky80tbY=
X-Google-Smtp-Source: ABdhPJzvaI53OX+xGKvsUPbsLHcQ7HOum4/hh330wFgGF+KPXMCuEGxL8rfSW2+AfyYMWiKmpRUP1YMfpeKbT6lQ1zQ=
X-Received: by 2002:adf:f481:: with SMTP id l1mr34009404wro.411.1634071339409;
 Tue, 12 Oct 2021 13:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211011151443.12040-1-vegard.nossum@oracle.com>
 <CAK8P3a2+dU53PMJZvkDDGUyv=EiHuc03njGf6SXTxw9A4ByeHw@mail.gmail.com>
 <47e60186-2408-19cf-3231-92bd9c30483a@oracle.com> <CAK8P3a2nai8xGQPPMH89rO83252trdRFM67s-mmivAXeDE0zfA@mail.gmail.com>
 <8b209292-5b94-5a14-dee0-2c152ac02a5d@oracle.com> <CAK8P3a1X38CHrCFDxsZq=TYJw9Q_uP7MrM8fG1_D4X3-F2yL2Q@mail.gmail.com>
 <d02ef168-e105-27b6-0456-6db590807dcb@infradead.org>
In-Reply-To: <d02ef168-e105-27b6-0456-6db590807dcb@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Oct 2021 22:42:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Ox4s7WbSueR85TvkPzt7R46MQL=yBXw2VBy1HK4wduw@mail.gmail.com>
Message-ID: <CAK8P3a2Ox4s7WbSueR85TvkPzt7R46MQL=yBXw2VBy1HK4wduw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: select CRC32
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:gi/9fzUixrcxTA3XlUhcKQNTiL2iiYoNamHvD7GRtBmnjlLksma
 ghLhcwyGBFViFwsFsh/FPUL/kiE33Rl/8k7K27DZENtDOUF9aNirV8py6Se1y2/W8qWkS8C
 ptJckcr0TAvMkjxMiuNyEU4jEBKm36gpywjToiWF5xhB3BzXVnzOfvNUdvrYnTpSjzQ5kJK
 Ju+K789CDYaucZ8rRdl5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fb4mKkmeyyQ=:MhXO9uKkwA2p32QgJfI9hg
 Ww/CeFxJMI5x7ReVcQI35wQR2Q9e1pH20LwriuTa/HZsmkiK6q206orfWCxe9+heIGMCFAwx6
 5MZy3qt3UPG3KM39cjJ1fCa7/JT+YHo2tI4CExs010n6/umCY0AbKde8CLMc9MqyfPEuz/56e
 5yVn/PKeOG1/0UjmggOEnyD+1PAnQzXjaGKzuzrmh5dSnskM0YCduZ8h0vzPT6CBuvUqRXOVm
 lJbWaB33gO87erCZGmHiQHMZvc/ph+ocrtAUpz8k8xRkSGUGO2DuX9cYUG8tzmc+q5gOIpW1u
 ++ShLnKU3zGbxQkm2fJQV7ddOPTDGB2kzf+7kVr2vlpGez3JBnRj9y59bJCmwyTKIYXPQcGS1
 wEfZNM1ftScSP38uFoYLHxtwBj7mP0muJuwH/cJBLn/5xkBqlDlIB6qlEGhr9LdG+J4HuWwv8
 1ygcn5TkIpyUaoCYbysKH9R8IH+86IdGPl/kBM2y87KD881uteGCYackKJkZMh2VZViUYPBMw
 OalxIkzh3IgiPTZ/lkueXlxKVKdXijwhIQ/kPJG4bjFJyqChux/klcfobWDhYZpDl9sHq/Hlg
 Oo2SvCHGLi4afri7SFiygCKOh0y/+wXU5DZZgV4UUTXoBoanwd0FCerrocNEAPqr/MDxQrgOs
 C6PTxqX20E7yiyGgZOHJbDtu6YS14RI315MiimX6zWq8QOdyIY00cjyV/IDoA1c0AFL9lvivt
 /Q4dH45hoWSPuDQrS/Xj2Nu1juTq0iSEdSKCWg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/11/21 11:44 PM, Arnd Bergmann wrote:
> > On Tue, Oct 12, 2021 at 7:54 AM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> >> On 10/11/21 9:37 PM, Arnd Bergmann wrote:
> >>> On Mon, Oct 11, 2021 at 6:29 PM Vegard Nossum <vegard.nossum@oracle.com> wrote:
> >>
> >> Otherwise it's mostly CRC32 and a couple of odd ones like this that I've
> >> seen so far:
> >>
> >> ERROR: modpost: "dell_privacy_has_mic_mute"
> >> [drivers/platform/x86/dell/dell-laptop.ko] undefined!
> >
> > I have a patch for this one that I should send out.
>
> I sent a patch for that. Hans de Goede replaced with:
> [PATCH] platform/x86: dell: Make DELL_WMI_PRIVACY depend on DELL_WMI
>
> <20211011132338.407571-1-hdegoede@redhat.com>
>
> so no need to send your patch.

Unfortunately there is still a related problem that remains with
"DELL_WMI=m && DELL_SMBIOS=y", and another one with
"DELL_WMI=m && DELL_LAPTOP=y && DELL_WMI_PRIVACY=y".

      Arnd
