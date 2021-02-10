Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549B8316A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 16:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhBJPby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 10:31:54 -0500
Received: from mout.gmx.net ([212.227.17.21]:45657 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhBJPbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 10:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612971010;
        bh=QyZfw+BD0zZRhcWMhBm0TlXd6xXiohjsOfFSDKlGCns=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=R/A6W0ZAtb18PkpL7zXeAAgbaUxIUSHdLQFfnhTs5dcaL7I2rKQgn6/fZV2p3vNwV
         MtEYjyBZ8C5YflDzD4oU0vqHZwC102XOzyziV/3OmMPSK2BP2tIpJADcbCtXHPCf6X
         LfgbEQMsM78AGwMFGft9m+SiI9gd3GFjfJlwLEEA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.231]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmUHp-1lZoXb0kj3-00iQKJ; Wed, 10
 Feb 2021 16:30:10 +0100
Message-ID: <6b2fa70c333d49dee64fa3c96cd7b7c99e8a6e9b.camel@gmx.de>
Subject: Re: drm/nouneau: 5.11 cycle regression bisected to 461619f5c324
 "drm/nouveau: switch to new allocator"
From:   Mike Galbraith <efault@gmx.de>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Date:   Wed, 10 Feb 2021 16:30:09 +0100
In-Reply-To: <468ec16b-d716-5bd4-db2b-fb79e6c72a4f@amd.com>
References: <1d663cd74af91e23f4f24ebbdd65ef3ba72c15fc.camel@gmx.de>
         <43924195-c4e1-fce4-5766-aaefe2d6f766@amd.com>
         <2793c200beb530ed4a8ac32c5eea0f5aaa53c7e8.camel@gmx.de>
         <bfd62492-e6a9-3899-dd7d-87b7800f45c7@amd.com>
         <41cc52bd57a466f29ea81676d42f57a7b9da7dd8.camel@gmx.de>
         <5df26bda-9ff8-168f-e5a3-0bb503ffcca9@amd.com>
         <eeea2d002142ec7f8737b9d0fb5128b0cdb2ae58.camel@gmx.de>
         <468ec16b-d716-5bd4-db2b-fb79e6c72a4f@amd.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IQ8E4OevCPqnKIllxiCl1s3ZQJKM/K1cFsAL0R2b9n6yD/Ovu//
 N2Ek8nXWACS9WCJNY5E6kmg1VODlwudvJNIgoAI+N0R/EbsNKXlMKIgTJUGetvdK2qc7LuO
 HgjgR3Qat4sL9zM3jwx6juh8/u9N85/YCxq0Yys2WRF5UcunOCW3avhwGNTlE1qDngjw+kK
 gfw9ppmq5r4vT/U2M7XBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7P2kWGFjaa4=:0CGM/zMyp5sfzmv+txI9nD
 E/x2vBT+/YcFI4VjJVI6/3vtPcE0MqDcfmEmSVDdJq4F7zj5rVJcLawAcZUTt6NwzrhTn3KvJ
 7ArKoteoR/1McKD6RtidYXppvaLnlai3xfvMgbxPORBitVt/CIH33FJN42gWphYKCo9TKCWtR
 nXNSE6NiNxTDw61mq4j+BjMp7IwMTWrnaghDr3dGHFvIT9gficYPCnsvD1RUjTmvPOgMG9Ped
 tpISS3ukb/s06hS0iJLQYNQzLY43JdseaAQpT5jOzjPV+vMUZ5FbKqdr2yEYoxNIdMXpBcVfo
 bwytyRV+ju3nXFVquiO2pqVa0pibNMAc0MKz9ilqqemztyE4Gp3w5JTaSUvWsyrdxubNzGH21
 GepW+i8EKgQOkx1qSXI+ptHXc0O6WW1GmgBYNLEtzSk4YCAXntZtWUlzgHtkqOnxv9GVhfWCb
 uMOAoU1kxg2fNtU0IdEcavHsm6XZQQToUZMNwj97CL1upgJjM8/w3t4ggd+o4AGFPFXid2gwi
 dz65ZL73KeLKFcggtbvu9jEygBfinNv5mtc90hk0TOExqVjjYCQ3OKt0toHOw62SY0duVNram
 JkpgXD6hCMToQD8VcNjDz98lGjWVB3BkwSB3RH27oAC7QA2aonydVSYvotsy5C6TMGxUzRvM/
 JXMt3wSYpD2m84sm28iwh+A2aHh/QjhsYHI8t3iE++Ym3P5sxk0BuKUhFOMe12UrSMpKI47/Q
 QzZ/5R7RFDxGdTCrId6dPrFdt9NJneN20sfdjO2pZj8u1CYDXcLmbkNTiKBHz7qf0KZGeTse/
 yDnKmYeTFwLjq6y7fa4YmO/HtjWhTz3nXOTve8xUmabgtPaugfpYjK/txl4zKfrIc93a1WVd7
 /b4lI6SL54U2/Y/e5OQw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-10 at 14:26 +0100, Christian K=F6nig wrote:
>
> Am 10.02.21 um 13:22 schrieb Mike Galbraith:
> > On Wed, 2021-02-10 at 12:44 +0100, Christian K=F6nig wrote:
> >> Please try to add a "return NULL" at the beginning of ttm_pool_type_t=
ake().
> >>
> >> That should effectively disable using the pool.
> > That did away with the yield looping, but it doesn't take long for the
> > display to freeze.  I ssh'd in from lappy, but there was nada in dmesg=
.
>
> Yeah, that is expected. Without taking pages from the pool we leak
> memory like sieve.
>
> At least we could narrow down the problem quite a bit with that.
>
> Can you test the attached patch and see if it helps?

Yup, that seems to have fixed it all up.  Another one bites the dust ;)

	-Mike

