Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A908839CEE4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhFFMOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFFMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:13:59 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57901C061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:12:09 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3C0k8Yz9sPf; Sun,  6 Jun 2021 22:12:06 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <afef0ec65a8ba8651bf4f6e4f4f08a8b6991dbfb.1620379469.git.christophe.leroy@csgroup.eu>
References: <afef0ec65a8ba8651bf4f6e4f4f08a8b6991dbfb.1620379469.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Define NR_CPUS all the time
Message-Id: <162298131590.2353459.11042566229022141911.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:35 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 09:24:43 +0000 (UTC), Christophe Leroy wrote:
> include/linux/threads.h defines a default value for CONFIG_NR_CPUS
> but suggests the architectures should always define it.
> 
> So do it, when CONFIG_SMP is not selected set CONFIG_NR_CPUS to 1.

Applied to powerpc/next.

[1/1] powerpc: Define NR_CPUS all the time
      https://git.kernel.org/powerpc/c/c176c3d58a3ed623e8917acaafe240245e700e33

cheers
