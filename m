Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729DF3484B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbhCXWjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhCXWjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:39:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1B2261A0A;
        Wed, 24 Mar 2021 22:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616625574;
        bh=de+yQOC4AFeazrYN12HdeULhNT12GDinPrZHryBCNGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0HPKNaWm3YRk/E3/90HeDxm9sfsVCDeUbLe0d9j4Ro4ooqARvlxOw3LxHjumZhELV
         T2HJ0e/S88lpJazdsypqeEshzlIxcut9Jt/jwlXnF08cozN8qjerqQl9RCMPWE/za9
         Afyn6/arrWcGX8zky6s8nZGKMGIc9gweonmu2m1g=
Date:   Wed, 24 Mar 2021 15:39:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] ia64: mca: allocate early mca with GFP_ATOMIC
Message-Id: <20210324153934.963ac2cb8f44a4e529016612@linux-foundation.org>
In-Reply-To: <4f7ccc08-7355-63a0-7239-16a5fb29207f@physik.fu-berlin.de>
References: <20210315085045.204414-1-slyfox@gentoo.org>
        <f351183c-7d70-359f-eed7-4d1722cf41c5@physik.fu-berlin.de>
        <20210323174724.78b61c02@sf>
        <4f7ccc08-7355-63a0-7239-16a5fb29207f@physik.fu-berlin.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021 11:20:45 +0100 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> >> #NEXT_PATCHES_START mainline-later (next week, approximately)
> >> ia64-mca-allocate-early-mca-with-gfp_atomic.patch
> 
> Great, thanks. We're still missing Valentin's patch for the NUMA enumeration issue
> though. Should Valentin send the patch again with Andrew CC'ed?

I subscribed to linux-ia64 today, so I can go in there to find things. 
But if there's anything presently outstanding, please do resend.

I presently have

module-remove-duplicate-include-in-arch-ia64-kernel-heads.patch
ia64-kernel-few-typos-fixed-in-the-file-fsyss.patch
ia64-include-asm-minor-typo-fixes-in-the-file-pgtableh.patch
ia64-ensure-proper-numa-distance-and-possible-map-initialization.patch
ia64-drop-unused-ia64_fw_emu-ifdef.patch

