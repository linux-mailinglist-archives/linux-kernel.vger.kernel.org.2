Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F0E39CEC6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFFMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhFFMNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:13:53 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36C4C061789
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:03 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb360Mmgz9sVm; Sun,  6 Jun 2021 22:12:01 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <7f4aaa479569328a1e5b07c96c08fbca0cd7dd88.1620307890.git.christophe.leroy@csgroup.eu>
References: <7f4aaa479569328a1e5b07c96c08fbca0cd7dd88.1620307890.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Remove asm/book3s/32/hash.h
Message-Id: <162298131735.2353459.10982027333245553692.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 13:32:18 +0000 (UTC), Christophe Leroy wrote:
> Move the PAGE bits into pgtable.h to be more similar to book3s/64.

Applied to powerpc/next.

[1/1] powerpc/32s: Remove asm/book3s/32/hash.h
      https://git.kernel.org/powerpc/c/ca8cc36901e9bdd01d371f6236faf9f61d1325d1

cheers
