Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C63388B12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbhESJwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhESJv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:51:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1702F610A1;
        Wed, 19 May 2021 09:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621417839;
        bh=Zts2inRHfLvIsBj9OZbQasOMtlHs9BYNosUCPvJ1T9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYx5pQzSxMqlaV8n0fR1kTWwv5EhEQefeSz2rziMjzcxQNLbWn4jD+hWN/8EWHLWd
         n5bl0IcnAsu8Mv8wbXUMWLT+JJdge/Yr18/iJzNyl3vRj65MEme1AvMqc3GSyd7l2d
         Y8on9YDWJdxB7D8K+gQF3BCa7J/kVa+WUNW1p/ks=
Date:   Wed, 19 May 2021 11:50:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hriday Hegde <hridayhegde1999@gmail.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 'const' keyword
Message-ID: <YKTfbdFhvM7fbpet@kroah.com>
References: <20210519081958.7223-1-hridayhegde1999@gmail.com>
 <YKTM8KmXI8bXUSqp@kroah.com>
 <0ddb894f-f66f-f31b-ef8a-0646e0a99b9f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ddb894f-f66f-f31b-ef8a-0646e0a99b9f@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

http://daringfireball.net/2007/07/on_top

On Wed, May 19, 2021 at 03:00:08PM +0530, Hriday Hegde wrote:
> I am not really sure how to do that and how to reflect it in the patch i followed what was taught in the Beginners course and it does not mention building. I know i need to test it out but is running 'patch -p1 < x.patch what i need to do?

That does not build the code you changed, right?

I'm sure whatever course you took, it did reference the fact that you
need to ensure that your change actually works properly by the very
least being able to be compiled correctly.  Please go over those
instructions again.

good luck!

greg k-h
