Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7C640F80A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244728AbhIQMk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:40:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:38147 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244698AbhIQMkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:40:46 -0400
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 18HCXk9i027608;
        Fri, 17 Sep 2021 07:33:47 -0500
Message-ID: <55941ad30ce5515e6955565e3fa155f6caa2a896.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: warn on emulation of dcbz instruction
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Christophe Leroy'" <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@linux-m68k.org>
Date:   Fri, 17 Sep 2021 22:33:46 +1000
In-Reply-To: <2fc6953808854149965e60f340eca94b@AcuMS.aculab.com>
References: <62b33ca839f3d1d7d4b64b6f56af0bbe4d2c9057.1631716292.git.christophe.leroy@csgroup.eu>
         <2c0fd775625c76c4dd09b3e923da4405a003f3bd.camel@kernel.crashing.org>
         <eb1a39368401bf46e805ca64256604cc649f771e.camel@kernel.crashing.org>
         <43f736d4-8625-2848-786f-79b902d5c753@csgroup.eu>
         <2fc6953808854149965e60f340eca94b@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-09-16 at 14:36 +0000, David Laight wrote:
> > Does userspace accesses non-cached memory directly ?
> 
> 
> It probably can if a driver mmaps PCI space directly into user space.
> 
> That certainly works on x86-64.

The posterchild for that is Xorg

Cheers,
Ben.


