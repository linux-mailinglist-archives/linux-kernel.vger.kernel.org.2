Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0142C374
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhJMOhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbhJMOhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:37:50 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76621C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:35:47 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r2so2488886pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=u3UVtloaaMqDkztEGASyWNnbDwu0ymuLbk5cZTT/COQ=;
        b=iyqGkk0HIKBoCkRrYqyDyUzTSSOsD3lzHkbsap8I//LSNM9PZXPrvP+wj+0+6w5XCj
         uB+MjTFSjr23QNdX0jTtSmfqOfomN64GAQNgYmLhR6CIwJjQ1TRh7AP5fAZXumajYIBt
         jt0lkv3v7t7mcmd/HEmmbJPW6EvBfPKhQbfhwzllVtLIkHcJcrjDq6Z/1q2yRPQoGrxg
         IHr7puQv3DGDf60vu/z4hwJGEOhsxFsEBKxJySlsNveSmIqU25hPsHTs64BMTQgcNRDv
         WQecTcZ5xOy5pb44q0+9GKRK5Xvm8+JXdihEss9MrgvEaY/rZ0y2UVDQgEMdNMCcKnjO
         2zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=u3UVtloaaMqDkztEGASyWNnbDwu0ymuLbk5cZTT/COQ=;
        b=cw+DtV+xMpZFiCu5j+Nel97KPFQ/8cdyGkUTISzCO540LSMzkwKfOYml95tT0XZrUa
         2CR9Tqu2rTK8vRSEmEoilNL9jigX/P4BdG68xrg2f4+3aUR4Z0QNVoLHmYZFoZkM/elg
         Qy9RcMe1NezjD6bUJhrxqnOAO1g/br0w8WsiH+C0yF7o41EWFaJ8VinbSQrckFF9GrJt
         khJO/I9Vz+df2OmCCyccr/quGkLAxUyocxSLExBdrM1aGCOcpISUDgqGBOvgAvRq6cOE
         x0/8rx01a3eyvn2pkPirbG8Ao1ElAa7U60h6pQSdF38WRWDgTsaEPDqQKV2/+8NIuH9A
         HP8w==
X-Gm-Message-State: AOAM533TXg2/evvrzkpbnkbgsDDleI8JEQN53K/dIebQLOBBl8nvYovT
        yZHByXzYI+DPnVZFYAj8JvnuExu8HmHlF4fBh0Q=
X-Google-Smtp-Source: ABdhPJwxMVghtWWcyJpsZT/2/nBqiIYAJ5fLjeFqBX+zqNN5YdBNY0alWKAaZcljcJlG4GcThEL1vlk1LCqgytvV2v0=
X-Received: by 2002:a63:d250:: with SMTP id t16mr28242177pgi.95.1634135746754;
 Wed, 13 Oct 2021 07:35:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:8a56:0:0:0:0 with HTTP; Wed, 13 Oct 2021 07:35:46
 -0700 (PDT)
