Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7E43DC46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhJ1HpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 03:45:19 -0400
Received: from mout.web.de ([212.227.17.12]:49409 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229809AbhJ1HpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 03:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635406969;
        bh=jH2FAqlcvg95i/VkOXowGoxabOMR4UceI1MhyKJDr0A=;
        h=X-UI-Sender-Class:Subject:To:Cc:From:Date;
        b=ckM1lUakentxSg5+ut5bF66KMQDCEQ3DGB5Z2CyzRzdcbBMYaZtnL3+7Geqga1T5I
         Ugyx0Ie8CYskZWLZqOudTrgz4H4GMS059FPX/CJ7RYi7hiQMuzQbx2gCeYxo06DlpT
         SeXVSDFKH2jZQHNbZTmetKd5iaeFUi4nMi8OmfB0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([178.9.210.138]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MtPvg-1mw1Ze3NdO-00uziG; Thu, 28 Oct 2021 09:42:48 +0200
Subject: ???UNSURE??? Re: Unwanted activation of root-processes getting highly activated
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org
Content-Language: en-US
From:   secret <andreas-stoewing@web.de>
Date:   Thu, 28 Oct 2021 09:44:51 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8";
  format=flowed
Content-Transfer-Encoding: quoted-printable
Message-Id: <202110280944.54262.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:nXrwXA3e+YmV7TWTHZI28dzXHg8CfDAlVfafPV9vaM/6K5JOJvR
 bRT51Lb/THOu+aWhhHZyAMgHk5fBBePH0iNfOTw5/qCvQyLbwvJlE4dUzDU4RjgPtepodj6
 L5q6rxLVMzii1at1ieSI6pqmxP4KVUWssWT7x0FnrAl0VVlt4zGqPgnTb9jaje1w6m4xWyy
 MKcZgtZvj7+a0hGg//isQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SNC3QTBkvs8=:7KCIMT/vRyZKLn2bgByZY9
 WQ3K8NI3uuxt5A5FsZ2Q9UBPQAFVePMCIqOyn6EFvZ1JUEpr1ezmSbn8iftC7Sku6wCKyVVAI
 h8zTWnLjwlVeFg67YhR4Ss+WHfqaqo/aB1PV0Ql/Y+f2T/3ZRonYOqcRX/5xGAHKAav5N3zGF
 jumue0i80VudzFn627dsALAn1FaBnLwIiSa8fsT0hJYlBPU5WBNObjteXmK6LeEnEu5X+pnpp
 vlV2HAIPObfpe+7p/DKzyKFVkjE7oEGpYiGZbMfBcZLoBlWVpAcVG5NAWwi8c88jyfWrAf1X0
 W2U5fszw0Ip75Wx7KInssKU8GfqC3tft20q0GnxuXodcvUnt2IhcM1AnnfjM7yzofeJm+0XmK
 6Ld0LCnKWSlzMPSw1qooM02qrhrdTtQbCHBAC6EMwq9NpgYlBHkmA+gXqqnkoQ20alF8+SfAp
 ZTu9rnAYfPEIq3gx5HiUfuHsY7+dZ1Vekfbsb+DlySCfiMrqATZQsmfgmMJ0Jl8gu6BC3/qe2
 b2Bwf6s3UDkzkdbRjyMGfwpjCzTkav0k/Xw8IiLI4rfVKyUaE9w+9m8VudjnJiTGceyNcJeWt
 o+/f2NrE3gBfTGNzpk2NroWddNGEShpoI6u9GFy+lwQnIHmy+ud6DeSUwFP8wOXt8o4Wiww2f
 sHkhWafMkgnaKQhHwXhrZcrafAYFJScMQPuvU7akmGjZAwV1YTURHHyxcKZBHqHwyIoDZ4DUh
 5muuBCfT6rH3VKstWpq/6411mm5Hnx6qZGGqDPD8qlYXrhXjf8rF3WubJ5kn4V1FpRNgOnWw5
 XKAuosUE8/1azTnV3gg2p7KQ++AEny+bRwzIBTyTXw2Hf8ijttR8vmoBMilSn/GjwXGrp7T44
 FJwVW+5YgaiWqk++6RITTVc18Dh3i+RZByrn/d0l8SuecNRlElM49ALmrrTF29CoeYaw9RQ6M
 v//B+ScsmGqiswv17s5K2jeDx4nrDKnTLrt2KWX1Xjn4evNzBRtMULtmHmhjNBtubyhKOluSn
 7oLt5GUaY6Ap8DyCuMTGnC2hAYGyFYIeoQzwR3IfS86StmXydGk3/hRh8tKKHQoB9cG8cFFdI
 Kem8NnqzCGadb4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.27.2021
Hello, today it manages us (Gooken) to prevent the highly active kernel-
processes from above after a look into the home-directory of tor
(/home/surfuser).
There the size of a file increases all the times during the activation of =
tor
surrounded by firejail (that causes the high activity of the kernel-
processes), it is named:

cached-microdesc-consensus

and its size was incredible high (much over 100 MB)!

It prevents Tor from building up any connection, so I had to wait up to 20
minutes.

Deleting it did not help: This file occured and larges its size again.

So we set integrity on it (this file) by "chattr +i";. Now the problem
described next indeed got solved, Tor immediately builds up connections,
kernel-processes activity lowered to the current percentage far below 10
percent and the tower-LED for readwrites stopped blinking,
but nevertheless this is not really a good solution,
tor or firejail and kernel (here 5.4) of course still have to get patched =
! (
!!! )
The listed processes becoming highly active themselves got started by khre=
add.

Hi,
Firejail must have caused the high activity.
Whenever I stop it (process firejail), they lower to origin.
Regards

On 10/9/21 7:15 AM, Theodore Ts'o wrote:
> On Fri, Oct 08, 2021 at 05:04:55PM +0000, secret wrote:
>> Date: 08.10.2021
>>
>> Subject/Betreff: Unwanted activation of root-processes reading and writ=
ing
out
>> the whole SSD/harddrive ! / Kernel-5.4.134 (pclos, AppArmor / Tor
(OpenSuSE)
>> usw. etc.: Freigabe von Informationen, Ausf=C3=BChren von Code mit h=C3=
=B6heren
>> Privilegien und beliebiger Kommandos in Linux, Erzeugung, Lesen und
>> =C3=9Cberschreiben beliebiger Dateien
>>
>> Hi, Greg, dear Linux experts and friends,
>>
>> this is one of the most dangerous and worst things, Linux can happen!
>> Refering to the actual kernel 5.4.134 ( now up to the actual version
5.4.151
>> and higher, additional remark from 10.08.2021), there still is a proble=
m
with
>> unexpectedly activated, highly active root-processes (making the tower-=
LED
>> causing readwrites onto harddiscs and making the SSD/harddrive blink
serious-
>> madly hard for about up to 20 minutes). The whole SSD/harddrive seems t=
o
get
>> read out and overwritten!
>>
>> The unwanted, highly by tor (pclos, mga7) resp. firejail activated kern=
el-
>> root-processes are named
>>
>> kworker/u2:1-kcryptd/253:2 (escpecially this one, CPU: gt; 10%)
>> kworker/0:1H-kblockd
>> dmcrypt_write/2 and
>> jbd2/dm2--8
>
> Activity by these kernel threads indicate that some userspace program
> running on your system is reading (and in the case of the
> dmcrypt_write and jbd2 kernel threads, writing) data to your hard
> drive.  They are a symptom, not the cause of whatever is causing the
> large amount of activity on your SSD/hard drive.
>
> It is not something that can be "patched" in the kernel.  It is an
> indication of some program (or possibly malware) running on your
> system is doing a lot of file I/O.
>
> It is possible that as a result of some web site that you visited, it
> is causing the web browser ("firejail", which sounds like the firefox
> browser running some kind of security sandbox) to do a lot of I/O.  So
> the first thing you might try is to exit the web browser and see that
> causes the I/O to abate.  If it does, and if it starts up again when
> you start the web browser and the web browser is not open on any web
> pages, then you might have some misbehaving browser extension that
> somehow got installed, and you might want to try clearing your browser
> profile and uninstalling all of your browser extensions.
>
> If exiting the browser does not cause the SSD/HDD activity to stop
> within half a minute or so, then some other userspace program must be
> causing it.  It is possible that this might be some background system
> indexing (for example, rebuilding the locatedb), although normally if
> you've left the system up at night, this sort of activity is done when
> the system is idle typically in the wee hours of the morning.
>
> But it is also possible that you have some kind of malware installed
> on your system, in which case the only good solution is to reinstall
> it.  In any case, this is not something that kernel developers can
> help you with.  Perhaps if there is a local Linux User's Group that
> you can contact for more assistance, they can help you.  If not,
> you'll need to find someone who can help you with Linux system
> administration.
>
> Cheers,
> 						- Ted

Hi,
Did you try any of what Ted suggested?
and what happened when you did that?

=2D-
~Randy
