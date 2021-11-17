Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAA945459C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 12:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbhKQL2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 06:28:40 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:54153 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhKQL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:28:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HvLFs6ptPz4xdT;
        Wed, 17 Nov 2021 22:25:37 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Christian Zigotzky <chzigotzky@xenosoft.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <d319f2a9367d4d08fd2154e506101bd5f100feeb.1636967119.git.christophe.leroy@csgroup.eu>
References: <d319f2a9367d4d08fd2154e506101bd5f100feeb.1636967119.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/book3e: Fix TLBCAM preset at boot
Message-Id: <163714821504.1508509.7196630509343337267.b4-ty@ellerman.id.au>
Date:   Wed, 17 Nov 2021 22:23:35 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 10:05:32 +0100, Christophe Leroy wrote:
> Commit 52bda69ae8b5 ("powerpc/fsl_booke: Tell map_mem_in_cams() if
> init is done") was supposed to just add an additional parameter to
> map_mem_in_cams() and always set it to 'true' at that time.
> 
> But a few call sites were messed up. Fix them.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/book3e: Fix TLBCAM preset at boot
      https://git.kernel.org/powerpc/c/5b54860943dc4681be5de2fc287408c7ce274dfc

cheers
