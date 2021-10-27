Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F16643C4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbhJ0ILG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240767AbhJ0ILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:11:05 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2538C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 01:08:39 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 7DA64452; Wed, 27 Oct 2021 10:08:38 +0200 (CEST)
Date:   Wed, 27 Oct 2021 10:08:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik@protonmail.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dart: Initialize DART_STREAMS_ENABLE
Message-ID: <YXkJBXCnzZ/MgYFV@8bytes.org>
References: <20211019162253.45919-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211019162253.45919-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 06:22:53PM +0200, Sven Peter wrote:
> DART has an additional global register to control which streams are
> isolated. This register is a bit redundant since DART_TCR can already
> be used to control isolation and is usually initialized to DART_STREAM_ALL
> by the time we get control. Some DARTs (namely the one used for the audio
> controller) however have some streams disabled initially. Make sure those
> work by initializing DART_STREAMS_ENABLE during reset.
> 
> Reported-by: Martin Povišer <povik@protonmail.com>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---

Applied, thanks.

