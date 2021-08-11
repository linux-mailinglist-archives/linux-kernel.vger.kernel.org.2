Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC17F3E9232
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhHKNGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230412AbhHKNGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:06:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B63FE60C3E;
        Wed, 11 Aug 2021 13:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628687150;
        bh=Bz33UzmD6GboTLTh0tNwXiYUjE64KjnAWSJYzsiTfKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iy/JdTx+4a03OAcCgwBPVNy7PMWmQKM1EjVDuoTKuwhbxT13eprkX1XJpm6Q+P/YP
         d344Wy+P3o+rnePw7XvoUrdQeWnUCCGqOuN/TdpegCKiFT6mdse4dzoIVQxsKtrhL2
         aK7jvEpN6bNTJ4x0qIGC7JSCnhZ9Tlgltq6bVCP7q8h40Q9Dsje3buxCtwJSxXfC1K
         qxUq936xUZF3/VlPmJkTaTZxABfjLmgAekLS4DPc9imuHf/VX3m7iPEGAGtN3c/v27
         lfXHSi9mGMelP+o7r6N59/QnxAasOTpvdKtdVu7zTHQ71iHciG1CGn6qogGyFksK/h
         HsSMFxbu1uAvA==
Date:   Wed, 11 Aug 2021 16:05:45 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Add missing debug code to memblock_add_node()
Message-ID: <YRPLKSjH71Z9tBih@kernel.org>
References: <c45e5218b6fcf0e3aeb63d9a9d9792addae0bb7a.1628672041.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c45e5218b6fcf0e3aeb63d9a9d9792addae0bb7a.1628672041.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:54:36AM +0200, Geert Uytterhoeven wrote:
> All other memblock APIs built on top of memblock_add_range() contain
> debug code to print their parameters.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for 5.15,
Thanks!

-- 
Sincerely yours,
Mike.
