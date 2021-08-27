Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC9B3F99DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbhH0NXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245357AbhH0NXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:22 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA3C0611FB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 06:22:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0k43q8cz9sWw;
        Fri, 27 Aug 2021 23:22:04 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <ba49cdd574558a0363300c3f6b5b062b397cb071.1629451483.git.christophe.leroy@csgroup.eu>
References: <ba49cdd574558a0363300c3f6b5b062b397cb071.1629451483.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/audit: Avoid unneccessary #ifdef in syscall_get_arguments()
Message-Id: <163007014826.52768.5080376494412859642.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:15:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 09:28:19 +0000 (UTC), Christophe Leroy wrote:
> Use is_32bit_task() which already handles CONFIG_COMPAT.
> 
> 
> 
> 

Applied to powerpc/next.

[1/1] powerpc/audit: Avoid unneccessary #ifdef in syscall_get_arguments()
      https://git.kernel.org/powerpc/c/898a1ef06ad4a2a8e3c9490ce62624fcd1a7b1f8

cheers
