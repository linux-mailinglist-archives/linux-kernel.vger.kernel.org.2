Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11338381B81
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 00:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEOWrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 18:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhEOWq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 18:46:59 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D57C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 15:45:45 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FjL8P3l5fz9sX1; Sun, 16 May 2021 08:45:41 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     pmenzel@molgen.mpg.de,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <d5e3c8e66bad3725d7d48d0e45c4b7eb7c02631d.1620455671.git.christophe.leroy@csgroup.eu>
References: <d5e3c8e66bad3725d7d48d0e45c4b7eb7c02631d.1620455671.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/legacy_serial: Fix UBSAN: array-index-out-of-bounds
Message-Id: <162111863369.1890426.15615918327643788763.b4-ty@ellerman.id.au>
Date:   Sun, 16 May 2021 08:43:53 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 06:36:21 +0000 (UTC), Christophe Leroy wrote:
> UBSAN complains when a pointer is calculated with invalid
> 'legacy_serial_console' index, allthough the index is verified
> before dereferencing the pointer.
> 
> Fix it by checking 'legacy_serial_console' validity before
> calculating pointers.

Applied to powerpc/fixes.

[1/1] powerpc/legacy_serial: Fix UBSAN: array-index-out-of-bounds
      https://git.kernel.org/powerpc/c/63970f3c37e75997ed86dbdfdc83df35f2152bb1

cheers
