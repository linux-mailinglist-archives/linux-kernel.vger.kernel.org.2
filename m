Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF7F3F99DB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245384AbhH0NX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:27 -0400
Received: from ozlabs.org ([203.11.71.1]:57469 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245314AbhH0NXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0kG1Lftz9sVw;
        Fri, 27 Aug 2021 23:22:14 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <c6eabb4fb6c156f75d56dcbcc6f243e5ac0fba42.1629791763.git.christophe.leroy@csgroup.eu>
References: <c6eabb4fb6c156f75d56dcbcc6f243e5ac0fba42.1629791763.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc: Avoid link stack corruption in misc asm functions
Message-Id: <163007015730.52768.16250473929486782356.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:15:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 07:56:35 +0000 (UTC), Christophe Leroy wrote:
> bl;mflr is used at several places to get code position.
> 
> Use bcl 20,31,+4 instead of bl in order to preserve link stack.
> 
> See commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
> in __get_datapage()") for details.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Avoid link stack corruption in misc asm functions
      https://git.kernel.org/powerpc/c/33e1402435cb9f3021439a15935ea2dc69ec1844

cheers
