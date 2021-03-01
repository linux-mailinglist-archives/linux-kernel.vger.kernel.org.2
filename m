Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BEB329FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbhCBDqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:46:08 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:54010 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbhCAU5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:57:54 -0500
X-Greylist: delayed 1419 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Mar 2021 15:57:54 EST
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGpA6-0023AN-BQ; Mon, 01 Mar 2021 20:29:02 +0000
Date:   Mon, 1 Mar 2021 20:29:02 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: #pragma once (was Re: incoming)
Message-ID: <YD1OjvWcal+rPz+4@zeniv-ca.linux.org.uk>
References: <YDlXWHkYntoO4fk0@localhost.localdomain>
 <CAHk-=wjZJPqmPE_gzvzPtPsojxw-Xg8QTBCn+Oi-ca2s0818NA@mail.gmail.com>
 <YDl9/QU8EsCOPyuf@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDl9/QU8EsCOPyuf@localhost.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 02:02:21AM +0300, Alexey Dobriyan wrote:

> There are rules and schemes about how to create guard macro.
> 
> Should it be prefixed by underscore?
> Should it be prefixed by two underscores?
> Should it be full path uppercased or just last path component?
> Should the guard macro be lowercased?
> Should it be changed when header is moved?
> Should trailing #endif contain comment?
> Should #define be just #define or "#define FOO 1"?

Who cares?  To all of the above, really.

> I've even seen advice (or an IDE doing that) that is should contain
> timestamp of a header creation time to minimise collisions (implying
> collisions could happen as could typos as could broken guards)

Ever seen that in the tree?  Where, if so?

> All this zoo of styles and made up mental work is completely avoided
> by using #pragma once:
> 
> 	1) put #pragma once on the first line
> 	
> 		or
> 
> 	2) put #pragma once on the second line after SPDX banner
> 
> and that's it.
> 
> No fuss, no filled up preprocessor hashtables, no implicit arguing
> about styles.

Care to provide some stats on the amount of those macros encountered
on build, along with the total amount of defines parsed and hashed?
It's noise.

And what is "implicit arguing", BTW?  I'm yet to see any fights
along those lines - you are the first one to bring that up, AFAICS.
Maybe I'd simply been lucky until now, of course, but...
