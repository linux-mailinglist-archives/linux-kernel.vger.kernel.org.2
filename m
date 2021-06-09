Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5233A1CB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 20:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhFIS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 14:29:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:35435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229472AbhFIS3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 14:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623263246;
        bh=g4a/xRh3zCsI4HuE9nSjJePjbo/ZbaMGlUpxWmzZDfs=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=OHrKY7QjgPoVoghavMtUXP6nEt5WrD6HWDsIF3GzndWlXXp2wW0k39r0fpSh3v8lr
         6iMwC0t49skivan7btfsgqasE9ukJ9OIiuc3db4Qbs6dnIX1G0BDaP0JK2hps64boz
         j68ul4j7Ts+cy/tzxmA4xy33O7rP1gfqnA3DMoG8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.0.61.205]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQe5k-1lfacC2eqk-00NeZi for
 <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 20:27:26 +0200
To:     Linux Kernel <linux-kernel@vger.kernel.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Subject: repeating [Hardware Error]: Corrected error, no action required.
Message-ID: <cba1f224-7a21-7a1f-3f82-6f7e98a274d0@gmx.de>
Date:   Wed, 9 Jun 2021 20:27:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q0eDfhXn+2F2Nc/5QllgKcFZoztigE5lKk3tu37enioeSzz+EI3
 aHToUvvU2KZBPqAhhWz8aXNlGAIrOIUlArW6mB3T23O6No8Dq7R285lXar93tpBTrZl/Xs/
 PbStdqbjipFjp4Lb4ngxyoEePnx0xZcbyEJkY0BmjyMsJ/sKlv4fb+CGGAZ9LS8FasDH02d
 I9mJzO02mxL8AG9l8NBjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VL9LW9SfyoM=:MO4l4oRdAmQy+r5kjrshst
 QvqaohUoZ1LF3to3SSgbCysra/tA/yjSH2eoaimW0q4GGFSX0eRoGOGOsNa+wMnauGfj/v4A1
 wjMEWuBhD8uoR84igZWhFqAl1ZPt8l86f7jBWLcPdvgsSfV/TemfYl3vKTyAO7aJzjtdEe/+O
 QNif/OBRn0JzxIubx9W1/07HJutaGL6n9NyPSDj4T98kCgpQ1Bdhf3O5s0O1FK+ct7t2IG3sF
 OUyw9s2OYtNztvPti2tkBxDfG3F7EeLaUtlHLmUWEuioLGxVkf4BXugy9fFgpDHafzTrcZBPp
 MELOZTKNrdQscJJwNDF0S6Og4s1v2nP73OoGF/ESKgNDAoyI3MH0YbN+HFmXNk8H5geDJyhVN
 +lOh5ZqSh3wEQblms/cefniL0xGniQNiCZou05u141X5I75RDAf28Z3knPu9xNGSUU0dEkt+o
 DCAqLygyjfzun92urAUps2+WqHqjfzUi6ivaA1kxgTDUeb+7vfcGVQSKlDVqRr29/AFi5ViZb
 brPtI8+pJG6oJHbmwRitkDDdifR/C5Oyn9waeqPrddNbCuxP5vu2nzjUpuXnYtI0EkGJ3Ra7O
 IN8jN/LYPh/XiXt81LyjxRUHKRHi52EA0c2/8HqbG+LqqUxUmdLRavKHu++uYJ4dzrzwGq5XJ
 0JHgywwhZXSWVOAUxksrpocYfc6OrvAlvNRTtivZEfzv+MSz8AGBj/oolBNjOX7f+blFKpeUR
 F1up07gsWhxRZLc8YXcmguBHEI+p3bl3hs0ym63JT7Hqg+Jkn89dxZeE8rwC9LmwElvibAsM+
 n/ps8bneWZBcueneQXgnNEODY6E3YXVEMWc+oQymsNv51bLxKN+Xqc56HX7chilHZMyrwczFC
 gcTqGsArgIGqHFrE0sq4MFsuOVLRICqIYtdPKVf2XfoBhoH63ciw516ysjeaReVPbEst2h7O3
 ob65Lioyk0QOiu7CIY//1QU2eqOOFUfxHEOh8vryuHYcHmh7zoWA2tiF1w8ZJRGdFYIyle/tF
 L5xdfbNI5So+PHQ98wAmaJF/iUMA8FBl/JP6jC8tg1HKF9yWa018JMEdH5YUiFuAQK5B4hL5j
 SM/lSm66bzv/8lHapoDy4aaLrOVbQcgQGvXTWh4A9WP6Q7WaooYQp7AdA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My syslog messages show at a hardened Gentoo

# uname -a
Linux mr-fox 5.12.9 #8 SMP Thu Jun 3 17:59:32 CEST 2021 x86_64 AMD Ryzen
9 5950X 16-Core Processor AuthenticAMD GNU/Linux
mr-fox ~ #

repeating entries every 5 mins like (always same address
0x000000031fb566e0):

Jun  9 16:21:24 mr-fox kernel: mce: [Hardware Error]: Machine check
events logged
Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: Corrected error, no
action required.
Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: CPU:0 (19:21:0)
MC17_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]: 0xdc2040000000011b
Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: Error Addr:
0x000000031fb566e0
Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: IPID:
0x0000009600050f00, Syndrome: 0x33fa01000a800101
Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: Unified Memory
Controller Ext. Error Code: 0, DRAM ECC error.
Jun  9 16:21:24 mr-fox kernel: EDAC MC0: 1 CE on mc#0csrow#1channel#0
(csrow:1 channel:0 page:0xcaed59 offset:0x8e0 grain:64 syndrome:0x100)
Jun  9 16:21:24 mr-fox kernel: [Hardware Error]: cache level: L3/GEN,
tx: GEN, mem-tx: RD


A hw mem check by Hetzner didn't found anything.
May I asked whether I sahll worry about or not ?


=2D-
Toralf