Reply-To: jesspayne72@gmail.com
From:   Jess Payne <joeladamu2@gmail.com>
Date:   Wed, 13 Oct 2021 07:35:46 -0700
Message-ID: <CAO_K9dg82szBP50HiMFNvHeewD5i0gVzR_kvEYqjLE=NorJzNw@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5YqpIC8gSSBuZWVkIHlvdXIgYXNzaXN0YW5jZQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5oiR5piv5p2w6KW/5L2p5oGp5Lit5aOr5aSr5Lq644CCDQoNCuWcqOe+juWbvemZhuWGm+eahOWG
m+S6i+mDqOmXqOOAgue+juWbve+8jOS4gOWQjeS4reWjq++8jDMyIOWyge+8jOaIkeWNlei6q++8
jOadpeiHque+juWbveeUsOe6s+ilv+W3nuWFi+WIqeWkq+WFsO+8jOebruWJjempu+aJjuWcqOWI
qeavlOS6muePreWKoOilv++8jOS4juaBkOaAluS4u+S5ieS9nOaImOOAguaIkeeahOWNleS9jeaY
r+esrDTmiqTnkIbpmJ/nrKw3ODLml4XmlK/mj7TokKXjgIINCg0K5oiR5piv5LiA5Liq5YWF5ruh
54ix5b+D44CB6K+a5a6e5ZKM5rex5oOF55qE5Lq677yM5YW35pyJ6Imv5aW955qE5bm96buY5oSf
77yM5oiR5Zac5qyi57uT6K+G5paw5pyL5Y+L5bm25LqG6Kej5LuW5Lus55qE55Sf5rS75pa55byP
77yM5oiR5Zac5qyi55yL5Yiw5aSn5rW355qE5rOi5rWq5ZKM5bGx6ISJ55qE576O5Li95Lul5Y+K
5aSn6Ieq54S25omA5oul5pyJ55qE5LiA5YiH5o+Q5L6b44CC5b6I6auY5YW06IO95pu05aSa5Zyw
5LqG6Kej5oKo77yM5oiR6K6k5Li65oiR5Lus5Y+v5Lul5bu656uL6Imv5aW955qE5ZWG5Lia5Y+L
6LCK44CCDQoNCuaIkeS4gOebtOW+iOS4jeW8gOW/g++8jOWboOS4uui/meS6m+W5tOadpeeUn+a0
u+WvueaIkeS4jeWFrOW5s++8m+aIkeWkseWOu+S6hueItuavje+8jOmCo+W5tOaIkSAyMQ0K5bKB
44CC5oiR54i25Lqy55qE5ZCN5a2X5piv5biV54m56YeM5pav5L2p5oGp77yM5oiR55qE5q+N5Lqy
5piv546b5Li95L2p5oGp44CC5rKh5pyJ5Lq65biu5Yqp5oiR77yM5L2G5b6I6auY5YW05oiR57uI
5LqO5Zyo576O5Yab5Lit5om+5Yiw5LqG6Ieq5bex44CCDQoNCuaIkee7k+WpmueUn+S6huWtqeWt
kO+8jOS9huS7luatu+S6hu+8jOS4jeS5heaIkeS4iOWkq+W8gOWni+asuumql+aIke+8jOaJgOS7
peaIkeS4jeW+l+S4jeaUvuW8g+WpmuWnu+OAgg0KDQrmiJHkuZ/lvojlubjov5DvvIzlnKjmiJHn
moTlm73lrrbnvo7lm73lkozliKnmr5Tkuprnj63liqDopb/ov5nph4zmi6XmnInmiJHnlJ/mtLvk
uK3miYDpnIDnmoTkuIDliIfvvIzkvYbmsqHmnInkurrkuLrmiJHmj5Dkvpvlu7rorq7jgILmiJHp
nIDopoHkuIDkuKror5rlrp7nmoTkurrmnaXkv6Hku7vvvIzku5bkuZ/kvJrlsLHlpoLkvZXmipXo
tYTmiJHnmoTpkrHmj5Dkvpvlu7rorq7jgILlm6DkuLrmiJHmmK/miJHniLbmr43lnKjku5bku6zl
jrvkuJbliY3nlJ/kuIvnmoTllK/kuIDkuIDkuKrlpbPlranjgIINCg0K5oiR5LiN6K6k6K+G5L2g
5pys5Lq677yM5L2G5oiR6K6k5Li65pyJ5LiA5Liq5YC85b6X5L+h6LWW55qE5aW95Lq677yM5LuW
5Y+v5Lul5bu656uL55yf5q2j55qE5L+h5Lu75ZKM6Imv5aW955qE5ZWG5Lia5Y+L6LCK77yM5aaC
5p6c5L2g55yf55qE5pyJ5LiA5Liq6K+a5a6e55qE5ZCN5a2X77yM5oiR5Lmf5pyJ5LiA5Lqb5Lic
6KW/6KaB5ZKM5L2g5YiG5Lqr55u45L+h44CC5Zyo5L2g6Lqr5LiK77yM5Zug5Li65oiR6ZyA6KaB
5L2g55qE5biu5Yqp44CC5oiR5oul5pyJ5oiR5Zyo5Yip5q+U5Lqa54+t5Yqg6KW/6L+Z6YeM6LWa
5Yiw55qE5oC76aKd77yIMjUwDQrkuIfnvo7lhYPvvInjgILmiJHkvJrlnKjkuIvkuIDlsIHnlLXl
rZDpgq7ku7bkuK3lkYror4nkvaDmiJHmmK/lpoLkvZXlgZrliLDnmoTvvIzkuI3opoHmg4rmhYzv
vIzku5bku6zmsqHmnInpo47pmanvvIzogIzkuJTmiJHov5jlnKjkuI4gUmVkDQrmnInogZTns7vn
moTkurrpgZPkuLvkuYnljLvnlJ/nmoTluK7liqnkuIvlsIbov5nnrJTpkrHlrZjlhaXkuobpk7bo
oYzjgILmiJHluIzmnJvmgqjlsIboh6rlt7HkvZzkuLrmiJHnmoTlj5fnm4rkurrmnaXmjqXmlLbl
n7rph5HlubblnKjmiJHlnKjov5nph4zlrozmiJDlkI7noa7kv53lroPnmoTlronlhajlubbojrfl
vpfmiJHnmoTlhpvkuovpgJrooYzor4Hku6XlnKjmgqjnmoTlm73lrrbkuI7mgqjkvJrpnaLvvJvk
uI3opoHlrrPmgJXpk7booYzkvJrlsIbotYTph5HlrZjlgqjlnKgNCkFUTSBWSVNBIOWNoeS4re+8
jOi/meWvueaIkeS7rOadpeivtOaYr+WuieWFqOS4lOW/q+aNt+eahOOAgg0KDQrnrJTorrA75oiR
5LiN55+l6YGT5oiR5Lus6KaB5Zyo6L+Z6YeM5ZGG5aSa5LmF77yM5oiR55qE5ZG96L+Q77yM5Zug
5Li65oiR5Zyo6L+Z6YeM5Lik5qyh54K45by56KKt5Ye75Lit5bm45a2Y5LiL5p2l77yM6L+Z5L+D
5L2/5oiR5a+75om+5LiA5Liq5YC85b6X5L+h6LWW55qE5Lq65p2l5biu5Yqp5oiR5o6l5pS25ZKM
5oqV6LWE5Z+66YeR77yM5Zug5Li65oiR5bCG5p2l5Yiw5L2g5Lus55qE5Zu95a625Ye66Lqr5oqV
6LWE77yM5byA5aeL5paw55Sf5rS777yM5LiN5YaN5b2T5YW144CCDQoNCuWmguaenOaCqOaEv+aE
j+iwqOaFjuWkhOeQhu+8jOivt+WbnuWkjeaIkeOAguaIkeS8muWRiuivieS9oOS4i+S4gOatpeea
hOa1geeoi++8jOW5tue7meS9oOWPkemAgeabtOWkmuWFs+S6juWfuumHkeWtmOWFpemTtuihjOea
hOS/oeaBr+OAguS7peWPiumTtuihjOWwhuWmguS9leW4ruWKqeaIkeS7rOmAmui/hyBBVE0gVklT
QQ0KQ0FSRCDlsIbotYTph5Hovaznp7vliLDmgqjnmoTlm73lrrYv5Zyw5Yy644CC5aaC5p6c5L2g
5pyJ5YW06Laj77yM6K+35LiO5oiR6IGU57O744CCDQo=
