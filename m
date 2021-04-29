Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D7336E85D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbhD2KF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhD2KF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:05:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C0766142A;
        Thu, 29 Apr 2021 10:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619690711;
        bh=B4U6INbbFuXS+8tIhj+PBopurtIGvEU38c61RE6Eub0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLXOyZU9r4x90zJaCqHW5KIYgp0EHTxJB/k2ST7qXSsJZNBYfx3gvIspOCwv+1vz3
         yqtAkzvhxz936nWSSn2FGTU7aq2bTvLl5HDGx3Qvzqz9F6OIAlx7lP6DfpCs3iAnBW
         f4U/VDleEEXsl/sRT7bOUs7Yfa8NxccafswaPOck=
Date:   Thu, 29 Apr 2021 12:05:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: module parameters permission
Message-ID: <YIqE1B3qMK+5AwQj@kroah.com>
References: <20210429095819.GE1409@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429095819.GE1409@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:58:20AM +0200, Fabio Aiuto wrote:
> Hi all,
> 
> I'm trying to declare module parameters this way:
> 
> 
>    params: {
>         scull_major: i32 {
>             default: 0,
>             permissions: bindings::S_IRUGO as i32,
>             description: b"Major number",
>         },
>         scull_minor: i32 {
>             default: 0,
>             permissions: bindings::S_IRUGO as i32,
>             description: b"Minor number",
>         },
> 
> i.e. using S_IRUGO macro exposed by bindgen. But I have the
> following compiler error:
> 
> error: proc macro panicked
>   --> samples/rust/rust_scull.rs:12:1
>    |
> 12 | / module! {
> 13 | |     type: RustScull,
> 14 | |     name: b"rust_scull",
> 15 | |     author: b"Alessandro Rubini, Jonathan Corbet",
> ...  |
> 44 | |     },
> 45 | | }
>    | |_^
>    |
>    = help: message: Expected Literal
> 
> the same if I remove as i32 casts.
> 
> if I write permissions as in samples/rust/rust_module_parameters.rs
> 
>     params: {
>         my_bool: bool {
>             default: true,
>             permissions: 0,
>             description: b"Example of bool",
>         },
>         my_i32: i32 {
>             default: 42,
>             permissions: 0o644, <-------
>             description: b"Example of i32",
>         },
> 
> I get no error.
> 
> What's the right way to use S_I*UGO macros?

Not at all, use the octal values instead please.

That's the way that we have declared a while ago, and I think
checkpatch.pl will even catch if you try to do this in any new code.
Please don't force us to deal with S_* defines in rust code as well.

thanks,

greg k-h
