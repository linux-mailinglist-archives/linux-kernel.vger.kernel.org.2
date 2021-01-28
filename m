Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA2E308115
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhA1W0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbhA1W0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:26:34 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA41C06174A;
        Thu, 28 Jan 2021 14:25:54 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 32A5E6173;
        Thu, 28 Jan 2021 22:25:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 32A5E6173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611872754; bh=n3bNCZfvvOgSEPImncNtlfIjxMkprSYkS+VwNzrol2c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q1ov7O4elzTCF85UBBzc3qJuZsEN4SLnpEfF/o4L42dhLDaKLB/G6utplU/c7qe6c
         CqztL/IiuueqHrznDWGyK1XgaHpgZc25ZL6Cr9tg0BrvAb7g1fD0xYJboqlk5jrT6o
         zQ4vEAu7YNUE9MZgkNDfN0pV/CKzubqD440y5DCWpGs1bNOrUYGAZQb2q8XlEmXsdA
         dIp9PEyWp1t6ErvOTYlvwkmSGugoayXrYMQGsdBj7j6zqsvPo7bzTLdvcq8rPinjaa
         fc3RYma5OclWjS1dHdAJXcNawdHlm9d1Bjg4oZ39PS0pxZYWeqBESVzm9OnAAOhw5p
         ttYRFqVZVoAeA==
Date:   Thu, 28 Jan 2021 15:25:53 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     Cao jin <jojing64@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] Documentation/x86/boot.rst: Correct the example of
 SETUP_INDIRECT
Message-ID: <20210128152553.0dec711e@lwn.net>
In-Reply-To: <20210127125440.ma4ir6w7gqahbxbz@tomti.i.net-space.pl>
References: <20210127084911.63438-1-jojing64@gmail.com>
        <20210127125440.ma4ir6w7gqahbxbz@tomti.i.net-space.pl>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 13:54:40 +0100
Daniel Kiper <daniel.kiper@oracle.com> wrote:

> On Wed, Jan 27, 2021 at 04:49:11PM +0800, Cao jin wrote:
> > struct setup_data.len is the length of data field. In case of
> > SETUP_INDIRECT, it should be sizeof(setup_indirect).
> >
> > Signed-off-by: Cao jin <jojing64@gmail.com>  
> 
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Applied, thanks.

jon
