Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDEF456044
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhKRQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:19:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:36719 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232984AbhKRQTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637252168;
        bh=R1Da6f0eM2GEzCzgkzCUXcWS+oLCUqHQulyAz/iRcF4=;
        h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
        b=S35npDQBX8f/j0E3/60Uy61KDUfQRTxtpz1NEBcSsuKNKx46Q5nWHoYWsRpMQ7iCk
         X8+pO25pfFTsVC7XBYVRAZ+jyDI00JfCHX+Q82FyNCp+0wJn5v/JMa+VMiz/9vXPdu
         2awO0nlUMhF3jvzqLLNDEO5n5CPY9zwgrS01cKss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.8.228.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZkpR-1n8FDj2Bgl-00Wlhe for
 <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:16:08 +0100
Message-ID: <180bc128-6017-1a87-f738-a407b1af9a3a@gmx.de>
Date:   Thu, 18 Nov 2021 17:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: BUG with 5.14.19
Content-Language: en-US
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
References: <43a8abc2-6168-5f5f-5436-58f69fa7e679@gmx.de>
In-Reply-To: <43a8abc2-6168-5f5f-5436-58f69fa7e679@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GndE9ENJGVlE8VINAAFOib1IgWau5/evAbuwx+yk7D4/IPf4jD7
 EZKYBZ6owR9xaZPK2Y8vfraTSxurq1bOh4wu2d0Ny93HJC5l5g7sM/IKhHEwX9RiU4WAhLI
 kHoWXex49uYhYR7lvtjCoAzLxBTB+KSNDAleyqNkaXFtGQfCK0z4+H/GrDUAecsuZQfikZj
 MN8yWMbalIKVve2K9tjnw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uiazx/O0/BU=:m+cyakrbztSrvuPTpoCf/q
 /NjrWOLI8smklB+/DidNAyb/d9DVRckqmCxOCeV1IYTDEJmPDG531ZMDGMNibuNe0NyUpzKh+
 8F1aAg6ZS/Ub3XWPEXZzYPxqKaHmj/n7iOmKom4jGHSVWxQqK63YD0Tb+MXjN0ZPfh1ZvAfmA
 EdJGfWtFVRFGCjM0rOa+pJPMbrWr/RRIRHPqDQu30Aabw3yOtczwgY/GqEhnOTCe66pOdpiWF
 84zqE5TNAF/i1eIU/4O9JKKz2szlilp364/fcEytMz8KxrjW09YFvCwomy+UV5Exa6uwfIon9
 t73zPR+4SzfsECBEeowk5S6GyEsGbMXzezmOn/cQfKR2MUlEAru8KSk/g+fZFOprme8dl3B8W
 YsZCZLharf0sWs865rv0HutdSxM2L4R4wsNxc3YjNGFRer6iYkQ+gJpSAg9d6p8gHFxFNBFm1
 PNMQugUkOO7u0YbHAPohAU3IywUVCF1B1S/F3//XlruYFy13RZ4EIUT0Z/7E2teLySet7Y9pz
 P79nvPt2FxQzGC7NWubFeVLgsUKGGLdXTobrCk2SX1BJl941a9wLWN9y4J7Ul6gMULwCU9lyR
 hDvBe6OgcIBhSKHLATvZA2GHiyKlbdibBWJYO0ADx8SNykcWJkDf9Zg65tVm0WziaUrm3cDra
 BKX/hTplEVXBGjSjY0wWD6eQxu1EXu7gP7U731ZHi0CLq28Yfnl/oKFzZwssq/M/gHmOWk8hE
 OqnEQfJoIvrtRLhg2gKySbkh+EWkCDGqyfW4kkoOPvAXs10brQ/vwrx9YaD0USDho6dXxGBA3
 bZRhTMTILThdSxd0c9dCn7XroXvOtJ1qoMeUWe9olbY7sGE3S6UnUsGV6VTguO8IxuXdQQAzh
 0LdwUvK0NRGd93LKpbMG2H6y6gc89KMASAIqRnfRtDp27cNHBcsNaaJMNnjiU4MUV2iT1t5DQ
 h3dAtMy6NF+wP3Aq5u9oLli+YB8RBVIlT9IvsXKkBYwT4b/mZAoGd1cBXuLxmsV0JLZnxGSZ+
 hGISFIb8YPeE9VuGFae6FaqpbS5MgvIMYb2qbXNgOMcirkxfVqy5jstfMVQNlgTFX/6A0ROwX
 a7r1YxXLhLIgrQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/21 09:09, Toralf F=C3=B6rster wrote:
> Hi,
>
> got the crash (attached) today at a ThinkPad T440s
> IIRC this is happened the first time.
> I updated from 5.14.17 yesterday.
> At that time the KDE sessions freezed and I had to power off/on.
>
>
> $ uname -a
> Linux t44 5.14.19 #16 SMP Wed Nov 17 11:46:45 CET 2021 x86_64 Intel(R)
> Core(TM) i5-4300U CPU @ 1.90GHz GenuineIntel GNU/Linux
>

FWIW it produced data corruption here at a BTRFS volume.

KDE config files, password vaults, but even larger Git repositories like
the kernel or Gentoo portage git tree were corrupted.

Didn't really expected this for a .19 stable release.

=2D-
Toralf
