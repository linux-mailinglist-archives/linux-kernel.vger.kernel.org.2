Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DD9433471
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhJSLOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhJSLOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:14:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A37F60F22;
        Tue, 19 Oct 2021 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634641952;
        bh=xSLpVhIimaEc2GSO7dKWsRCb7cTgM+8to+JnNVQdntg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCbpwg9xv51+xHWAUCfvWWsXSXpbYzrRFL6ZKdfzd2rPw1739MSmPlPLMPjOdmeU4
         Egb8kBFl0/KAZgLH1baQtMmuJvfSupUy2WSM01Y2UwE8T3sAsInjF1rN/6GcPrp5RB
         rTZDprGImIIUMjTONnQgNcGHvfp674UgxbqGWTO8=
Date:   Tue, 19 Oct 2021 13:12:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     Joe Perches <joe@perches.com>, outreachy-kernel@googlegroups.com,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Fix line wrapping in rf.c file
Message-ID: <YW6oHsli56urDry6@kroah.com>
References: <20211018150526.9718-1-karolinadrobnik@gmail.com>
 <YW2O3wC8wMEKS3Ub@kroah.com>
 <84f3c940fedb961e6e7e88d47c3d15e598bc32c3.camel@perches.com>
 <810a4e29b0c54520a30cae4d37fde0a59ea3d83b.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <810a4e29b0c54520a30cae4d37fde0a59ea3d83b.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 11:59:56AM +0100, Karolina Drobnik wrote:
> Hi,
> 
> Thank you very much for your comments.
> 
> On Mon, 2021-10-18 at 17:12 +0200, Greg KH wrote:
> > Also, these are all just fine as-is for now.  A better way to make
> > these lines smaller is to use better variable and function names 
> > that are shorter and make sense :)
> 
> I have v2 ready but I'm not sure, given the Joe's patch, if my solution
> is a satisfactory one. I didn't jump on such refactoring as I'm still
> learning about the codebase/process and didn't want to muddle the
> waters (...more than I do already).
> 
> Greg, what would you prefer? Should I back up with my patch, pick
> something else and let Joe's patch be merged?

Joe hasn't submitted it in a format that I can take it in, so that is up
to you, I can't tell you want to work on :)

good luck!

greg k-h
