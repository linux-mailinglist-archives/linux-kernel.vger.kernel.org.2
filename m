Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B65381B7C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 00:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhEOWq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 18:46:58 -0400
Received: from ozlabs.org ([203.11.71.1]:55083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhEOWq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 18:46:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FjL8N6wMzz9sWW; Sun, 16 May 2021 08:45:40 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b831e54a2579db24fbef836ed415588ce2b3e825.1620312573.git.christophe.leroy@csgroup.eu>
References: <b831e54a2579db24fbef836ed415588ce2b3e825.1620312573.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/interrupts: Fix kuep_unlock() call
Message-Id: <162111863251.1890426.8864764297302499423.b4-ty@ellerman.id.au>
Date:   Sun, 16 May 2021 08:43:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2021 14:49:45 +0000 (UTC), Christophe Leroy wrote:
> Same as kuap_user_restore(), kuep_unlock() has to be called when
> really returning to user, that is in interrupt_exit_user_prepare(),
> not in interrupt_exit_prepare().

Applied to powerpc/fixes.

[1/1] powerpc/interrupts: Fix kuep_unlock() call
      https://git.kernel.org/powerpc/c/a78339698ab1f43435fbe67fcd6de8f4f6eb9eec

cheers
