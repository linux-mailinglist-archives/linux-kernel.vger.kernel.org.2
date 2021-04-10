Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF4635AE53
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhDJO35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbhDJO3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:29:51 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF856C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:29:35 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FHcp53z4Gz9sWw; Sun, 11 Apr 2021 00:29:33 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Axtens <dja@axtens.net>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <c95a648fdf75992c9d88f3c73cc23e7537fcf2ad.1615555354.git.christophe.leroy@csgroup.eu>
References: <0ad4629c2d222019e82fcdfccc70d372beb4adf9.1615398265.git.christophe.leroy@csgroup.eu> <c95a648fdf75992c9d88f3c73cc23e7537fcf2ad.1615555354.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 03/15] powerpc/align: Convert emulate_spe() to user_access_begin
Message-Id: <161806492680.1467223.16788785953274402372.b4-ty@ellerman.id.au>
Date:   Sun, 11 Apr 2021 00:28:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2021 13:25:11 +0000 (UTC), Christophe Leroy wrote:
> This patch converts emulate_spe() to using user_access_begin
> logic.
> 
> Since commit 662bbcb2747c ("mm, sched: Allow uaccess in atomic with
> pagefault_disable()"), might_fault() doesn't fire when called from
> sections where pagefaults are disabled, which must be the case
> when using _inatomic variants of __get_user and __put_user. So
> the might_fault() in user_access_begin() is not a problem.
> 
> [...]

Applied to powerpc/next.

[03/15] powerpc/align: Convert emulate_spe() to user_access_begin
        https://git.kernel.org/powerpc/c/3fa3db32956d74c0784171ae0334685502bb169a

cheers
