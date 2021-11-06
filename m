Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42713446DB0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 12:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhKFLuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 07:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhKFLuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 07:50:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B5FC061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 04:47:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w9-20020a17090a1b8900b001a6b3b7ec17so5095416pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lNi1CgbGopAx195xe/6ruTFtcIo4yn2GjlwMsYeQN1E=;
        b=VL6HuUg/54pM6cKqCK5JtgzQWlWNXbtizgO2GMd/8eND6sw15YoKgJZEE24TMbVtgj
         byR+9ARazRwekWk1cst9r44niT3XS0tzPvmOc10VysCBIYu65FdzTrslc+KqyFaRIBYi
         87EnqLagdn7/iXZdMbJeQEVb0C8higkYqkuS72DV/VqjqLObGUrAozBcnG2atB4QYtXv
         YcbEsWEl7ew1AVxC2ajSRLXHLJqEcctB1Io0D1puIttYn7TXHxA+7b4dcZG3myW4Wx3I
         RmymLLK2YeUou8nL9FEc9qVcrjCQTGWN3RSzgBgYUQbgBgRZlYSm8KcpDlYWw3OQDlD7
         5Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=lNi1CgbGopAx195xe/6ruTFtcIo4yn2GjlwMsYeQN1E=;
        b=og7vSkGnseyMi4TC4/I/FfUf6tlp2CPEEszkJf+ZVdmrJAMf6BbdHS1vIqeVRhiCJy
         gxFXN++BM5wkgRxO08L5TkcYpzX6oNj/TPKtnsBp/m1f3nLbIN7XSASEoIx+nnjA14Ux
         IaGDagFzB1zVsduFc04xnu2V2YFsPO6ThBgynePw70sYG7FQQpuaZdo7wlMvNnaSpAoq
         NrUQ24ekqjvhdVf/xQKZugh4e0A/YlvogqCJxQPpRsxQM01hEGFu6ar8CjEpXRj4B0zh
         BAqIx6OwF37JZqizw7h4gJseVR0KPWZapsOLlOq6yzuXt2rrkokykDSwFvguQT+N0FsK
         VqNw==
X-Gm-Message-State: AOAM532oKDn/g5I154NYh/mMJCb4lB6NNv/J3LypUXGnOl+cV6Qlf2Jy
        U7TTm5u/6cJU55+FhcUx7YoIVoXdEFU1L4eeDho=
X-Google-Smtp-Source: ABdhPJxgBHMFMz9nQ0c0b3pO8M1ptST8iuhQj51PgeIWX4nhtRU3PCHMbNpk+itOiTu5Vz0RgQXA7s0PJJpoM9jBGtU=
X-Received: by 2002:a17:903:2306:b0:141:e52e:457d with SMTP id
 d6-20020a170903230600b00141e52e457dmr39321219plh.3.1636199254373; Sat, 06 Nov
 2021 04:47:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:2d0f:0:0:0:0 with HTTP; Sat, 6 Nov 2021 04:47:34
 -0700 (PDT)
