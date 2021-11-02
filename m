Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5A442CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhKBLlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:13 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:33893 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhKBLlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fc3qbrz4xcL;
        Tue,  2 Nov 2021 22:38:28 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Stan Johnson <userm57@yahoo.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <22831c9d17f948680a12c5292e7627288b15f713.1631817805.git.christophe.leroy@csgroup.eu>
References: <22831c9d17f948680a12c5292e7627288b15f713.1631817805.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/lib/sstep: Don't use __{get/put}_user() on kernel addresses
Message-Id: <163584791077.1845480.9899621375066111807.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:50 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 20:43:36 +0200, Christophe Leroy wrote:
> In the old days, when we didn't have kernel userspace access
> protection and had set_fs(), it was wise to use __get_user()
> and friends to read kernel memory.
> 
> Nowadays, get_user() and put_user() are granting userspace access and
> are exclusively for userspace access.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/lib/sstep: Don't use __{get/put}_user() on kernel addresses
      https://git.kernel.org/powerpc/c/e28d0b675056d072f1f11fa644d0efbb016bb7ce

cheers
