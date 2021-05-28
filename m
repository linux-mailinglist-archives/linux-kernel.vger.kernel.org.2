Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D737C3943BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhE1OEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:04:35 -0400
Received: from air.basealt.ru ([194.107.17.39]:42166 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhE1OEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:04:32 -0400
Received: by air.basealt.ru (Postfix, from userid 490)
        id 0C35C58951C; Fri, 28 May 2021 14:02:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on
        sa.local.altlinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
Received: from [10.88.144.159] (obninsk.basealt.ru [217.15.195.17])
        by air.basealt.ru (Postfix) with ESMTPSA id D42A8589517;
        Fri, 28 May 2021 14:02:53 +0000 (UTC)
To:     Vojtech Pavlik <vojtech@suse.cz>
From:   Egor Ignatov <egori@altlinux.org>
Subject: Problem with i8042 and PS/2 keyboard on HP laptop
Cc:     linux-kernel@vger.kernel.org
Message-ID: <f586401d-73af-097f-812c-f033a922bfc2@altlinux.org>
Date:   Fri, 28 May 2021 17:02:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I have a problem with the PS/2 keyboard on an HP laptop
(15s-fq2020ur).  The problem is that after booting the
system, the keyboard does not work.  But it starts working
about 10 seconds after pressing any key.

I looked at the i8042 log and it seems to me that the
problem is that the driver does not wait for a response to
the GETID. It receives ACK and immediately sends the
0xed command without waiting for ID.

[    0.460964] i8042: [1] f2 -> i8042 (kbd-data)
[    0.471708] i8042: [12] fa <- i8042 (interrupt, 0, 1)
[    0.977581] i8042: [518] ed -> i8042 (kbd-data)
[    1.185586] i8042: [726] 60 -> i8042 (command)
[    1.185686] i8042: [726] 64 -> i8042 (parameter)
[    1.185842] i8042: [726] 60 -> i8042 (command)
[    1.185935] i8042: [726] 65 -> i8042 (parameter)
[    1.185975] i8042: [726] ab <- i8042 (interrupt, 0, 0)
[    1.189909] i8042: [730] 83 <- i8042 (interrupt, 0, 1)
[    1.189952] i8042: [730] f2 -> i8042 (kbd-data)
[    1.200096] i8042: [740] fa <- i8042 (interrupt, 0, 1)
[    1.204012] i8042: [744] fa <- i8042 (interrupt, 0, 1)
[    1.204031] i8042: [744] 60 -> i8042 (command)
[    1.204124] i8042: [744] 64 -> i8042 (parameter)
[    1.204272] i8042: [744] 60 -> i8042 (command)
[    1.204364] i8042: [744] 65 -> i8042 (parameter)

At this point it doesn't do anything until you press a key.
Then the driver starts sending GETID repeatedly until at
some point it gets the correct answer, after which the
keyboard starts working. As I sad it takes about 10 secs.

Here is a part of the log after pressing a key:

[   11.103249] i8042: [10643] 1d <- i8042 (interrupt, 0, 1)
[   11.103287] i8042: [10643] f2 -> i8042 (kbd-data)
[   11.113673] i8042: [10654] fa <- i8042 (interrupt, 0, 1)
[   11.113719] i8042: [10654] ab <- i8042 (interrupt, 0, 1)
[   11.617485] i8042: [11158] ed -> i8042 (kbd-data)
[   11.825485] i8042: [11366] 60 -> i8042 (command)
[   11.825778] i8042: [11366] 64 -> i8042 (parameter)
[   11.825924] i8042: [11366] 60 -> i8042 (command)
[   11.826016] i8042: [11366] 65 -> i8042 (parameter)
[   11.826049] i8042: [11366] 83 <- i8042 (interrupt, 0, 0)
[   11.830084] i8042: [11370] fa <- i8042 (interrupt, 0, 1)
[   11.830107] i8042: [11370] f2 -> i8042 (kbd-data)
[   11.840241] i8042: [11380] fa <- i8042 (interrupt, 0, 1)
[   11.844063] i8042: [11384] 38 <- i8042 (interrupt, 0, 1)
[   11.844083] i8042: [11384] 60 -> i8042 (command)
[   11.844174] i8042: [11384] 64 -> i8042 (parameter)
[   11.844320] i8042: [11384] 60 -> i8042 (command)
[   11.844413] i8042: [11384] 65 -> i8042 (parameter)
[   11.849039] i8042: [11389] 3c <- i8042 (interrupt, 0, 1)
[   11.849059] i8042: [11389] f2 -> i8042 (kbd-data)
[   11.859198] i8042: [11399] fa <- i8042 (interrupt, 0, 1)
[   12.361490] i8042: [11902] ed -> i8042 (kbd-data)
...
[   27.516138] i8042: [27455] f2 -> i8042 (kbd-data)
[   27.526395] i8042: [27466] fa <- i8042 (interrupt, 0, 1)
[   27.531044] i8042: [27471] fa <- i8042 (interrupt, 0, 1)
[   27.531080] i8042: [27471] 60 -> i8042 (command)
[   27.531183] i8042: [27471] 64 -> i8042 (parameter)
[   27.531336] i8042: [27471] 60 -> i8042 (command)
[   27.531713] i8042: [27471] 65 -> i8042 (parameter)
[   27.536215] i8042: [27476] 1d <- i8042 (interrupt, 0, 1)
**HERE IT FINALLY RECEIVES THE CORRECT RESPONSE**
[   27.536290] i8042: [27476] f2 -> i8042 (kbd-data)
[   27.546882] i8042: [27487] fa <- i8042 (interrupt, 0, 1)
[   27.546940] i8042: [27487] ab <- i8042 (interrupt, 0, 1)
[   27.546997] i8042: [27487] 83 <- i8042 (interrupt, 0, 1)
[   27.547018] i8042: [27487] f5 -> i8042 (kbd-data)
[   27.557566] i8042: [27497] fa <- i8042 (interrupt, 0, 1)
[   27.557615] i8042: [27497] ed -> i8042 (kbd-data)
[   27.568242] i8042: [27508] fa <- i8042 (interrupt, 0, 1)
[   27.568294] i8042: [27508] 00 -> i8042 (kbd-data)
[   27.578730] i8042: [27518] fa <- i8042 (interrupt, 0, 1)
[   27.578785] i8042: [27518] f3 -> i8042 (kbd-data)
[   27.589151] i8042: [27529] fa <- i8042 (interrupt, 0, 1)
[   27.589206] i8042: [27529] 00 -> i8042 (kbd-data)
[   27.599602] i8042: [27539] fa <- i8042 (interrupt, 0, 1)
[   27.599676] i8042: [27539] f4 -> i8042 (kbd-data)
[   27.609986] i8042: [27550] fa <- i8042 (interrupt, 0, 1)

Any idea what to do about this?

Best regards,
Egor
