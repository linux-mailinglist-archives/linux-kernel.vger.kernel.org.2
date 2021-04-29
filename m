Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1D36EBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 16:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhD2ODT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 10:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbhD2ODP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:15 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2EFC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 07:02:28 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FWHJ14Ptvz9sjD; Fri, 30 Apr 2021 00:02:25 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <a29aadc54c93bcbf069a83615fa102ca0f59c3ae.1619185912.git.christophe.leroy@csgroup.eu>
References: <a29aadc54c93bcbf069a83615fa102ca0f59c3ae.1619185912.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/signal32: Fix erroneous SIGSEGV on RT signal return
Message-Id: <161970488799.4033873.13546091065982026265.b4-ty@ellerman.id.au>
Date:   Fri, 30 Apr 2021 00:01:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2021 13:52:10 +0000 (UTC), Christophe Leroy wrote:
> Return of user_read_access_begin() is tested the wrong way,
> leading to a SIGSEGV when the user address is valid and likely
> an Oops when the user address is bad.
> 
> Fix the test.

Applied to powerpc/next.

[1/1] powerpc/signal32: Fix erroneous SIGSEGV on RT signal return
      https://git.kernel.org/powerpc/c/5256426247837feb8703625bda7fcfc824af04cf

cheers
