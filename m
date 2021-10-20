Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3D43566E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 01:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJTXX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 19:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhJTXX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 19:23:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C7F760EFE;
        Wed, 20 Oct 2021 23:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634772101;
        bh=/xqLQmjienSp554eHZIl64dYoKQyTBAnqNBmKwd5TVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Czf1IwhwdwBivekNEoZ4zSrEU1bcDZnOAyKxHoNMQAdb7pEc5KqzVht+3ZUK4DHya
         zDkXroTJADOkSVoKEtaT0JkWPtFk65msl20ICX8S8zMBnd0HOx9Y5Ft13QEz6EJZWw
         be+Q4DqzRd/kuTpH8FOLIMueaY3KpIiVnJU2nH1sCUsglO2Cc2aIj1K9nfM8M1Z4+o
         aMQD+DvhDOdKGJKny8dJL14MxlQR5tmulKbxCC1ZG3Hs/5AYzNmbWcsU96nD47/Mom
         x2GDv9nboHIv5vCY+3Q4MfhFP4+8sdmJ2NpEmnQAvvQSJz0BU0mfpxTvHqUZJ2zTHW
         niWiU5lGZKs1g==
Date:   Wed, 20 Oct 2021 18:26:20 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Len Baker <len.baker@gmx.com>, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Kees Cook <keescook@chromium.org>,
        linux-afs@lists.infradead.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Prefer struct_size over open coded arithmetic
Message-ID: <20211020232620.GA1314964@embeddedor>
References: <20210919094432.30510-1-len.baker@gmx.com>
 <8664159c-b986-64b0-13d1-b2739deb159d@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8664159c-b986-64b0-13d1-b2739deb159d@embeddedor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 07:09:38PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 9/19/21 04:44, Len Baker wrote:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or similar)
> > function arguments due to the risk of them overflowing. This could lead
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> > 
> > So, use the struct_size() helper to do the arithmetic instead of the
> > argument "size + size * count" in the kzalloc() function.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> > 
> > Signed-off-by: Len Baker <len.baker@gmx.com>
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

I'm taking this in my -next tree.

Thanks, Len.
--
Gustavo
