Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB6381B7D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 00:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhEOWrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 18:47:01 -0400
Received: from ozlabs.org ([203.11.71.1]:36815 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhEOWq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 18:46:58 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FjL8R6WcQz9sf8; Sun, 16 May 2021 08:45:43 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <332773775cf24a422105dee2d383fb8f04589045.1620302182.git.christophe.leroy@csgroup.eu>
References: <332773775cf24a422105dee2d383fb8f04589045.1620302182.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/syscall: Calling kuap_save_and_lock() is wrong
Message-Id: <162111863271.1890426.12479008048900584669.b4-ty@ellerman.id.au>
Date:   Sun, 16 May 2021 08:43:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 11:56:31 +0000 (UTC), Christophe Leroy wrote:
> kuap_save_and_lock() is only for interrupts inside kernel.
> 
> system call are only from user, calling kuap_save_and_lock()
> is wrong.

Applied to powerpc/fixes.

[1/1] powerpc/syscall: Calling kuap_save_and_lock() is wrong
      https://git.kernel.org/powerpc/c/5d510ed78bcfcbbd3b3891cbe79cd7543bce1d05

cheers
