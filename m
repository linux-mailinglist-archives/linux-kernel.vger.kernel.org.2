Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1158A42D85B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbhJNLnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:43:50 -0400
Received: from mout.web.de ([212.227.17.11]:47337 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229984AbhJNLnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1634211701;
        bh=OS4SK8ads47sNJLjpl2nvFFE49OJn/ewgb7S3SvQ1b4=;
        h=X-UI-Sender-Class:Subject:To:Cc:From:Date;
        b=EQkeoicPMSTAcDYotlxomEvfTCPowdICCGnNRCnnkZOzBRX0NHl/yx0Ws8+twAmz1
         slx7b2TX79Kf+Ud6xQPQNsSBAOTgKn8meDx60S33gqjoQUnlPTxIBH53Jke9LVTyJC
         ExVu3rMcLU2eHoPCcL2EyjPSqaLRCPcOJJLpyU98=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([178.9.208.239]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0Lm4Z3-1nAaur45In-00ZeYV; Thu, 14 Oct 2021 13:41:41 +0200
Subject: ???UNSURE??? Re: Unwanted activation of root-processes getting highly activated
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org
Content-Language: en-US
From:   secret <andreas-stoewing@web.de>
Date:   Thu, 14 Oct 2021 13:43:18 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8";
  format=flowed
Content-Transfer-Encoding: quoted-printable
Message-Id: <202110141343.22222.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:giyuR9Ya9V0awImpsXQI3XXfy6f7nmKJf2lUOl0P61c64J7nwVC
 5PGAFPOG4sLiM77gMIJkhc5L87nx6170Tdyl/s9g3Llmmrfrui4mGS5XQkVTYrBB0NdvLqD
 PD3ECnoh1/Crz9kQjn69dU1P+9VxPJyq9YqzzWdx+0sT7BQdsX1fZPcQHluOBcJmzwYBb1U
 BlbIc5mlutjGcFtdjwyGg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PiyI4nacb5Y=:ABTenijx7F+/YdDaHFRerU
 IT4LP0U8phM0Yfv0hdPnWD74G22JEq0OSHKXQyYx+uAk03Qo/WM94xZZEa+xEaSqTmvyINI1p
 HTueXu2tZGURqRaKxnqzxfsvC0QD/y88JrpWuNk8W7HK1nCnJ+J0d763wpAgW5Tqy/i3tmdvd
 x0euo5TuwzdGv4cJJdriVOH6IVCDoClkRp+5FWYhEwpiEiaTLB6Gr0ODF4HXMS8da9jVb3b93
 h650ArJMPP/jpPcf0wPOH4kilLQ0vWDETiTugT7nRk/gd1bf8uKOl0Nmri6kEOl1sU3FgFEk4
 NucHlL8OyTOUBeLM1cyqkRW0Qr/cKUbT24BRiT4fAkpW5TCr0Efd2Pl3m3harX77v0boTx/Ue
 JJhz4zuB+9kZly0P0pwTBEHUiUH9vijYkkp9d4s4KCO8lS4kbf++Jf6Sbfk8eJxqgaVwoPdu2
 QXA4TtzDcU/MFQLDW9DwpG0vz4ECT7gv904bBFq8Hu+e3MfWV9yHiIoUy3kIXWixNB6AhjM6u
 6RV7SWPAdDB5/2FHDLA1StWB0isPzU1MhDl19mqXd4EMs9Sy8m7adnYfZwFvHPeFUqBMI8FSe
 N7Nypj0VcP/Hv0w08/L2wU6tW+lWrlb/26RwxTQ9ZEWYzMo+7CR4jtjs9O5hSsDgGraY1JT8v
 5yuF7XS/fYdlbbq3tA+vAYG95idnWeLsLyvEkKHW6LciiGjWRQ7eeQfWI+up4Eyx9DLSjWyML
 f2WzXDRPTsXj/KPfhpVOfQcHLzsVmelUu0R51qprrTadc2DST6rFapeKdCDIJ9O78S/z2RAXs
 1EW1pkx+Z1VhK66crz9zSOyizhQXTlZDQy2DnpbRnSraL/MlxqAfSDWt26BZvWJgeVVQw0QBu
 C5dXPZAD+yYmRBISSyWnavYXuZZ26Ec4Y2XtKOpvtn7MbAAWVfVUfqdJjbtbeSG9BGXhteHwi
 vxM0Esf7AdKiSMTZxD9GUPkt5LwcebYLkcl8X3Z9LY80W23mtCcBdsxLuV3CYI9iDiHft7U3A
 2TT8eG6uacrI0kR2XU8zkqv8ML/P1ydfyMeWo1fiSpvG7WJ6R3u0C3hqxKi75/PuOQNEhgXex
 6sL6k+/IaJgbnk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