Reply-To: cristinacampeell@outlook.com
From:   "Mrs. Cristina Campbell" <look6532@gmail.com>
Date:   Sat, 6 Nov 2021 11:47:34 +0000
Message-ID: <CAJ3bDB4-0bf6TE973eqZbJ8qXzqU6UuzTpSBnr8zfOOK1pjTrA@mail.gmail.com>
Subject: =?UTF-8?B?5L2g6IO95biu5oiR5ZCX?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5Lqy54ix55qE77yMDQoNCuivt+aFouaFouS7lOe7humYheivu++8jOWboOS4uuWug+WPr+iDveaY
r+aCqOaUtuWIsOeahOacgOmHjeimgeeahOeUteWtkOmCruS7tuS5i+S4gOOAguaIkeaYryBDcmlz
dGluYSBDYW1wYmVsbCDlpKvkurrvvIzmiJHkuI7lt7LmlYXnmoQgRWR3YXJkDQpDYW1wYmVsbCDn
u5PlqZrjgILku5bmm77lnKjkvKbmlablo7PniYznn7PmsrnlvIDlj5Hlhazlj7jlt6XkvZzvvIzk
uZ/mmK/kuIDlkI3kuJzkuprlnLDljLrnu4/pqozkuLDlr4znmoTmib/ljIXllYbjgILku5bkuo4g
MjAwMyDlubQgNyDmnIggMzENCuaXpeaYn+acn+S4gOWcqOW3tOm7juWOu+S4luOAguaIkeS7rOe7
k+WpmuS4g+W5tOayoeacieWtqeWtkOOAgg0KDQrlvZPkvaDor7vliLDov5nph4zml7bvvIzmiJHk
uI3mg7PorqnkvaDkuLrmiJHmhJ/liLDpmr7ov4fvvIzlm6DkuLrvvIzmiJHnm7jkv6Hmr4/kuKrk
urrmgLvmnInkuIDlpKnkvJrmrbvljrvjgILmiJHooqvor4rmlq3lh7rmgqPmnInpo5/pgZPnmYzv
vIzmiJHnmoTljLvnlJ/lkYror4nmiJHvvIznlLHkuo7miJHlpI3mnYLnmoTlgaXlurfpl67popjv
vIzmiJHmkpHkuI3kuoblpJrkuYXjgIINCg0K5oiR5biM5pyb5LiK5bid5oCc5oKv5oiR77yM5o6l
57qz5oiR55qE54G16a2C77yM5omA5Lul77yM5oiR5Yaz5a6a5ZCR5oWI5ZaE57uE57uHL+aVmeWg
gi/kvZvmlZnlr7rlupkv5riF55yf5a+6L+aXoOavjeWptC/lvLHlir/nvqTkvZPlkozlr6Hlpofm
lr3oiI3vvIzlm6DkuLrmiJHluIzmnJvov5nmmK/mnIDlkI7nmoTlloTooYzkuYvkuIDmiJHmrbvl
iY3lnKjlnLDnkIPkuIrlgZrjgILliLDnm67liY3kuLrmraLvvIzmiJHlt7Lnu4/lkJHoi4/moLzl
hbDjgIHlqIHlsJTlo6vjgIHlsLzms4rlsJTjgIHoiqzlhbDlkozlt7Topb/nmoTkuIDkupvmhYjl
loTnu4Tnu4fliIblj5HkuobotYTph5HjgILnjrDlnKjmiJHnmoTlgaXlurfnirblhrXmgbbljJbl
vpflpoLmraTkuKXph43vvIzmiJHkuI3og73lho3oh6rlt7HlgZrov5nku7bkuovkuobjgIINCg0K
5oiR5pu+57uP6KaB5rGC5oiR55qE5a625Lq65YWz6Zet5oiR55qE5LiA5Liq6LSm5oi377yM5bm2
5bCG5oiR5Zyo6YKj6YeM55qE6ZKx5YiG6YWN57uZ5Lit5Zu944CB57qm5pem44CB5b635Zu944CB
6Z+p5Zu95ZKM5pel5pys55qE5oWI5ZaE57uE57uH77yM5LuW5Lus5ouS57ud5bm25bCG6ZKx55WZ
57uZ6Ieq5bex44CC5Zug5q2k77yM5oiR5rKh5pyJ5LiN5YaN55u45L+h5LuW5Lus77yM5Zug5Li6
5LuW5Lus5Ly85LmO5LiN5Lya5LiO5oiR5Li65LuW5Lus55WZ5LiL55qE5Lic6KW/5oqX6KGh44CC
5oiR5pyA5ZCO5LiA56yU5peg5Lq655+l6YGT55qE6ZKx5piv5oiR5Zyo5rOw5Zu95LiA5a626ZO2
6KGM5a2Y5YWl55qEDQo2MDAg5LiH576O5YWD55qE5beo6aKd546w6YeR5a2Y5qy+44CC5aaC5p6c
5oKo55yf6K+a77yM5oiR5biM5pyb5oKo5bCG6L+Z56yU6LWE6YeR55So5LqO5oWI5ZaE6K6h5YiS
5bm25pSv5oyB5oKo5omA5Zyo5Zu95a6255qE5Lq657G744CCDQoNCuaIkeWBmuWHuui/meS4quWG
s+WumuaYr+WboOS4uuaIkeayoeacieWtqeWtkOS8mue7p+aJv+i/meeslOmSse+8jOaIkeS4jeaA
leatu++8jOaJgOS7peaIkeefpemBk+aIkeimgeWOu+WTqumHjOOAguaIkeefpemBk+aIkeS8muWc
qOS4u+eahOaAgOaKsemHjOOAguaUtuWIsOaCqOeahOWbnuWkjeWQju+8jOaIkeS8muWwveW/q+e7
meaCqOmTtuihjOeahOiBlOezu+aWueW8j++8jOW5tuWQkeaCqOWPkeWHuuaOiOadg+S5pu+8jOaO
iOadg+aCqOaIkOS4uuivpeWfuumHkeeahOWOn+Wni+WPl+ebiuS6uu+8jOS7peS+v+aCqOeri+WN
s+WcqOaCqOaJgOWcqOeahOWbveWuti/lnLDljLrlvIDlp4vov5npobnmhYjlloTorqHliJLjgIIN
Cg0K5Y+q5pyJ5Li65LuW5Lq66ICM5rS755qE5Lq655Sf5omN5piv5pyJ5Lu35YC855qE44CC5oiR
5biM5pyb5L2g5rC46L+c5Li65oiR56WI56W377yM5L2g5Zue5aSN55qE5Lu75L2V5bu26L+f6YO9
5Lya6K6p5oiR5pyJ56m66Ze05Li65ZCM5qC355qE55uu55qE5a+75om+5Y+m5LiA5Liq5Lq644CC
5aaC5p6c5oKo5LiN5oSf5YW06Laj77yM6K+35Y6f6LCF5oiR5LiO5oKo6IGU57O744CC5oKo5Y+v
5Lul6YCa6L+H5oiR55qE56eB5Lq655S15a2Q6YKu5Lu26IGU57O75oiW5Zue5aSN5oiR77yaKGNy
aXN0aW5hY2FtcGVlbGxAb3V0bG9vay5jb20p44CCDQoNCuiwouiwou+8jA0K5q2k6Ie077yMDQrl
hYvph4zmlq/okoLlqJzCt+Wdjui0neWwlOWkq+S6ug0K55S15a2Q6YKu5Lu2OyBjcmlzdGluYWNh
bXBlZWxsQG91dGxvb2suY29tDQo=
