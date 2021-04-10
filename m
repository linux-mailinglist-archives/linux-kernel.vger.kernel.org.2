Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0269035AE50
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhDJO3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:29:52 -0400
Received: from ozlabs.org ([203.11.71.1]:32849 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234768AbhDJO3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:29:47 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FHcp42Vcbz9sWc; Sun, 11 Apr 2021 00:29:32 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1615398265.git.christophe.leroy@csgroup.eu>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 00/15] powerpc: Cleanup of uaccess.h and adding asm goto for get_user()
Message-Id: <161806493038.1467223.3176738134833493844.b4-ty@ellerman.id.au>
Date:   Sun, 11 Apr 2021 00:28:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 17:46:39 +0000 (UTC), Christophe Leroy wrote:
> This series cleans up uaccess.h and adds asm goto for get_user()
> 
> v2:
> - Further clean ups
> - asm goto for get_user()
> - Move a few patches unrelated to put_user/get_user into another misc series.
> 
> [...]

Applied to powerpc/next.

[01/15] powerpc/uaccess: Remove __get_user_allowed() and unsafe_op_wrap()
        https://git.kernel.org/powerpc/c/8cdf748d557f15ae6f9e0d4108cc3ea6e1ee4419
[02/15] powerpc/uaccess: Define ___get_user_instr() for ppc32
        https://git.kernel.org/powerpc/c/9bd68dc5d7463cb959bff9ac4b6c7e578171de35
[03/15] powerpc/align: Convert emulate_spe() to user_access_begin
        https://git.kernel.org/powerpc/c/3fa3db32956d74c0784171ae0334685502bb169a
[04/15] powerpc/uaccess: Remove __get/put_user_inatomic()
        https://git.kernel.org/powerpc/c/bad956b8fe1a8b3b634d596ed2023ec30726cdf1
[05/15] powerpc/uaccess: Move get_user_instr helpers in asm/inst.h
        https://git.kernel.org/powerpc/c/35506a3e2d7c4d93cb564e23471a448cbd98f085
[06/15] powerpc/align: Don't use __get_user_instr() on kernel addresses
        https://git.kernel.org/powerpc/c/111631b5e9dae764754657aad00bd6cd1a805d0d
[07/15] powerpc/uaccess: Call might_fault() inconditionaly
        https://git.kernel.org/powerpc/c/ed0d9c66f97c6865e87fa6e3631bbc3919a31ad6
[08/15] powerpc/uaccess: Remove __unsafe_put_user_goto()
        https://git.kernel.org/powerpc/c/be15a165796598cd3929ca9aac56ba5ec69e41c1
[09/15] powerpc/uaccess: Remove __chk_user_ptr() in __get/put_user
        https://git.kernel.org/powerpc/c/028e15616857add3ba4951f989027675370b0e82
[10/15] powerpc/uaccess: Remove calls to __get_user_bad() and __put_user_bad()
        https://git.kernel.org/powerpc/c/9975f852ce1bf041a1a81bf882e29ee7a3b78ca6
[11/15] powerpc/uaccess: Split out __get_user_nocheck()
        https://git.kernel.org/powerpc/c/f904c22f2a9fb09fe705efdedbe4af9a30bdf633
[12/15] powerpc/uaccess: Rename __get/put_user_check/nocheck
        https://git.kernel.org/powerpc/c/17f8c0bc21bbb7d1fe729c7f656924a6ea72079b
[13/15] powerpc/uaccess: Refactor get/put_user() and __get/put_user()
        https://git.kernel.org/powerpc/c/e72fcdb26cde72985c418b39f72ecaa222e1f4d5
[14/15] powerpc/uaccess: Introduce __get_user_size_goto()
        https://git.kernel.org/powerpc/c/035785ab2826beb43cfa65a2df37d60074915a4d
[15/15] powerpc/uaccess: Use asm goto for get_user when compiler supports it
        https://git.kernel.org/powerpc/c/5cd29b1fd3e8f2b45fe6d011588d832417defe31

cheers
