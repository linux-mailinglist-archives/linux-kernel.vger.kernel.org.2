Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD64428C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhJKMJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:09:54 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:35439 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhJKMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:09:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HScxh2Qzzz4xqN;
        Mon, 11 Oct 2021 23:07:52 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <b2e52934e5a500f149e6d94db3cfa0569bc35081.1630657402.git.christophe.leroy@csgroup.eu>
References: <b2e52934e5a500f149e6d94db3cfa0569bc35081.1630657402.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/powermac: Remove stale declaration of pmac_md
Message-Id: <163395399888.4094789.11186435934463842789.b4-ty@ellerman.id.au>
Date:   Mon, 11 Oct 2021 23:06:38 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2021 08:23:52 +0000 (UTC), Christophe Leroy wrote:
> pmac_md doesn't exist anymore, remove stall declaration.
> 

Applied to powerpc/next.

[1/1] powerpc/powermac: Remove stale declaration of pmac_md
      https://git.kernel.org/powerpc/c/9d7fb0643a156a5dddd887814e1263b648501cb0

cheers
