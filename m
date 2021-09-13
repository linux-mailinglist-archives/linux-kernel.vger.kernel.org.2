Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D140944E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347026AbhIMOaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 10:30:08 -0400
Received: from ipmail04.adl3.internode.on.net ([150.101.137.10]:61919 "EHLO
        ipmail04.adl3.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245713AbhIMOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 10:25:49 -0400
X-SMTP-MATCH: 1
IronPort-Data: =?us-ascii?q?A9a23=3AYgtL4KDyMLv7RxVW/xfhw5YqxClBgxIJ4kV8j?=
 =?us-ascii?q?S/XYbTApGwq0jYFy2oYWm2GO6qPYTajeNB1b9vi80JV6sXTnNc1HFFurC02R?=
 =?us-ascii?q?CwT8sTOD4zEfkr8bnyYIMDORRo+4s9GN9TpIZFvRBcwhD/0YuC79yUUOYJk5?=
 =?us-ascii?q?1bE5V2t1hlZHWeIdQ944f5ds75h6mJXqYDR7zOl4bsekuWHULOX82cc3lE8s?=
 =?us-ascii?q?8pvnChSUMHa41v0iLCficdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw?=
 =?us-ascii?q?4/Xw/stIovNfrcXnKEIaueLbU7U0yMQCvXk2EMYzsAx+v9T2P40YF1LiyiT2?=
 =?us-ascii?q?dV40s5NnZ22VQozOKrAlaIaVV9eHj0W0ahuoeCWfibh4ZTCp6HBWyC0mKU0V?=
 =?us-ascii?q?hBe0Zcj0uJ2B3xesP8VMjYAajidiO+shrG2UO9hgoIkNsaDFJNP5FljwCvfA?=
 =?us-ascii?q?PJgRorMK5gmT/cwMCwY35keW6yHPoxINHw1N06oXvGGAX9PYLpWoQtiriOvG?=
 =?us-ascii?q?9GAlG+omA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AqIhr/qnmbSRFQb4VRrmRXqFNuUPpDfI53D?=
 =?us-ascii?q?Abv31ZSRFFG/FwWfrOoB1p73DJYVEqKRQdcLG7Scu9qBznn6KdjbNwAV7AZm?=
 =?us-ascii?q?TbUQmTR72KhLGKqwEIcBeOldK1u50PT0EzMrHNMWQ=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CsBACqXj9h/+hf03ZagQkJgVCBHlg?=
 =?us-ascii?q?GgXyFM5ELnCOBaAsBTwECBAEBhANwgkUBJTcGDgECBBUBAQYBAQEBAQYEgSS?=
 =?us-ascii?q?FdYZsFUEYEA0CJgJsCAEBgm2DB60BgTEaAmWEaoMqgWOBECqONYFVRIEVJww?=
 =?us-ascii?q?Dh1xngkqCZASILjETTIElCHCgDF2LApFyLQeDLoExBgudCAYULINmkhIDAZE?=
 =?us-ascii?q?JhnmRQaUxgX4zGi6DL1COf28BCY0wNGgCBgsBAQMJhUEBHggTiXgBAQ?=
Received: from unknown (HELO localhost) ([118.211.95.232])
  by ipmail04.adl3.internode.on.net with ESMTP; 13 Sep 2021 23:54:18 +0930
Message-ID: <000ef85f-9326-706e-007b-4549901797d7@internode.on.net>
Date:   Mon, 13 Sep 2021 23:54:15 +0930
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:88.0) Gecko/20100101
 Thunderbird/88.0
Content-Language: en-US
To:     x86@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
From:   Arthur Marsh <arthur.marsh@internode.on.net>
Subject: Cross-comilation from amd64 to i686 - issue with
 /usr/src/linux/arch/x86/boot/tools/build
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, I had a problem when doing a Linux kernel cross compile from amd64 
to i386/i686 a few days ago which I solved quickly, but wonder if the 
issue points to a problem:

/usr/src/linux/arch/x86/boot/tools/build had (apparently) been compiled 
over a year earlier when I was running under amd64 without multilib 
support, when I installed the i386/i686 gcc-11 under amd64, and 
attempted to cross-compile the kernel for i386, I received an error 
about bzImage:

BUILD   arch/x86/boot/bzImage
make[5]: *** [arch/x86/boot/Makefile:84: arch/x86/boot/bzImage] Error 139
make[5]: *** Deleting file 'arch/x86/boot/bzImage'
make[4]: *** [arch/x86/Makefile:273: bzImage] Error 2


Once I removed the old /usr/src/linux/arch/x86/boot/tools/build binary 
and re-ran the kernel build, a new "build" binary was built and the 
kernel build process succeeded and the built kernels ran fine on my 
i386/i686 system.

I'm not sure if running a cross-compile from amd64 to i386 for the first
time or in fact any update of the host CC or cross-compiler CC should 
have triggered a recompilation of /usr/src/linux/arch/x86/boot/tools/build.c

Kernel build command for the cross-compilation was:

make ARCH=i386 CROSS_COMPILE=i686-linux-gnu- CC=i686-linux-gnu-gcc-11 
-j6 menuconfig bindeb-pkg

Arthur.


