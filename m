Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C951F400F8B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 14:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237950AbhIEMNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 08:13:02 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:40982 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhIEMNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 08:13:01 -0400
Date:   Sun, 05 Sep 2021 12:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630843915;
        bh=Uxd1HHy1U64AcjCAf6RKRV7zCXuNsgwbFJWE+5uUs4k=;
        h=Date:To:From:Reply-To:Subject:From;
        b=wHFdiSladOcnC3+DVJbwjQmSu/XuCjL4qVm5ITTTHHf1yvIGkrJveGwB4zY1MIGSJ
         w9WtJxYUfLZq56RzfnorciZJL6JHYqxJXgelAVLwyy18BokfotgOOFI2RWDqAirYl4
         cy2arfxHfDVZgH6eTqyrIWOA7GWJs+2ii4IvVdik=
To:     linux-kernel <linux-kernel@vger.kernel.org>
From:   EpicLemon99 <EpicLemon99@protonmail.com>
Reply-To: EpicLemon99 <EpicLemon99@protonmail.com>
Subject: Can't boot up Linux ISO on HP computer
Message-ID: <t2AGLXpsN--6I99ztVoBlXWzyEUo9HarRnRtFyM_sXXkaWbN9m8nmrCLyB1aKetozYTKQ1PV9JEC3Kr3yKpIiYczmcidKgt5uv1COs49c9I=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have problems trying to use Linux distributions on my new machine, a HP P=
avilion TG01-2856no. The CPU it has was released Q1 2021.

My problem is that whenever I boot a Linux distribution ISO, it appears tha=
t my CPU stalls on tasks. The most recent kernel version this has happened =
on is 5.13.13, with Arch Linux.

I could get journalctl logs from NixOS: https://ibb.co/album/9wMM0p

The fact that I have the same problem on multiple distributions has led me =
to believe that it's something to do with the kernel, but I could be wrong.

I have set Secure Boot off in my BIOS settings and the SATA emulation is se=
t to AHCI. I have tried with RAID.

I have tried the following boot options: nomodeset, noacpi, noapic, acpi=3D=
off.

The only distributions that I have managed to get working are Devuan and Ge=
ntoo.
