Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7C42D738
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJNKkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:40:36 -0400
Received: from mout.web.de ([212.227.17.11]:49723 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhJNKkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1634207907;
        bh=YvzQCZbqelmdS06pKeQ1zkxj8XaCpfYUtQtnFKf3BFw=;
        h=X-UI-Sender-Class:Subject:To:Cc:From:Date;
        b=HpFIJBgY8gJRHyZfUUBq2eVjbIH8tFD9UmaRIJbsMymWRn9ztR3Ncq4tn5DAbD+rp
         OE1P3TaQnxfKp8zKQrZuNovSSc4qEbc6fKcDk40xZSs2kx9ovY7DifgymvnRxHJSI2
         qwBCMI/UWePRQFs6Ad3MA4LIfwOQ65jKvmiAAJJA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([178.9.208.239]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MBTEQ-1mTrNd2KSU-00AWHf; Thu, 14 Oct 2021 12:38:27 +0200
Subject: ???UNSURE??? Re: Unwanted activation of root-processes getting highly activated
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org
Content-Language: en-US
From:   secret <andreas-stoewing@web.de>
Date:   Thu, 14 Oct 2021 12:40:08 +0000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8";
  format=flowed
Content-Transfer-Encoding: quoted-printable
Message-Id: <202110141240.12172.andreas-stoewing@web.de>
X-Provags-ID: V03:K1:KBFzJ9kUkkQ+CtwA7eQiZ77DfrgWhJ5YgdxFvf7EkovB+7S+KdP
 CDp/rEtQ4e0PyuEpmjLYNQyogAJ9cQ4KzSAoMYQNz1PZoDLbZp4TYPUneacZZ3NnxtZSobI
 dIAkUhHyLq4B9YWV7NCf+Iz/9TyKccIyO04j//c0R3NMEfgqwKDdgANX4GzXhsQm4eLMJ2B
 72SiM/XzG9zYj2rzV9Yrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nRKFDrmlgRM=:bGqyK9PQAsGxk20J/0u4+B
 YRcr72v9ikHSnNe9EVn3MCIWj1VnUUxwQcizGiH1SplJdl4LBSXJNa5nNfeRCTED+q0qrm2hD
 G0Uhs2lnx+WB6Qo1hfNtO551wcnlRcHCRZUzZs7d+9fPNeRxuVbIozPp0A4H3o9622YI2ps6h
 IeJ54mKHR5VIZBF/cwnyVsFQIz7jX1zD+uHLPOu5NVCUYKu7zJirgBLywd5SIBt588xsnI7FN
 0TD7S07WxDXIwgWo5d9+uEBFVcyrSCJmCOAcfQ9G5Vdj/5Ybp2xZmesSUq749JovuwDJIZGYQ
 ItcCVneoK4QsuErOO3hqOLJHCWqCiNUxWl+JWNWoZbIyj8ufwtRYuOQOdpihXc57GZMIclwcZ
 uHmQNRDsXADDGvcYrmkkB+TlIK04DkEMmxxLKjz4ZRw76ApNFYph53YQOQCT6Nqz+/AloGcHh
 HiEkihtwbq62JHSWnVOxYir7mqjffaikxmwdSvOKauscKC6yR6X1KGrfa3pfKykQd4EX6+/KL
 OMdbxGkmVdO21FLXScT2Ngy13bpgUR3E9aP+8xGGuJMOenKdC2Cg7qy12WW6T9gcE/ARUZvft
 C/+OCyUJsI4wOhmKTLWiWvg7m3HhQS5qKB8xG6ORXlYpyzC5h6Qam7zK4R6OIL6CQKOws1Hc0
 JFWM+8UnDRyzgbeMPHFWNzeQOp4L0rcPYc69Mz4aEZh33GwcfVfnf9N3F9EBNjbUxhM+YNOCy
 CROvE7ABTZRHxitYbOeU+XW/XC+5wS0b7+NhB4Zk2W7KGLQGVH06nlmHQlyoI//94jQyOToVh
 Kv4kc0Wz1lKvMjwvlKyri/WP9Z/3dM+Wd5ml7BUkw07AwI3Y/agEVPPVD0MWtOYKfIIWV1mfl
 SVe2hd++wX+5+MvIAlRD4jWeEJWctzMqb/c8Uz1QZZlOctEQs/98Dc+fx3KDIFx9kv8qnejfx
 Tard99f96yMZ9Q5z1tAwunBlck0eQH6dLU14aG/7OtDt/MvNF8j0AIWMkEsopMgbCrHl/HVnZ
 oXDoaOkkIvWDHO5yHfC3Otffs6lZLpDMu0Jf200BrJZ5ltRDU6fGYRcOS99j1UvAX9SBOul0J
 6VM/+4XL5Guz9o=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
