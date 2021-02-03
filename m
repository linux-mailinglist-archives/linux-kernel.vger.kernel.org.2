Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D410730D8EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhBCLk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:40:59 -0500
Received: from ozlabs.org ([203.11.71.1]:56909 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234305AbhBCLkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:40:49 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW09312NWz9tlc; Wed,  3 Feb 2021 22:40:06 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <2fed79b1154c872194f98bac4422c23918325e61.1611128938.git.christophe.leroy@csgroup.eu>
References: <2fed79b1154c872194f98bac4422c23918325e61.1611128938.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/47x: Disable 256k page size
Message-Id: <161235200635.1516112.16234407332530214324.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:40:06 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 07:49:13 +0000 (UTC), Christophe Leroy wrote:
> PPC47x_TLBE_SIZE isn't defined for 256k pages, so
> this size of page shall not be selected for 47x.

Applied to powerpc/next.

[1/2] powerpc/47x: Disable 256k page size
      https://git.kernel.org/powerpc/c/910a0cb6d259736a0c86e795d4c2f42af8d0d775
[2/2] powerpc/44x: Remove STDBINUTILS kconfig option
      https://git.kernel.org/powerpc/c/4eeef098b43242ed145c83fba9989d586d707589

cheers
