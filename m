Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3393877DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348796AbhERLlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 07:41:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348769AbhERLli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 07:41:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27027AFF8;
        Tue, 18 May 2021 11:40:20 +0000 (UTC)
Date:   Tue, 18 May 2021 13:40:18 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org
Subject: Re: [PATCH stable-5.10,5.11,5.12] x86/boot/compressed/64: Check SEV
 encryption in the 32-bit boot-path
Message-ID: <YKOnot8C4RKrWtXm@suse.de>
References: <20210508032224.039CF613ED@mail.kernel.org>
 <YJZnYDty7Siyo68k@kroah.com>
 <YKOnVYLRxk9CUzTc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKOnVYLRxk9CUzTc@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 01:39:02PM +0200, Joerg Roedel wrote:
> [ Upstream commit fef81c86262879d4b1176ef51a834c15b805ebb9 ]
> 
> Check whether the hypervisor reported the correct C-bit when running
> as an SEV guest. Using a wrong C-bit position could be used to leak
> sensitive data from the guest to the hypervisor.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lkml.kernel.org/r/20210312123824.306-8-joro@8bytes.org
> ---
>  arch/x86/boot/compressed/head_64.S | 85 ++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)

This is compile-tested now for 5.10, 5.11 and 5.12. With 5.12 I also did
a boot-test using the 32-bit boot-path and verified it still works as
expected.

Regards,

	Joerg
