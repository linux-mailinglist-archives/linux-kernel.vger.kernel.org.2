Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39136319761
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhBLAVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 19:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhBLAUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 19:20:39 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FA3C061756
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 16:19:58 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DcDf322BKz9sVm; Fri, 12 Feb 2021 11:19:54 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <99d4ccb58a20d8408d0e19874393655ad5b40822.1612879284.git.christophe.leroy@csgroup.eu>
References: <99d4ccb58a20d8408d0e19874393655ad5b40822.1612879284.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/3] powerpc/uaccess: get rid of small constant size cases in raw_copy_{to,from}_user()
Message-Id: <161308904868.3606979.5042920812236325748.b4-ty@ellerman.id.au>
Date:   Fri, 12 Feb 2021 11:19:54 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021 14:02:12 +0000 (UTC), Christophe Leroy wrote:
> Copied from commit 4b842e4e25b1 ("x86: get rid of small
> constant size cases in raw_copy_{to,from}_user()")
> 
> Very few call sites where that would be triggered remain, and none
> of those is anywhere near hot enough to bother.

Applied to powerpc/next.

[1/3] powerpc/uaccess: get rid of small constant size cases in raw_copy_{to,from}_user()
      https://git.kernel.org/powerpc/c/6b385d1d7c0a346758e35b128815afa25d4709ee
[2/3] powerpc/uaccess: Merge __put_user_size_allowed() into __put_user_size()
      https://git.kernel.org/powerpc/c/95d019e0f9225954e33b6efcad315be9d548a4d7
[3/3] powerpc/uaccess: Merge raw_copy_to_user_allowed() into raw_copy_to_user()
      https://git.kernel.org/powerpc/c/052f9d206f6c4b5b512b8c201d375f2dd194be35

cheers
