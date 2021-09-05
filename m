Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6CE40116C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhIETvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:51:03 -0400
Received: from mout.web.de ([212.227.15.3]:47567 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229865AbhIETvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630871395;
        bh=FAx/rO9K1RK3SrZO0dEK8qHepRBRgwULCOoqC9i3LpI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JY5pMoI3mX3wXihLdcjMfTHStVicPRt8JyrcpO/sAsx8JuV2clGF7psTVDt+IbxBu
         ec3DgmrpPISEDuh0rT0tu5eN0KfX5k9W+//w3ljUU0SKJTh9NZ9m8pHQzjy5/+yxJm
         J4Qgld7tN5xhL9ok9asQss6Pn5LA0yhaw5yfHE1k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.0.0.110] ([185.159.157.24]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWApN-1mTMz53uqP-00XLKC; Sun, 05
 Sep 2021 21:49:55 +0200
Subject: Re: Can't boot up Linux ISO on HP computer
To:     EpicLemon99 <EpicLemon99@protonmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <t2AGLXpsN--6I99ztVoBlXWzyEUo9HarRnRtFyM_sXXkaWbN9m8nmrCLyB1aKetozYTKQ1PV9JEC3Kr3yKpIiYczmcidKgt5uv1COs49c9I=@protonmail.com>
From:   Andre Muller <andre.muller@web.de>
Message-ID: <5a291d30-aad9-9285-192e-b5e6c4708315@web.de>
Date:   Sun, 5 Sep 2021 21:51:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <t2AGLXpsN--6I99ztVoBlXWzyEUo9HarRnRtFyM_sXXkaWbN9m8nmrCLyB1aKetozYTKQ1PV9JEC3Kr3yKpIiYczmcidKgt5uv1COs49c9I=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zwE0gSGpdbfLBzciZ7aEnesmOWscCjCFxHE6YSCFKxQwU7lrS9t
 wLhivkLOqZocgqYpkxRhcAspTtJugrEd5F1vffxB769ZUw2bTg9BrUlc+Yr+EEDKojT8Nse
 GGd5Vj7RqjQBx68EN2yQBGl8CKdVs63KgCfi2iW5lh9O9gSybuH02AyXm44+AtTCQeWBSMh
 VBl3Ey20hF1hlQpDGsVMw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t3iADJ7HuV0=:9/OFUA3hBy0tIGWjmE3YCT
 /KjOrV35JJRHbioJwpCUzvkmPDygRs2HatCN64o40aVN5+rVou69Qz+FSFOlAaQ6jkp5xH/xI
 pWKxFntxafZA6deHEQl7Sy5iI7mxRRkU/DZaRFzJkag5XSziC1BXCmZM8U/C9XoFZzq+9YzAx
 L08Mt7OhJ1t1NxAoLQB2495xLztrQFwl62nWovl9phr6HVqVAuqKy3GYm0XZ5bWh7mo1p7fGD
 Iq6Nld9Hrt2D7zvrSe+oemMNUsgtEvaNtxLU6YBrfVKMvhBTS/8Osah16zohc2zlAK56eYJup
 2wbTxQAqVd01kFdsNmP0CDl7PAYhZuJOAR1ZuPAdjJ6+OClpIjqbMpCZ1UybycHZWTtjH7i2k
 /BHWeCCB0AUaNW7iY/iync1lFJ9DqqeCKlVJ5z5XgbVlxyaXIoxeldG5wc8ag4C9QoXkSUias
 Vq/KIstuUYMo4ErG9p2yXDjZNB7p2nrWrMNSs84xDreKda9lWP5zxWrv6H7krhekkLPlTPvVs
 mYVNNamGMH8ejqOgKofpeX5G0KZZzwWDgY9IliKDejPRG5yV3Ip/1o+jgXCzCxD7mKGgDd2ma
 ulz1J0voPzROjAkdA4nUXwT6XZbQAiFLOTbLxGX9o0Cr3HESWK2jS6z84uD83fikEGZcLWQHw
 zTgiglU1m9LCpL5FDPu61hG76e4XJR7pSf3wXxoALehDuXObRmsMZXy3konhSKnnold6Px0ww
 3aB7Ct4paNC8ryBdBQp0Vq47V+LNV0mI/dcb7zd2zIg52B/2cQ3duMmb7ziq/LifKmCGnnx79
 XpFwQNFTg79X/3PyEfOu3svNzpmjPsER8FcOqyX//wXAHN8dxC3AcTlj8BSHOp8dMdxOzX+3q
 vLSAzZCmlLFX/lUptFbRMd32JDKeYBKJ2EmGf7oM41b/nxEY2yfHtL3l+BxBmuEhP3xFUtJQL
 0uoSVr54DDUB4YGO2r8VDRX213rLfxiC+sHB5Edv6oGulVP5oanShN7JLH44ZG/ILS9Hx9b4h
 CR6paw8fdTyG9CjSt5NWiHHOZyuVMYfOKx0/s5uM8zhRWVCZHxgqABCFQciLxqR5AXmlsFiG2
 9S0/T40EpqNPL+FIbsFIWAnJSrNT1QBmHkX9MrY03ul1fdPMTyW/BZEZE5H6MGY/rG6yfI9rK
 LeJm4ZRUKTjjt2ti8+UYnvRYiwUv9FeoM8h0MygJk05oHkmtgtiJRWvW75VZuAa5jk6uM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2021 14.11, EpicLemon99 wrote:
> I have problems trying to use Linux distributions on my new machine, a H=
P Pavilion TG01-2856no. The CPU it has was released Q1 2021.
>
> My problem is that whenever I boot a Linux distribution ISO, it appears =
that my CPU stalls on tasks. The most recent kernel version this has happe=
ned on is 5.13.13, with Arch Linux.
>
> I could get journalctl logs from NixOS: https://ibb.co/album/9wMM0p
>
> The fact that I have the same problem on multiple distributions has led =
me to believe that it's something to do with the kernel, but I could be wr=
ong.
>
> I have set Secure Boot off in my BIOS settings and the SATA emulation is=
 set to AHCI. I have tried with RAID.
>
> I have tried the following boot options: nomodeset, noacpi, noapic, acpi=
=3Doff.
>
> The only distributions that I have managed to get working are Devuan and=
 Gentoo.
>

Devuan and Gentoo both do not use systemd,
about any other distro does so by default.

So I would suspect an issue with systemd.

HTH,
Andre
