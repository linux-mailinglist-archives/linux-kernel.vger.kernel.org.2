Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AA7407A80
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 23:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbhIKVXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 17:23:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:45283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhIKVXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 17:23:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631395349;
        bh=/X5pSMBX8NUtstDu7Hfg+6MKEl4gDMTVjTjXfKitkT0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ugc+ie613MTdAg7cRCCNuRmZg+LmP3XvQDgT6p2uDS/q14RzRhCpB8sbY5ogCGPw5
         KkYRbh+W685FGQD8ea9HFpWWVuhEj+D1D9yI5/F+0LzAAkzc2t4uU11F3I7suEBqkp
         3cij6Cy+3Putcm4ZxaD3ZCiB7QFwen+jSo0m0fiw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.48] ([91.43.37.105]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1nAvLe0V1T-00xHQ4; Sat, 11
 Sep 2021 23:22:29 +0200
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.15-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
References: <YTsioP7hPOP47cfn@ls3530>
 <CAHk-=wjtcSUFiXn4E22SrQBVE0giWZ=m4owA6MmS74C9jW1=dQ@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Message-ID: <09369fe4-7946-2048-7799-6ddb34ce2a91@gmx.de>
Date:   Sat, 11 Sep 2021 23:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjtcSUFiXn4E22SrQBVE0giWZ=m4owA6MmS74C9jW1=dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/PkfXx1zp6f+0nKNlF3NQEON5ouWprW0Tkjw/VpknMUybcLtW8J
 rJD1YwibB5p9iRC7E9YrsRrRoS41rLKtpKdRY4um0dnxuGql0HucYLoqaY9tU0eS3/4hB2I
 dyTrf3pxd5zeSC0O6gFX/gA2UB0V53zQaBM0/KiqarCu3VdljcrM+Nc9Lg6espFW2dZDcCG
 WASpfI1lCRgyJuAFqeQWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H36gsV98dE8=:UniUoyRtRJAAsyHk5ASdUs
 6CCWAZIGkmLv5+sEPzzYmRc604iUve8dBURYo2Y+6DXlx3gIp6qdMwx2ESLjW8nclP99plQ/Y
 xuthY6hg/+ykewXH/M4WnSMkf6BE3VdQPpyZaHQYRhWfnAKOlcuqU72xVtyBVPzHohNeyaUTS
 7nLrogucIWg0ZWSQ3FTLO6MlNmi58ljJJ4mzmPlDVi+2zLvQlOxuG9spFEBMaaDtflsPwGo67
 yGMxMtvPUxlP/ah+iMu9E0Ol5SYNVqNyZaDNkRSjGasoKiXdbVgVO1gX6VI7skBpHzET+FZ5Z
 ftmMF2tJPHQnvAvQh5YiG0w9J6kxEgNj5xUZmwIfmCQ+cEZPWpbMHTW/ITfVX8sGX2NrMCL7y
 JHpTjgSpR3LIgMqoXW3CNp0/SEXFaUqqUpmZIupGwgy5GiBKblh6ZFYTXrF9lLb2pB9uPooCX
 JD49raU4a4LgDVzXCWxAyUidFVF1N78JXfIww1TVdQweerG0KFn3tn4vmqI8FCUeIXvcSxwxA
 LyBAeJLlgZ9vYiNYA7vKurN8gKNQhtqmF0N0jggcCFWS/CeKLqxjiSm3FFGa0fEnPu5SdGAqt
 roFmEcs1lmflZGYo1hwqxuQDtzZS+XTTDVz40nlBUyBJVV2P0S56aYJBxKs7M5yPT+Gc26e3M
 eBaPeR60QLdpR4hgYAn477pXmDYVoUPKPq8/HlxqaU87P5ou7uF3IoYZ5krCjn5u1WTYHZG3z
 +XuGw5so/pmN4U+xDliRo1AmR0T0DoEkuAlxI93NHo70jmu9PHDSFzjX3RGOdoANNwSBe3pEy
 Q57HUxq1vXqdZtINEZSpES1+vcnb8cCHBCpcATW141OhB/I4yWIiHdPYfnopk5aNtYJotMnhG
 IUhJcXNwTEz/S7yq/Xv0Z8Rf11IZNKhd76r+Iyu9az9CNMoLXhcIHRYO+3F2m1wWXcz2NjSpp
 emYnaQdc4P5t0Rfp44jHB7VbfKLSsUjB8OYkjUoiqwWDl84x/813N3rz4BEZ0E6lIVzpbYidd
 5NiIik5jmI8Nvw/EFrHVIxEYpBbUv7FY4wtGZ1AuQi6e9rM0IxZRm831sJTtjCr1AP1UkLBzA
 ooeNHzj5YHeqEE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/21 8:57 PM, Linus Torvalds wrote:
> On Fri, Sep 10, 2021 at 2:19 AM Helge Deller <deller@gmx.de> wrote:
>>
>> please pull some more parisc architecture fixes for kernel 5.15-rc1 fro=
m:
>>
>>    http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.g=
it tags/for-5.15/parisc-3
>
> Well that doesn't work at all.
>
> The *branch* name that you have a few lines lower down in the actual
> pull request part ('parisc-5.15-3') does work, but I didn't get the
> tag. I suspect you used the branch name because you couldn't get the
> wrong tag name to work, and didn't look at why it didn't work.
>
> Because looking closer using 'git ls-remote', it's because your tag
> name was bogus. You actually named it 'for-5.13/parisc-3'.
>
> I fixed it up and edited the wrong name after-the-fact, but please be
> more careful.

Linus, thanks for fixing it up!
It was actually a copy'n'paste mistake on my side. I used an old
git-tag line from my bash history and missed that it was named
"for-5.13" instead of "for-5.15".
Sorry for that.

>> * Remove CONFIG_SET_FS incl. KERNEL_DS and USER_DS from parisc and
>>    switch to __get/put_kernel_nofault()
>
> Lovely. Several architectures to go (alpha, arc, csky, h8300, hexagon,
> ia64, m68k, microblaze, nds32, nios2, openrisc, sh, sparc, um, and
> xtensa) but it's slowly shrinking..

That's still quite many... :-)

Helge
