Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F43A972B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhFPKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:24:41 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:57674 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbhFPKYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:24:36 -0400
Date:   Wed, 16 Jun 2021 10:22:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1623838947;
        bh=Ee1i/3aQHoZK7KoMy8marF5RXKLrE6u8BxhTyC17o20=;
        h=Date:To:From:Reply-To:Subject:From;
        b=HQS/5DKpsR+VtHAU6alYrzE1yOzRsS9IQM8+1nHd9Dbr2yZ+Xhh1bC3Jq0jSvxaT5
         3zeAqwr31XbUOXMECRNltiDz5bixxatPebMozhXFGpgLLWPgLyvDzWRTxjB8+7iUlS
         hlmfpgpXKrUYYYKZ4oQg/n8eP6GdX+S/wRmTLUQg=
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Andrei E." <andreien@protonmail.com>
Reply-To: "Andrei E." <andreien@protonmail.com>
Subject: Why do kernel panics caused by init exiting peg the CPU?
Message-ID: <5r1aLDnOSih_aMBiFkhgpCo8RUYjlyGmTmuJ_1PB4lotjEhCdV7ROPX_HCG4WSGM63DIhm6aDJQiNAT2lD0ol7J70MCGQDfQ2PiAUNQgvDY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning LKML,

I have noticed that using a very simple hello world program as init (very s=
imilar to the one from https://landley.net/writing/rootfs-howto.html, just =
with the sleep function removed) pegs the CPU on both linux (5.12.10.arch1-=
1) and linux-lts (5.10.43-1) kernels on Arch. Is this intended?

Steps to reproduce:
#!/bin/sh
cat << END > hello.c
#include <stdio.h>

int main(int argc, char *argv[])
{
=C2=A0 printf("Hello world\n");
}
END

gcc -static hello.c -o hello

mkdir sub
cp hello sub/init
cd sub
find . | cpio -o -H newc | gzip > ../initramfs_data.cpio.gz
cd ..
rm -rf sub

qemu-system-x86_64 -kernel /boot/vmlinuz-linux-lts -initrd initramfs_data.c=
pio.gz
# Spikes one thread to 100% usage. Causes the same issue with vmlinuz-linux=
.

Thank you for your time,
Andrei E.
