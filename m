Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4BB40593B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhIIOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbhIIOkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:40:04 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6535AC1A16FC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 06:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=AS4GoMNuNsExioqPJiOWEVu+3vDbz3bR3P
        ju384umbs=; b=Q0mP44lKzggbQhiTjNegXyJD4X+EDPSQAEquIo+Ib3iEGvj4eI
        NDlzUEUFl04iFojHsp7XC7RKM482eu2GIYRg/tff3iXi74q9S2ba+HzQJ6gXRSWO
        r5eWgt0Y+2rm5wn77BdY6ur8xEF2nuVkz08cGcd5L1JDelro1wRu7wE8k=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygB3fgJsEjphqk0PAA--.207S2;
        Thu, 09 Sep 2021 21:55:56 +0800 (CST)
Date:   Thu, 9 Sep 2021 21:49:29 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: enable GENERIC_FIND_FIRST_BIT
Message-ID: <20210909214929.7c2b9ae0@xhacker>
In-Reply-To: <bbd220c4-b535-d024-6bd3-b620b4702ed3@huawei.com>
References: <20210718001423.6b8e1d23@xhacker>
        <20210908230427.3a92fb87@xhacker>
        <bbd220c4-b535-d024-6bd3-b620b4702ed3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: LkAmygB3fgJsEjphqk0PAA--.207S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF18GF4DJw1xZrW8Kr4xCrg_yoWkuFX_Wr
        y0y3ykCw4UZrs7Aan8XayavFWqkF48W34ruw4jyrn8XrW3J3y8CF4kWF9aqayrCr40yF4U
        KF9Iv3W5Xr97JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbrAYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        W3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
        JbIYCTnIWIevJa73UjIFyTuYvjxU2_HUDUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2021 08:58:31 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> On 2021/9/8 23:04, Jisheng Zhang wrote:
> > Hi Palmer,
> >
> > On Sun, 18 Jul 2021 00:14:23 +0800
> > Jisheng Zhang wrote:
> > =20
> >> From: Jisheng Zhang <jszhang@kernel.org>
> >>
> >> riscv doesn't implement architecture-optimized bitsearching functions
> >> such as find_first_{zero}_bit() etc.
> >>
> >> When GENERIC_FIND_FIRST_BIT=3Dn, find_first_bit() is implemented with
> >> find_next_bit() which is less efficient. Enable GENERIC_FIND_FIRST_BIT
> >> for riscv to get more optimized find_first_bit() implementation, an
> >> initial test(lib/find_bit_benchmark) shows find_first_bit() performance
> >> is improved by nearly 32%. =20
> > It seems this patch is missed. Is it possible to pick it up for 2nd 5.1=
5-rc1 PR?
> >
> > Thanks =20
>=20
> It is enabled unconditionally by following commit
>=20
> commit dbbccfe505ef8fae804677abf0564c1e07479102
>=20
> Author: Yury Norov <yury.norov@gmail.com>
> Date:=C2=A0=C2=A0 Tue Aug 24 09:59:56 2021 +1000
>=20
>  =C2=A0=C2=A0=C2=A0 arch: remove GENERIC_FIND_FIRST_BIT entirely
>=20

Aha, thanks for the information. After Yury's commit, this patch
is useless now.

thanks

