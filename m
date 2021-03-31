Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E95350180
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhCaNjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbhCaNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:39:18 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608CCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 06:39:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4F9S8g236Hz9sVb;
        Thu,  1 Apr 2021 00:39:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1617197955;
        bh=Wf6CnDfQWgn/hY7cq2C/wa4ZqetQCiDimtarRYDe7Fk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=c31RFkI19rETqVysZaOwWC8u9K7r/4KDXzwaRwGv/tAmIkdwj8sHpKkltWtHiSYgs
         2ATqq1X/CTzmr+oqJkHXgyziksQ2ow6u+dKA7ViOnB/VC+7vAP7CCzXKwd5kDs16k2
         c3AnFQ45Rp2R2QhI+8dz3+philYiBMbm6hBZ4A0DXixQiHlVlkDmGKNs6/KvGIsCQU
         W0efuCKCs+4owJLFCU8g+/kFoEDwNC40D7iysAbymsN0BhTk7Ps3sph7cFNWLD4CaV
         jirTAL/EnmFO3vmvxSxwrjjS7zsnqKnPYw/Wm/QYJ/BcAZIL3yVNbF3+Xsj3gZhJHZ
         oRWibay0XD2oA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/8xx: Load modules closer to kernel text
In-Reply-To: <db20abbecb129c49d3c663de67dac6a87501ac0b.1617001615.git.christophe.leroy@csgroup.eu>
References: <db20abbecb129c49d3c663de67dac6a87501ac0b.1617001615.git.christophe.leroy@csgroup.eu>
Date:   Thu, 01 Apr 2021 00:39:14 +1100
Message-ID: <87czvf788t.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> On the 8xx, TASK_SIZE is 0x80000000. The space between TASK_SIZE and
> PAGE_OFFSET is not used.
>
> Use it to load modules in order to minimise the distance between
> kernel text and modules and avoid trampolines in modules to access
> kernel functions or other module functions.
>
> Define a 16Mbytes area for modules, that's more than enough.

16MB seems kind of small.

At least on 64-bit we could potentially have hundreds of MBs of modules.

cheers
