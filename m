Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938293684E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbhDVQdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:33:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:40631 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238206AbhDVQdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619109158;
        bh=cSmMf6FVFCXx6/Sb18tAT65fJaJkrLmFKmn91DPp2pk=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=XuMgAtOa0Wo1TgkkSSyau8xaOAIXMbJkVJO+ThS1qZOLWIBxr+2OL0QycKpg16sXw
         ndA2l6c+W8QsXNQszTUw24AFSomPIhSjdowU96Lt6ZmrROzmN69dHk6vxsOpMfQtbl
         o8u5aAJw9yEypaytAMBwvaAnCczZjHlWauD/IUiw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.64] ([46.223.149.64]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ma20q-1m5Yry3Rjw-00VuNk for
 <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 18:32:38 +0200
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Volker_Wei=c3=9fmann?= <volker.weissmann@gmx.de>
Subject: University of Minnesota paper
Message-ID: <d85db373-c112-47e1-2efa-1f7164a255ef@gmx.de>
Date:   Thu, 22 Apr 2021 18:32:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:c24558wAL6/aclGw9XvN1RwoIVTzAKP6FR22DBV11a2It4bogD4
 2H5kzQxSJJ8aeO2b1f1Ae34fl7X8VeDTm5kj5L7BzLoqicARVaeSfc505Bed/oG7jaILbNm
 fvJIsQciXQY8ST1ftcBHjnQaSDipiSoluSC0ml+rCdewKf66F2LGYmV55QH1CTY3TyBQ1UQ
 86Y8eNdCR/kBASe0+nZSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UE0gZ/psLo8=:OrQoOTkHSF0KmBhk2lF6xz
 t50eoCmc4iSX456uVVRr1bNEUw/8QdY0NYvGJj2s7HCH4NF1bn5PlqJVcLX6K5hWTUkjJAYDZ
 1vjgG/w7a3KcpmTJf88NQipduJbd4AsyWn1dSe2G0Dt/aRxpEus5qwmYYYCJ00HIVB+TPNOrR
 JzL4sXRfKSxMhF0NJ4jgQyBxzh6AA9aFu0UpXvRn1X4uru2JGUBtSRUD1nTlDoUYR2gGvUUcL
 7j3eR4ASaykSloHPhKfn+evQBVjiCmP4D1x4VwZp7Y0w3Cl/CH+4LycmxNppQDcuIcul0RhEj
 mP/B0fYJPFXzQa05g9Xd9dKtAyKlhNtMgl0Kedfjb1xF2nbAAgCHGxuEAe0TyMdOXqxigKNpq
 BZAMvOF05r/jiLHknpuHwwyC3nw+Eb8A0FGQXrkfVnVNwPWdx46T4VJjqKhwDwG8u8QEazkFo
 MHh1QDn9ZOoM5nC83A+vw7+ReMOHXKjXu9yNJNGyQVX49iX0mOWQ9klyIoJPPJx64InqL9Iv7
 nA4ncxd0fURwediwE+UVoSa7xzfcEC6e57OlS45X4ugbB4CbnPcWqICfeg5UbiByaunCHhjEM
 NGWzu0r3EFHWoTs1jt/aOP9018naIOkgUg9Rb6gqdnDzTK3fnT8hiu8My4jg+c2mgP92a0jSm
 oeZO32M5xtBXRLsN/KJ3HJEqQrdqF67gGdXip2j8dmfnD+G6l+s+/iDboUjWup1BLDiFPWzOs
 Ln5/6NkHxKlf/Kgb36E9RZtsdtoDDYENenMXatFE4DiMtZsrtjVXrcH9utI1/D5ZLcFoDkgkR
 8PtX1y2j3brRBlQS66xl5ta8HOEMQRCOHEC/bBQ9m835Fl3QDxTXuuaILyvdWSNf5a+v0VqWW
 7xp9xej8NwTeFBa0Epv4H39HCwKPjaMFET2FJvcLPDbQfR64n66WRpZTEuAN7Lc2jgwOlfrL6
 UcXkVZXylCBxKSIv3tr09rnvq3ivWn9s86jwpgzeK05ODLIZQErzl+BQrr6xij9CDXHKARbjA
 qARcnBzFnU9+ht/w1ZOv7r+NJkLl5EVpaEBR658FXLpyWZNZpo15P04VF94TE4DCBUR8iX6Fy
 Mf4K/GpatenGhgQ1cSCCwdyIzGyx+wv5Ib5i8tsr6/IusIrehxJbStS5XiOxv0ZtXugUSyDAQ
 MO+Bq1NzOoPCLTcd9MbceAiwSO3/PREYuoh5CyIEueJ50PVnw+ETPZsJOAtfV/Pz6yWDCC5lg
 9whsuIYuYeSET8jK59lVQjHt8Ma2TEEVtv0LhDg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to inform everyone here, that I just wrote the mail below
to the authors of the paper (wu000273@umn.edu and kjlu@umn.edu).

When I receive an answer, I will post the answer here.


Mail that I sent (from my university mail address):


Hello,

I saw your paper [1
<https://raw.githubusercontent.com/QiushiWu/qiushiwu.github.io/main/papers=
/OpenSourceInsecurity.pdf>]
where you claimed that you proposed patches with vulnerabilities to test
the review process.
Can you prove that you just did this to test the review process and not
to actually introduce vulnerabilities.

Did you tell some trustful people in advance that you are doing this to
test the linux reviewers?
Did you gave a text that says that those patches have vulnerabilities to
a notary and told him to publish those texts after a certain date?
Did you publish a hash of a message that explains that those patches are
vulnerable in advance?

No offense, but proposing patches with vulnerabilities and then claiming
(after they got rejected) that you just did it to test the reviewers
sounds like a really lame excuse to hide something truly malicious.

[1]:
https://raw.githubusercontent.com/QiushiWu/qiushiwu.github.io/main/papers/=
OpenSourceInsecurity.pdf
<https://raw.githubusercontent.com/QiushiWu/qiushiwu.github.io/main/papers=
/OpenSourceInsecurity.pdf>

Greetings

Volker=C2=A0Wei=C3=9Fmann
