Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF230812D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhA1Wff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhA1Wfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:35:30 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75718C061574;
        Thu, 28 Jan 2021 14:34:50 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EAF0E6178;
        Thu, 28 Jan 2021 22:34:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EAF0E6178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611873290; bh=c/YX0w8L5tHHfkNx8TTpz49twscupjKEIfy44fPfkoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r/NMOg9+ywVslzx6hH1FQDNxfKfFSJgL6rD6BF/wPfQqG92fBcqz/etuRRTel2hm4
         oXn+gUVvAmVuCWkBMFNp/rKDmEDPJqe2CX4VtHj/NPhKab4+8t6VWY+ho4p3NUqOv0
         cVcuHC/FmYlPKnWKi4526v+FC+yV5ZMnp4R3gVbFy9TfhIGI/XrCyXfsWbKqjd0KeQ
         SxZlLtPQbHj8lus1Wd3rHEuCWG52BMUkUxTAU1Po3PuIHsnKJZmNZCHAEEDRfr5jgc
         QDLHfXR9jdB5kigROlBnn0lopvWQqxmgxQCWtMCRVxD7Dc8+cyBdnV/34266X6fS2B
         VyAV15JGM6vTg==
Date:   Thu, 28 Jan 2021 15:34:49 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2] Documentation/admin-guide: kernel-parameters: update
 CMA entries
Message-ID: <20210128153449.32099ffc@lwn.net>
In-Reply-To: <20210125043202.22399-1-rdunlap@infradead.org>
References: <20210125043202.22399-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Jan 2021 20:32:02 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Add qualifying build option legend [CMA] to kernel boot options
> that requirce CMA support to be enabled for them to be usable.
> 
> Also capitalize 'CMA' when it is used as an acronym.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> ---
> v2: rebase & resend
> 
>  Documentation/admin-guide/kernel-parameters.txt |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
